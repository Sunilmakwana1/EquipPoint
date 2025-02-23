package com.equip.point.Service;

import com.equip.point.model.SecurityQuestions;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

/**
 * Service class for managing security questions.
 */
public class SecurityQuestionsService {

    private Connection conn;

    /**
     * Constructor to initialize the SecurityQuestionsService with a database connection.
     *
     * @param conn The database connection.
     */
    public SecurityQuestionsService(Connection conn) {
        super();
        this.conn = conn;
    }

    /**
     * Retrieves all security questions from the database.
     *
     * @return List of security questions as strings.
     */
    public List<String> getSecurityQuestions() {
        List<String> questions = new ArrayList<>();
        try {
            String query = "SELECT question FROM security_questions";
            try (PreparedStatement ps = conn.prepareStatement(query)) {
                ResultSet rs = ps.executeQuery();
                while (rs.next()) {
                    questions.add(rs.getString("question"));
                }
            }
        } catch (Exception e) {
            System.out.println("Error in UserService getSecurityQuestions: " + e.getMessage());
        }
        return questions;
    }

    /**
     * Saves the answer to a security question for a user.
     *
     * @param answer The answer to the security question.
     * @param email The email of the user.
     * @param securityQuestions The security question object.
     * @return Boolean indicating if the answer was successfully saved.
     */
    public Boolean saveSecutityQuestionsAnswer(String answer, String email, SecurityQuestions securityQuestions) {
        boolean isAnswerSaved = false;
        try {
            String query = "INSERT INTO security_questions_answer (user_id, question_id, answer, created_date) VALUES ((SELECT id FROM user WHERE email = ? AND is_deleted = false), (SELECT id FROM security_questions WHERE question = ?), ?, now())";
            int i;
            try (PreparedStatement pstmt = conn.prepareStatement(query)) {
                pstmt.setString(1, email);
                pstmt.setString(2, securityQuestions.getQuestion());
                pstmt.setString(3, answer);
                i = pstmt.executeUpdate();
            }
            if (i == 1) {
                isAnswerSaved = true;
            }
        } catch (Exception e) {
            System.out.println("Error in SecurityQuestionsService saveSecutityQuestionsAnswer: " + e.getMessage());
        }
        return isAnswerSaved;
    }
}