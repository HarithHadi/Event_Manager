package com.harith.model;

public class Club {
    private int clubID;
    private String clubName;
    private int organizerID;

    // Default constructor
    public Club() {
        this.clubID = 0;
        this.clubName = "";
        this.organizerID = 0;
    }

    // Full constructor
    public Club(int clubID, String clubName, int organizerID) {
        this.clubID = clubID;
        this.clubName = clubName;
        this.organizerID = organizerID;
    }

    // Getters and setters
    public int getClubID() {
        return clubID;
    }

    public void setClubID(int clubID) {
        this.clubID = clubID;
    }

    public String getClubName() {
        return clubName;
    }

    public void setClubName(String clubName) {
        this.clubName = clubName;
    }

    public int getOrganizerID() {
        return organizerID;
    }

    public void setOrganizerID(int organizerID) {
        this.organizerID = organizerID;
    }
}
