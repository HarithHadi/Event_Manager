/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.harith.servlets;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;


public class PromoteOrganizerServlet extends HttpServlet {

   
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String studentId = request.getParameter("student_id");
        if(studentId == null){
            response.sendRedirect("ClubManagement.jsp?error=StudentNotFound");
        }
        try{
            Connection conn = DriverManager.getConnection("jdbc:derby://localhost:1527/Event_Manager", "app", "app");
            int StudentId = Integer.parseInt(studentId);
            String sql = "INSERT INTO ORGANIZERS (STUDENT_ID) VALUES (?)";
            PreparedStatement stmt = conn.prepareStatement(sql);
            stmt.setInt(1, StudentId);
            int rowsAffected = stmt.executeUpdate();
            
            if(rowsAffected > 0){
                response.sendRedirect("ClubManagement.jsp?action=promoted");
            }else{
                response.sendRedirect("ClubManagement.jsp?action=error");
            }
            
            stmt.close();
            conn.close();
            
        
        }catch (Exception e) {
            e.printStackTrace();
        }
        
    }

    

}
