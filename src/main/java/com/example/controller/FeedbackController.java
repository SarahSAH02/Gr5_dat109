package com.example.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.example.dto.FeedbackDTO;

import com.example.service.FeedbackService;
import com.example.service.LectureService;

@Controller
@RequestMapping("/feedback")
public class FeedbackController {

    @Autowired
    private FeedbackService feedbackService;
    
    @Autowired
    private LectureService lectureService;

    @GetMapping("/submit")
    public String showSubmitForm(Model model) {
        model.addAttribute("feedback", new FeedbackDTO());
        model.addAttribute("lectures", lectureService.findAll());
        return "submit";
    }

    @PostMapping("/submit")
    public String processSubmission(@ModelAttribute("feedback") FeedbackDTO dto, 
                                  Model model) {
        try {
            feedbackService.submitFeedback(dto);
            model.addAttribute("message", "Takk for tilbakemeldingen!");
        } catch (Exception e) {
            model.addAttribute("error", "Noe gikk galt: " + e.getMessage());
        }
        model.addAttribute("lectures", lectureService.findAll());
        return "submit";
    }
}