package com.harith.model;

public class Student {
    private int studentID;
    private int userID;
    private int clubID;
    private String studentName;
    private String studentCourse;
    private int studentPart;
    private String studentGroup;
    private String studentPhone;

    // Default constructor
    public Student() {
        this.studentID = 0;
        this.userID = 0;
        this.clubID = 0;
        this.studentName = "";
        this.studentCourse = "";
        this.studentPart = 0;
        this.studentGroup = "";
        this.studentPhone = "";
    }

    // Full constructor
    public Student(int studentID, int userID, int clubID, String studentName, String studentCourse, int studentPart, String studentGroup, String studentPhone) {
        this.studentID = studentID;
        this.userID = userID;
        this.clubID = clubID;
        this.studentName = studentName;
        this.studentCourse = studentCourse;
        this.studentPart = studentPart;
        this.studentGroup = studentGroup;
        this.studentPhone = studentPhone;
    }

    // Getters and setters
    public int getStudentID() {
        return studentID;
    }

    public void setStudentID(int studentID) {
        this.studentID = studentID;
    }

    public int getUserID() {
        return userID;
    }

    public void setUserID(int userID) {
        this.userID = userID;
    }

    public int getClubID() {
        return clubID;
    }

    public void setClubID(int clubID) {
        this.clubID = clubID;
    }

    public String getStudentName() {
        return studentName;
    }

    public void setStudentName(String studentName) {
        this.studentName = studentName;
    }

    public String getStudentCourse() {
        return studentCourse;
    }

    public void setStudentCourse(String studentCourse) {
        this.studentCourse = studentCourse;
    }

    public int getStudentPart() {
        return studentPart;
    }

    public void setStudentPart(int studentPart) {
        this.studentPart = studentPart;
    }

    public String getStudentGroup() {
        return studentGroup;
    }

    public void setStudentGroup(String studentGroup) {
        this.studentGroup = studentGroup;
    }

    public String getStudentPhone() {
        return studentPhone;
    }

    public void setStudentPhone(String studentPhone) {
        this.studentPhone = studentPhone;
    }
}
