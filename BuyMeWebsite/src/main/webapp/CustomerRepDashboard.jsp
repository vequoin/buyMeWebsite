<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="ISO-8859-1" import="com.buyMe15.pkg.*"%>
    <%@ page import ="java.sql.*" %>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>

<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8" />
  <title>Your DashBoard</title>
  <meta name="viewport" content="width=device-width,initial-scale=1" />
  <meta name="description" content="" />
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/css/bootstrap.min.css" rel="stylesheet" crossorigin="anonymous">
  <link rel="stylesheet" type="text/css" href="DashboardStyles.css" />
  <link rel="icon" href="favicon.png">
</head>
<body>
    <section class="colored">
    <div class="container-fluid">
    <nav class="navbar navbar-expand-lg navbar-light">
        <a class="navbar-brand" href="#">Representative Dashboard</a>
        <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav" aria-controls="navbarNav" aria-expanded="false" aria-label="Toggle navigation">
          <span class="navbar-toggler-icon"></span>
        </button>
        <div class="collapse navbar-collapse" id="navbarNav">
          <ul class="navbar-nav ms-auto">
            <li class="nav-item active ms-5">
              <a class="nav-link" href="#">Home <span class="sr-only">(current)</span></a>
            </li>
            <li class="nav-item ms-5">
              <a class="nav-link" href="Logout.jsp">Logout</a>
            </li>
          </ul>
        </div>
      </nav>
    </div>
    </section>
    
    <div class="container-two">
        <div class="queryTitle">
            <label class="headings" for="">Alter UserAccount</label>
        <form class="Account-create" method="post" action="">
            <label for="CustomerRepLoginID">UserLoginID:</label>
            <input name="LoginCustomerRep" type="text"><br>
            <br>
            <label for="Password">UserPassword:</label>
            <input name="Password" type="text"><br>
            <input style="margin-top: 10px; margin-left: 100px;" class="btn btn-primary btn-lg" type="submit" value="Submit">
        </form>
        </div>
    </div>
        
  <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
  <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/js/bootstrap.bundle.min.js" crossorigin="anonymous"></script>
</body>
</html>