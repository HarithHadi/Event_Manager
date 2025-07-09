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
    
      body.no-hover .card:hover {
    transform: none !important;
    box-shadow: 0px 13px 10px -7px rgba(0, 0, 0, 0.1) !important;
  }

  body.no-hover .card:hover .card__img--hover {
    height: 235px !important;
    opacity: 1 !important;
  }

  body.no-hover .card:hover .card__info {
    background-color: #fff !important;
    position: static !important;
  }

  body.no-hover .card:hover .card__info-hover {
    opacity: 0 !important;
  }
  </style>
</head>
<body class="no-hover">
 
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
              <h2 class="card-title text-center mb-4">Login</h2>
                <%
                    String error = request.getParameter("error");
                    if ("invalid".equals(error)) {
                %>
                    <div class="alert alert-danger text-center" role="alert">
                        Invalid email or password. Please try again.
                    </div>
                <%
                    }
                %>


              <!-- update login servlet disini -->
              <form action="loginServlet" method="post">
                <div class="mb-3">
                  <label for="email" class="form-label">Email</label>
                  <input type="email" class="form-control" id="email" name="email" placeholder="Enter your email">
                </div>
                <div class="mb-3">
                  <label for="password" class="form-label">Password</label>
                  <input type="password" class="form-control" id="password" name="password" placeholder="Enter your password">
                </div>
                <div class="d-grid">
                  <button type="submit" class="btn btn-primary">Login</button>
                </div>
              </form>

              <hr>
              <p class="text-center small text-muted">This is a mockup. Click a role to simulate login flow:</p>
<!--              <div class="d-flex justify-content-center gap-2">
                <a href="index.jsp" class="btn btn-outline-primary btn-sm">Login as Student</a>
                <a href="approval.jsp" class="btn btn-outline-warning btn-sm">Login as Staff</a>
              </div>-->
              <div class="d-flex justify-content-center gap-2">
                <a href="register.jsp" class="btn btn-outline-primary btn-sm">Register</a>
              </div>

            </div>
          </div>
        </div>
      </div>
    </div>
  </section>


  <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
