package com.jk.klap.servlet;

import com.jk.klap.utility.DBConnection;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import java.io.IOException;
import java.sql.*;

@WebServlet("/RewardServlet")
public class RewardServlet extends HttpServlet {

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        Integer parentId = (Integer) request.getSession().getAttribute("parent_id");
        int earnedCoins = 0, usedCoins = 0;

        try (Connection conn = DBConnection.getConnection()) {

            // Step 1: Total coins earned
            PreparedStatement ps1 = conn.prepareStatement(
                "SELECT IFNULL(SUM(supercoin_added), 0) AS totalCoins FROM test_results WHERE parent_id = ?"
            );
            ps1.setInt(1, parentId);
            ResultSet rs1 = ps1.executeQuery();
            if (rs1.next()) {
                earnedCoins = rs1.getInt("totalCoins");
            }

            // Step 2: Total coins used
            PreparedStatement ps2 = conn.prepareStatement(
                "SELECT IFNULL(SUM(coins_used), 0) AS usedCoins FROM supercoin_redeem WHERE parent_id = ?"
            );
            ps2.setInt(1, parentId);
            ResultSet rs2 = ps2.executeQuery();
            if (rs2.next()) {
                usedCoins = rs2.getInt("usedCoins");
            }

            int balance = earnedCoins - usedCoins;
            request.setAttribute("supercoinBalance", balance);

        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("supercoinBalance", 0);
        }

        request.getRequestDispatcher("rewards.jsp").forward(request, response);
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doGet(request, response);
    }
} 