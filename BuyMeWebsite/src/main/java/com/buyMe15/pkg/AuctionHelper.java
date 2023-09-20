package com.buyMe15.pkg; // Use your package name

import java.sql.*;

public class AuctionHelper {
	
	
	
	public float getSecretPrice(int itemId, Connection conn) throws SQLException {
        String fetchSecretPriceQuery = "SELECT secret_price FROM Items WHERE ItemID = ?";
        try (PreparedStatement statement = conn.prepareStatement(fetchSecretPriceQuery)) {
            statement.setInt(1, itemId);
            try (ResultSet resultSet = statement.executeQuery()) {
                if (resultSet.next()) {
                    return resultSet.getFloat("secret_price");
                }
            }
        }
        return 0; // Default value, adjust as needed
    }

    public static String getSellerId(int itemId, Connection conn) throws SQLException {
        String sellerID = null;
        String query = "SELECT SellerID FROM Items WHERE ItemID = ?";
        try (PreparedStatement stmt = conn.prepareStatement(query)) {
            stmt.setInt(1, itemId);
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    sellerID = rs.getString("SellerID");
                }
            }
        }
        return sellerID;
    }
    
    public String getSellerIdTwo(int itemId, Connection conn) throws SQLException {
        String fetchSellerIdQuery = "SELECT SellerID FROM Items WHERE ItemID = ?";
        try (PreparedStatement statement = conn.prepareStatement(fetchSellerIdQuery)) {
            statement.setInt(1, itemId);
            try (ResultSet resultSet = statement.executeQuery()) {
                if (resultSet.next()) {
                    return resultSet.getString("SellerID");
                }
            }
        }
        return null; // Default value if no seller is found
    }
    
    
    
    

    public static void insertAlert(String sellerID, String message, Connection conn) throws SQLException {
        // Assuming you have an alerts table with columns: sellerID and message
        String query = "INSERT INTO alerts(UserID, message) VALUES (?, ?)";
        try (PreparedStatement stmt = conn.prepareStatement(query)) {
            stmt.setString(1, sellerID);
            stmt.setString(2, message);
            stmt.executeUpdate();
        }
    }
}
