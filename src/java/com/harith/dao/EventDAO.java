package com.harith.dao;

import com.harith.model.Event;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class EventDAO {
    private Connection conn;

    public EventDAO(Connection conn) {
        this.conn = conn;
    }

    // Fetch all events with club name
    public List<Event> getAllEvents() {
       List<Event> events = new ArrayList<Event>();

        String sql = "SELECT E.EVENT_ID, E.CLUB_ID, C.CLUB_NAME, E.EVENT_TITLE, E.EVENT_DATE, E.EVENT_DESC " +
                     "FROM EVENTS E JOIN CLUBS C ON E.CLUB_ID = C.CLUB_ID";
        try (
            Statement stmt = conn.createStatement();
            ResultSet rs = stmt.executeQuery(sql)
        ) {
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
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return events;
    }
    
    public int InsertEvent(Event event ) throws SQLException{
        String sql = "INSERT INTO EVENTS (EVENT_TITLE, EVENT_DATE, EVENT_DESC, CLUB_ID) VALUES(?,?,?,?)";
        int generatedId = -1;
         try (PreparedStatement stmt = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {
             stmt.setString(1, event.getEventTitle());
             stmt.setString(2, event.getEventDate());
             stmt.setString(3, event.getEventDesc());
             stmt.setInt(4, event.getClubID());
             
             int rowsAffected = stmt.executeUpdate();
             if(rowsAffected > 0){
                 ResultSet rs = stmt.getGeneratedKeys();
                 if(rs.next()){
                     generatedId = rs.getInt(1);
                 }
                 rs.close();
             }
             
         }
         return generatedId;
    }
    
    public List<Event> getEventsByClubId(int clubId) throws SQLException {
    List<Event> events = new ArrayList<Event>();
    String sql = "SELECT EVENT_ID, EVENT_TITLE, EVENT_DATE, EVENT_DESC FROM EVENTS WHERE CLUB_ID = ?";
    PreparedStatement stmt = conn.prepareStatement(sql);
    stmt.setInt(1, clubId);
    ResultSet rs = stmt.executeQuery();

    while (rs.next()) {
        Event e = new Event();
        e.setEventID(rs.getInt("EVENT_ID"));
        e.setEventTitle(rs.getString("EVENT_TITLE"));
        e.setEventDate(rs.getDate("EVENT_DATE").toString());
        e.setEventDesc(rs.getString("EVENT_DESC"));
        events.add(e);
    }

    rs.close();
    stmt.close();
    return events;
}


   
}
