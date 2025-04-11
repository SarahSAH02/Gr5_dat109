package com.example.dto;




public class FeedbackDTO {
    public Long lectureId;
    public String comment;
    public String color; // "GREEN", "YELLOW", "RED"
    public Long getLectureId() {
        return lectureId;
    }
    public void setLectureId(Long lectureId) {
        this.lectureId = lectureId;
    }
    public String getComment() {
        return comment;
    }
    public void setComment(String comment) {
        this.comment = comment;
    }
    public String getColor() {
        return color;
    }
    public void setColor(String color) {
        this.color = color;
    }
}