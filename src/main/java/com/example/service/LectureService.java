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

    public Lecture update(Long id, Lecture updated) {
        Lecture existing = lectureRepository.findById(id).orElseThrow();
        existing.setTitle(updated.getTitle());
        existing.setDate(updated.getDate());
        return lectureRepository.save(existing);
    }

    public void delete(Long id) {
        lectureRepository.deleteById(id);
    }

    // Implementing createNewLectureForm method
public Lecture createNewLectureForm(String lectureTitle) {
    // Create a new Lecture instance
    Lecture newLecture = new Lecture(lectureTitle, null);
    newLecture.setTitle(lectureTitle);  // Set the lecture title

    // Save and return the new lecture
    return lectureRepository.save(newLecture);  // Save the lecture to the database and return it
}

    // Implementing getAllLectures method
    public List<Lecture> getAllLectures() {
        return lectureRepository.findAll();
    }
}
