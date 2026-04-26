package com.jk.klap.servlet;

import com.jk.klap.bean.ContentBean;
import com.jk.klap.dao.ContentDAO;
import com.jk.klap.dao.ContentDAO;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import java.io.IOException;
import java.util.List;

@WebServlet("/EditContentServlet")
public class EditContentServlet extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int contentId = Integer.parseInt(request.getParameter("content_id"));
        ContentBean bean = ContentDAO.getContentById(contentId);
        List<String[]> categories = ContentDAO.getAllCategories();
        request.setAttribute("content", bean);
        request.setAttribute("categories", categories);
        RequestDispatcher rd = request.getRequestDispatcher("edit_content.jsp");
        rd.forward(request, response);
    }
}
