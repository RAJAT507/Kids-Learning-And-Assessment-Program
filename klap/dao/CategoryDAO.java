package com.jk.klap.dao;

import com.jk.klap.bean.CategoryBean;
import com.jk.klap.utility.DBConnection;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class CategoryDAO {

    public static boolean addCategory(CategoryBean bean) {
        boolean status = false;
        try {
            Connection con = DBConnection.getConnection();
            String sql = "INSERT INTO categories (category_name) VALUES (?)";
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setString(1, bean.getCategoryName());
            int rows = ps.executeUpdate();
            if (rows > 0) {
                status = true;
            }
            con.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return status;
    }

    public static CategoryBean getCategoryById(int id) {
        CategoryBean bean = null;
        try {
            Connection con = DBConnection.getConnection();
            String sql = "SELECT * FROM categories WHERE category_id = ?";
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setInt(1, id);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                bean = new CategoryBean();
                bean.setCategoryId(rs.getInt("category_id"));
                bean.setCategoryName(rs.getString("category_name"));
                bean.setCreatedAt(rs.getTimestamp("created_at")); // if you want to show created date
            }
            con.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return bean;
    }

    public static boolean updateCategory(CategoryBean bean) {
        boolean status = false;
        try {
            Connection con = DBConnection.getConnection();
            String sql = "UPDATE categories SET category_name = ? WHERE category_id = ?";
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setString(1, bean.getCategoryName());
            ps.setInt(2, bean.getCategoryId());
            int rows = ps.executeUpdate();
            if (rows > 0) {
                status = true;
            }
            con.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return status;
    }

    public static boolean deleteCategory(int categoryId) {
        boolean status = false;
        try {
            Connection con = DBConnection.getConnection();
            String sql = "DELETE FROM categories WHERE category_id = ?";
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setInt(1, categoryId);
            int rows = ps.executeUpdate();
            if (rows > 0) {
                status = true;
            }
            con.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return status;
    }

    // ✅ NEW METHOD: getAllCategories
    public static List<CategoryBean> getAllCategories() {
        List<CategoryBean> list = new ArrayList<>();
        try {
            Connection con = DBConnection.getConnection();
            String sql = "SELECT * FROM categories ORDER BY category_id ASC";
            PreparedStatement ps = con.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                CategoryBean cb = new CategoryBean();
                cb.setCategoryId(rs.getInt("category_id"));
                cb.setCategoryName(rs.getString("category_name"));
                cb.setCreatedAt(rs.getTimestamp("created_at")); // Assuming your DB has this column
                list.add(cb);
            }
            con.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }
}
