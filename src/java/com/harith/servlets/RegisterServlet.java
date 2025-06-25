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
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 *
 * @author User
 */
public class RegisterServlet extends HttpServlet {
    public void doPost(HttpServletRequest request, HttpServletResponse response)throws ServletException, IOException{
        String email = request.getParameter("email");
        String name = request.getParameter("name");
        String course = request.getParameter("course");
        String group = request.getParameter("group");
        int part = Integer.parseInt(request.getParameter("part"));
        String phone = request.getParameter("phone");
        String password = request.getParameter("password");
        String cpassword = request.getParameter("cpassword");
        
        
        if(!password.equals(cpassword)){
            response.sendRedirect("register.jsp?message=passerror");
        }else{
            try{
                Connection conn = DriverManager.getConnection("jdbc:derby://localhost:1527/Event_Manager", "app", "app");
                String dupe = "SELECT * FROM USERS WHERE password =? AND email=?";
                PreparedStatement stmtdupe = conn.prepareStatement(dupe);
                stmtdupe.setString(1, password);
                stmtdupe.setString(2, email);
                ResultSet rs = stmtdupe.executeQuery();
                if(rs.next()){
                    stmtdupe.close();
                    response.sendRedirect("register.jsp?dupe=true");
                }else{
                    String insertUser = "INSERT INTO USERS (email, password, role) VALUES(?,?,'student')";
                    String insertStudent = "INSERT INTO STUDENTS (user_id, student_name, student_course, student_part, student_group, student_phone) VALUES (?, ?, ?, ?, ?, ?)";
                    
                    PreparedStatement stmtUser = conn.prepareStatement(insertUser, Statement.RETURN_GENERATED_KEYS);
                    stmtUser.setString(1, email);
                    stmtUser.setString(2, password);
                    stmtUser.executeUpdate();
                    ResultSet rsuser = stmtUser.getGeneratedKeys();
                    int userId = -1;
                    if (rsuser.next()) {
                        userId = rsuser.getInt(1);
                    }
                    stmtUser.close();
                    rsuser.close();
                     if (userId != -1) {
                        PreparedStatement stmtStudent = conn.prepareStatement(insertStudent);
                        stmtStudent.setInt(1, userId);            // foreign key from USERS
                        stmtStudent.setString(2, name);
                        stmtStudent.setString(3, course);
                        stmtStudent.setInt(4, part);
                        stmtStudent.setString(5, group);
                        stmtStudent.setString(6, phone);
                        stmtStudent.executeUpdate();
                        stmtStudent.close();
                    }
                    
                }
                
                rs.close();
                conn.close();
                response.sendRedirect("index.jsp?success");
            }catch (Exception e){
                e.printStackTrace(); // shows the error in the server logs
                response.getWriter().println("An error occurred: " + e.getMessage());
            }
            
            
        }
        
    }
    

    

}
