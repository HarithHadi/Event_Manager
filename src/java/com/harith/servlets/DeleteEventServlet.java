package com.harith.servlets;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.sql.*;


public class DeleteEventServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String eventIDStr = request.getParameter("eventID");
        if (eventIDStr == null) {
            response.sendRedirect("ClubManagement.jsp?action=missingeventid");
            return;
        }

        try {
            int eventID = Integer.parseInt(eventIDStr);
            Connection conn = DriverManager.getConnection("jdbc:derby://localhost:1527/Event_Manager", "app", "app");

          
            PreparedStatement delAttendance = conn.prepareStatement("DELETE FROM EVENT_ATTENDANCE WHERE EVENT_ID = ?");
            delAttendance.setInt(1, eventID);
            delAttendance.executeUpdate();
            delAttendance.close();

     
            PreparedStatement stmt = conn.prepareStatement("DELETE FROM EVENTS WHERE EVENT_ID = ?");
            stmt.setInt(1, eventID);
            stmt.executeUpdate();
            stmt.close();

            conn.close();
        } catch (Exception e) {
            e.printStackTrace();
        }

        response.sendRedirect("ClubManagement.jsp?action=deletedEventTrue");
    }
}
