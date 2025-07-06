<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.Connection"%>
<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="utf-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1" />
  <title>Login - Campus Event System</title>

  <!-- Styles -->
  <link href="css/styles.css" rel="stylesheet" />
  <link rel="icon" type="image/x-icon" href="assets/favicon.ico" />
  <link rel="stylesheet" href="css/card.css">
  <link href="https://fonts.googleapis.com/css2?family=Poppins&display=swap" rel="stylesheet">

  <style>
    body {
      font-family: 'Poppins', sans-serif;
      background-color: #f9f9f9;
    }
    .card {
      border: none;
      border-radius: 10px;
    }
  </style>
</head>
<body>
 
  <nav class="navbar navbar-expand-lg navbar-light bg-white border-bottom">
    <div class="container px-5">
      <a class="navbar-brand fw-bold" href="index.jsp">CampusEvents</a>
    </div>
  </nav>

 
  <section class="py-5">
    <div class="container px-5">
      <div class="row justify-content-center">
        <div class="col-md-6">
          <div class="card shadow-sm">
            <div class="card-body">
              <h2 class="card-title text-center mb-4">Register</h2>
              <%
                    String mess = request.getParameter("message");
                    String dupe = request.getParameter("dupe");
                    if(dupe != null){
                %>
                        <p style="color: red">Username & Password already exists</p>
                        <p style="color: red">Please choose another one</p>
                <%
                    }
                    if (mess == null) {
                        mess = "none";
                    }

                    if (mess.equals("passerror")) {
                %>
                        <a style="color: red">Password is not the same</a>
                <%
                    }
                %>
              
              <form action="RegisterServlet" method="post">
                <div class="mb-3">
                  <label for="email" class="form-label">Email</label>
                  <input type="email" class="form-control" id="email" name="email" placeholder="Enter your email">
                </div>
                <div class="mb-3">
                  <label for="name" class="form-label">Name</label>
                  <input type="text" class="form-control" id="email" name="name" placeholder="Enter your full name">
                </div>
                <div class="mb-3">
                    <label for="course" class="form-label">Course</label>
                    <select class="form-select" id="course" name="course" >
                      <option value="" selected disabled>Select your course</option>
                      <option value="Computer Science">Computer Science</option>
                      <option value="Information Technology">Information Technology</option>
                      <option value="Software Engineering">Software Engineering</option>
                      <option value="Multimedia">Multimedia</option>
                      <option value="Finance">Finance</option>
                    </select>
                </div>
                  <div class="mb-3">
                    <label for="club" class="form-label">Select Club</label>
                    <select class="form-select" id="club" name="club">
                       <%
            try {
                Class.forName("org.apache.derby.jdbc.ClientDriver");
                Connection conn = DriverManager.getConnection("jdbc:derby://localhost:1527/Event_Manager", "app", "app");
                String sql = "SELECT CLUB_ID, CLUB_NAME FROM CLUBS";
                PreparedStatement stmt = conn.prepareStatement(sql);
                ResultSet rs = stmt.executeQuery();

                while (rs.next()) {
                    int clubId = rs.getInt("CLUB_ID");
                    String clubName = rs.getString("CLUB_NAME");
        %>
                    <option value="<%= clubId %>"><%= clubName %></option>
        <%
                }

                rs.close();
                stmt.close();
                conn.close();
            } catch (Exception e) {
                out.println("<option disabled>Error loading clubs</option>");
                e.printStackTrace();
            }
        %>
                    </select>
                  </div>


                <div class="mb-3">
                  <label for="group" class="form-label">Group</label>
                  <input type="text" class="form-control" id="email" name="group" placeholder="Enter your group">
                </div>
                <div class="mb-3">
                  <label for="part" class="form-label">Part</label>
                  <input type="number" class="form-control" id="part" name="part" placeholder="Enter your group">
                </div>
                <div class="mb-3">
                  <label for="phone" class="form-label">Phone Number</label>
                  <input type="text" class="form-control" id="email" name="phone" placeholder="Enter your phone number">
                </div>
                <div class="mb-3">
                  <label for="password" class="form-label">Password</label>
                  <input type="password" class="form-control" id="password" name="password" placeholder="Enter your password">
                </div>
                  <div class="mb-3">
                  <label for="password" class="form-label">Confirm Password</label>
                  <input type="password" class="form-control" id="password" name="cpassword" placeholder="Confirm your password">
                </div>
                <div class="d-grid">
                  <button type="submit" class="btn btn-primary">Register</button>
                </div>
              </form>

            </div>
          </div>
        </div>
      </div>
    </div>
  </section>


  <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
