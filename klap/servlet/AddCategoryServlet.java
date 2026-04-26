package com.jk.klap.servlet;

import com.jk.klap.bean.CategoryBean;
import com.jk.klap.dao.CategoryDAO;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import java.io.*;

@WebServlet("/AddCategoryServlet")
public class AddCategoryServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String categoryName = request.getParameter("categoryName");

        CategoryBean bean = new CategoryBean();
        bean.setCategoryName(categoryName);

        boolean status = CategoryDAO.addCategory(bean);

        if(status) {
            response.sendRedirect("add_category.jsp?msg=category_added");
        } else {
            response.sendRedirect("add_category.jsp?msg=fail");
        }
    }
}
