package com.example.controller;

import com.example.service.FeedbackService;
import com.example.dto.StatsDTO;
import com.example.model.Lecture;
import com.example.service.LectureService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.List;

@Controller
public class StatsController {

    private final FeedbackService feedbackService;
    private final LectureService lectureService;

    @Autowired
    public StatsController(FeedbackService feedbackService, LectureService lectureService) {
        this.feedbackService = feedbackService;
        this.lectureService = lectureService;
    }

    @GetMapping("/stats")
    public String showStatsPage(Model model) {
        List<Lecture> lectures = lectureService.findAll();
        if (lectures.isEmpty()) {
            System.out.println("Warning: No lectures found in database");
        }
        model.addAttribute("lectures", lectures);
        return "stats";
    }

    @GetMapping("/api/stats/{lectureId}")
    @ResponseBody
    public StatsDTO getLectureStats(@PathVariable Long lectureId) {
        return feedbackService.getStatsForLecture(lectureId);
    }
}