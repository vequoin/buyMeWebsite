<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="com.buyMe15.pkg.*"%>
<%@ page import="java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Create Bid process</title>
</head>
<body>
    <%

    String itemIDstr = request.getParameter("ItemID");
    String BidPricestr = request.getParameter("BidPrice");
    String enableAutoBidding  = request.getParameter("AutoChoice");
    float autoBidLimit = 0;

    // Safeguard against null
    if(request.getParameter("AutoBidLimit") != null){
        autoBidLimit = Float.parseFloat(request.getParameter("AutoBidLimit"));
    }
    
    if (itemIDstr != null && BidPricestr != null){
        Connection connection = null;
        PreparedStatement statement = null;
        ResultSet resultSet = null;
        try {
            int itemID = Integer.parseInt(itemIDstr);
            Float BidPrice = Float.parseFloat(BidPricestr);

            ApplicationDB db = new ApplicationDB();
            connection = db.getConnection();
            
            String BiderID =(String)session.getAttribute("LoginID");
            if(BiderID == null) {
                response.sendRedirect("login.jsp?error=not_logged_in");
                return;
            }

            
            float startingBid = 0;
            float secretPrice = 0;
            String fetchStartingBidQuery = "SELECT start_price, secret_price FROM Items WHERE ItemID = ?";
            statement = connection.prepareStatement(fetchStartingBidQuery);
            statement.setInt(1, itemID);
            resultSet = statement.executeQuery();
            if (resultSet.next()) {
                startingBid = resultSet.getFloat("start_price");
                secretPrice = resultSet.getFloat("secret_price");
            }
            resultSet.close();
            statement.close();

            // Moved this check up before querying highest bid
            if(BidPrice <= startingBid){
                out.print("<script>");
                out.print("alert('Bid price is less than starting price for the item, please put an appropriate bid price');");
                out.print("setTimeout(function(){ window.location.href = 'dashboard.jsp?error=bid_toolow'; }, 5000);"); 
                out.print("</script>");
                return; // Added return after the redirect
            }
            
            // Getting highest bid
            String fetchHighestPrice = "SELECT MAX(bidPrice) AS HighestBid FROM bidding WHERE ItemID = ?";
            statement = connection.prepareStatement(fetchHighestPrice);
            statement.setInt(1, itemID);
            resultSet = statement.executeQuery();
            float currentHighestBid = 0;
            if (resultSet.next() && resultSet.getObject("highestBid") != null) {
                currentHighestBid = resultSet.getFloat("HighestBid");
            }
            resultSet.close();
            statement.close();

            if(BidPrice <= currentHighestBid){
                response.sendRedirect("dashboard.jsp?error=bid_toolow");
                return;
            }
            else{
                if("yes".equals(enableAutoBidding)){
                    // Insert with auto-bid limit
                    String queryInsert = "INSERT INTO bidding(itemID, BidderID, bidPrice, auto_bid_limit, curr_bid_time, is_auto_bid) VALUES (?,?,?,?, NOW(), true)";
                    statement = connection.prepareStatement(queryInsert);
                    statement.setInt(1, itemID);
                    statement.setString(2, BiderID);
                    statement.setFloat(3, BidPrice);  // Initial bid
                    statement.setFloat(4, autoBidLimit); // Auto-bid limit set by the user
                    statement.executeUpdate();
                } else {
                	
                	if(BidPrice > secretPrice) {
                        String sellerID = AuctionHelper.getSellerId(itemID, connection);
                        String alertMessage = String.format("Bid for item %d has surpassed the secret price!", itemID);
                        AuctionHelper.insertAlert(sellerID, alertMessage, connection);
                    }
                    // Inserting without auto-bid
                    String queryInsert = "INSERT INTO bidding(itemID, BidderID, bidPrice, curr_bid_time) VALUES (?,?,?, NOW())";
                    statement = connection.prepareStatement(queryInsert);
                    statement.setInt(1, itemID);
                    statement.setString(2, BiderID);
                    statement.setFloat(3, BidPrice);
                    statement.executeUpdate();
                }

            }

        } catch(NumberFormatException nfe) {
            out.print("Invalid input format!");
        } catch(SQLException se) {
            out.print("Database error: " + se.getMessage());
        } finally {
            try {
                if (resultSet != null) resultSet.close();
                if (statement != null) statement.close();
                if (connection != null) connection.close();
            } catch(SQLException se) {
                out.print("Cleanup error: " + se.getMessage());
            }
        }
    }
    
    %>
</body>
</html>
