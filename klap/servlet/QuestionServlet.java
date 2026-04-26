package com.jk.klap.servlet;

import com.jk.klap.bean.QuestionBean;
import com.jk.klap.dao.QuestionDAO;
import com.jk.klap.utility.DBConnection;
import jakarta.servlet.*;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.*;
import java.sql.Connection;

@WebServlet("/QuestionServlet")
@MultipartConfig(
    fileSizeThreshold = 1024 * 1024 * 1,
    maxFileSize = 1024 * 1024 * 10,
    maxRequestSize = 1024 * 1024 * 15
)
public class QuestionServlet extends HttpServlet {

    private String saveImage(Part part, HttpServletRequest request) throws IOException {
        String fileName = part.getSubmittedFileName();
        if (fileName == null || fileName.trim().isEmpty()) return null;

        String uploadPath = request.getServletContext().getRealPath("/") + "uploads";
        File uploadDir = new File(uploadPath);
        if (!uploadDir.exists()) uploadDir.mkdirs();

        String filePath = uploadPath + File.separator + fileName;
        try (InputStream input = part.getInputStream(); FileOutputStream fos = new FileOutputStream(filePath)) {
            byte[] buffer = new byte[1024];
            int bytesRead;
            while ((bytesRead = input.read(buffer)) != -1) {
                fos.write(buffer, 0, bytesRead);
            }
        }

        return "uploads/" + fileName;
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");
        Connection con = DBConnection.getConnection();
        QuestionDAO dao = new QuestionDAO(con);

        if ("add".equals(action)) {
            handleAddQuestion(request, response, dao);
        } else if ("update".equals(action)) {
            handleUpdateQuestion(request, response, dao);
        } else {
            response.sendRedirect("error.jsp");
        }
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");
        Connection con = DBConnection.getConnection();
        QuestionDAO dao = new QuestionDAO(con);

        if ("delete".equals(action)) {
            int questionId = Integer.parseInt(request.getParameter("question_id"));
            int categoryId = Integer.parseInt(request.getParameter("category_id"));
            dao.deleteQuestion(questionId);
            response.sendRedirect("view_questions.jsp?category_id=" + categoryId);
        } else {
            response.sendRedirect("error.jsp");
        }
    }

    private void handleAddQuestion(HttpServletRequest request, HttpServletResponse response, QuestionDAO dao) throws IOException, ServletException {
        QuestionBean q = extractQuestionFromRequest(request);

        Part imagePart = request.getPart("question_image");
        String imagePath = saveImage(imagePart, request);
        q.setQuestionImage(imagePath);

        dao.addQuestion(q);
        response.sendRedirect("view_questions.jsp?category_id=" + q.getCategoryId());
    }

    private void handleUpdateQuestion(HttpServletRequest request, HttpServletResponse response, QuestionDAO dao) throws IOException, ServletException {
        int questionId = Integer.parseInt(request.getParameter("question_id"));
        QuestionBean q = extractQuestionFromRequest(request);
        q.setQuestionId(questionId);

        Part imagePart = request.getPart("question_image");
        String imagePath = saveImage(imagePart, request);

        if (imagePath != null) {
            q.setQuestionImage(imagePath);
        } else {
            QuestionBean existing = dao.getQuestionById(questionId);
            q.setQuestionImage(existing.getQuestionImage());
        }

        dao.updateQuestion(q);
        response.sendRedirect("view_questions.jsp?category_id=" + q.getCategoryId());
    }

    private QuestionBean extractQuestionFromRequest(HttpServletRequest request) {
        QuestionBean q = new QuestionBean();
        q.setCategoryId(Integer.parseInt(request.getParameter("category_id")));
        q.setQuestionText(request.getParameter("question_text"));
        q.setOptionA(request.getParameter("option_a"));
        q.setOptionB(request.getParameter("option_b"));
        q.setOptionC(request.getParameter("option_c"));
        q.setOptionD(request.getParameter("option_d"));
        q.setCorrectOption(request.getParameter("correct_option"));
        q.setDifficultyLevel(request.getParameter("difficulty_level"));
        return q;
    }
}