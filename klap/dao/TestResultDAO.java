/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.jk.klap.dao;

/**
 *
 * @author Mahadev
 */


import com.jk.klap.bean.TestResultBean;
import com.jk.klap.utility.DBConnection;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

public class TestResultDAO {

    public static boolean saveTestResult(TestResultBean result) {
        boolean flag = false;

        try {
            Connection conn = DBConnection.getConnection();
            String sql = "INSERT INTO test_results (parent_id, test_date, category_id, total_questions, correct_answers, percentage, supercoin_added, pdf_path, created_at) "
                       + "VALUES (?, NOW(), ?, ?, ?, ?, ?, ?, NOW())";

            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setInt(1, result.getParentId());
            ps.setInt(2, result.getCategoryId());
            ps.setInt(3, result.getTotalQuestions());
            ps.setInt(4, result.getCorrectAnswers());
            ps.setDouble(5, result.getPercentage());
            ps.setInt(6, result.getSupercoinAdded());
            ps.setString(7, result.getPdfPath());

            int i = ps.executeUpdate();
            if (i > 0) {
                flag = true;
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return flag;
    }
    public List<TestResultBean> getResultsByParentId(int parentId) {
    List<TestResultBean> list = new ArrayList<>();
    try {
        String sql = "SELECT * FROM test_results WHERE parent_id = ?";
        PreparedStatement ps = DBConnection.getConnection().prepareStatement(sql);
        ps.setInt(1, parentId);
        ResultSet rs = ps.executeQuery();

        while (rs.next()) {
            TestResultBean r = new TestResultBean();
            r.setCategoryId(rs.getInt("category_id"));
            r.setTotalQuestions(rs.getInt("total_questions"));
            r.setCorrectAnswers(rs.getInt("correct_answers"));
            r.setPercentage(rs.getDouble("percentage"));
            r.setSupercoinAdded(rs.getInt("supercoin_added"));
            list.add(r);
        }

    } catch (Exception e) {
        e.printStackTrace();
    }
    return list;
}

}
