package com.harith.model;

public class EventAttendance {
    private int attendanceId;
    private int studentId;
    private int eventId;

    // Default constructor
    public EventAttendance() {
        this.attendanceId = 0;
        this.studentId = 0;
        this.eventId = 0;
    }

    // Parameterized constructor
    public EventAttendance(int attendanceId, int studentId, int eventId) {
        this.attendanceId = attendanceId;
        this.studentId = studentId;
        this.eventId = eventId;
    }

    // Getters and setters
    public int getAttendanceId() {
        return attendanceId;
    }

    public void setAttendanceId(int attendanceId) {
        this.attendanceId = attendanceId;
    }

    public int getStudentId() {
        return studentId;
    }

    public void setStudentId(int studentId) {
        this.studentId = studentId;
    }

    public int getEventId() {
        return eventId;
    }

    public void setEventId(int eventId) {
        this.eventId = eventId;
    }
}
