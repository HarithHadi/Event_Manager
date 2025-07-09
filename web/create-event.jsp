<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="utf-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />
  <title>Create Event</title>

  <link rel="icon" type="image/x-icon" href="assets/favicon.ico" />

  <link href="css/styles.css" rel="stylesheet" />
  <link rel="stylesheet" href="css/card.css">
  <link href="https://fonts.googleapis.com/css2?family=Poppins&display=swap" rel="stylesheet">
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
                <li class="nav-item"><a class="nav-link active" href="create-event.jsp">Create Event</a></li>
                <li class="nav-item"><a class="nav-link" href="ClubManagement.jsp">Club Management</a></li>
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
      <h1 class="display-4 fw-bold">Create New Event 📅</h1>
    </div>
  </header>
  

  <section class="py-5">
    <div class="container px-5">
      <!-- update create eveent servlet disini -->
      <form action="CreateEventServlet" method="post">
        <div class="mb-3">
          <label for="eventTitle" class="form-label">Event Title</label>
          <input type="text" class="form-control" id="eventTitle" name="eventTitle" placeholder="Enter event name" required>
        </div>

        <div class="mb-3">
          <label for="eventCategory" class="form-label">Category</label>
          <select class="form-select" id="eventCategory" name="eventCategory" required>
            <option selected disabled>Choose category</option>
            <option value="Ceremony">Ceremony</option>
            <option value="Social">Social</option>
            <option value="Talk">Talk</option>
            <option value="Sport">Sport</option>
          </select>
        </div>


        <div class="mb-3">
          <label for="eventDate" class="form-label">Event Date</label>
          <input type="date" class="form-control" id="eventDate" name="eventDate" required>
        </div>

        <div class="mb-3">
          <label for="eventDescription" class="form-label">Description</label>
          <textarea class="form-control" id="eventDescription" name="eventDescription" rows="4" placeholder="Brief description of the event" required></textarea>
        </div>

        <div class="d-grid">
          <button type="submit" class="btn btn-primary">Create Event</button>
        </div>
      </form>
    </div>
  </section>


  <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
