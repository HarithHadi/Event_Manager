package com.harith.servlets;

import java.io.IOException;
import java.sql.*;
import javax.servlet.*;
import javax.servlet.http.*;

public class RSVPServlet extends HttpServlet {

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        try {
            int eventId = Integer.parseInt(request.getParameter("event_id"));
            HttpSession session = request.getSession();
            int userId = (int) session.getAttribute("userID");
            int studentId = getStudentId(userId);

            Connection conn = DriverManager.getConnection(
                    "jdbc:derby://localhost:1527/Event_Manager", "app", "app");

            // Check if already RSVP’d
            String checkSql = "SELECT * FROM EVENT_ATTENDANCE WHERE student_id = ? AND event_id = ?";
            PreparedStatement checkStmt = conn.prepareStatement(checkSql);
            checkStmt.setInt(1, studentId);
            checkStmt.setInt(2, eventId);
            ResultSet checkRs = checkStmt.executeQuery();

            if (checkRs.next()) {
                // Already RSVP’d
                response.sendRedirect("index.jsp?rsvp=exists");
            } else {
                // Insert new RSVP
                String insertSql = "INSERT INTO EVENT_ATTENDANCE (student_id, event_id) VALUES (?, ?)";
                PreparedStatement insertStmt = conn.prepareStatement(insertSql);
                insertStmt.setInt(1, studentId);
                insertStmt.setInt(2, eventId);
                insertStmt.executeUpdate();
                insertStmt.close();

                response.sendRedirect("index.jsp?rsvp=success");
            }

            checkRs.close();
            checkStmt.close();
            conn.close();

        } catch (SQLException e) {
            e.printStackTrace();
            response.getWriter().println("RSVP Error: " + e.getMessage());
        } catch (NumberFormatException e) {
            e.printStackTrace();
            response.getWriter().println("Invalid event ID.");
        } catch (Exception e) {
            e.printStackTrace();
            response.getWriter().println("Unexpected error: " + e.getMessage());
        }
    }

    private int getStudentId(int userId) throws SQLException {
        int studentId = -1;
        Connection conn = DriverManager.getConnection(
                "jdbc:derby://localhost:1527/Event_Manager", "app", "app");

        String sql = "SELECT STUDENT_ID FROM STUDENTS WHERE USER_ID = ?";
        PreparedStatement stmt = conn.prepareStatement(sql);
        stmt.setInt(1, userId);
        ResultSet rs = stmt.executeQuery();

        if (rs.next()) {
            studentId = rs.getInt("STUDENT_ID");
        }

        rs.close();
        stmt.close();
        conn.close();

        return studentId;
    }
}
