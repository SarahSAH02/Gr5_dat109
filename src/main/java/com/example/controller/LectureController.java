package com.example.controller;


import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.example.model.Lecture;
import com.example.service.LectureService;

@Controller
@RequestMapping("/lectures")
public class LectureController {

    @Autowired
    private LectureService lectureService;

    // Keep just one method to handle GET requests for /lectures
    @GetMapping
    public String allLectures(Model model) {
        List<Lecture> lectures = lectureService.findAll();  // fetch all lectures
        model.addAttribute("lectures", lectures);
        return "lectures";  // matcher lectures.jsp or lectures.html
    }

    @PostMapping("/create")
    public String createFeedbackForm(
        @RequestParam String lectureTitle,
        RedirectAttributes redirectAttributes) {
        
        try {
            lectureService.createNewLectureForm(lectureTitle);
            redirectAttributes.addFlashAttribute("success", "Tilbakemeldingsskjema opprettet!");
        } catch (Exception e) {
            redirectAttributes.addFlashAttribute("error", "Kunne ikke opprette skjema: " + e.getMessage());
        }
        
        return "redirect:/dashboard";
    }
}
