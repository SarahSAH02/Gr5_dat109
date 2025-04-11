package com.example.service;

import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.example.dto.FeedbackDTO;
import com.example.dto.StatsDTO;
import com.example.model.Feedback;
import com.example.model.FeedbackColor;
import com.example.model.Lecture;
import com.example.repository.FeedbackRepository;
import com.example.repository.LectureRepository;

@Service
public class FeedbackService {

    @Autowired
    private FeedbackRepository feedbackRepository;
    @Autowired
    private LectureRepository lectureRepository;

    // For å sende inn tilbakemelding
    public Feedback submitFeedback(FeedbackDTO dto) {
        Lecture lecture = lectureRepository.findById(dto.lectureId).orElseThrow();
        Feedback feedback = new Feedback(null, null, lecture);
        feedback.setComment(dto.comment);
        feedback.setColor(FeedbackColor.valueOf(dto.color.toUpperCase()));
        feedback.setLecture(lecture);
        return feedbackRepository.save(feedback);
    }

    // Henter tilbakemeldinger for en bestemt forelesning
    public List<Feedback> getFeedbackForLecture(Long lectureId) {
        return feedbackRepository.findByLectureId(lectureId);
    }

    // Henter statistikk for en spesifikk forelesning
    public StatsDTO getStatsForLecture(Long lectureId) {
        List<Feedback> feedbackList = feedbackRepository.findByLectureId(lectureId);
        StatsDTO statsDTO = new StatsDTO();

        // Sett total antall tilbakemeldinger
        statsDTO.setTotal(feedbackList.size());

        // Beregn statistikk for fargefordeling, og konverter Long til Integer
        Map<String, Integer> colorStats = feedbackList.stream()
                .collect(Collectors.groupingBy(feedback -> feedback.getColor().name(), 
                        Collectors.reducing(0, e -> 1, Integer::sum))); // Nå blir summen Integer

        statsDTO.setByColor(colorStats);

        // Hent kommentarer
        List<String> comments = feedbackList.stream()
                .map(Feedback::getComment)
                .collect(Collectors.toList());

        statsDTO.setComments(comments);

        return statsDTO;
    }
}
