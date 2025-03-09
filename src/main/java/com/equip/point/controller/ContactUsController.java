package com.equip.point.controller;

import com.equip.point.Service.ContactUsService;
import com.equip.point.Service.EmailLogService;
import com.equip.point.util.CurrentLoginUser;
import com.equip.point.util.DbConnection;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.sql.Connection;

import static com.equip.point.util.AppConstant.*;
import static com.equip.point.util.URLConstant.*;

@WebServlet(API_CONTACT_US)
public class ContactUsController extends HttpServlet {



    /**
     * Handles HTTP POST requests to process form submissions from the contact us page.
     * This method retrieves user input from the request, saves the data to a database, and 
     * displays a success message with a generated ticket ID upon successful submission.
     *
     * @param req  the HttpServletRequest object that contains the request the client has made to the servlet
     * @param resp the HttpServletResponse object that contains the response the servlet sends to the client
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an input or output error is detected when the servlet handles the request
     */
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        try (Connection conn = DbConnection.getConnection()) {
            conn.setAutoCommit(false); // Start a transaction

            UserInput input = getUserInput(req);
            if (input == null) {
                redirectToErrorPage(req, resp, INVALID_INPUT);
                return;
            }

            ContactUsService contactUsService = new ContactUsService(conn);
            boolean isContactSaved = contactUsService.addContactUs(input.fullName, input.email, input.message);

            if (isContactSaved) {
                handleSuccess(req, resp, conn, contactUsService, input.email);
            } else {
                conn.rollback();
                redirectToErrorPage(req, resp, FAILED_TO_SAVE_MESSAGE);
            }
        } catch (Exception e) {
            System.err.println(ERROR_IN_CONTACT_US_CONTROLLER + e.getMessage());
            redirectToErrorPage(req, resp, UNEXPECTED_ERROR);
        }
    }

    /**
     * Extracts user input from an HttpServletRequest object, validating that all required
     * parameters (fullName, email, and message) are present. If any of these parameters are
     * missing, null is returned. Otherwise, a UserInput object is created and returned.
     *
     * @param req the HttpServletRequest containing the client's request parameters
     * @return a UserInput object containing the fullName, email, and message if all parameters
     *         are present; otherwise, returns null
     */
    private UserInput getUserInput(HttpServletRequest req) {
        String fullName = req.getParameter(NAME);
        String email = req.getParameter(EMAIL);
        String message = req.getParameter(MESSAGE);

        if (fullName == null || email == null || message == null) {
            return null;
        }
        return new UserInput(fullName, email, message);
    }

    /**
     * Handles the successful processing of the "Contact Us" form submission. This method
     * retrieves the contact us ticket ID associated with the given email, commits the database
     * transaction, sets a success message with the generated ticket ID as a request attribute,
     * and forwards the request to the success page.
     *
     * @param req the HttpServletRequest object that contains the request the client has made to the servlet
     * @param resp the HttpServletResponse object that contains the response the servlet sends to the client
     * @param conn the database connection used to commit the transaction
     * @param contactUsService the service used to interact with the "Contact Us" ticket data
     * @param email the email provided by the client used to fetch the ticket ID
     * @throws Exception if any error occurs during the processing of the request or database transaction
     */
    private void handleSuccess(HttpServletRequest req, HttpServletResponse resp, Connection conn, ContactUsService contactUsService, String email)
            throws Exception {
        EmailLogService emailLogService = new EmailLogService(conn);
        Long contactUsId = contactUsService.getContactUsIdByEmail(email);
        conn.commit();
        // Save the email log
        emailLogService.saveEmailLog(CurrentLoginUser.getCurrentLoginUser(), CONTACT_US, CONTACT_US_APPROVED_MESSAGE, SENT, null);
        req.setAttribute(CONTACT_US_SUCCESS, CONTACT_US_SUCCESS_MESSAGE + CONTACT_US_SUCCESS_MESSAGE_TICKET_ID+ contactUsId);
        forwardRequest(req, resp, CONTACT_US_SUCCESS_PAGE);
    }

    /**
     * Redirects the user to an error page with a specific error message.
     * This method sets an error message as a request attribute and forwards the request
     * to a pre-defined error page.
     *
     * @param req          the HttpServletRequest object that contains the request the client has made to the servlet
     * @param resp         the HttpServletResponse object that contains the response the servlet sends to the client
     * @param errorMessage the error message to be displayed on the error page
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException      if an input or output error is detected when the servlet handles the request
     */
    private void redirectToErrorPage(HttpServletRequest req, HttpServletResponse resp, String errorMessage) throws ServletException, IOException {
        EmailLogService emailLogService = new EmailLogService(DbConnection.getConnection());
        // Save the email log with error message
        emailLogService.saveEmailLog(CurrentLoginUser.getCurrentLoginUser(), CONTACT_US, CONTACT_US_SUCCESS_MESSAGE_TICKET_ID_MESSAGE ,SENT, errorMessage);
        req.setAttribute(CONTACT_US_ERROR, errorMessage);
        forwardRequest(req, resp, CONTACT_US_ERROR_PAGE);
    }

    /**
     * Forwards the request to the specified page using the RequestDispatcher.
     *
     * @param req  the HttpServletRequest containing the client's request
     * @param resp the HttpServletResponse containing the response sent to the client
     * @param page the path to the page to which the request should be forwarded
     * @throws ServletException if the request for forwarding fails due to a servlet-related issue
     * @throws IOException if an input or output error occurs while processing the forwarding request
     */
    private void forwardRequest(HttpServletRequest req, HttpServletResponse resp, String page) throws ServletException, IOException {
        req.getRequestDispatcher(page).forward(req, resp);
    }


    private static class UserInput {
        String fullName;
        String email;
        String message;

        UserInput(String fullName, String email, String message) {
            this.fullName = fullName;
            this.email = email;
            this.message = message;
        }
    }
    

    /**
     * Handles HTTP GET requests by responding with a "Method Not Allowed" error.
     * This method explicitly disallows the use of the GET method for this servlet.
     *
     * @param req  the HttpServletRequest object that contains the request the client has made to the servlet
     * @param resp the HttpServletResponse object that contains the response the servlet sends to the client
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an input or output error is detected when the servlet handles the request
     */
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        resp.sendError(HttpServletResponse.SC_METHOD_NOT_ALLOWED, GET_METHOD_NOT_SUPPORTED);
    }
}

