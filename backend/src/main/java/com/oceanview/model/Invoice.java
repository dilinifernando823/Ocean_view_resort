package com.oceanview.model;

import java.util.Date;

public class Invoice {
    private String id;
    private String reservationId; // FK to Reservation
    private String guestId; // FK to User
    private Date issueDate;
    private double subtotal;
    private String status; // paid, unpaid
    private String notes;
    private Date createdAt;
    private Date updatedAt;

    public Invoice() {}

    public Invoice(String id, String reservationId, String guestId, Date issueDate, double subtotal, String status, String notes, Date createdAt, Date updatedAt) {
        this.id = id;
        this.reservationId = reservationId;
        this.guestId = guestId;
        this.issueDate = issueDate;
        this.subtotal = subtotal;
        this.status = status;
        this.notes = notes;
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

    public Date getIssueDate() { return issueDate; }
    public void setIssueDate(Date issueDate) { this.issueDate = issueDate; }

    public double getSubtotal() { return subtotal; }
    public void setSubtotal(double subtotal) { this.subtotal = subtotal; }

    public String getStatus() { return status; }
    public void setStatus(String status) { this.status = status; }

    public String getNotes() { return notes; }
    public void setNotes(String notes) { this.notes = notes; }

    public Date getCreatedAt() { return createdAt; }
    public void setCreatedAt(Date createdAt) { this.createdAt = createdAt; }

    public Date getUpdatedAt() { return updatedAt; }
    public void setUpdatedAt(Date updatedAt) { this.updatedAt = updatedAt; }
}
