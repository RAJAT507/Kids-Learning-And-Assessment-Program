package com.jk.klap.servlet;

import com.jk.klap.dao.ContentDAO;
import com.jk.klap.bean.ContentBean;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import java.io.IOException;
import java.util.List;

@WebServlet("/ViewContentServlet")
public class ViewContentServlet extends HttpServlet {
    private static final int RECORDS_PER_PAGE = 5;

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int page = 1;
        if(request.getParameter("page") != null)
            page = Integer.parseInt(request.getParameter("page"));

        List<ContentBean> contentList = ContentDAO.getContents((page-1)*RECORDS_PER_PAGE, RECORDS_PER_PAGE);
        int noOfRecords = ContentDAO.getContentCount();
    
        int noOfPages = (int) Math.ceil(noOfRecords * 1.0 / RECORDS_PER_PAGE);

        request.setAttribute("contentList", contentList);
        request.setAttribute("noOfPages", noOfPages);
        request.setAttribute("currentPage", page);
        RequestDispatcher rd = request.getRequestDispatcher("view_all_content.jsp");
        rd.forward(request, response);
    }
}
