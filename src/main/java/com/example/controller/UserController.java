package com.example.controller;

import org.springframework.beans.factory.annotation.Autowired;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;

import org.springframework.web.bind.annotation.RequestParam;

import com.example.dto.UserDTO;
import com.example.service.UserService;

@Controller

public class UserController {  // Remove @RequestMapping("/users")

    @Autowired
    private UserService userService;

    // 👇 Login endpoints - now mapped to /login instead of /users/login
    @GetMapping("/login")
    public String showLoginForm(
            @RequestParam(value = "error", required = false) String error,
            @RequestParam(value = "logout", required = false) String logout,
            Model model) {
        if (error != null) model.addAttribute("error", "Invalid credentials");
        if (logout != null) model.addAttribute("message", "Logged out successfully");
        return "login";
    }

    // 👇 Registration endpoints - keep under /users/register
    @GetMapping("/users/register")
    public String showRegistrationForm(Model model) {
        model.addAttribute("user", new UserDTO());
        return "register";
    }

    @PostMapping("/users/register")
    public String registerUser(@ModelAttribute UserDTO dto, Model model) {
        try {
            userService.create(dto);
            return "redirect:/login?registered=true";  // Changed to /login
        } catch (Exception e) {
            model.addAttribute("error", "Registration failed: " + e.getMessage());
            return "register";
        }
    }
}