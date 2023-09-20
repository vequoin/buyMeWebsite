<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" import="com.buyMe15.pkg.*"%>
<%@ page import="java.sql.*, java.util.*" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Item Selling</title>
</head>
<body>
    <%
    	String itemName = request.getParameter("ItemName");
    String category = request.getParameter("Category");
    String itemDescription = request.getParameter("Item Description");
    float startPrice = Float.parseFloat(request.getParameter("startPrice"));
    float secretPrice = Float.parseFloat(request.getParameter("secretPrice"));
    String closingDate = request.getParameter("closingDate");
    
   
    Connection conn = null;
    PreparedStatement statement = null;
    ResultSet rs = null;
    
    try{
    	ApplicationDB db = new ApplicationDB();
    	conn = db.getConnection();
    	
    	// Check if category already exists
        String checkCategory = "SELECT COUNT(*) FROM Categories WHERE C_name=?";
        statement = conn.prepareStatement(checkCategory);
        statement.setString(1, category);
        rs = statement.executeQuery();
        
        if(rs.next() && rs.getInt(1) == 0) {
            // The category does not exist, so insert it
            rs.close();
            statement.close();
            String insertCategory = "INSERT INTO Categories(C_name) VALUES (?)";
            statement = conn.prepareStatement(insertCategory);
            statement.setString(1, category);
            statement.executeUpdate();
        }else{
        	rs.close();
        }
    	
            String sellerID = (String) session.getAttribute("LoginID");
            
            statement.close();

            // Insert new item
            String insertQuery = "INSERT INTO Items(I_name, SellerID, Category, I_description, start_price, secret_price, closing_date) VALUES(?, ?, ?, ?, ?, ?, ?)";
            statement = conn.prepareStatement(insertQuery);
            statement.setString(1, itemName);
            statement.setString(2, sellerID);
            statement.setString(3, category);
            statement.setString(4, itemDescription);
            statement.setFloat(5, startPrice);
            statement.setFloat(6, secretPrice);
            statement.setString(7, closingDate);
            statement.executeUpdate();

    }catch (SQLException e) {
        // Handle errors
        e.printStackTrace();
    } finally {
        // Close database resources
        try {
            if (statement != null) statement.close();
            if (conn != null) conn.close();
        } catch (SQLException se) {
            se.printStackTrace();
        }
    }
    
      %>
</body>
</html>
