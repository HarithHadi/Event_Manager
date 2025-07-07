package com.harith.dao;

import com.harith.model.Event; 
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.List;
import java.util.ArrayList;


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
    
    // rsvp'd events for students
    public List<Event> getRsvpEventsByStudentId(int studentId) throws SQLException {
    List<Event> events = new ArrayList<Event>();
    String sql = "SELECT e.EVENT_ID, e.CLUB_ID, c.CLUB_NAME, e.EVENT_TITLE, e.EVENT_DATE, e.EVENT_DESC " +
                 "FROM EVENTS e JOIN EVENT_ATTENDANCE ea ON e.EVENT_ID = ea.EVENT_ID " +
                 "JOIN CLUBS c ON e.CLUB_ID = c.CLUB_ID WHERE ea.STUDENT_ID = ?";
    PreparedStatement stmt = conn.prepareStatement(sql);
    stmt.setInt(1, studentId);
    ResultSet rs = stmt.executeQuery();

    while (rs.next()) {
        Event event = new Event();
        event.setEventID(rs.getInt("EVENT_ID"));
        event.setClubID(rs.getInt("CLUB_ID"));
        event.setClubName(rs.getString("CLUB_NAME"));
        event.setEventTitle(rs.getString("EVENT_TITLE"));
        event.setEventDate(rs.getDate("EVENT_DATE").toString());
        event.setEventDesc(rs.getString("EVENT_DESC"));
        events.add(event);
    }
    rs.close();
    stmt.close();
    return events;
}
}

  



