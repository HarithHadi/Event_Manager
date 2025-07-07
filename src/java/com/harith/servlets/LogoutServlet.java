package com.harith.servlets;

import java.io.IOException;
import javax.servlet.*;
import javax.servlet.http.*;

public class LogoutServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Invalidate the session
        HttpSession session = request.getSession(false); // false to avoid creating a new session
        if (session != null) {
            session.invalidate();
        }

        // Redirect to login or homepage
        response.sendRedirect("loginn.jsp"); // or "index.jsp"
    }
}
