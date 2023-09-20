<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" import="com.buyMe15.pkg.*"%>
<%@ page import="java.sql.*, java.util.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Item Bid History</title>
</head>
<body>

<%
        String itemID = request.getParameter("itemID");
        Connection conn = null;
        PreparedStatement statement = null;
        ResultSet rs = null;

        if(itemID != null && !itemID.trim().isEmpty()) {
            try {
                ApplicationDB db = new ApplicationDB();
                conn = db.getConnection();

                String query = "SELECT bidPrice, BidderID, curr_bid_time FROM bidding WHERE itemID = ? ORDER BY curr_bid_time DESC";
                statement = conn.prepareStatement(query);
                statement.setString(1, itemID);
                rs = statement.executeQuery();
%>	<h3>Bidding History for Item ID: <%= itemID %></h3>
                <table border="1">
                    <tr>
                        <th>Amount</th>
                        <th>User ID</th>
                        <th>Time of Bid</th>
                    </tr>
                <%

                while(rs.next()) {
                    %>
                    <tr>
                        <td><%= rs.getDouble("bidPrice") %></td>
                        <td><%= rs.getString("BidderID") %></td>
                        <td><%= rs.getTimestamp("curr_bid_time") %></td>
                    </tr>
                    <%
                }
                %>
                </table>
                <%

            } catch (SQLException e) {
                e.printStackTrace();
            } finally {
                try {
                    if(rs != null) rs.close();
                    if(statement != null) statement.close();
                    if(conn != null) conn.close();
                } catch (SQLException se) {
                    se.printStackTrace();
                }
            }
        }
    %>
    <a href="Dashboard.jsp">Back to Your Dashboard</a>
</body>
</html>