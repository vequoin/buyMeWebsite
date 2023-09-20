package com.buyMe15.pkg;

import java.sql.*;

public class AutoBidProcessor {

    private Connection getConnection() throws SQLException {
        ApplicationDB db = new ApplicationDB();
        return db.getConnection();
    }

    public void processAutoBids() {
        try (Connection connection = getConnection()) {

            // Fetch all distinct items with active auto-bidding.
            String fetchItemsWithAutoBids = "SELECT DISTINCT ItemID FROM bidding WHERE is_auto_bid = true";
            try (PreparedStatement statement = connection.prepareStatement(fetchItemsWithAutoBids);
                 ResultSet itemSet = statement.executeQuery()) {

                while (itemSet.next()) {
                    int itemId = itemSet.getInt("ItemID");
                    processItemAutoBids(itemId, connection);
                }
            }

        } catch (SQLException se) {
            // handle error, maybe log it
            se.printStackTrace();
        }
    }

    private void insertAlert(String LoginID, String message, Connection connection) throws SQLException {
        String sql = "INSERT INTO alerts (user_id, message, timestamp, read_status) VALUES (?, ?, NOW(), false)";
        try (PreparedStatement statement = connection.prepareStatement(sql)) {
            statement.setString(1, LoginID);
            statement.setString(2, message);
            statement.executeUpdate();
        }
    }
    
    private void processItemAutoBids(int itemId, Connection connection) throws SQLException {
    	AuctionHelper auctionHelper = new AuctionHelper();
        float secretPrice = auctionHelper.getSecretPrice(itemId, connection);
        float currentHighestBid = getCurrentHighestBid(itemId, connection);
  

        // Fetch all auto-bids for the current item, sorted by auto_bid_limit descending.
        String fetchAutoBids = "SELECT BidderID, auto_bid_limit FROM bidding WHERE ItemID = ? AND is_auto_bid = true ORDER BY auto_bid_limit DESC";
        try (PreparedStatement statement = connection.prepareStatement(fetchAutoBids)) {
            statement.setInt(1, itemId);

            try (ResultSet autoBidSet = statement.executeQuery()) {
                while (autoBidSet.next()) {
                    float autoBidLimit = autoBidSet.getFloat("auto_bid_limit");
                    String bidderId = autoBidSet.getString("BidderID");

                    // If the auto bid limit is higher than the current highest bid, place a new bid.
                    if (autoBidLimit > currentHighestBid) {
                        float newBidAmount = currentHighestBid + (currentHighestBid/100); // Increment by a predefined value, adjustable
                        if (newBidAmount > autoBidLimit) {
                            newBidAmount = autoBidLimit;
                        }
                        placeNewBid(itemId, bidderId, newBidAmount, autoBidLimit, connection);
                        currentHighestBid = newBidAmount; // Update the current highest bid value
                        if(newBidAmount > secretPrice) {
                        	String sellerID = auctionHelper.getSellerIdTwo(itemId, connection);
                            String alertMessage = String.format("Bid for item %d has surpassed the secret price!", itemId);
                            insertAlert(sellerID, alertMessage, connection);
                        }
                        }
                    else {
                    	String alertMessage = String.format("Your auto-bid limit for item %d has been surpassed.", itemId);
                        insertAlert(bidderId, alertMessage, connection);
                    }
                }
            }
        }
    }

    private float getCurrentHighestBid(int itemId, Connection connection) throws SQLException {
        String fetchHighestPrice = "SELECT MAX(bidPrice) AS HighestBid FROM bidding WHERE ItemID = ?";
        try (PreparedStatement statement = connection.prepareStatement(fetchHighestPrice)) {
            statement.setInt(1, itemId);

            try (ResultSet resultSet = statement.executeQuery()) {
                if (resultSet.next()) {
                    return resultSet.getFloat("HighestBid");
                }
            }
        }
        return 0;
    }

    private void placeNewBid(int itemId, String bidderId, float bidAmount, float autoBidLimit, Connection connection) throws SQLException {
        String insertQuery = "INSERT INTO bidding(itemID, BiderID, bidPrice, auto_bid_limit, curr_bid_time, is_auto_bid) VALUES (?, ?, ?, ?, NOW(), true)";
        try (PreparedStatement statement = connection.prepareStatement(insertQuery)) {
            statement.setInt(1, itemId);
            statement.setString(2, bidderId);
            statement.setFloat(3, bidAmount);
            statement.setFloat(4, autoBidLimit);
            statement.executeUpdate();
        }
    }
}
