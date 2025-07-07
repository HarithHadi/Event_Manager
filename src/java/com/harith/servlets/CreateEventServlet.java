
package com.harith.servlets;

import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.harith.dao.EventDAO;
import com.harith.model.Event;
import com.harith.model.Student;
import java.sql.Connection;
import java.sql.DriverManager;
import javax.servlet.http.HttpSession;

/**
 *
 * @author User
 */
public class CreateEventServlet extends HttpServlet {

    protected void doPost(HttpServletRequest request, HttpServletResponse response)throws ServletException, IOException {
        try{
            String title = request.getParameter("eventTitle");
            String category = request.getParameter("eventCategory"); // optional: save this too
            String date = request.getParameter("eventDate");
            String desc = request.getParameter("eventDescription");
            
            HttpSession session = request.getSession();
            Student organizer = (Student) session.getAttribute("currentStudent");
            
            if(organizer == null){
                response.sendRedirect("loginn.jsp?error=unauthorized");
                return;
            }
            
            int clubId = organizer.getClubID();
            
            Event event = new Event();
            event.setEventTitle(title);
            event.setEventDate(date);
            event.setEventDesc(desc);
            event.setClubID(clubId);
            
            Connection conn = DriverManager.getConnection("jdbc:derby://localhost:1527/Event_Manager", "app", "app");
            EventDAO eventDAO = new EventDAO(conn);
            int eventId = eventDAO.InsertEvent(event);
            
            conn.close();
            
            if (eventId > 0) {
                response.sendRedirect("index.jsp?event=created");
            } else {
                response.sendRedirect("create-event.jsp?error=insertfail");
            }
            
            
            
        }catch (Exception e) {
            e.printStackTrace();
            response.getWriter().println("Error creating event: " + e.getMessage());
        }
       
    }


}
