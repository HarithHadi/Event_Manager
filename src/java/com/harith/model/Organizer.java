package com.harith.model;

public class Organizer {
    private int organizerID;
    private int studentID;

    // Default constructor
    public Organizer() {
        this.organizerID = 0;
        this.studentID = 0;
    }

    // Full constructor
    public Organizer(int organizerID, int studentID) {
        this.organizerID = organizerID;
        this.studentID = studentID;
    }

    // Getters and Setters
    public int getOrganizerID() {
        return organizerID;
    }

    public void setOrganizerID(int organizerID) {
        this.organizerID = organizerID;
    }

    public int getStudentID() {
        return studentID;
    }

    public void setStudentID(int studentID) {
        this.studentID = studentID;
    }
}
