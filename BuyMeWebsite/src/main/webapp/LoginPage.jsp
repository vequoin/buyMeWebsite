<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="com.buyMe15.pkg.*"%>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8" />
  <title>Hello, world!</title>
  <meta name="viewport" content="width=device-width,initial-scale=1" />
  <meta name="description" content="" />
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/css/bootstrap.min.css" rel="stylesheet" crossorigin="anonymous">
  <link rel="stylesheet" href="stylesLogin.css">
  <link rel="icon" href="favicon.png">
</head>
<body>

<div class="sidenav">
         <div class="login-main-text">
            <h2>BuyMe<br> Login Page</h2>
            <p>Login or register from here to access.</p>
         </div>
      </div>
      <div class="main">
         <div class="col-md-6 col-sm-12">
            <div class="login-form">
               <form method="post" action="LoginChecker.jsp">
                  <div class="form-group">
                     <label>User Name</label>
                     <input type="text" name="LoginID" class="form-control" placeholder="User Name">
                  </div>
                  <div class="form-group">
                     <label>Password</label>
                     <input type="password" name="PassWord" class="form-control" placeholder="Password">
                  </div>
                  <div class="form-group">
    			<label for="role">Role:</label>
    			<select name="role" class="form-control" id="role">
        			<option value="user">User</option>
        			<option value="admin">Admin</option>
        			<option value="employee">Employee</option>
    			</select>
				</div>
				<br>
                  <button id="Submitbtn" type="submit" value="submit" class="btn btn-black">Login</button>
                  <button id="Registerbtn" type="submit" class="btn btn-secondary">Register</button>
               </form>
            </div>
         </div>
      </div>
  <h1>Buy Me Site</h1>
  <script src="https://code.jquery.com/jquery-3.7.0.min.js" crossorigin="anonymous"></script>
  <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/js/bootstrap.bundle.min.js" crossorigin="anonymous"></script>
  <script src="Loginapp.js"></script>
</body>
</html>