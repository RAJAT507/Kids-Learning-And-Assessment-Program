package com.jk.klap.servlet;

import com.jk.klap.bean.CategoryBean;
import com.jk.klap.dao.CategoryDAO;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import java.io.IOException;

@WebServlet("/EditCategoryServlet")
public class EditCategoryServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String categoryName = request.getParameter("categoryName");
        int categoryId = Integer.parseInt(request.getParameter("categoryId"));

        CategoryBean bean = new CategoryBean();
        bean.setCategoryId(categoryId);
        bean.setCategoryName(categoryName);

        boolean status = CategoryDAO.updateCategory(bean);

        if(status) {
            response.sendRedirect("edit_category.jsp?id=" + categoryId + "&msg=updated");
        } else {
            response.sendRedirect("edit_category.jsp?id=" + categoryId + "&msg=fail");
        }
    }
}
