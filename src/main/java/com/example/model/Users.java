package com.example.model;

import jakarta.persistence.Entity;

import jakarta.persistence.Id; // Use JPA's @Id

@Entity
public class Users {
    @Id



    
    
    private String username;
    private String password;
   
// Required no-arg constructor
public Users() {
}

    public Users(String username, String password) {
        this.username = username;
        this.password = password;
        
    }
    
  

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    
}
