package com.harith.servlets;

import com.harith.dao.OrganizerDAO;
import java.io.IOException;
import java.sql.*;
import javax.servlet.*;
import javax.servlet.http.*;
import com.harith.model.Student;
import com.harith.model.User;
import com.harith.dao.UserDAO;
import com.harith.dao.StudentDAO;

public class loginServlet extends HttpServlet {

    public void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");

        String email = request.getParameter("email");
        String password = request.getParameter("password");

        try {
            Connection conn = DriverManager.getConnection("jdbc:derby://localhost:1527/Event_Manager", "app", "app");
            UserDAO userDAO = new UserDAO(conn);
            
            User user = userDAO.getUserByEmailAndPassword(email, password);
            StudentDAO studentDAO = new StudentDAO(conn);
            OrganizerDAO organizerDAO = new OrganizerDAO(conn);
            
            
            if(user != null){
                int userId = user.getUserId();
                String role = user.getRole();
                
                Student student = studentDAO.getStudentByUserId(userId);
                boolean isOrganizer = (student != null) && organizerDAO.CheckIfStudentIsOrganizer(student.getStudentID());
                
                HttpSession session = request.getSession();
                session.setAttribute("userID", userId);
                session.setAttribute("role", role);
                session.setAttribute("currentStudent", student);
                session.setAttribute("isOrganizer", isOrganizer);

                response.sendRedirect("index.jsp");
            }else{
                response.sendRedirect("loginn.jsp?error=invalid");
            }
            

        } catch (Exception e) {
            e.printStackTrace();
            response.getWriter().println("Login error: " + e.getMessage());
        }
    }
}
    
