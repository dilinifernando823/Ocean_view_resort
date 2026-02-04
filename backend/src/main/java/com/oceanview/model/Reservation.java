package com.oceanview.model;

import java.util.Date;

public class Reservation {
    private String id;
    private String reservationNumber;
    private String guestId; // FK to User
    private String roomId; // FK to Room
    private Date checkIn;
    private Date checkOut;
    private double totalCost;
    private int totalNights;
    private String status; // approved, rejected, pending, completed, overdue
    private String paymentStatus; // paid, unpaid
    private String notes;
    private Date createdAt;
    private Date updatedAt;

    public Reservation() {}

    public Reservation(String id, String reservationNumber, String guestId, String roomId, Date checkIn, Date checkOut, double totalCost, int totalNights, String status, String paymentStatus, String notes, Date createdAt, Date updatedAt) {
        this.id = id;
        this.reservationNumber = reservationNumber;
        this.guestId = guestId;
        this.roomId = roomId;
        this.checkIn = checkIn;
        this.checkOut = checkOut;
        this.totalCost = totalCost;
        this.totalNights = totalNights;
        this.status = status;
        this.paymentStatus = paymentStatus;
        this.notes = notes;
        this.createdAt = createdAt;
        this.updatedAt = updatedAt;
    }

    // Getters and Setters
    public String getId() { return id; }
    public void setId(String id) { this.id = id; }

    public String getReservationNumber() { return reservationNumber; }
    public void setReservationNumber(String reservationNumber) { this.reservationNumber = reservationNumber; }

    public String getGuestId() { return guestId; }
    public void setGuestId(String guestId) { this.guestId = guestId; }

    public String getRoomId() { return roomId; }
    public void setRoomId(String roomId) { this.roomId = roomId; }

    public Date getCheckIn() { return checkIn; }
    public void setCheckIn(Date checkIn) { this.checkIn = checkIn; }

    public Date getCheckOut() { return checkOut; }
    public void setCheckOut(Date checkOut) { this.checkOut = checkOut; }

    public double getTotalCost() { return totalCost; }
    public void setTotalCost(double totalCost) { this.totalCost = totalCost; }

    public int getTotalNights() { return totalNights; }
    public void setTotalNights(int totalNights) { this.totalNights = totalNights; }

    public String getStatus() { return status; }
    public void setStatus(String status) { this.status = status; }

    public String getPaymentStatus() { return paymentStatus; }
    public void setPaymentStatus(String paymentStatus) { this.paymentStatus = paymentStatus; }

    public String getNotes() { return notes; }
    public void setNotes(String notes) { this.notes = notes; }

    public Date getCreatedAt() { return createdAt; }
    public void setCreatedAt(Date createdAt) { this.createdAt = createdAt; }

    public Date getUpdatedAt() { return updatedAt; }
    public void setUpdatedAt(Date updatedAt) { this.updatedAt = updatedAt; }
}
