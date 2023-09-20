<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="com.buyMe15.pkg.*"%>
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
	try {

		//Get the database connection
		ApplicationDB db = new ApplicationDB();	
		Connection con = db.getConnection();

		//Create a SQL statement
		Statement stmt = con.createStatement();

		//Get parameters from the HTML form at the HelloWorld.jsp
		String name = request.getParameter("name");
		String LoginID = request.getParameter("LoginID");
		String SSN = request.getParameter("SSN");
		String password = request.getParameter("Password");

		//Make an insert statement for the Accounts table:
		String insert = "INSERT INTO Accounts(LoginID, pssword)"
				+ "VALUES (?, ?)";
		//Create a Prepared SQL statement allowing you to introduce the parameters of the query
		PreparedStatement ps = con.prepareStatement(insert);

		//Add parameters of the query. Start with 1, the 0-parameter is the INSERT statement itself
		ps.setString(1, LoginID);
		ps.setString(2, password);
		//Run the query against the DB
		ps.executeUpdate();
		
		String insert_two = "INSERT INTO users(ssn, U_name, AccountID)"
				+ "VALUES (?,?,?)";
		
		PreparedStatement ps_two = con.prepareStatement(insert_two);
		ps_two.setString(1, SSN);
		ps_two.setString(2, name);
		ps_two.setString(3, LoginID);
		
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