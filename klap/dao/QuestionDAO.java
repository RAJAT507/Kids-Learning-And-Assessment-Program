package com.jk.klap.dao;

import com.jk.klap.bean.QuestionBean;
import java.sql.*;
import java.util.*;

public class QuestionDAO {
    private Connection con;

    public QuestionDAO(Connection con) {
        this.con = con;
    }

    public void addQuestion(QuestionBean q) {
        try {
            PreparedStatement ps = con.prepareStatement(
                "INSERT INTO test_questions (category_id, question_text, question_image, option_a, option_b, option_c, option_d, correct_option, difficulty_level) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)");
            ps.setInt(1, q.getCategoryId());
            ps.setString(2, q.getQuestionText());
            ps.setString(3, q.getQuestionImage());
            ps.setString(4, q.getOptionA());
            ps.setString(5, q.getOptionB());
            ps.setString(6, q.getOptionC());
            ps.setString(7, q.getOptionD());
            ps.setString(8, q.getCorrectOption());
            ps.setString(9, q.getDifficultyLevel());
            ps.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public void updateQuestion(QuestionBean q) {
        try {
            PreparedStatement ps = con.prepareStatement(
                "UPDATE test_questions SET question_text=?, question_image=?, option_a=?, option_b=?, option_c=?, option_d=?, correct_option=?, difficulty_level=? WHERE question_id=?");
            ps.setString(1, q.getQuestionText());
            ps.setString(2, q.getQuestionImage());
            ps.setString(3, q.getOptionA());
            ps.setString(4, q.getOptionB());
            ps.setString(5, q.getOptionC());
            ps.setString(6, q.getOptionD());
            ps.setString(7, q.getCorrectOption());
            ps.setString(8, q.getDifficultyLevel());
            ps.setInt(9, q.getQuestionId());
            ps.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public void deleteQuestion(int questionId) {
        try {
            PreparedStatement ps = con.prepareStatement("DELETE FROM test_questions WHERE question_id=?");
            ps.setInt(1, questionId);
            ps.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public QuestionBean getQuestionById(int questionId) {
        QuestionBean q = new QuestionBean();
        try {
            PreparedStatement ps = con.prepareStatement("SELECT * FROM test_questions WHERE question_id=?");
            ps.setInt(1, questionId);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                q.setQuestionId(rs.getInt("question_id"));
                q.setCategoryId(rs.getInt("category_id"));
                q.setQuestionText(rs.getString("question_text"));
                q.setQuestionImage(rs.getString("question_image"));
                q.setOptionA(rs.getString("option_a"));
                q.setOptionB(rs.getString("option_b"));
                q.setOptionC(rs.getString("option_c"));
                q.setOptionD(rs.getString("option_d"));
                q.setCorrectOption(rs.getString("correct_option"));
                q.setDifficultyLevel(rs.getString("difficulty_level"));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return q;
    }

    public List<QuestionBean> getQuestionsByCategory(int categoryId) {
        List<QuestionBean> list = new ArrayList<>();
        try {
            PreparedStatement ps = con.prepareStatement("SELECT * FROM test_questions WHERE category_id=?");
            ps.setInt(1, categoryId);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                QuestionBean q = new QuestionBean();
                q.setQuestionId(rs.getInt("question_id"));
                q.setCategoryId(rs.getInt("category_id"));
                q.setQuestionText(rs.getString("question_text"));
                q.setQuestionImage(rs.getString("question_image"));
                q.setOptionA(rs.getString("option_a"));
                q.setOptionB(rs.getString("option_b"));
                q.setOptionC(rs.getString("option_c"));
                q.setOptionD(rs.getString("option_d"));
                q.setCorrectOption(rs.getString("correct_option"));
                q.setDifficultyLevel(rs.getString("difficulty_level"));
                list.add(q);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }
}