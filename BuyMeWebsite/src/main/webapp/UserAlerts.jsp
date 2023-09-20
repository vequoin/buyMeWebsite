<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" import="com.buyMe15.pkg.*"%>
<%@ page import="java.sql.*, java.util.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>User Alerts</title>
</head>
<body>
	<%
	String LoginID = (String)session.getAttribute("LoginID");
    Connection conn = null;
    PreparedStatement statement = null;
    ResultSet rs = null;
    	try{
    		ApplicationDB db = new ApplicationDB();
    		conn = db.getConnection();
    		
    		String query = "SELECT AlertID, Alert_time, ItemID, message from alerts where UserID = ?";
    		statement = conn.prepareStatement(query);
            statement.setString(1, LoginID);
            rs = statement.executeQuery();
     %>

            <table border="1">
                <tr>
                    <th>Alert ID</th>
                    <th>Alert Time</th>
                    <th>Item ID</th>
                    <th>Message</th>
                </tr>

            <%
                    while(rs.next()) {
            %>
                <tr>
                    <td><%= rs.getInt("AlertID") %></td>
                    <td><%= rs.getTimestamp("Alert_time") %></td>
                    <td><%= rs.getInt("ItemID") %></td>
                    <td><%= rs.getString("message") %></td>
                </tr>
            <%
                    }
                } catch (SQLException e) {
                    e.printStackTrace();
                } finally {
                    if (rs != null) try { rs.close(); } catch (SQLException ignore) {}
                    if (statement != null) try { statement.close(); } catch (SQLException ignore) {}
                    if (conn != null) try { conn.close(); } catch (SQLException ignore) {}
                }
            %>

            </table>
</body>
</html>