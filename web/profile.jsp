<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.harith.model.Student" %>
<%@ page import="com.harith.model.Event" %>
<%@ page import="com.harith.dao.EventAttendanceDAO" %>
<%@ page import="java.sql.*" %>
<%@ page import="java.util.*" %>

<%
Student student = (Student) session.getAttribute("currentStudent");
if (student == null) {
    response.sendRedirect("loginn.jsp?haataklogin=true");
    return;
}

String clubName = "N/A";
List<Event> rsvpEvents = new ArrayList<Event>();

try {
    Connection conn = DriverManager.getConnection("jdbc:derby://localhost:1527/Event_Manager", "app", "app");

    // Fetch club name using club ID
    if (student.getClubID() > 0) {
        PreparedStatement clubStmt = conn.prepareStatement("SELECT CLUB_NAME FROM CLUBS WHERE CLUB_ID = ?");
        clubStmt.setInt(1, student.getClubID());
        ResultSet clubRs = clubStmt.executeQuery();
        if (clubRs.next()) {
            clubName = clubRs.getString("CLUB_NAME");
        }
        clubRs.close();
        clubStmt.close();
    }

    // If clubID is 0 but user is organizer, try find their club
    if ("N/A".equals(clubName) && Boolean.TRUE.equals(session.getAttribute("isOrganizer"))) {
        PreparedStatement orgStmt = conn.prepareStatement(
            "SELECT CLUB_NAME FROM CLUBS WHERE ORGANIZER_ID = ?"
        );
        orgStmt.setInt(1, student.getStudentID());
        ResultSet orgRs = orgStmt.executeQuery();
        if (orgRs.next()) {
            clubName = orgRs.getString("CLUB_NAME");
        }
        orgRs.close();
        orgStmt.close();
    }

    // Get RSVP'd events
    EventAttendanceDAO attendanceDAO = new EventAttendanceDAO(conn);
    rsvpEvents = attendanceDAO.getRsvpEventsByStudentId(student.getStudentID());

    conn.close();
} catch (Exception e) {
    e.printStackTrace();
}
%>

<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="utf-8" />
  <title>Student Profile</title>
  <meta name="viewport" content="width=device-width, initial-scale=1" />
  <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.5.0/font/bootstrap-icons.css" rel="stylesheet" />
  <link href="https://fonts.googleapis.com/css2?family=Poppins&display=swap" rel="stylesheet" />
  <link rel="stylesheet" href="css/styles.css" />
  <link rel="stylesheet" href="css/card.css" />
  <style>
    .profile-details {
      text-align: center;
      padding: 60px 10px 40px 10px;
    }
    .profile-details h1 {
      font-weight: 700;
      font-size: 2.8rem;
      color: #333;
      margin-bottom: 10px;
    }
    .profile-details h2 {
      font-size: 1.5rem;
      font-weight: 500;
      margin-bottom: 10px;
    }
    .profile-details p {
      margin: 3px 0;
      font-size: 1rem;
      color: #555;
    }
    .badge-organizer {
      background: #ffc107;
      color: #000;
      padding: 4px 8px;
      border-radius: 4px;
      font-size: 12px;
      margin-left: 5px;
    }
    .cards.profile-cards {
      display: flex;
      flex-direction: column;
      gap: 20px;
    }
    .cards.profile-cards .card {
      width: 100%;
      border-radius: 8px;
      overflow: hidden;
      box-shadow: 0 2px 8px rgba(0,0,0,0.1);
    }
    .cards.profile-cards .card__img {
      width: 100%;
      height: 160px;
    }
    .cards.profile-cards .card__info {
      padding: 10px 15px;
    }
  </style>
</head>
<body>

<nav class="navbar navbar-expand-lg navbar-light bg-white border-bottom">
  <div class="container px-5">
    <a class="navbar-brand fw-bold" href="index.jsp">CampusEvents</a>
    <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav">
      <span class="navbar-toggler-icon"></span>
    </button>
    <div class="collapse navbar-collapse justify-content-end" id="navbarNav">
      <ul class="navbar-nav">
        <li class="nav-item"><a class="nav-link" href="index.jsp">Home</a></li>
        <%
          Boolean isOrganizer = (Boolean) session.getAttribute("isOrganizer");
          if (isOrganizer != null && isOrganizer) {
        %>
        <li class="nav-item"><a class="nav-link" href="create-event.jsp">Create Event</a></li>
        <%
          }
        %>
        <li class="nav-item"><a class="nav-link" href="profile.jsp">Profile</a></li>
        <li class="nav-item"><a class="nav-link text-danger" href="LogoutServlet">Logout</a></li>
      </ul>
    </div>
  </div>
</nav>

<div class="profile-details">
  <h1><%= student.getStudentName() %></h1>
  <h2>
    <%= clubName %>
    <% if (Boolean.TRUE.equals(session.getAttribute("isOrganizer"))) { %>
      <span class="badge-organizer">Organizer</span>
    <% } %>
  </h2>
  <p>Course: <%= student.getStudentCourse() %></p>
  <p>Part: <%= student.getStudentPart() %> | Group: <%= student.getStudentGroup() %></p>
  <p>Phone: <%= student.getStudentPhone() %></p>
</div>

<hr/>

<div class="container">
  <h3 class="text-center my-4">My RSVP'd Events</h3>
  <div class="cards profile-cards">
    <% 
    for (Event evt : rsvpEvents) {
      String bgClass = "";
      switch (evt.getClubID()) {
        case 1: bgClass = "bg-multimedia"; break;
        case 2: bgClass = "bg-photography"; break;
        case 3: bgClass = "bg-debate"; break;
        case 4: bgClass = "bg-entrepreneurship"; break;
        default: bgClass = "";
      }
    %>
    <div class="card">
      <div class="card__img <%= bgClass %>"></div>
      <div class="card__info">
        <span class="card_category"><%= evt.getClubName() %></span>
        <h3 class="card__title"><%= evt.getEventTitle() %></h3>
        <span class="card__by">On <%= evt.getEventDate() %></span>
      </div>
    </div>
    <% } %>
  </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
