
package com.harith.servlets;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;


public class RemoveMemberServlet extends HttpServlet {


    protected void doPost(HttpServletRequest request, HttpServletResponse response)throws ServletException, IOException {
        int StudentId = Integer.parseInt(request.getParameter("student_id"));
        if(StudentId == 0){
            response.sendRedirect("ClubManagement.jsp?action=error");
            return;
        }
        
        try {
            Connection conn = DriverManager.getConnection("jdbc:derby://localhost:1527/Event_Manager", "app", "app");
            String sql = "UPDATE STUDENTS SET CLUB_ID=NULL WHERE STUDENT_ID = ?";
            PreparedStatement remove = conn.prepareStatement(sql);
            remove.setInt(1, StudentId);
            
            int rowsAffected = remove.executeUpdate(); // ✅ use this

            if (rowsAffected > 0) {
                response.sendRedirect("ClubManagement.jsp?action=deleted");
            } else {
                response.sendRedirect("ClubManagement.jsp?action=deletefailed");
            }

            remove.close();
            conn.close();
            
            
        }catch (Exception e) {
            e.printStackTrace();
        }
    }

    

}
