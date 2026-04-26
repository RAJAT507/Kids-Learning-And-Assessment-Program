package com.jk.klap.servlet;

import com.jk.klap.bean.ContentBean;
import com.jk.klap.dao.ContentDAO;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import java.io.*;
import java.util.List;

@WebServlet("/ContentServlet")
@MultipartConfig(fileSizeThreshold=1024*1024*2, maxFileSize=1024*1024*10)
public class ContentServlet extends HttpServlet {

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");
        if(action == null) action = "list";

        if(action.equals("list")) {
            int currentPage = 1;
            int recordsPerPage = 5;

            if(request.getParameter("page") != null) {
                currentPage = Integer.parseInt(request.getParameter("page"));
            }

            int start = (currentPage - 1) * recordsPerPage;
            int totalRecords = ContentDAO.getTotalContentCount();
            int totalPages = (int) Math.ceil(totalRecords * 1.0 / recordsPerPage);

            List<ContentBean> contentList = ContentDAO.getAllContent(start, recordsPerPage);

            request.setAttribute("contentList", contentList);
            request.setAttribute("currentPage", currentPage);
            request.setAttribute("totalPages", totalPages);

            RequestDispatcher rd = request.getRequestDispatcher("view_all_content.jsp");
            rd.forward(request, response);
        } 
        else if(action.equals("delete")) {
            int id = Integer.parseInt(request.getParameter("content_id"));
            ContentDAO.deleteContent(id);
            response.sendRedirect("ContentServlet?action=list");
        } 
        else if(action.equals("edit")) {
            int id = Integer.parseInt(request.getParameter("content_id"));
            ContentBean bean = ContentDAO.getContentById(id);
            List<String[]> categories = ContentDAO.getAllCategories();

            request.setAttribute("content", bean);
            request.setAttribute("categories", categories);
            RequestDispatcher rd = request.getRequestDispatcher("edit_content.jsp");
            rd.forward(request, response);
        }
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int contentId = Integer.parseInt(request.getParameter("contentId"));
        int categoryId = Integer.parseInt(request.getParameter("categoryId"));
        String textContent = request.getParameter("textContent");
        

        Part filePart = request.getPart("uploads");
        String imagePath = null;

        if(filePart != null && filePart.getSize() > 0) {
            String fileName = new File(filePart.getSubmittedFileName()).getName();
            String uploadPath = getServletContext().getRealPath("/uploads") + File.separator;
            File fileDir = new File(uploadPath);
            if(!fileDir.exists()) fileDir.mkdirs();
            filePart.write(uploadPath + fileName);
            imagePath = "uploads/" + fileName;
        } else {
            imagePath = request.getParameter("oldImage");
        }

        ContentBean bean = new ContentBean();
        bean.setContentId(contentId);
        bean.setCategoryId(categoryId);
        bean.setTextContent(textContent);
      
        bean.setImagePath(imagePath);

        boolean status = ContentDAO.updateContent(bean);

        if(status) {
            response.sendRedirect("ContentServlet?action=list");
        } else {
            request.setAttribute("msg", "Update Failed");
            doGet(request, response);
        }
    }
}
