<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="com.buyMe15.pkg.*"%>
<!DOCTYPE html><html>
<head>
<meta charset="ISO-8859-1">
<title>RegisterPage</title>
<link href="//maxcdn.bootstrapcdn.com/bootstrap/4.1.1/css/bootstrap.min.css" rel="stylesheet" id="bootstrap-css">
<script src="//maxcdn.bootstrapcdn.com/bootstrap/4.1.1/js/bootstrap.min.js"></script>
<script src="//cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
<link rel="stylesheet" href="RegisterStyle.css">
</head>
<body>
<div class="container register-form">
		<form method="post" action="RegisterUser.jsp">
            <div class="form">
                <div class="note">
                    <p>Please Enter your Details.</p>
                </div>
                <div class="form-content">
                    <div class="row">
                        <div class="col-md-6">
                            <div class="form-group">
                                <input type="text" name="name" class="form-control" placeholder="Your Name *" value=""/>
                            </div>
                            <div class="form-group">
                                <input type="text" name="LoginID" class="form-control" placeholder="LoginID *" value=""/>
                            </div>
                        </div>
                        <div class="col-md-6">
                            <div class="form-group">
                                <input type="text" name="SSN" class="form-control" placeholder="SSN *" value=""/>
                            </div>
                            <div class="form-group">
                                <input type="text" name="Password" class="form-control" placeholder="Password *" value=""/>
                            </div>
                        </div>
                    </div>
                    <button type="submit" class="btnSubmit">Submit</button>
                </div>
            </div>
            </form>
        </div>

</body>
</html>