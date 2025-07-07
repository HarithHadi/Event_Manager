package com.harith.servlets;

import java.io.IOException;
import java.sql.*;
import javax.servlet.*;
import javax.servlet.http.*;
import com.harith.dao.EventAttendanceDAO;
import com.harith.model.Student;

public class RSVPServlet extends HttpServlet {

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        
        try {
            int eventId = Integer.parseInt(request.getParameter("event_id"));
            
            HttpSession session = request.getSession();
            Student student =(Student) session.getAttribute("currentStudent");
            
            if(student == null){
                response.sendRedirect("index.jsp?rsvp=unauthorized");
                return;
            }
            
            int studentId = student.getStudentID();
            System.out.println(studentId);
            Connection conn = DriverManager.getConnection("jdbc:derby://localhost:1527/Event_Manager", "app", "app");
            EventAttendanceDAO eventDAO = new EventAttendanceDAO(conn);
            
            if(eventDAO.hasRSVPed(studentId, eventId)){
                response.sendRedirect("index.jsp?rsvp=exists");
            }else{
                eventDAO.insertRSVP(studentId, eventId);
                response.sendRedirect("index.jsp?rsvp=success");
            }
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

}
