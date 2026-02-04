package com.oceanview.model;

import java.util.Date;

public class Review {
    private String id;
    private String reservationId; // FK to Reservation
    private String guestId; // FK to User
    private String roomId; // FK to Room
    private int rating;
    private String feedback;
    private Date createdAt;
    private Date updatedAt;

    public Review() {}

    public Review(String id, String reservationId, String guestId, String roomId, int rating, String feedback, Date createdAt, Date updatedAt) {
        this.id = id;
        this.reservationId = reservationId;
        this.guestId = guestId;
        this.roomId = roomId;
        this.rating = rating;
        this.feedback = feedback;
        this.createdAt = createdAt;
        this.updatedAt = updatedAt;
    }

    // Getters and Setters
    public String getId() { return id; }
    public void setId(String id) { this.id = id; }

    public String getReservationId() { return reservationId; }
    public void setReservationId(String reservationId) { this.reservationId = reservationId; }

    public String getGuestId() { return guestId; }
    public void setGuestId(String guestId) { this.guestId = guestId; }

    public String getRoomId() { return roomId; }
    public void setRoomId(String roomId) { this.roomId = roomId; }

    public int getRating() { return rating; }
    public void setRating(int rating) { this.rating = rating; }

    public String getFeedback() { return feedback; }
    public void setFeedback(String feedback) { this.feedback = feedback; }

    public Date getCreatedAt() { return createdAt; }
    public void setCreatedAt(Date createdAt) { this.createdAt = createdAt; }

    public Date getUpdatedAt() { return updatedAt; }
    public void setUpdatedAt(Date updatedAt) { this.updatedAt = updatedAt; }
}
