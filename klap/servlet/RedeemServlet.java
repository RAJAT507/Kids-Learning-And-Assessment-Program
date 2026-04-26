package com.jk.klap.servlet;

import com.jk.klap.utility.DBConnection;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import java.io.IOException;
import java.sql.*;

@WebServlet("/RedeemServlet")
public class RedeemServlet extends HttpServlet {

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        Integer parentId = (Integer) request.getSession().getAttribute("parent_id");

        String reward = request.getParameter("reward");
        int requiredCoins = Integer.parseInt(request.getParameter("required"));

        int currentCoins = 0;

        try (Connection conn = DBConnection.getConnection()) {

            // Step 1: Calculate total coins earned
            PreparedStatement ps1 = conn.prepareStatement(
                "SELECT IFNULL(SUM(supercoin_added), 0) AS totalCoins FROM test_results WHERE parent_id = ?"
            );
            ps1.setInt(1, parentId);
            ResultSet rs1 = ps1.executeQuery();
            if (rs1.next()) {
                currentCoins = rs1.getInt("totalCoins");
            }

            // Step 2: Calculate total coins spent
            PreparedStatement ps2 = conn.prepareStatement(
                "SELECT IFNULL(SUM(coins_used), 0) AS usedCoins FROM supercoin_redeem WHERE parent_id = ?"
            );
            ps2.setInt(1, parentId);
            ResultSet rs2 = ps2.executeQuery();
            int usedCoins = 0;
            if (rs2.next()) {
                usedCoins = rs2.getInt("usedCoins");
            }

            int availableCoins = currentCoins - usedCoins;

            // Step 3: Check if enough coins available
            if (availableCoins >= requiredCoins) {
                // Step 4: Insert redemption
                PreparedStatement ps3 = conn.prepareStatement(
                    "INSERT INTO supercoin_redeem (parent_id, reward_name, coins_used, redeemed_at) VALUES (?, ?, ?, NOW())"
                );
                ps3.setInt(1, parentId);
                ps3.setString(2, reward);
                ps3.setInt(3, requiredCoins);
                ps3.executeUpdate();

                request.setAttribute("message", "\uD83C\uDF89 Reward redeemed successfully!");
            } else {
                request.setAttribute("message", "\u274C Not enough Supercoins to redeem this reward.");
            }

        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("message", "\u26A0\uFE0F Error occurred during redemption.");
        }

        // Forward to rewards page with updated balance
        request.getRequestDispatcher("/RewardServlet").forward(request, response);
    }
}