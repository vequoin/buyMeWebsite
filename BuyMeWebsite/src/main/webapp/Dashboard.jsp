<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
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
        <a class="navbar-brand" href="#">Your Dashboard</a>
        <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav" aria-controls="navbarNav" aria-expanded="false" aria-label="Toggle navigation">
          <span class="navbar-toggler-icon"></span>
        </button>
        <div class="collapse navbar-collapse" id="navbarNav">
          <ul class="navbar-nav ms-auto">
          <li  class="nav-item ms-5">
          <div class="dropdown">
                <button class="btn btn-light dropdown-toggle" type="button" id="createAlertButton" data-bs-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                    Item History
                </button>
                <div class="dropdown-menu" aria-labelledby="ItemHistoryButton">
                    <form class="px-4 py-3" method="post" action="ItemHistory.jsp">
                        <div class="form-group">
                            <label for="itemID">Item ID</label>
                            <input type="text" class="form-control" id="itemID" name="itemID" required>
                        </div>
                        <button type="submit" class="btn btn-primary">Search</button>
                    </form>
                </div>
            </div>
          </li>
          <li class="nav-item ms-5">
          <a class="nav-link" href="UserAlerts.jsp">Alerts</a>
          </li>
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
            <!-- ... Your search form ... -->
            <label class="headings" for="">Search for an item</label>
        <form class="item-search" method="post" action="ItemSearch.jsp">
            <label for="Item name">Item name:</label>
            <input name="Item name" type="text"><br>
            <br>
            <label for="Description">Description:</label>
            <input name="Description" type="text"><br>
            <input style="margin-top: 10px; margin-left: 100px;" class="btn btn-primary btn-lg" type="submit" value="Submit">
        </form>
        </div>
        <div class="titT">
            <label class="headings">CreateBid</label>
                <form class="create-bid" method="post" action="CreateBid.jsp">
                    <div class="numitems">
                    <label for="ItemID">ItemID</label>
                        <input name="ItemID" type="text"><br>
                    </div>
                    <div class="numitems">
                        <label for="itemName">Name</label>
                        <input name="itemName" type="text"><br>
                    </div>
                    <div class="numitems">
                        <label for="BidPrice">BidPrice</label>
                        <input name="BidPrice" type="text"><br>
                    </div>
                    <div class="numitems">
                        <label for="UpperLimit">Your Upper Limit</label>
                        <input name="UpperLimit" type="text"><br>
                    </div>
                    <div class="form-check">
                    	<p>Enable Automatic Bidding?</p>
  							<input class="form-check-input" type="radio" name="AutoChoice" id="flexRadioDefault1" value="yes">
  							<label class="form-check-label" for="flexRadioDefault1">
    										Yes
  							</label>
							</div>
							<div class="form-check">
  							<input class="form-check-input" type="radio" name="AutoChoice" id="flexRadioDefault2" checked value="no">
  							<label class="form-check-label" for="flexRadioDefault2">
    										No
  							</label>
							</div>
                        <input style="margin-top: 10px; margin-left: 100px;" class="btn btn-primary btn-lg" type="submit" value="Create Bid">
                </form>
        </div>
    </div>
        
    <div class="container-three">
        <div class="querythree" style="display: inline-block;">
            <!-- ... Your sell item form ... -->
            <label class="headings">Sell an item</label>
            <form method="post" action="Selling.jsp">
                <div class="numitems">
                    <label for="ItemName">Item Name: </label>
                    <input name="ItemName" type="text"><br>
                </div>
                <div class="numitems">
                    <label for="Category">Item Category: </label>
                    <input name="Category" type="text"><br>
                </div>
                <div class="numitems">
                    <label for="Item Description">Brief Description: </label>
                    <input name="Item Description" type="text"><br>
                </div>
                <div class="numitems">
                    <label for="StartPrice">Enter Bidding<br>StartPrice: </label>
                    <input name="StartPrice" type="text"><br>
                </div>
                <div class="numitems">
                    <label for="secretPrice">Enter SecretPrice: </label>
                    <input name="secretPrice" type="text"><br>
                </div>
                <div class="numitems">
                    <label for="Closing date">Enter Auction closing date: </label>
                    <input name="Closing date" type="date"><br>
                </div>
                <input style="margin-top: 10px; margin-left: 100px;" class="btn btn-primary btn-lg" type="submit" value="Sell Item">
            </form>
        </div>
        <div class="containerfour">
            <div class="dropdown">
                <button class="btn btn-primary dropdown-toggle" type="button" id="createAlertButton" data-bs-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                    Create Alert
                </button>
                <div class="dropdown-menu" aria-labelledby="createAlertButton">
                    <form class="px-4 py-3" method="post" action="CreateAlerts.jsp">
                        <div class="form-group">
                            <label for="itemID">Item ID</label>
                            <input type="text" class="form-control" id="itemID" name="itemID" required>
                        </div>
                        <div class="form-group">
                            <label for="Reason">What's it for? </label>
                            <input type="text" class="form-control" id="Reason" name="Reason" required>
                        </div>
                        <button type="submit" class="btn btn-primary">Create</button>
                    </form>
                </div>
            </div>
        </div>        
    </div>

  <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
  <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/js/bootstrap.bundle.min.js" crossorigin="anonymous"></script>
</body>
</html>
