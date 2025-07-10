<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="utf-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />
  <title>Event Approvals</title>


  <link rel="icon" type="image/x-icon" href="assets/favicon.ico" />

 
  <link href="css/styles.css" rel="stylesheet" />
  <link rel="stylesheet" href="css/card.css">
  <link href="https://fonts.googleapis.com/css2?family=Poppins&display=swap" rel="stylesheet">
</head>
<body>
  
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
          <li class="nav-item"><a class="nav-link" href="registerClub.jsp">Register Club</a></li>
          <li class="nav-item"><a class="nav-link" href="create-event.jsp">Create Event</a></li>
          <li class="nav-item"><a class="nav-link" href="approval.jsp">Approve Events</a></li>
          <li class="nav-item"><a class="nav-link text-danger" href="loginn.jsp">Logout</a></li>
        </ul>
      </div>
    </div>
  </nav>

 
  <header class="bg-light py-5">
    <div class="container text-center">
      <h1 class="display-4 fw-bold">Event Approval ✅</h1>
    </div>
  </header>


  <section class="py-5">
    <div class="container px-5">
      <!-- Event 1 -->
      <div class="card mb-4 shadow-sm">
        <div class="card-body">
          <h5 class="card-title">TEDx: What is AI?</h5>
          <h6 class="card-subtitle mb-2 text-muted">Organized by: KPPIM | Category: Talk</h6>
          <p class="card-text">
            A talk on how artificial intelligence is changing our world. Join us to explore the possibilities of the future.
          </p>
          <p><strong>Date:</strong> 2025-06-15</p>
          <div class="d-flex gap-2">
            <button class="btn btn-success">Approve</button>
            <button class="btn btn-danger">Reject</button>
          </div>
        </div>
      </div>

    
      <div class="card mb-4 shadow-sm">
        <div class="card-body">
          <h5 class="card-title">Graduation Celebration</h5>
          <h6 class="card-subtitle mb-2 text-muted">Organized by: KPPIM | Category: Social</h6>
          <p class="card-text">
            A social event to celebrate the graduating class with food, music, and memories.
          </p>
          <p><strong>Date:</strong> 2025-07-01</p>
          <div class="d-flex gap-2">
            <button class="btn btn-success">Approve</button>
            <button class="btn btn-danger">Reject</button>
          </div>
        </div>
      </div>

    </div>
  </section>

 
  <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
