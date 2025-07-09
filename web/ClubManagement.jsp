<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.harith.model.Student" %>
<%@ page import="java.sql.*" %>
<%@ page import="java.util.*" %>


<%@ page import="com.harith.dao.ClubDAO" %>
<%@ page import="com.harith.dao.OrganizerDAO" %>
<%@ page import="com.harith.model.Club" %>
<%@ page import="com.harith.model.Event" %>
<%@ page import="com.harith.dao.EventDAO" %>
<%@ page import="com.harith.dao.EventAttendanceDAO" %>


<%
    List<Student> Students = new ArrayList<Student>();
    Map<Integer, List<String>> attendeesMap = new HashMap<Integer, List<String>>();
    List<Event> organiserEvents = new ArrayList<Event>();
    Student student = (Student) session.getAttribute("currentStudent");
    OrganizerDAO organizerDAO = null;
    ClubDAO clubDAO = null;
    Club club = null;
    if(student==null){
       response.sendRedirect("loginn.jsp?haataklogin=true");
       return;
    }
    int clubId = student.getClubID();
    
    
    
    try{
        Connection conn = DriverManager.getConnection("jdbc:derby://localhost:1527/Event_Manager", "app", "app");
        clubDAO = new ClubDAO(conn);
        organizerDAO = new OrganizerDAO(conn);
        Students = clubDAO.isClub(student, clubId);
        club = clubDAO.getClub(clubId);
        
        if(clubId>0){
            EventDAO eventDAO = new EventDAO(conn);
            EventAttendanceDAO attendanceDAO = new EventAttendanceDAO(conn);
            
            organiserEvents = eventDAO.getEventsByClubId(clubId);
            for(Event evt : organiserEvents){
                attendeesMap.put(evt.getEventID(), attendanceDAO.getAttendeesForEvent(evt.getEventID()));
            }
        }
        
        
    
    }catch (Exception e) {
    e.printStackTrace();
    }
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8" />
    <title>Club Management</title>
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <link rel="icon" type="image/x-icon" href="assets/favicon.ico" />
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
                    Boolean isOrganizer = true;
                    if (isOrganizer) {
                %>
                <li class="nav-item"><a class="nav-link" href="create-event.jsp">Create Event</a></li>
                <li class="nav-item"><a class="nav-link active" href="club-management.jsp">Club Management</a></li>
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
        <h1 class="display-4 fw-bold"><%= club.getClubName() %> Management 👥</h1>
        <p class="lead mt-3">Manage your club members and organizers</p>
    </div>
</header>

<!-- Aletrts -->
<%
    String actionStatus = request.getParameter("action");
    if ("promoted".equals(actionStatus)) {
%>
<div class="alert alert-success alert-dismissible fade show text-center mx-auto mt-3" style="max-width: 600px;">
    Member successfully promoted to organizer! 🎉
    <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
</div>
<% 
    } else if ("error".equals(actionStatus)) {
%>
<div class="alert alert-danger alert-dismissible fade show text-center mx-auto mt-3" style="max-width: 600px;">
    Something went wrong. Please try again.
    <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
</div>
<%
    } else if ("deleted".equals(actionStatus)) {
%>
<div class="alert alert-success alert-dismissible fade show text-center mx-auto mt-3" style="max-width: 600px;">
    Member successfully removed 🎉
    <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
</div>
<%
    } else if ("deletefailed".equals(actionStatus)) {
%>
<div class="alert alert-danger alert-dismissible fade show text-center mx-auto mt-3" style="max-width: 600px;">
    Member removal failed ❌
    <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
</div>
<%
    } else if ("deletedEventTrue".equals(actionStatus)) {
%>
<div class="alert alert-success alert-dismissible fade show text-center mx-auto mt-3" style="max-width: 600px;">
    Event successfully deleted ✅
    <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
</div>
<%
    } else if ("missingeventid".equals(actionStatus)) {
%>
<div class="alert alert-danger alert-dismissible fade show text-center mx-auto mt-3" style="max-width: 600px;">
    Event Deletion failed✅
    <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
</div>
<%
    }
%>

<section class="py-5">
    <div class="container">
        <div class="row">
            <div class="col-12">
                <div class="card shadow-sm">
                    <div class="card-header bg-primary text-white">
                        <h5 class="mb-0"><i class="bi bi-people"></i> Club Members</h5>
                    </div>
                    <div class="card-body">
                        <div class="table-responsive">
                            <table class="table table-hover">
                                <thead class="table-light">
                                    <tr>
                                        <th>Student ID</th>
                                        <th>Name</th>
                                        <th>Course</th>
                                        <th>Role</th>
                                        <th>Actions</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <% for (Student s : Students) { %>
                                    <tr>
                                        <td><%= s.getStudentID() %></td>
                                        <td>
                                            <strong><%= s.getStudentName() %></strong>
                                        </td>
                                        <td><%= s.getStudentCourse() %></td>
                                        <td>
                                            <% if ((Boolean) organizerDAO.CheckIfStudentIsOrganizer(s.getStudentID())) { %>
                                                <span class="badge bg-success">Organizer</span>
                                            <% } else { %>
                                                <span class="badge bg-secondary">Member</span>
                                            <% } %>
                                        </td>
                                        <td>
                                            <% if (!(Boolean) organizerDAO.CheckIfStudentIsOrganizer(s.getStudentID())) { %>
                                            <button type="button" class="btn btn-sm btn-outline-danger"
                                                    onclick="openRemoveModal('<%= s.getStudentID() %>')">
                                                <i class="bi bi-trash"></i> Remove
                                            </button>
                                            <button type="button" class="btn btn-sm btn-outline-warning" 
                                                    onclick="openPromoteModal('<%= s.getStudentID() %>', '<%= s.getStudentName() %>')">
                                                <i class="bi bi-arrow-up-circle"></i> Promote
                                            </button>
                                            <% } %>
                                        </td>
                                    </tr>
                                    <% } %>
                                </tbody>
                            </table>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</section>
                                
<% if (!organiserEvents.isEmpty()) { %>
<section class="py-5">
  <div class="container">
    <div class="rsvp-title">My Organized Events</div>
    <% for (Event evt : organiserEvents) { %>
    <div class="org-card position-relative mb-3 p-3 shadow-sm rounded bg-white">
      <button type="button" class="delete-btn bi bi-trash-fill" title="Delete Event"
              data-bs-toggle="modal" data-bs-target="#deleteModal"
              data-event-id="<%= evt.getEventID() %>" data-event-title="<%= evt.getEventTitle() %>">
      </button>
      <div class="org-title fw-bold"><%= evt.getEventTitle() %></div>
      <div class="org-date text-muted">Date: <%= evt.getEventDate() %></div>
      <div class="org-attendees mt-2">
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
</section>
<% } %>
                                

<!-- Remove Member Modal -->
<div class="modal fade" id="removeModal" tabindex="-1" aria-labelledby="removeModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <form method="post" action="RemoveMemberServlet">
                <div class="modal-header">
                    <h5 class="modal-title" id="removeModalLabel">Remove Member</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                </div>
                <div class="modal-body">
                    <p>Are you sure you want to <strong>remove</strong> this member from the club?</p>
                    <input type="hidden" name="student_id" id="remove_student_id" />
                </div>
                <div class="modal-footer">
                    <button type="submit" class="btn btn-danger">Yes, Remove</button>
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancel</button>
                </div>
            </form>
        </div>
    </div>
</div>

<!-- Promote to Organizer Modal -->
<div class="modal fade" id="promoteModal" tabindex="-1" aria-labelledby="promoteModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <form method="post" action="PromoteOrganizerServlet">
                <div class="modal-header">
                    <h5 class="modal-title" id="promoteModalLabel">Promote to Organizer</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                </div>
                <div class="modal-body">
                    <p>Are you sure you want to promote <strong id="promote_student_name"></strong> to organizer?</p>
                    <p class="text-muted">Organizers will have access to create events and manage club members.</p>
                    <input type="hidden" name="student_id" id="promote_student_id" />
                </div>
                <div class="modal-footer">
                    <button type="submit" class="btn btn-warning">Yes, Promote</button>
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancel</button>
                </div>
            </form>
        </div>
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

<script>
function openRemoveModal(studentId) {
    document.getElementById('remove_student_id').value = studentId;
    var myModal = new bootstrap.Modal(document.getElementById('removeModal'));
    myModal.show();
}
function openPromoteModal(studentId, studentName) {
    document.getElementById('promote_student_id').value = studentId;
    document.getElementById('promote_student_name').textContent = studentName;
    var myModal = new bootstrap.Modal(document.getElementById('promoteModal'));
    myModal.show();
}

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

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>