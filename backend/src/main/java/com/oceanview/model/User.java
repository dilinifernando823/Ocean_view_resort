package com.oceanview.model;

import java.util.Date;

public class User {
    private String id;
    private String username;
    private String password;
    private String role;
    private String email;
    private String address;
    private String phone;
    private String fullName;
    private String nic;
    private Date createdAt;
    private Date updatedAt;

    public User() {}

    public User(String id, String username, String password, String role, String email, String fullName, String address, String phone, String nic, Date createdAt, Date updatedAt) {
        this.id = id;
        this.username = username;
        this.password = password;
        this.role = role;
        this.email = email;
        this.fullName = fullName;
        this.address = address;
        this.phone = phone;
        this.nic = nic;
        this.createdAt = createdAt;
        this.updatedAt = updatedAt;
    }

    // Getters and Setters
    public String getId() { return id; }
    public void setId(String id) { this.id = id; }

    public String getUsername() { return username; }
    public void setUsername(String username) { this.username = username; }

    public String getPassword() { return password; }
    public void setPassword(String password) { this.password = password; }

    public String getRole() { return role; }
    public void setRole(String role) { this.role = role; }

    public String getEmail() { return email; }
    public void setEmail(String email) { this.email = email; }

    public String getFullName() { return fullName; }
    public void setFullName(String fullName) { this.fullName = fullName; }

    public String getAddress() { return address; }
    public void setAddress(String address) { this.address = address; }

    public String getPhone() { return phone; }
    public void setPhone(String phone) { this.phone = phone; }

    public String getNic() { return nic; }
    public void setNic(String nic) { this.nic = nic; }

    public Date getCreatedAt() { return createdAt; }
    public void setCreatedAt(Date createdAt) { this.createdAt = createdAt; }

    public Date getUpdatedAt() { return updatedAt; }
    public void setUpdatedAt(Date updatedAt) { this.updatedAt = updatedAt; }
}
