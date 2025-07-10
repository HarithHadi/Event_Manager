<div align="center">

# Event Campus Manger



</div>

## About

The Campus Club and Event Management System is a web-based application designed to centralize and simplify the management of student clubs and campus events. 
It serves as a digital hub for students, club leaders to interact, coordinate, and participate in extracurricular activities efficiently.

## Objectives


1. Develop a secure system with role-based access

2. Allow users to register, login/logout, and manage profiles

3. Enable clubs to create, update and track events

4. Provide real-time RSVP tracking

## Technology Stack
|  | Technology |
|-----:|-----------|
|     Frontend| HTML, CSS, JSP|
|     Backend| Java Servlets, JavaBean    |
|     Architecture| MVC       |
|     Database| Apache Derby       |
|     Server| Glassfish       |
|     Development Tools| Netbeans IDE       |
  
 # Installation

1. Clone this repo (Navigate to git clone in netbeans)
2.  Create database using the code below
```
-- USERS Table
CREATE TABLE USERS (
    USER_ID INT GENERATED ALWAYS AS IDENTITY(START WITH 1, INCREMENT BY 1) PRIMARY KEY,
    EMAIL VARCHAR(100) NOT NULL UNIQUE,
    PASSWORD VARCHAR(100) NOT NULL,
    ROLE VARCHAR(50) NOT NULL
);

-- STUDENTS Table
CREATE TABLE STUDENTS (
    STUDENT_ID INT GENERATED ALWAYS AS IDENTITY(START WITH 1, INCREMENT BY 1) PRIMARY KEY,
    USER_ID INT NOT NULL,
    STUDENT_NAME VARCHAR(100) NOT NULL,
    STUDENT_COURSE VARCHAR(100),
    STUDENT_PART INT,
    STUDENT_GROUP VARCHAR(50),
    STUDENT_PHONE VARCHAR(20),
    CLUB_ID INT, -- Optional FK to CLUBS
    FOREIGN KEY (USER_ID) REFERENCES USERS(USER_ID),
    FOREIGN KEY (CLUB_ID) REFERENCES CLUBS(CLUB_ID)
);

-- ORGANIZERS Table
CREATE TABLE ORGANIZERS (
    ORGANIZER_ID INT GENERATED ALWAYS AS IDENTITY(START WITH 1, INCREMENT BY 1) PRIMARY KEY,
    STUDENT_ID INT NOT NULL,
    FOREIGN KEY (STUDENT_ID) REFERENCES STUDENTS(STUDENT_ID)
);

-- CLUBS Table
CREATE TABLE CLUBS (
    CLUB_ID INT GENERATED ALWAYS AS IDENTITY(START WITH 1, INCREMENT BY 1) PRIMARY KEY,
    CLUB_NAME VARCHAR(100) NOT NULL,
    ORGANIZER_ID INT NOT NULL,
    FOREIGN KEY (ORGANIZER_ID) REFERENCES ORGANIZERS(ORGANIZER_ID)
);

-- EVENTS Table
CREATE TABLE EVENTS (
    EVENT_ID INT GENERATED ALWAYS AS IDENTITY(START WITH 1, INCREMENT BY 1) PRIMARY KEY,
    EVENT_TITLE VARCHAR(100) NOT NULL,
    EVENT_DATE DATE NOT NULL,
    EVENT_DESC CLOB,
    CLUB_ID INT NOT NULL,
    FOREIGN KEY (CLUB_ID) REFERENCES CLUBS(CLUB_ID)
);

-- EVENTS ATTENDANCE Table
CREATE TABLE EVENT_ATTENDANCE (
    attendance_id INT GENERATED ALWAYS AS IDENTITY(START WITH 1, INCREMENT BY 1) PRIMARY KEY,
    student_id INT NOT NULL,
    event_id INT NOT NULL,
    FOREIGN KEY (student_id) REFERENCES STUDENTS(STUDENT_ID),
    FOREIGN KEY (event_id) REFERENCES EVENTS(EVENT_ID)
);

```
3. You're ready ! 
