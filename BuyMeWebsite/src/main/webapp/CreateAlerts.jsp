<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" import="com.buyMe15.pkg.*"%>
<%@ page import="java.sql.*, java.util.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Create Alerts</title>
</head>
<body>
	<%
	String itemID = request.getParameter("itemID");
	String LoginID = (String)session.getAttribute("LoginID");
	String message = request.getParameter("Reason");
	String Atime = request.getParameter("dateFor") + " 00:00:00";
    Connection conn = null;
    PreparedStatement statement = null;
    ResultSet rs = null;
    
    try {
    	ApplicationDB db = new ApplicationDB();
    	conn = db.getConnection();
    	
    	String insertAlert = "INSERT INTO Alerts(Alert_time, ItemID, UserID, message, created_at, read_status) VALUES (?, ?, ?, ?, NOW(), false)";
        
        statement = conn.prepareStatement(insertAlert);
        
        statement.setString(1, Atime);
        statement.setString(2, itemID);
        statement.setString(3, LoginID);
        statement.setString(4, message);
        
        int affectedRows = statement.executeUpdate();
        if(affectedRows > 0) {
            out.println("Alert created successfully.");
        } else {
            out.println("Failed to create alert.");
        }

    } catch(SQLException e) {
        e.printStackTrace();
    } finally {
        try {
            if(statement != null) {
                statement.close();
            }
            if(conn != null) {
                conn.close();
            }
        } catch(SQLException se) {
            se.printStackTrace();
        }
    }
    
	%>
</body>
</html>