<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="utf-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1" />
  <title>Admin Dashboard - Campus Event System</title>


  <link rel="icon" type="image/x-icon" href="assets/favicon.ico" />
  <link href="css/styles.css" rel="stylesheet" />
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css" rel="stylesheet">
  <link href="https://fonts.googleapis.com/css2?family=Poppins&display=swap" rel="stylesheet">

  <style>
    body {
      font-family: 'Poppins', sans-serif;
      background-color: #f9f9f9;
    }
    .sidebar {
      height: 100vh;
      width: 220px;
      position: fixed;
      top: 0;
      left: 0;
      background-color: #fff;
      padding-top: 60px;
      border-right: 1px solid #ddd;
    }
    .sidebar a {
      padding: 15px 20px;
      display: block;
      color: #333;
      text-decoration: none;
      font-weight: 500;
    }
    .sidebar a:hover {
      background-color: #f1f1f1;
    }
    .main-content {
      margin-left: 240px;
      padding: 40px 30px;
    }
    .card-body {
      font-size: 1rem;
      font-weight: 500;
    }
  </style>
</head>
<body>


<div class="sidebar">
  <h5 class="text-center fw-bold">CampusEvents</h5>
  <a href="dashboard.jsp">Dashboard</a>
  <a href="create-event.jsp">Manage Events</a>
  <a href="index.jsp">Registrations</a>
  <a href="#">Manage Users</a>
  <a href="login.jsp" class="text-danger">Logout</a>
</div>


<div class="main-content">
  <h2 class="fw-bold">Campus Event Management System</h2>

 
  <div class="row mb-4">
    <div class="col-md-4">
      <input type="text" class="form-control" placeholder="Search event here..." />
    </div>
    <div class="col-md-3">
      <select class="form-select">
        <option>Category</option>
        <option>Ceremony</option>
        <option>Talk</option>
        <option>Social</option>
      </select>
    </div>
    <div class="col-md-3">
      <select class="form-select">
        <option>Filter</option>
        <option>Upcoming</option>
        <option>Past</option>
      </select>
    </div>
  </div>

  <div class="card mb-3 shadow-sm">
    <div class="card-body bg-white">Created by admin</div>
  </div>
  <div class="card mb-3 shadow-sm">
    <div class="card-body bg-white">Scheduled events</div>
  </div>
  <div class="card mb-3 shadow-sm">
    <div class="card-body bg-white">Past events</div>
  </div>
  <div class="card mb-3 shadow-sm">
    <div class="card-body bg-white">Total registered</div>
  </div>
  <div class="card mb-3 shadow-sm">
    <div class="card-body bg-white">Feedback received</div>
  </div>
</div>


<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
