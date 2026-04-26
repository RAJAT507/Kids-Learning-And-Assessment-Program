package com.jk.klap.dao;

import com.jk.klap.bean.ParentBean;
import com.jk.klap.utility.DBConnection;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class ParentDAO {

    Connection con;

    public ParentDAO(Connection con) {
        this.con = con;
    }

    // 🔥 CHECK EMAIL EXISTS
    public boolean isEmailExists(String email) {
        boolean exists = false;
        try {
            String sql = "SELECT parent_id FROM parents WHERE email=?";
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setString(1, email);

            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                exists = true;
            }

        } catch (Exception e) {
            e.printStackTrace();
        }
        return exists;
    }

    // REGISTER
    public boolean registerParent(ParentBean parent) {
        boolean status = false;
        try {
            String sql = "INSERT INTO parents(name, email, password, contact) VALUES(?, ?, ?, ?)";
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setString(1, parent.getName());
            ps.setString(2, parent.getEmail());
            ps.setString(3, parent.getPassword());
            ps.setString(4, parent.getContact());

            int i = ps.executeUpdate();
            if (i > 0) status = true;

        } catch (Exception e) {
            e.printStackTrace();
        }
        return status;
    }

    // LOGIN
    public static boolean checkLogin(String email, String password) {
        boolean status = false;
        try {
            Connection con = DBConnection.getConnection();
            String sql = "SELECT * FROM parents WHERE email=? AND password=?";
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setString(1, email);
            ps.setString(2, password);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                status = true;
            }
            con.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return status;
    }

    public List<ParentBean> getAllParents() {
        List<ParentBean> list = new ArrayList<>();
        try {
            String sql = "SELECT * FROM parents";
            PreparedStatement ps = con.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                ParentBean p = new ParentBean();
                p.setParentId(rs.getInt("parent_id"));
                p.setName(rs.getString("name"));
                p.setEmail(rs.getString("email"));
                p.setPassword(rs.getString("password"));
                p.setContact(rs.getString("contact"));
                list.add(p);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    public static int getParentIdByEmail(String email) {
        int parentId = -1;
        try {
            Connection con = DBConnection.getConnection();
            PreparedStatement ps = con.prepareStatement("SELECT parent_id FROM parents WHERE email = ?");
            ps.setString(1, email);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                parentId = rs.getInt("parent_id");
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return parentId;
    }
}