/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package com.jk.klap.servlet;

import com.jk.klap.dao.ParentDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

/**
 *
 * @author Mahadev
 */
@WebServlet(name = "ParentLoginServlet", urlPatterns = {"/ParentLoginServlet"})
public class ParentLoginServlet extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String email = request.getParameter("email");
        String password = request.getParameter("password");

        boolean status = ParentDAO.checkLogin(email, password);

        if(status) {
            HttpSession session = request.getSession();
            session.setAttribute("parent_email", email);
            int parentId = ParentDAO.getParentIdByEmail(email); // bana lena
session.setAttribute("parent_id", parentId);

            response.sendRedirect("navbar.jsp");
        } else {
            response.sendRedirect("login.jsp?error=invalid");
        }
    }
}