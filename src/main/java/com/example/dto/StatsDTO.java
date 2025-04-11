package com.example.dto;

import java.util.List;
import java.util.Map;

public class StatsDTO {
    private int total;
    private Map<String, Integer> byColor;  // Fargefordeling
    private List<String> comments;

    // Getters and setters

    public int getTotal() {
        return total;
    }

    public void setTotal(int total) {
        this.total = total;
    }

    public Map<String, Integer> getByColor() {
        return byColor;
    }

    public void setByColor(Map<String, Integer> byColor) {
        this.byColor = byColor;
    }

    public List<String> getComments() {
        return comments;
    }

    public void setComments(List<String> comments) {
        this.comments = comments;
    }
}
