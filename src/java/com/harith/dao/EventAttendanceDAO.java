package com.harith.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class EventAttendanceDAO {
    private Connection conn;

    public EventAttendanceDAO(Connection conn) {
        this.conn = conn;
    }

    // Check if student already RSVP'd
    public boolean hasRSVPed(int studentId, int eventId) throws SQLException {
        String sql = "SELECT * FROM EVENT_ATTENDANCE WHERE student_id = ? AND event_id = ?";
        PreparedStatement stmt = conn.prepareStatement(sql);
        stmt.setInt(1, studentId);
        stmt.setInt(2, eventId);
        ResultSet rs = stmt.executeQuery();

        boolean exists = rs.next();

        rs.close();
        stmt.close();
        return exists;
    }

    // Insert a new RSVP
    public void insertRSVP(int studentId, int eventId) throws SQLException {
        String sql = "INSERT INTO EVENT_ATTENDANCE (student_id, event_id) VALUES (?, ?)";
        PreparedStatement stmt = conn.prepareStatement(sql);
        stmt.setInt(1, studentId);
        stmt.setInt(2, eventId);
        stmt.executeUpdate();
        stmt.close();
    }

    // Get student ID by user ID
    public int getStudentIdByUserId(int userId) throws SQLException {
        int studentId = -1;
        String sql = "SELECT STUDENT_ID FROM STUDENTS WHERE USER_ID = ?";
        PreparedStatement stmt = conn.prepareStatement(sql);
        stmt.setInt(1, userId);
        ResultSet rs = stmt.executeQuery();

        if (rs.next()) {
            studentId = rs.getInt("STUDENT_ID");
        }

        rs.close();
        stmt.close();
        return studentId;
    }
}
