<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
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
	<%
	// Get parameters from the HTML form
	String LoginID = request.getParameter("LoginID");
	String PassWord = request.getParameter("PassWord");
	String role = request.getParameter("role");

	Class.forName("com.mysql.jdbc.Driver");
	Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/buy_me_website","root","bro9090Code#165");
	Statement st = con.createStatement();
	ResultSet rs;

	boolean isValidUser = false;

	// Initial check against the Accounts table
	rs = st.executeQuery("select * from Accounts where LoginID='" + LoginID + "' and Pssword='" + PassWord + "'");
	if (rs.next()){
	    isValidUser = true;
	}
	rs.close();

	if (isValidUser) {
	    boolean isValidRole = false;
	    switch(role) {
	        case "admin":
	            rs = st.executeQuery("select * from Site_Admin where Admin_Account='" + LoginID + "'");
	            if (rs.next()) {
	                isValidRole = true;
	            }
	            break;	         
	        case "employee":
	        	rs.close();
	            rs = st.executeQuery("select * from CustomerRep where CustomerRepAcc='" + LoginID + "'");
	            if (rs.next()) {
	                isValidRole = true;
	            }
	            break;
	        case "user":
	            // If the user is valid and the role is "user", they're automatically considered valid
	            isValidRole = true;
	            break;
	    }

	    if (isValidRole) {
	        session.setAttribute("LoginID", LoginID);   // Store LoginID in the session
	        out.println("Welcome " + LoginID);
	        out.println("<a href='logout.jsp'>Log out</a>");
	        if(role.equals("user")){
	        	response.sendRedirect("Dashboard.jsp");
	        }
	        if(role.equals("admin")){
	        	response.sendRedirect("AdminDashboard.jsp");
	        }
	        if(role == "employee"){
	        	response.sendRedirect("CustomerRepDashboard.jsp");
	        }
	    } else {
	        out.println("Invalid role <a href='LoginPage.jsp'>try again</a>");
	    }
	} else {
	    out.println("Invalid credentials <a href='LoginPage.jsp'>try again</a>");
	}
%>
</body>
</html>