package com.harith.servlets;

import com.harith.model.Student;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.sql.*;


public class UpdateProfileServlet extends HttpServlet {

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Retrieve updated values from form
        String newName = request.getParameter("studentName");
        String newPhoneStr = request.getParameter("studentPhone");

        // Validate and parse phone
        int newPhone = 0;
        try {
            newPhone = Integer.parseInt(newPhoneStr);
        } catch (NumberFormatException e) {
            e.printStackTrace();
            response.sendRedirect("profile.jsp?error=invalidphone");
            return;
        }

        HttpSession session = request.getSession();
        Student student = (Student) session.getAttribute("currentStudent");

        if (student == null) {
            response.sendRedirect("loginn.jsp?haataklogin=true");
            return;
        }

        try (Connection conn = DriverManager.getConnection("jdbc:derby://localhost:1527/Event_Manager", "app", "app")) {
            String sql = "UPDATE STUDENTS SET STUDENT_NAME = ?, STUDENT_PHONE = ? WHERE STUDENT_ID = ?";
            PreparedStatement stmt = conn.prepareStatement(sql);
            stmt.setString(1, newName);
            stmt.setInt(2, newPhone);
            stmt.setInt(3, student.getStudentID());

            int rows = stmt.executeUpdate();
            if (rows > 0) {
               
                student.setStudentName(newName);
                student.setStudentPhone(newPhone);
                session.setAttribute("currentStudent", student);
            }

            stmt.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }

        response.sendRedirect("profile.jsp?updated=true");
    }
}
