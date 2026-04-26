/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package com.jk.klap.servlet;

import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet(name = "AdminLoginServlet", urlPatterns = {"/AdminLoginServlet"})
public class AdminLoginServlet extends HttpServlet {

    private static final String ADMIN_EMAIL = "jk@gmail.com";
    private static final String ADMIN_PASSWORD = "101";

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String email = request.getParameter("email");
        String password = request.getParameter("password");

        if (ADMIN_EMAIL.equals(email) && ADMIN_PASSWORD.equals(password)) {
            
            response.sendRedirect("admin_navbar.jsp");
        } else {
            
            response.sendRedirect("adminlogin.jsp?error=true");
        }
    }

    @Override
    public String getServletInfo() {
        return "Admin login servlet for KLAP project";
    }
}
    