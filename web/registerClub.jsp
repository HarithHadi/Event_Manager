<%-- 
    Document   : registerClub
    Created on : Jul 4, 2025, 3:05:47 PM
    Author     : User
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
        <style>
            /* ======= FORM SECTION ======= */
        .form-section {
          display: flex;
          justify-content: center;
          align-items: center;
          padding: 60px 20px;
          min-height: 100vh;
        }

        .form-container {
          background: white;
          padding: 40px 50px;
          max-width: 800px;
          width: 100%;
          border-radius: 16px;
          box-shadow: 0 8px 32px rgba(0,0,0,0.08);
        }

        h1 {
          font-size: 32px;
          margin-bottom: 10px;
          color: #2c3e50;
        }

        p {
          margin-bottom: 30px;
          color: #666;
        }

        .form-grid {
          display: grid;
          grid-template-columns: 1fr 1fr;
          gap: 20px;
        }

        .form-group {
          display: flex;
          flex-direction: column;
        }

        .form-group.full-width {
          grid-column: span 2;
        }

        label {
          font-weight: 600;
          margin-bottom: 8px;
          color: #444;
        }

        input, select {
          padding: 12px 14px;
          border: 1px solid #ccc;
          border-radius: 8px;
          font-size: 16px;
          background-color: #fff;
          transition: border-color 0.3s ease;
        }

        input:focus, select:focus {
          border-color: #3498db;
          outline: none;
        }

        button {
          background-color: #3498db;
          color: #fff;
          border: none;
          padding: 14px;
          font-size: 16px;
          font-weight: 600;
          border-radius: 8px;
          cursor: pointer;
          transition: background-color 0.3s ease;
        }

        button:hover {
          background-color: #2980b9;
        }

        /* ===== RESPONSIVE ===== */
        @media (max-width: 768px) {
          .form-grid {
            grid-template-columns: 1fr;
          }

          .navbar {
            flex-direction: column;
            align-items: flex-start;
          }

          nav ul {
            flex-direction: column;
            width: 100%;
            gap: 15px;
            margin-top: 10px;
          }

          .form-container {
            padding: 30px;
          }
        }
        </style>
        
        <!-- Styles -->
        <link href="css/styles.css" rel="stylesheet" />
        <link rel="icon" type="image/x-icon" href="assets/favicon.ico" />
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
        <section class="form-section">
            <div class="form-container">
              <h1>Club Membership Registration</h1>
              <p>Please fill in the form below to join one of our exciting clubs!</p>

              <form id="registrationForm" method="post" class="form-grid">
                <div class="form-group">
                  <label for="fullname">Full Name</label>
                  <input type="text" id="fullname" name="fullname" placeholder="Whats Your Name" required>
                </div>

                <div class="form-group">
                  <label for="email">Email Address</label>
                  <input type="email" id="email" name="email" placeholder="you@example.com" required>
                </div>

                <div class="form-group">
                  <label for="phone">Phone Number</label>
                  <input type="tel" id="phone" name="phone" placeholder="Number Phone" required>
                </div>

                <div class="form-group">
                  <label for="club">Select Club</label>
                  <select id="club" name="club" required>
                    <option value="">-- Select a Club --</option>
                    <option value="Robotics Club">Robotics Club</option>
                    <option value="Music Club">Music Club</option>
                    <option value="Sports Club">Sports Club</option>
                    <option value="Debate Club">Debate Club</option>
                    <option value="Photography Club">Photography Club</option>
                    <option value="Volunteer Club">Volunteer Club</option>
                  </select>
                </div>

                <div class="form-group full-width">
                  <button type="submit">Submit Registration</button>
                </div>
              </form>
            </div>
          </section>
    </body>
</html>
