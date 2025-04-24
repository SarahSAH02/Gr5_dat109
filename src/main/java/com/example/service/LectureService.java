package com.example.service;

import java.util.List;


import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.example.model.Lecture;
import com.example.repository.LectureRepository;

@Service
public class LectureService {

    @Autowired
    private LectureRepository lectureRepository;

    public List<Lecture> findAll() {
        return lectureRepository.findAll();
    }

    public Lecture create(Lecture lecture) {
        return lectureRepository.save(lecture);
    }

    public Lecture update(String title, Lecture updated) {
        Lecture existing = lectureRepository.findByTitle(title);
        if (existing == null) {
            throw new RuntimeException("Forelesning med tittel '" + title + "' ble ikke funnet.");
        }
        existing.setTitle(updated.getTitle());
        existing.setDate(updated.getDate());
        return lectureRepository.save(existing);
    }

    public void delete(String title) {
        Lecture existing = lectureRepository.findByTitle(title);
        if (existing == null) {
            throw new RuntimeException("Kan ikke slette: forelesning med tittel '" + title + "' ble ikke funnet.");
        }
        lectureRepository.delete(existing);
    }

    public Lecture createNewLectureForm(String lectureTitle) {
        Lecture newLecture = new Lecture(lectureTitle, null);
        return lectureRepository.save(newLecture);
    }

    public List<Lecture> getAllLectures() {
        return lectureRepository.findAll();
    }

    public Lecture findByTitle(String lectureTitle) {
        return lectureRepository.findByTitle(lectureTitle);
    }
}
