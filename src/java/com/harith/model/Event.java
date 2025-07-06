package com.harith.model;

public class Event {
    private int eventID;
    private int clubID;
    private String eventTitle;
    private String eventDate;
    private String eventDesc;

    // Default constructor
    public Event() {
        this.eventID = 0;
        this.clubID = 0;
        this.eventTitle = "";
        this.eventDate = "";
        this.eventDesc = "";
    }

    // Full constructor
    public Event(int eventID, int clubID, String eventTitle, String eventDate, String eventDesc) {
        this.eventID = eventID;
        this.clubID = clubID;
        this.eventTitle = eventTitle;
        this.eventDate = eventDate;
        this.eventDesc = eventDesc;
    }

    // Getters and setters
    public int getEventID() {
        return eventID;
    }

    public void setEventID(int eventID) {
        this.eventID = eventID;
    }

    public int getClubID() {
        return clubID;
    }

    public void setClubID(int clubID) {
        this.clubID = clubID;
    }

    public String getEventTitle() {
        return eventTitle;
    }

    public void setEventTitle(String eventTitle) {
        this.eventTitle = eventTitle;
    }

    public String getEventDate() {
        return eventDate;
    }

    public void setEventDate(String eventDate) {
        this.eventDate = eventDate;
    }

    public String getEventDesc() {
        return eventDesc;
    }

    public void setEventDesc(String eventDesc) {
        this.eventDesc = eventDesc;
    }
}
