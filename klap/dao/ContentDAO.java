/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.jk.klap.dao;

/**
 *
 * @author Mahadev
 */



import com.jk.klap.bean.ContentBean;
import com.jk.klap.utility.DBConnection;
import java.sql.*;
import java.util.ArrayList;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

public class ContentDAO {
    
    public static Map<String, List<ContentBean>> getContentGroupedByCategory() {
    Map<String, List<ContentBean>> contentMap = new LinkedHashMap<>();

    try (Connection con = DBConnection.getConnection()) {
        String sql = "SELECT c.content_id, c.category_id, cat.category_name, c.image_path, c.text_content, c.volume_level " +
                     "FROM learning_content c JOIN categories cat ON c.category_id = cat.category_id " +
                     "ORDER BY cat.category_name, c.content_id";

        PreparedStatement ps = con.prepareStatement(sql);
        ResultSet rs = ps.executeQuery();

        while (rs.next()) {
            ContentBean bean = new ContentBean();
            bean.setContentId(rs.getInt("content_id"));
            bean.setCategoryId(rs.getInt("category_id"));
            bean.setTextContent(rs.getString("text_content"));
            bean.setImagePath(rs.getString("image_path"));
            bean.setVolumeLevel(rs.getString("volume_level"));

            String categoryName = rs.getString("category_name");

            contentMap.computeIfAbsent(categoryName, k -> new ArrayList<>()).add(bean);
        }
    } catch (Exception e) {
        e.printStackTrace();
    }

    return contentMap;
}


    public static boolean addContent(ContentBean bean) {
        boolean status = false;
        try {
            Connection con = DBConnection.getConnection();
            String sql = "INSERT INTO learning_content (category_id, image_path, text_content, volume_level) VALUES (?,?,?,?)";
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setInt(1, bean.getCategoryId());
            ps.setString(2, bean.getImagePath());
            ps.setString(3, bean.getTextContent());
            ps.setString(4, bean.getVolumeLevel());
            int rows = ps.executeUpdate();
            if(rows > 0) {
                status = true;
            }
            con.close();
        } catch(Exception e) {
            e.printStackTrace();
        }
        return status;
    }

    // For dropdown — fetch all categories
    public static List<String[]> getAllCategories() {
        List<String[]> list = new ArrayList<>();
        try {
            Connection con = DBConnection.getConnection();
            String sql = "SELECT category_id, category_name FROM categories";
            PreparedStatement ps = con.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();
            while(rs.next()) {
                String[] cat = {rs.getString("category_id"), rs.getString("category_name")};
                list.add(cat);
            }
            con.close();
        } catch(Exception e) {
            e.printStackTrace();
        }
        return list;
    }
        public static List<ContentBean> getContents(int offset, int noOfRecords) {
        List<ContentBean> list = new ArrayList<>();
        Connection con = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        try {
            con = DBConnection.getConnection();
            String sql = "SELECT lc.*, c.category_name FROM learning_content lc INNER JOIN categories c ON lc.category_id = c.category_id ORDER BY content_id DESC LIMIT ?, ?";
            ps = con.prepareStatement(sql);
            ps.setInt(1, offset);
            ps.setInt(2, noOfRecords);
            rs = ps.executeQuery();
            while(rs.next()) {
                ContentBean bean = new ContentBean();
                bean.setContentId(rs.getInt("content_id"));
                bean.setCategoryId(rs.getInt("category_id"));
                bean.setImagePath(rs.getString("image_path"));
                bean.setTextContent(rs.getString("text_content"));
                bean.setVolumeLevel(rs.getString("volume_level"));
                // For display category name, optional: can add in ContentBean if needed
                list.add(bean);
            }
        } catch(Exception e) {
            e.printStackTrace();
        } finally {
            try { if(rs!=null) rs.close(); } catch(Exception e) {}
            try { if(ps!=null) ps.close(); } catch(Exception e) {}
            try { if(con!=null) con.close(); } catch(Exception e) {}
        }
        return list;
    }

    public static int getContentCount() {
        int count = 0;
        try(Connection con = DBConnection.getConnection();
            PreparedStatement ps = con.prepareStatement("SELECT COUNT(*) FROM learning_content");
            ResultSet rs = ps.executeQuery();) {
            if(rs.next()) count = rs.getInt(1);
        } catch(Exception e) {
            e.printStackTrace();
        }
        return count;
    }

    public static boolean deleteContent(int contentId) {
        boolean status = false;
        try(Connection con = DBConnection.getConnection();
            PreparedStatement ps = con.prepareStatement("DELETE FROM learning_content WHERE content_id = ?")) {
            ps.setInt(1, contentId);
            int rows = ps.executeUpdate();
            status = rows > 0;
        } catch(Exception e) {
            e.printStackTrace();
        }
        return status;
    }

