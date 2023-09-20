<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" import="com.buyMe15.pkg.*"%>
<%@ page import="java.sql.*, java.util.*" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Item Search</title>
</head>
<body>
    <%
        String itemName = request.getParameter("Item Name");
        String itemDescription = request.getParameter("Description");
        boolean resultsFound = false;

        if (itemName != null && itemDescription != null) {

            try {
                
                ApplicationDB db = new ApplicationDB();
                Connection connection = db.getConnection();

                String query = "SELECT ItemID, I_Name, itemDescription, SellerID, start_price FROM Items WHERE I_Name LIKE ? AND I_Description LIKE ?";
                PreparedStatement statement = connection.prepareStatement(query);
                statement.setString(1, "%" + itemName + "%");
                statement.setString(2, "%" + itemDescription + "%");

                ResultSet resultSet = statement.executeQuery();
    %>
                <h2>Search Results:</h2>
                <table border="1">
                    <tr>
                        <th>Item ID</th>
                        <th>Item Name</th>
                        <th>Item Description</th>
                        <th>Seller Name</th>
                        <th>Price</th>
                        <th>Bid</th>
                    </tr>
    <%
                while (resultSet.next()) {
                    resultsFound = true;
                    int itemID = resultSet.getInt("itemID");
                    String itemNameResult = resultSet.getString("itemName");
                    String itemDescriptionResult = resultSet.getString("itemDescription");
                    int sellerID = resultSet.getInt("sellerID");
                    double startPrice = resultSet.getDouble("start_price");
    %>
                    <tr>
                        <td><%= itemID %></td>
                        <td><%= itemNameResult %></td>
                        <td><%= itemDescriptionResult %></td>
                        <td><%= "Seller" + sellerID %></td>
                        <td><%= startPrice %></td>
                        <td>
                            <a href="Dashboard.jsp">Bid from Dashboard</a>
                        </td>
                    </tr>
    <%
                }
    %>
                </table>
    <%
                statement.close();
                connection.close();
            } catch (Exception e) {
                e.printStackTrace();
            }
        }

        if (!resultsFound) {
    %>
            <p>No items matching the search criteria were found. Redirecting...</p>
            <%
                // Redirect the user back to the previous page after a delay
                response.setHeader("Refresh", "3;URL=Dashboard.jsp");
            %>
    <%
        }
    %>
</body>
</html>
