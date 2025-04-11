package com.example.repository;


import java.util.Optional;

import org.springframework.data.jpa.repository.JpaRepository;

import com.example.model.Users;

public interface UserRepository extends JpaRepository<Users, String> {
    Optional<Users> findByUsername(String username);

    void deleteByUsername(String username);

  
   
}