    public static ContentBean getContentById(int contentId) {
        ContentBean bean = null;
        try(Connection con = DBConnection.getConnection();
            PreparedStatement ps = con.prepareStatement("SELECT * FROM learning_content WHERE content_id = ?")) {
            ps.setInt(1, contentId);
            ResultSet rs = ps.executeQuery();
            if(rs.next()) {
                bean = new ContentBean();
                bean.setContentId(rs.getInt("content_id"));
                bean.setCategoryId(rs.getInt("category_id"));
                bean.setImagePath(rs.getString("image_path"));
                bean.setTextContent(rs.getString("text_content"));
                bean.setVolumeLevel(rs.getString("volume_level"));
            }
            rs.close();
        } catch(Exception e) {
            e.printStackTrace();
        }
        return bean;
    }

    public static boolean updateContent(ContentBean bean) {
        boolean status = false;
        try(Connection con = DBConnection.getConnection();
            PreparedStatement ps = con.prepareStatement("UPDATE learning_content SET category_id=?, image_path=?, text_content=?, volume_level=? WHERE content_id=?")) {
            ps.setInt(1, bean.getCategoryId());
            ps.setString(2, bean.getImagePath());
            ps.setString(3, bean.getTextContent());
            ps.setString(4, bean.getVolumeLevel());
            ps.setInt(5, bean.getContentId());
            int rows = ps.executeUpdate();
            status = rows > 0;
        } catch(Exception e) {
            e.printStackTrace();
        }
        return status;
    }
    public static List<ContentBean> getAllContent(int start, int total) {
    List<ContentBean> list = new ArrayList<>();
    try {
        Connection con = DBConnection.getConnection();
        String sql = "SELECT lc.content_id, lc.category_id, c.category_name, lc.image_path, lc.text_content, lc.volume_level " +
                     "FROM learning_content lc JOIN categories c ON lc.category_id = c.category_id " +
                     "ORDER BY lc.created_at DESC LIMIT ?, ?";
        PreparedStatement ps = con.prepareStatement(sql);
        ps.setInt(1, start);
        ps.setInt(2, total);
        ResultSet rs = ps.executeQuery();
        while(rs.next()) {
            ContentBean bean = new ContentBean();
            bean.setContentId(rs.getInt("content_id"));
            bean.setCategoryId(rs.getInt("category_id"));
            // Agar category name bhi chahiye, to bean mein add kar sakta hai agar field hai
            bean.setImagePath(rs.getString("image_path"));
            bean.setTextContent(rs.getString("text_content"));
            bean.setVolumeLevel(rs.getString("volume_level"));
            list.add(bean);
        }
        con.close();
    } catch(Exception e) {
        e.printStackTrace();
    }
    return list;
}
public static int getTotalContentCount() {
    int count = 0;
    try {
        Connection con = DBConnection.getConnection();
        PreparedStatement ps = con.prepareStatement("SELECT COUNT(*) FROM learning_content");
        ResultSet rs = ps.executeQuery();
        if(rs.next()) {
            count = rs.getInt(1);
        }
        con.close();
    } catch(Exception e) {
        e.printStackTrace();
    }
    return count;
}

public static List<ContentBean> getContentByCategoryId(int categoryId) {
    List<ContentBean> list = new ArrayList<>();
    try {
        Connection con = DBConnection.getConnection();
        String sql = "SELECT * FROM learning_content WHERE category_id = ?";
        PreparedStatement ps = con.prepareStatement(sql);
        ps.setInt(1, categoryId);
        ResultSet rs = ps.executeQuery();
        while(rs.next()) {
            ContentBean bean = new ContentBean();
            bean.setContentId(rs.getInt("content_id"));
            bean.setCategoryId(rs.getInt("category_id"));
            bean.setImagePath(rs.getString("image_path"));
            bean.setTextContent(rs.getString("text_content"));
            bean.setVolumeLevel(rs.getString("volume_level"));
            list.add(bean);
        }
        con.close();
    } catch(Exception e) {
        e.printStackTrace();
    }
    return list;
}
 public static List<String[]> getQuestionsByCategoryId(int categoryId) {
        List<String[]> list = new ArrayList<>();
        try {
            Connection con = DBConnection.getConnection();
            PreparedStatement ps = con.prepareStatement(
                "SELECT question_id, question_text, option1, option2, option3, option4, correct_option FROM test_questions WHERE category_id = ?"
            );
            ps.setInt(1, categoryId);
            ResultSet rs = ps.executeQuery();
            while(rs.next()) {
                String[] data = new String[7];
                data[0] = rs.getString("question_id");
                data[1] = rs.getString("question_text");
                data[2] = rs.getString("option1");
                data[3] = rs.getString("option2");
                data[4] = rs.getString("option3");
                data[5] = rs.getString("option4");
                data[6] = rs.getString("correct_option");
                list.add(data);
            }
        } catch(Exception e) {
            e.printStackTrace();
        }
        return list;
    }
 
}
