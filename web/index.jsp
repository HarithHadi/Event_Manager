<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%
    if (session.getAttribute("currentStudent") == null) {
        response.sendRedirect("loginn.jsp?haataklogin=true");
    }
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />
    <meta name="description" content="Campus Events Page" />
    <meta name="author" content="Your Name" />
    <title>Events</title>
    
  
    <link rel="icon" type="image/x-icon" href="assets/favicon.ico" />

   
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.5.0/font/bootstrap-icons.css" rel="stylesheet" />

  
    <link href="https://fonts.googleapis.com/css2?family=Poppins&display=swap" rel="stylesheet">

  
    <link rel="stylesheet" href="css/styles.css" />
    <link rel="stylesheet" href="css/card.css" />
</head>
<body>
  <!-- Navbar -->
    <nav class="navbar navbar-expand-lg navbar-light bg-white border-bottom">
        <div class="container px-5">
            <a class="navbar-brand fw-bold" href="index.jsp">CampusEvents</a>
            <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav"
                    aria-controls="navbarNav" aria-expanded="false" aria-label="Toggle navigation">
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
                    <li class="nav-item"><a class="nav-link text-danger" href="login.jsp">Logout</a></li>
                </ul>
            </div>
        </div>
    </nav>

   
    <header class="bg-light py-5">
        <div class="container px-4 px-lg-5 my-5">
            <div class="text-center text-dark">
                <h1 class="display-4 fw-bold">Join 🎉🎈</h1> 
            </div>
        </div>
    </header>

<%
    String rsvpStatus = request.getParameter("rsvp");
    if ("success".equals(rsvpStatus)) {
%>
<div class="alert alert-success alert-dismissible fade show text-center mx-auto mt-3" style="max-width: 600px;" role="alert">
    Successfully RSVP’d for the event! 🎉 See you there!
    <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
</div>
<%
    } else if ("exists".equals(rsvpStatus)) {
%>
<div class="alert alert-warning alert-dismissible fade show text-center mx-auto mt-3" style="max-width: 600px;" role="alert">
    You have already RSVP’d for this event.
    <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
</div>
<%
    }
%>


    <section class="py-3">
        <div class="container px-5">
            <div class="row justify-content-end">
                <div class="col-md-6">
                    <div class="input-group">
                        <input type="search" class="form-control rounded" placeholder="Search" aria-label="Search" id="search" />
                        <button type="button" class="btn btn-outline-primary">Search</button>
                    </div>
                </div>
            </div>
        </div>
    </section>

   
    <section class="py-5">
        <div class="cards">
         
            <div class="card card--1">
                <div class="card__img"></div>
                <a href="#" class="card__img--hover"></a>
                <div class="card__info">
                    <span class="card_category">Ceremony</span>
                    <h3 class="card__title">Hari Raya Event</h3>
                    <span class="card__by">By <a href="#" class="card__author">MCS</a></span>
                </div>
                <div class="card__info-hover">
                    <div class="card__clock-info">
                        <svg class="card__clock" viewBox="0 0 24 24">
                            <path d="M12,20A8,8 0 1,0 4,12A8,8 0 0,0 12,20M12,2A10,10 0 1,1 2,12A10,10 0 0,1 12,2M11,6H13V13H11V6M11,16H13V18H11V16Z" />
                        </svg>
                        <span class="card__time">10 Days</span>
                    </div>
                    <button type="button" class="btn btn-outline-warning" onclick="openRsvpModal(1)">RSVP</button>
                </div>
            </div>

 
            <div class="card card--2">
                <div class="card__img"></div>
                <a href="#" class="card__img--hover"></a>
                <div class="card__info">
                    <span class="card_category">Social</span>
                    <h3 class="card__title">Graduation Party</h3>
                    <span class="card__by">By <a href="#" class="card__author">KPPIM</a></span>
                </div>
                <div class="card__info-hover">
                    <div class="card__clock-info">
                        <svg class="card__clock" viewBox="0 0 24 24">
                            <path d="M12,20A8,8 0 1,0 4,12A8,8 0 0,0 12,20M12,2A10,10 0 1,1 2,12A10,10 0 0,1 12,2M11,6H13V13H11V6M11,16H13V18H11V16Z" />
                        </svg>
                        <span class="card__time">10 Days</span>
                    </div>
                    <button type="button" class="btn btn-outline-warning" onclick="openRsvpModal(1)">RSVP</button>
                </div>
            </div>

         
            <div class="card card--3">
                <div class="card__img"></div>
                <a href="#" class="card__img--hover"></a>
                <div class="card__info">
                    <span class="card_category">Talk</span>
                    <h3 class="card__title">What is AI? | TED TALK</h3>
                    <span class="card__by">By <a href="#" class="card__author">KPPIM</a></span>
                </div>
                <div class="card__info-hover">
                    <div class="card__clock-info">
                        <svg class="card__clock" viewBox="0 0 24 24">
                            <path d="M12,20A8,8 0 1,0 4,12A8,8 0 0,0 12,20M12,2A10,10 0 1,1 2,12A10,10 0 0,1 12,2M11,6H13V13H11V6M11,16H13V18H11V16Z" />
                        </svg>
                        <span class="card__time">10 Days</span>
                    </div>
                    <button type="button" class="btn btn-outline-warning" onclick="openRsvpModal(1)">RSVP</button>
                </div>
            </div>

          
            <div class="card card--4">
                <div class="card__img"></div>
                <a href="#" class="card__img--hover"></a>
                <div class="card__info">
                    <span class="card_category">Event</span>
                    <h3 class="card__title">Fun Run</h3>
                    <span class="card__by">By <a href="#" class="card__author">Faculty of Sport Science</a></span>
                </div>
                <div class="card__info-hover">
                    <div class="card__clock-info">
                        <svg class="card__clock" viewBox="0 0 24 24">
                            <path d="M12,20A8,8 0 1,0 4,12A8,8 0 0,0 12,20M12,2A10,10 0 1,1 2,12A10,10 0 0,1 12,2M11,6H13V13H11V6M11,16H13V18H11V16Z" />
                        </svg>
                        <span class="card__time">10 Days</span>
                    </div>
                    <button type="button" class="btn btn-outline-warning" onclick="openRsvpModal(1)">RSVP</button>
                </div>
            </div>
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
<script src="js/scripts.js"></script>
</body>
</html>
