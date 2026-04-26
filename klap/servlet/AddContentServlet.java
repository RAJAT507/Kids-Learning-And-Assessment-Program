package com.jk.klap.servlet;

import com.jk.klap.bean.ContentBean;
import com.jk.klap.dao.ContentDAO;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import java.io.*;

@WebServlet("/AddContentServlet")
@MultipartConfig(fileSizeThreshold=1024*1024*2, maxFileSize=1024*1024*10)
public class AddContentServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        int categoryId = Integer.parseInt(request.getParameter("categoryId"));
        String textContent = request.getParameter("textContent");
        String volumeLevel = request.getParameter("volumeLevel");

        // File upload
        Part filePart = request.getPart("image");
        String fileName = filePart.getSubmittedFileName();
        String uploadPath = getServletContext().getRealPath("/") + "uploads" + File.separator;
        File fileDir = new File(uploadPath);
        if(!fileDir.exists()) {
            fileDir.mkdirs();
        }
        String imagePath = "uploads/" + fileName;
        filePart.write(uploadPath + fileName);

        // Set bean values
        ContentBean bean = new ContentBean();
        bean.setCategoryId(categoryId);
        bean.setImagePath(imagePath);
        bean.setTextContent(textContent);
        bean.setVolumeLevel(volumeLevel);

        boolean status = ContentDAO.addContent(bean);

        if(status) {
            response.sendRedirect("add_content.jsp?msg=success");
        } else {
            response.sendRedirect("add_content.jsp?msg=fail");
        }
    }
}
