package com.harith.servlets;

import java.io.IOException;
import java.sql.*;
import javax.servlet.*;
import javax.servlet.http.*;
import com.harith.model.Student;

public class loginServlet extends HttpServlet {

    public void doPost(HttpServletRequest request, HttpServletResponse response)throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");

        String email = request.getParameter("email");
        String password = request.getParameter("password");

        try {
            Connection conn = DriverManager.getConnection("jdbc:derby://localhost:1527/Event_Manager", "app", "app");
            String query = "SELECT * FROM USERS WHERE email=? AND password=?";
            PreparedStatement stmt = conn.prepareStatement(query);
            stmt.setString(1, email);
            stmt.setString(2, password);

            ResultSet rs = stmt.executeQuery();

            if (rs.next()) {
                int userId = rs.getInt("user_id");
                HttpSession session = request.getSession();
                session.setAttribute("userID", rs.getInt("user_id")); // Use actual column name
                session.setAttribute("role", rs.getString("role"));
                
                String studentQuery = "SELECT * FROM STUDENTS WHERE USER_ID=?";
                PreparedStatement studentStmt = conn.prepareStatement(studentQuery);
                studentStmt.setInt(1, userId);
                ResultSet studentrs = studentStmt.executeQuery();
                
                if(studentrs.next()){
                    Student student = new Student();
                    student.setStudentID(studentrs.getInt("STUDENT_ID"));
                    student.setUserID(userId);
                    student.setClubID(studentrs.getInt("CLUB_ID"));
                    student.setStudentName(studentrs.getString("STUDENT_NAME"));
                    student.setStudentCourse(studentrs.getString("STUDENT_COURSE"));
                    student.setStudentPart(studentrs.getInt("STUDENT_PART"));
                    student.setStudentGroup(studentrs.getString("STUDENT_GROUP"));
                    student.setStudentPhone(studentrs.getInt("STUDENT_PHONE"));
                    
                    session.setAttribute("currentStudent", student);
                }
                studentrs.close();
                studentStmt.close();
                
                response.sendRedirect("index.jsp");
            } else {
                response.sendRedirect("loginn.jsp?error=invalid");
            }

            rs.close();
            stmt.close();
            conn.close();

        } catch (Exception e) {
            e.printStackTrace();
            response.getWriter().println("Login error: " + e.getMessage());
        }
    }
}
    