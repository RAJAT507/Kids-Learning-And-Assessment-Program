package com.jk.klap.servlet;

import com.jk.klap.dao.CategoryDAO;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import java.io.IOException;

@WebServlet("/DeleteCategoryServlet")
public class DeleteCategoryServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String idStr = request.getParameter("id");
        if (idStr != null && !idStr.isEmpty()) {
            try {
                int categoryId = Integer.parseInt(idStr);

                boolean status = CategoryDAO.deleteCategory(categoryId);

                if (status) {
                    response.sendRedirect("view_categories.jsp?msg=deleted");
                } else {
                    response.sendRedirect("view_categories.jsp?msg=fail");
                }

            } catch (NumberFormatException e) {
                e.printStackTrace();
                response.sendRedirect("view_categories.jsp?msg=invalid");
            }
        } else {
            response.sendRedirect("view_categories.jsp?msg=missing");
        }
    }
}
