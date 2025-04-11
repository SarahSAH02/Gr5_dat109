package com.example.model;

import jakarta.persistence.Entity;
import jakarta.persistence.EnumType;
import jakarta.persistence.Enumerated;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.ManyToOne;

@Entity
public class Feedback {

  @Id
@GeneratedValue(strategy = GenerationType.IDENTITY)
private Long id;

  

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    private String comment;

    public String getComment() {
        return comment;
    }

    public void setComment(String comment) {
        this.comment = comment;
    }

    // Correct EnumType.STRING (case-sensitive)
    @Enumerated(EnumType.STRING)
    private FeedbackColor color;

    public FeedbackColor getColor() {
        return color;
    }

    public void setColor(FeedbackColor color) {
        this.color = color;
    }

    @ManyToOne
    private Lecture lecture;

    public Lecture getLecture() {
        return lecture;
    }

    public void setLecture(Lecture lecture) {
        this.lecture = lecture;
    }
 // Required no-arg constructor
 public Feedback() {
}

    public Feedback(String comment, FeedbackColor color, Lecture lecture) {
        this.comment = comment;
        this.color = color;
        this.lecture = lecture;
    }
    
}
