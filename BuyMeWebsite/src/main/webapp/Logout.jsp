<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="javax.servlet.http.HttpSession" %>
<%
    // Invalidate the session
    HttpSession userSession = request.getSession();
    if (userSession != null) {
    	out.print("You are successfully logged out!");
        userSession.invalidate();
    }
    
    // Redirect the user to the login page or any desired destination
      response.setHeader("Refresh", "2;URL=LoginPage.jsp");
%>