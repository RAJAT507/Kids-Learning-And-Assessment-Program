package com.jk.klap.servlet;

import com.jk.klap.bean.ParentBean;
import com.jk.klap.dao.ParentDAO;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import java.io.*;
import java.sql.*;

@WebServlet("/ParentRegisterServlet")
public class ParentRegisterServlet extends HttpServlet {

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String name = request.getParameter("name");
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        String contact = request.getParameter("contact");

        ParentBean parent = new ParentBean();
        parent.setName(name);
        parent.setEmail(email);
        parent.setPassword(password);
        parent.setContact(contact);

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection con = DriverManager.getConnection(
                    "jdbc:mysql://localhost:3306/klap", "root", "root");

            ParentDAO dao = new ParentDAO(con);

            // 🔥 CHECK DUPLICATE EMAIL
            if (dao.isEmailExists(email)) {
                response.sendRedirect("parent_register.jsp?msg=already");
                return;
            }

            // INSERT
            boolean status = dao.registerParent(parent);

            if (status) {
                response.sendRedirect("parent_register.jsp?msg=success");
            } else {
                response.sendRedirect("parent_register.jsp?msg=failed");
            }

        } catch (SQLIntegrityConstraintViolationException e) {
            // 🔥 DB LEVEL DUPLICATE
            response.sendRedirect("parent_register.jsp?msg=already");

        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}