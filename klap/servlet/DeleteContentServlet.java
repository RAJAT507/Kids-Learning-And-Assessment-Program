package com.jk.klap.servlet;

import com.jk.klap.dao.ContentDAO;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import java.io.IOException;

@WebServlet("/DeleteContentServlet")
public class DeleteContentServlet extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int contentId = Integer.parseInt(request.getParameter("content_id"));
        boolean status = ContentDAO.deleteContent(contentId);
        if(status) {
            response.sendRedirect("ViewContentServlet?msg=deleted");
        } else {
            response.sendRedirect("ViewContentServlet?msg=fail");
        }
    }
}
