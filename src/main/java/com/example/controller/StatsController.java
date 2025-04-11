package com.example.controller;

import com.example.service.FeedbackService;
import com.example.dto.StatsDTO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RestController;

@RestController

public class StatsController {

    @Autowired
    private FeedbackService feedbackService;

    @GetMapping("/{lectureId}")
    public StatsDTO getStats(@PathVariable Long lectureId) {
        return feedbackService.getStatsForLecture(lectureId);
    }
}
