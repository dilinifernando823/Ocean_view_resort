package com.oceanview.model;

import java.util.Date;

public class Room {
    private String id;
    private String roomNumber;
    private String categoryId; // FK to RoomCategory
    private String status; // available, unavailable, maintenance, booked
    private String description;
    private String amenities; // comma separated list
    private double pricePerNight;
    private int capacity;
    private String roomName;
    private String image1;
    private String image2;
    private String image3;
    private Date createdAt;
    private Date updatedAt;

    public Room() {}

    public Room(String id, String roomNumber, String categoryId, String status, String description, String amenities, double pricePerNight, int capacity, String roomName, String image1, String image2, String image3, Date createdAt, Date updatedAt) {
        this.id = id;
        this.roomNumber = roomNumber;
        this.categoryId = categoryId;
        this.status = status;
        this.description = description;
        this.amenities = amenities;
        this.pricePerNight = pricePerNight;
        this.capacity = capacity;
        this.roomName = roomName;
        this.image1 = image1;
        this.image2 = image2;
        this.image3 = image3;
        this.createdAt = createdAt;
        this.updatedAt = updatedAt;
    }

    // Getters and Setters
    public String getId() { return id; }
    public void setId(String id) { this.id = id; }

    public String getRoomNumber() { return roomNumber; }
    public void setRoomNumber(String roomNumber) { this.roomNumber = roomNumber; }

    public String getCategoryId() { return categoryId; }
    public void setCategoryId(String categoryId) { this.categoryId = categoryId; }

    public String getStatus() { return status; }
    public void setStatus(String status) { this.status = status; }

    public String getDescription() { return description; }
    public void setDescription(String description) { this.description = description; }

    public String getAmenities() { return amenities; }
    public void setAmenities(String amenities) { this.amenities = amenities; }

    public double getPricePerNight() { return pricePerNight; }
    public void setPricePerNight(double pricePerNight) { this.pricePerNight = pricePerNight; }

    public int getCapacity() { return capacity; }
    public void setCapacity(int capacity) { this.capacity = capacity; }

    public String getRoomName() { return roomName; }
    public void setRoomName(String roomName) { this.roomName = roomName; }

    public String getImage1() { return image1; }
    public void setImage1(String image1) { this.image1 = image1; }

    public String getImage2() { return image2; }
    public void setImage2(String image2) { this.image2 = image2; }

    public String getImage3() { return image3; }
    public void setImage3(String image3) { this.image3 = image3; }

    public Date getCreatedAt() { return createdAt; }
    public void setCreatedAt(Date createdAt) { this.createdAt = createdAt; }

    public Date getUpdatedAt() { return updatedAt; }
    public void setUpdatedAt(Date updatedAt) { this.updatedAt = updatedAt; }
}
