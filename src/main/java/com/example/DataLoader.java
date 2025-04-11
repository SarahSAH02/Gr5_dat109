package com.example;

import org.springframework.boot.CommandLineRunner;
import org.springframework.context.annotation.Bean;
import org.springframework.stereotype.Component;

import com.example.model.Feedback;
import com.example.model.FeedbackColor;
import com.example.model.Lecture;
import com.example.model.Users;
import com.example.repository.FeedbackRepository;
import com.example.repository.LectureRepository;
import com.example.repository.UserRepository;

import jakarta.transaction.Transactional;

import java.time.LocalDate;
import java.util.List;

@Component
public class DataLoader {

    @Bean
    @Transactional
    public CommandLineRunner loadTestData(UserRepository userRepository,
                                        LectureRepository lectureRepository,
                                        FeedbackRepository feedbackRepository) {
        return args -> {
            // 1. Create and save user first
            Users user = new Users();
            user.setUsername("alice");
            user.setPassword("alice123");
            userRepository.save(user);

            // 2. Create and save lectures
            Lecture javaIntro = new Lecture("Introduksjon til Java", LocalDate.of(2025, 4, 10));
            Lecture springBoot = new Lecture("Spring Boot for nybegynnere", LocalDate.of(2025, 4, 12));
            Lecture postgres = new Lecture("Avansert PostgreSQL", LocalDate.of(2025, 4, 15));
            
            lectureRepository.saveAll(List.of(javaIntro, springBoot, postgres));
            
            // 3. Create and save feedback
            feedbackRepository.saveAll(List.of(
                new Feedback("Veldig lærerikt!", FeedbackColor.GREEN, javaIntro),
                new Feedback("Gikk litt fort frem", FeedbackColor.YELLOW, javaIntro),
                new Feedback("Super forelesning!", FeedbackColor.GREEN, springBoot),
                new Feedback("Trenger mer tid på database", FeedbackColor.YELLOW, postgres),
                new Feedback("Altfor avansert!", FeedbackColor.RED, postgres)
            ));
        };
    }
}