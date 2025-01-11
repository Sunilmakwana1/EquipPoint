package com.equip.point.model;

public class SecurityQuestions {

    private Long id;
    private String question;

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public String getQuestion() {
        return question;
    }

    public void setQuestion(String question) {
        this.question = question;
    }

    public SecurityQuestions(String question) {
        this.question = question;
    }



    public SecurityQuestions() {
    }
}
