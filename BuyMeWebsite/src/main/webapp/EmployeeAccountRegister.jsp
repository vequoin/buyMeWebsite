<%@ page language="java" contentType="text/html; UTF-8"
    pageEncoding="ISO-8859-1" import="com.buyMe15.pkg.*"%>
    <%@ page import ="java.sql.*" %>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<%
	try {

		//Get the database connection
		ApplicationDB db = new ApplicationDB();	
		Connection con = db.getConnection();

		//Create a SQL statement
		Statement stmt = con.createStatement();

		//Get parameters from the HTML form at the HelloWorld.jsp
		String RepLoginID = request.getParameter("LoginCustomerRep");
		String password = request.getParameter("Password");

		//Make an insert statement for the Accounts table:
		String insert = "INSERT INTO Accounts(LoginID, pssword)"
				+ "VALUES (?, ?)";
		
		PreparedStatement ps = con.prepareStatement(insert);

		
		ps.setString(1, RepLoginID);
		ps.setString(2, password);
		//Run the query against the DB
		ps.executeUpdate();
		
		String insert_two = "INSERT INTO CustomerRep(RepLoginID)"
				+ "VALUES (?)";
		
		PreparedStatement ps_two = con.prepareStatement(insert_two);
		ps_two.setString(1, RepLoginID);
		
		ps_two.executeUpdate();

		//Close the connection. Don't forget to do it, otherwise you're keeping the resources of the server allocated.
		con.close();

		out.print("Insert succeeded!");
		
	} catch (Exception ex) {
		out.print(ex);
		out.print("Insert failed :()");
	}
%>

</body>
</html>