package com.example.repository;

import org.springframework.data.jpa.repository.JpaRepository;

import com.example.model.Lecture;

public interface LectureRepository extends JpaRepository<Lecture, Long> {}
