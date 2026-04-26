package com.jk.klap.servlet;

import com.jk.klap.bean.QuestionBean;
import com.jk.klap.dao.QuestionDAO;
import com.jk.klap.dao.TestResultDAO;
import com.jk.klap.bean.TestResultBean;
import com.jk.klap.utility.DBConnection;

import jakarta.servlet.*;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.sql.Connection;
import java.util.List;

@WebServlet("/SubmitTestServlet")
public class SubmitTestServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();
        Integer parentId = (Integer) session.getAttribute("parent_id");

        if (parentId == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        try {
            // Fetch form parameters
            int categoryId = Integer.parseInt(request.getParameter("categoryId"));
            int totalQuestions = Integer.parseInt(request.getParameter("totalQuestions"));

            // Database connection & DAO initialization
            Connection conn = DBConnection.getConnection();
            QuestionDAO qdao = new QuestionDAO(conn);
            List<QuestionBean> questions = qdao.getQuestionsByCategory(categoryId);

            int correctAnswers = 0;

            // Check answers one by one
            for (QuestionBean question : questions) {
                String ansParam = request.getParameter("q" + question.getQuestionId());
                if (ansParam != null) {
                    String correctOption = question.getCorrectOption();
                    if (ansParam.equals(correctOption)) {
                        correctAnswers++;
                    }
                }
            }

            // Calculate percentage
            double percentage = (correctAnswers * 100.0) / totalQuestions;

            // Supercoin logic
            int supercoinAdded = (percentage >= 80) ? 1 : 0;

            // Create TestResultBean and save result
            TestResultBean result = new TestResultBean();
            result.setParentId(parentId);
            result.setCategoryId(categoryId);
            result.setTotalQuestions(totalQuestions);
            result.setCorrectAnswers(correctAnswers);
            result.setPercentage(percentage);
            result.setSupercoinAdded(supercoinAdded);
            result.setPdfPath("N/A");  // If no PDF generated yet

            boolean saved = TestResultDAO.saveTestResult(result);

            if (saved) {
                response.sendRedirect("results.jsp?msg=Test+Submitted+Successfully&score=" 
                    + correctAnswers + "&total=" + totalQuestions);
            } else {
                response.sendRedirect("test.jsp?error=Could+not+save+result");
            }

        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("test.jsp?error=Error+occurred");
        }
    }
}
