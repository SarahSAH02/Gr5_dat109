package com.example.controller;


import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/stats")

public class StatsViewController {

    @GetMapping
    public String showStatsPage(Model model) {
        // Hvis du ønsker å sende med noe statisk (eks. valgt lecture), gjør det her:
        model.addAttribute("lectureId", null); // kan oppdateres senere via JavaScript
        return "stats";  // ✅ stats.jsp vises her
    }
}
