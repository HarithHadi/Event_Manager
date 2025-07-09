 <%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.harith.model.Student" %>
<%@ page import="com.harith.model.Event" %>
<%@ page import="com.harith.dao.EventAttendanceDAO" %>
<%@ page import="com.harith.dao.OrganizerDAO" %>
<%@ page import="com.harith.dao.EventDAO" %>
<%@ page import="java.sql.*" %>
<%@ page import="java.util.*" %>

<%
Student student = (Student) session.getAttribute("currentStudent");
Boolean isOrganizer = (Boolean) session.getAttribute("isOrganizer");
if (student == null) {
    response.sendRedirect("loginn.jsp?haataklogin=true");
    return;
}

String clubName = "N/A";
List<Event> rsvpEvents = new ArrayList<Event>();
List<Event> organiserEvents = new ArrayList<Event>();
Map<Integer, List<String>> attendeesMap = new HashMap<Integer, List<String>>();


try {
    Connection conn = DriverManager.getConnection("jdbc:derby://localhost:1527/Event_Manager", "app", "app");
    

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

    if ("N/A".equals(clubName) && Boolean.TRUE.equals(session.getAttribute("isOrganizer"))) {
        PreparedStatement orgStmt = conn.prepareStatement("SELECT CLUB_NAME, CLUB_ID FROM CLUBS WHERE ORGANIZER_ID = ?");
        orgStmt.setInt(1, student.getStudentID());
        ResultSet orgRs = orgStmt.executeQuery();
        if (orgRs.next()) {
            clubName = orgRs.getString("CLUB_NAME");
            student.setClubID(orgRs.getInt("CLUB_ID"));
        }
        orgRs.close();
        orgStmt.close();
    }

    EventAttendanceDAO attendanceDAO = new EventAttendanceDAO(conn);
    EventDAO eventDAO = new EventDAO(conn);

    rsvpEvents = attendanceDAO.getRsvpEventsByStudentId(student.getStudentID());

    if (Boolean.TRUE.equals(session.getAttribute("isOrganizer")) && student.getClubID() > 0) {
        organiserEvents = eventDAO.getEventsByClubId(student.getClubID());
        for (Event evt : organiserEvents) {
            attendeesMap.put(evt.getEventID(), attendanceDAO.getAttendeesForEvent(evt.getEventID()));
        }
    }

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
    body {
      font-family: 'Poppins', sans-serif;
    }
    .profile-details {
      max-width: 600px;
      margin: 40px auto;
      background: #fff;
      border-radius: 10px;
      box-shadow: 0 4px 10px rgba(0,0,0,0.1);
      padding: 30px;
      text-align: center;
      position: relative;
    }
    .profile-details h1 {
      font-weight: 700;
      font-size: 2.2rem;
      color: #333;
      margin-bottom: 10px;
    }
    .profile-details h2 {
      font-size: 1.3rem;
      font-weight: 500;
      margin-bottom: 15px;
    }
    .badge-organizer {
      background: #ffc107;
      color: #000;
      padding: 4px 8px;
      border-radius: 4px;
      font-size: 12px;
      margin-left: 5px;
    }
    .profile-grid {
      display: grid;
      grid-template-columns: 1fr 1fr;
      gap: 10px 20px;
      margin-top: 15px;
      text-align: left;
    }
    .profile-grid p {
      margin: 0;
      font-size: 1rem;
      color: #555;
    }
    hr {
      margin: 40px auto;
      width: 80%;
      border: 0;
      border-top: 1px solid #ddd;
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
    .rsvp-title {
      text-align: center;
      font-weight: 700;
      font-size: 1.8rem;
      padding-top: 30px;
      margin-bottom: 10px;
    }
    .rsvp-empty {
      text-align: center;
      color: #888;
      font-style: italic;
    }
    .org-card {
      background: #fff;
      border: 1px solid #eee;
      border-radius: 8px;
      padding: 15px 20px;
      margin-bottom: 15px;
      box-shadow: 0 2px 5px rgba(0,0,0,0.05);
    }
    .org-title {
      font-size: 1.2rem;
      font-weight: 600;
      margin-bottom: 5px;
    }
    .org-date {
      font-size: 0.9rem;
      color: #888;
      margin-bottom: 10px;
    }
    .org-attendees ul {
      padding-left: 1.2em;
      margin: 0;
    }
    .org-attendees li {
      padding: 2px 0;
    }
    
    .edit-btn {
  position: absolute;
  top: 20px;
  right: 20px;
  display: none;
  cursor: pointer;
  font-size: 1rem;
  color: #0d6efd;
}
.profile-details:hover .edit-btn {
  display: block;
}

.delete-btn {
  position: absolute;
  top: 10px;
  right: 10px;
  display: none;
  background: transparent;
  border: none;
  color: red;
  font-size: 1.1rem;
  cursor: pointer;
}
.org-card:hover .delete-btn {
  display: block;
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
                    // Dummy check - assume user is organizer for demo
                    
                    if (isOrganizer) {
                %>
                <li class="nav-item"><a class="nav-link" href="create-event.jsp">Create Event</a></li>
                <li class="nav-item"><a class="nav-link" href="ClubManagement.jsp">Club Management</a></li>
                <%
                    }
                %>
                <li class="nav-item"><a class="nav-link active" href="profile.jsp">Profile</a></li>
                <li class="nav-item"><a class="nav-link text-danger" href="LogoutServlet">Logout</a></li>
            </ul>
        </div>
    </div>
</nav>

<div class="profile-details">
  <p class="edit-btn bi bi-pencil-square" data-bs-toggle="modal" data-bs-target="#editModal"> Edit</p>

  <h1><%= student.getStudentName() %></h1>
  <h2><%= clubName %>
    <% if (Boolean.TRUE.equals(session.getAttribute("isOrganizer"))) { %>
      <span class="badge-organizer">Organizer</span>
    <% } %>
  </h2>
  <div class="profile-grid">
    <p>Course: <%= student.getStudentCourse() %></p>
    <p>Part: <%= student.getStudentPart() %></p>
    <p>Group: <%= student.getStudentGroup() %></p>
    <p>Phone: <%= student.getStudentPhone() %></p>
  </div>
</div>


<hr/>

<div class="container">
  <div class="rsvp-title">My RSVP'd Events</div>
  <% if (rsvpEvents.isEmpty()) { %>
    <div class="rsvp-empty">You have not RSVP'd to any events yet.</div>
  <% } else { %>
    <div class="cards profile-cards">
      <% for (Event evt : rsvpEvents) { 
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
  <% } %>
</div>

<% if (!organiserEvents.isEmpty()) { %>
<hr/>
<div class="container">
  <div class="rsvp-title">My Organized Events</div>
  <% for (Event evt : organiserEvents) { %>
  <div class="org-card position-relative">
    <button type="button" class="delete-btn bi bi-trash-fill" title="Delete Event"
            data-bs-toggle="modal" data-bs-target="#deleteModal"
            data-event-id="<%= evt.getEventID() %>" data-event-title="<%= evt.getEventTitle() %>">
    </button>

    <div class="org-title"><%= evt.getEventTitle() %></div>
    <div class="org-date"><%= evt.getEventDate() %></div>
    <div class="org-attendees">
      <small class="text-muted">Attendees:</small>
      <% List<String> attendees = attendeesMap.get(evt.getEventID());
         if (attendees != null && !attendees.isEmpty()) { %>
        <ul>
          <% for (String name : attendees) { %>
            <li><%= name %></li>
          <% } %>
        </ul>
      <% } else { %>
        <div class="text-muted">No attendees yet.</div>
      <% } %>
    </div>
  </div>
  <% } %>
</div>
<% } %>



<!-- Edit Modal -->
<div class="modal fade" id="editModal" tabindex="-1">
  <div class="modal-dialog">
    <form class="modal-content" action="UpdateProfileServlet" method="post">
      <div class="modal-header">
        <h5 class="modal-title">Edit Profile</h5>
        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
      </div>
      <div class="modal-body">
        <input type="hidden" name="studentID" value="<%= student.getStudentID() %>" />

        <div class="mb-3">
          <label for="name" class="form-label">Name</label>
          <input type="text" class="form-control" id="name" name="studentName" value="<%= student.getStudentName() %>" required>
        </div>

        <div class="mb-3">
          <label for="phone" class="form-label">Phone</label>
          <input type="text" class="form-control" id="phone" name="studentPhone" value="<%= student.getStudentPhone() %>" required>
        </div>
      </div>

      <div class="modal-footer">
        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancel</button>
        <button type="submit" class="btn btn-primary">Save changes</button>
      </div>
    </form>
  </div>
</div>

<!-- Delete Confirmation Modal -->
<div class="modal fade" id="deleteModal" tabindex="-1" aria-hidden="true">
  <div class="modal-dialog">
    <form class="modal-content" action="DeleteEventServlet" method="post">
      <div class="modal-header">
        <h5 class="modal-title">Confirm Deletion</h5>
        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
      </div>
      <div class="modal-body">
        Are you sure you want to delete the event <strong id="eventToDelete"></strong>?
        <input type="hidden" name="eventID" id="modalEventID">
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancel</button>
        <button type="submit" class="btn btn-danger">Delete</button>
      </div>
    </form>
  </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"></script>

<script>
  const deleteModal = document.getElementById('deleteModal');
  deleteModal.addEventListener('show.bs.modal', function (event) {
    const button = event.relatedTarget;
    const eventId = button.getAttribute('data-event-id');
    const eventTitle = button.getAttribute('data-event-title');

    const eventIdInput = deleteModal.querySelector('#modalEventID');
    const eventTitleText = deleteModal.querySelector('#eventToDelete');

    eventIdInput.value = eventId;
    eventTitleText.textContent = eventTitle;
  });
</script>

</body>
</html>