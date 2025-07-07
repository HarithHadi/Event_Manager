<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.harith.model.Student" %>
<%@ page import="com.harith.dao.EventDAO" %>
<%@ page import="com.harith.model.Event" %>
<%@ page import="java.sql.*" %>
<%@ page import="java.util.*" %>

<%
    Student student = (Student) session.getAttribute("currentStudent");
    if (student == null) {
        response.sendRedirect("loginn.jsp?haataklogin=true");
        return;
    }

    List<Event> eventList = new ArrayList<Event>();
    try {
        Connection conn = DriverManager.getConnection("jdbc:derby://localhost:1527/Event_Manager", "app", "app");
        EventDAO eventDAO = new EventDAO(conn);
        eventList = eventDAO.getAllEvents();
        conn.close();
    } catch (Exception e) {
        e.printStackTrace();
    }
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8" />
    <title>Events</title>
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <link rel="icon" type="image/x-icon" href="assets/favicon.ico" />
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.5.0/font/bootstrap-icons.css" rel="stylesheet" />
    <link href="https://fonts.googleapis.com/css2?family=Poppins&display=swap" rel="stylesheet" />
    <link rel="stylesheet" href="css/styles.css" />
    <link rel="stylesheet" href="css/card.css" />
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

<header class="bg-light py-5">
    <div class="container text-center">
        <h1 class="display-4 fw-bold">Hello <%= student.getStudentName() %>!👋</h1>
    </div>
</header>

<%
    String rsvpStatus = request.getParameter("rsvp");
    if ("success".equals(rsvpStatus)) {
%>
<div class="alert alert-success alert-dismissible fade show text-center mx-auto mt-3" style="max-width: 600px;">
    Successfully RSVP’d for the event! 🎉 See you there!
    <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
</div>
<% } else if ("exists".equals(rsvpStatus)) { %>
<div class="alert alert-warning alert-dismissible fade show text-center mx-auto mt-3" style="max-width: 600px;">
    You have already RSVP’d for this event.
    <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
</div>
<% } %>

<section class="py-5">
    <div class="cards">
    <% 
        for (Event evt : eventList) { 
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
            <div class="card__img--hover <%= bgClass %>"></div>
            <div class="card__info">
                <span class="card_category"><%= evt.getClubName() %></span> 
                <h3 class="card__title"><%= evt.getEventTitle() %></h3>
                <span class="card__by">On <%= evt.getEventDate() %></span>
            </div>
            <div class="card__info-hover">
                <div class="card__clock-info">
                    <svg class="card__clock" viewBox="0 0 24 24">
                        <path d="M12,20A8,8 0 1,0 4,12A8,8 0 0,0 12,20M12,2A10,10 0 1,1 2,12A10,10 0 0,1 12,2M11,6H13V13H11V6M11,16H13V18H11V16Z" />
                    </svg>
                    <span class="card__time"><%= evt.getEventDate() %></span>
                </div>
                <button type="button" class="btn btn-outline-warning" onclick="openRsvpModal(<%= evt.getEventID() %>)">RSVP</button>
            </div>
        </div>
    <% 
        } 
    %>
    </div>
</section>


<!-- RSVP Modal -->
<div class="modal fade" id="rsvpModal" tabindex="-1" aria-labelledby="rsvpModalLabel" aria-hidden="true">
  <div class="modal-dialog">
    <div class="modal-content">
      <form method="post" action="RSVPServlet">
        <div class="modal-header">
          <h5 class="modal-title" id="rsvpModalLabel">Confirm RSVP</h5>
          <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
        </div>
        <div class="modal-body">
          <p>Do you want to RSVP for this event?</p>
          <input type="hidden" name="event_id" id="event_id_field" />
        </div>
        <div class="modal-footer">
          <button type="submit" class="btn btn-primary">Yes, RSVP</button>
          <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancel</button>
        </div>
      </form>
    </div>
  </div>
</div>

<script>
function openRsvpModal(eventId) {
    document.getElementById('event_id_field').value = eventId;
    var myModal = new bootstrap.Modal(document.getElementById('rsvpModal'));
    myModal.show();
}
</script>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
