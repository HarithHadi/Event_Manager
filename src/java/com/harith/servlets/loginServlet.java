package com.harith.servlets;

import java.io.IOException;
import java.sql.*;
import javax.servlet.*;
import javax.servlet.http.*;

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
                HttpSession session = request.getSession();
                session.setAttribute("userID", rs.getInt("user_id")); // Use actual column name
                session.setAttribute("role", rs.getString("role"));
                response.sendRedirect("index.jsp");
            } else {
                response.sendRedirect("loginn.jsp?takjadi=true");
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
