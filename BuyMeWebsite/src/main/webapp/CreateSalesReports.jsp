<%@ page language="java" contentType="text/html; UTF-8"
    pageEncoding="ISO-8859-1" import="com.buyMe15.pkg.*"%>
    <%@ page import ="java.sql.*" %>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Insert title here</title>
</head>
<body>
<%@ page import ="java.sql.*" %>

<%
    // Get parameters from the form in AdminDashboard.jsp
    String bestSellingItem = request.getParameter("BestSale");
    String earningsPerItem = request.getParameter("EarningsItem");
    String totalEarnings = request.getParameter("TotalEarnings");
    String bestSeller = request.getParameter("BestSeller");


    int createdBy = 10987; // Example: This represents the unique AdminID. In real-world applications, you might want to fetch it dynamically.


    Connection conn = null;
    PreparedStatement stmt = null;

    try {
        
        ApplicationDB db = new ApplicationDB();
        conn = db.getConnection();

        String sql = "INSERT INTO SalesReports (Best_selling_Item, time, Earnings_per_item, Total_Earnings, Best_Sellers, Created_by) VALUES (?, NOW(), ?, ?, ?, ?)";
        stmt = conn.prepareStatement(sql);
        stmt.setString(1, bestSellingItem);
        stmt.setFloat(2, Float.parseFloat(earningsPerItem));
        stmt.setFloat(3, Float.parseFloat(totalEarnings));
        stmt.setString(4, bestSeller);
        stmt.setInt(5, createdBy);

        int rowsInserted = stmt.executeUpdate();

        if (rowsInserted > 0) {
            out.println("Sales report created successfully.");
        } else {
            out.println("There was an issue creating the sales report.");
        }

    } catch(SQLException se) {
        out.println("Database error: " + se.getMessage());
    } catch(Exception e) {
        out.println("Error: " + e.getMessage());
    } finally {
        try {
            if(stmt != null) stmt.close();
            if(conn != null) conn.close();
        } catch(SQLException se) {
            out.println("Closing error: " + se.getMessage());
        }
    }
%>


</body>
</html>