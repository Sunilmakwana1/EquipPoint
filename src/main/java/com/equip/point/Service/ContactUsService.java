package com.equip.point.Service;

import com.equip.point.model.ContactUs;

import java.sql.*;
import java.time.ZoneId;
import java.time.ZonedDateTime;
import java.util.ArrayList;
import java.util.List;

public class ContactUsService {

    private Connection conn;

    public ContactUsService(Connection conn) {
        super();
        this.conn = conn;
    }

    private static final String INSERT_CONTACT_US = "INSERT INTO contact_us(name, email, message, created_date ,is_notify) VALUES(?, ?, ?, now(),true)";

    private static final String GET_ALL_CONTACT_US = "SELECT * FROM contact_us ORDER BY id DESC";

    private static final String GET_CONTACT_US_BY_EMAIL = "SELECT * FROM contact_us WHERE email = ? ORDER BY id DESC";

    private static final String APPROVE_CONTACT_US = "UPDATE contact_us SET approval_status = ?, approved_by = ?, approval_date = now() WHERE id = ?";

    private static final String REPLY_CONTACT_US = "UPDATE contact_us SET reply_message = ?, replied_by = ?, reply_date = now(), replied_status = ? WHERE id = ?";

    private static final String PROGRESS_CONTACT_US = "UPDATE contact_us SET progress_status = ? WHERE id = ?";

    private static final String UN_APPROVE_CONTACT_US = "UPDATE contact_us SET approved_status = ?, approved_by = ?, approved_date = now() WHERE id = ?";

    private static final String GET_CONTACT_US_ID_BY_EMAIL = "SELECT id FROM contact_us WHERE email = ? ORDER BY created_date DESC LIMIT 1;";

    private static final String GET_CONTACT_US_BY_ID = "SELECT * FROM contact_us WHERE id = ?";

    private static final String UPDATE_IS_NOTIFIED_ALL = "UPDATE contact_us SET is_notify = false";

    private static final String COUNT_NEW_CONTACT_US = "SELECT COUNT(id) FROM contact_us WHERE is_notify = true";

    private static final String GET_COUNT_BY_EMAIL = "SELECT COUNT(id) FROM contact_us WHERE email = ?";

    private static final String GET_TOTAL_COUNT = "SELECT COUNT(id) FROM contact_us";


    /**
     * Adds a new Contact Us entry to the database.
     *
     * @param fullName The full name of the person submitting the contact request.
     * @param email    The email address of the person submitting the contact request.
     * @param message  The message content of the contact request.
     * @return A Boolean indicating whether the Contact Us entry was successfully added to the database.
     */
    // Method to add a new Contact Us entry to the database
    public Boolean addContactUs(String fullName, String email, String message) {
        final int FULL_NAME_INDEX = 1;
        final int EMAIL_INDEX = 2;
        final int MESSAGE_INDEX = 3;

        try (java.sql.PreparedStatement preparedStatement = conn.prepareStatement(INSERT_CONTACT_US)) {
            preparedStatement.setString(FULL_NAME_INDEX, fullName);
            preparedStatement.setString(EMAIL_INDEX, email);
            preparedStatement.setString(MESSAGE_INDEX, message);

            int rowsAffected = preparedStatement.executeUpdate();
            return handleUpdateResult(rowsAffected);
        } catch (Exception exception) {
            handleException("Error in ContactUsService addContactUs: ", exception);
            return false;
        }
    }

    /**
     * Helper method to handle the result of an update operation.
     *
     * @param rowsAffected The number of rows affected by the update operation.
     * @return A Boolean indicating whether the update operation was successful.
     *         Returns true if exactly one row was affected, false otherwise.
     */
    // Helper method to handle the result of an update operation
    private Boolean handleUpdateResult(int rowsAffected) {
        if (rowsAffected == 1) {
            System.out.println("Contact Us added successfully");
            return true;
        }
        return false;
    }

    /**
     * Handles exceptions by outputting a message and the exception details to the error stream.
     * This method can be enhanced in the future to include logging with a logging framework.
     *
     * @param message   A descriptive message providing context about the exception.
     * @param exception The exception object containing details of the error that occurred.
     */
    // Helper method for exception handling
    private void handleException(String message, Exception exception) {
        System.err.println(message + exception.getMessage());
        // Consider adding logging framework calls here in the future (e.g., logger.error())
    }

    /**
     * Retrieves all Contact Us entries from the database.
     *
     * The method fetches data for each contact entry, including details such as
     * full name, email, subject, message, approval status, reply details,
     * and creation date, and maps it to a list of ContactUs objects.
     * Any exceptions encountered during the execution are caught and logged.
     *
     * @return A list of ContactUs objects representing all entries in the database.
     *         The list will be empty if no records are found or an error occurs.
     */
    public List<ContactUs> getAllContactUs() {
        List<ContactUs> contactUsList = new ArrayList<>();
        UserService userService = new UserService(conn); // Move outside of the loop for efficiency

        try (PreparedStatement pstmt = conn.prepareStatement(GET_ALL_CONTACT_US);
             ResultSet rs = pstmt.executeQuery()) {

            while (rs.next()) {
                ContactUs contactUs = new ContactUs();
                contactUs.setId(rs.getLong("id"));
                contactUs.setFullName(rs.getString("name"));
                contactUs.setEmail(rs.getString("email"));
                contactUs.setMessage(rs.getString("message"));
                contactUs.setApprovedBy(userService.getUserById(rs.getLong("approved_by")));
                contactUs.setApprovedDate(convertTimestamp(rs.getTimestamp("approval_date")));
                contactUs.setApprovedStatus(rs.getBoolean("approval_status"));
                contactUs.setReplyMessage(rs.getString("replay_message"));
                contactUs.setProgressStatus(rs.getBoolean("progress_status"));
                contactUs.setReplyDate(convertTimestamp(rs.getTimestamp("replay_date")));
                contactUs.setRepliedBy(userService.getUserById(rs.getLong("replay_by")));
                contactUs.setRepliedStatus(rs.getBoolean("replay_status"));
                contactUs.setCreatedDate(convertTimestamp(rs.getTimestamp("created_date")));
                contactUsList.add(contactUs);
            }
        } catch (Exception e) {
            handleException("Error in ContactUsService getAllContactUs", e);
        }

        return contactUsList;
    }

    /**
     * Converts an SQL Timestamp to a formatted date string using the system's default time zone.
     * The date is formatted as "dd/MM/yyyy".
     *
     * @param timestamp The SQL Timestamp to be converted. It can be null.
     * @return A string representing the formatted date if the input Timestamp is not null,
     * or null if the input Timestamp is null.
     */
    // Helper method: Converts SQL Timestamp to ZonedDateTime
    private ZonedDateTime convertTimestamp(Timestamp timestamp) {
        return timestamp != null ? timestamp.toInstant().atZone(ZoneId.systemDefault()) : null;
    }

    /**
     * Retrieves a ContactUs entry from the database based on the provided email address.
     *
     * @param email The email address used to locate the ContactUs entry.
     * @return A ContactUs object containing the details of the contact entry, or an empty ContactUs
     *         object if no match is found.
     */

    public ContactUs getContactUsByEmail(String email) {
        try (PreparedStatement preparedStatement = conn.prepareStatement(GET_CONTACT_US_BY_EMAIL)) {
            preparedStatement.setString(1, email);
            try (ResultSet resultSet = preparedStatement.executeQuery()) {
                if (resultSet.next()) {
                    return mapResultSetToContactUs(resultSet);
                }
            }
        } catch (SQLException e) {
            handleException("Error fetching ContactUs by email: " + email, e);
        }
        return new ContactUs(); // Return empty object if no result found or an error occurred
    }

    /**
     * Maps a ResultSet object to a ContactUs object, populating its fields
     * with the corresponding column values retrieved from the database.
     *
     * @param resultSet The ResultSet object containing data retrieved from the database,
     *                  which represents a single row of the ContactUs table.
     * @return A ContactUs object populated with the data from the ResultSet.
     * @throws SQLException If an SQL exception occurs while accessing the ResultSet.
     */
    private ContactUs mapResultSetToContactUs(ResultSet resultSet) throws SQLException {
        ContactUs contactUs = new ContactUs();
        contactUs.setId(resultSet.getLong(ColumnConstants.ID));
        contactUs.setFullName(resultSet.getString(ColumnConstants.NAME));
        contactUs.setEmail(resultSet.getString(ColumnConstants.EMAIL));
        contactUs.setMessage(resultSet.getString(ColumnConstants.MESSAGE));
        UserService userService = new UserService(conn);
        contactUs.setApprovedBy(userService.getUserById(resultSet.getLong(ColumnConstants.APPROVED_BY)));
        contactUs.setApprovedDate(convertTimestampToZonedDateTime(resultSet.getTimestamp(ColumnConstants.APPROVED_DATE)));
        contactUs.setApprovedStatus(resultSet.getBoolean(ColumnConstants.APPROVED_STATUS));
        contactUs.setReplyMessage(resultSet.getString(ColumnConstants.REPLY_MESSAGE));
        contactUs.setProgressStatus(resultSet.getBoolean(ColumnConstants.PROGRESS_STATUS));
        contactUs.setReplyDate(convertTimestampToZonedDateTime(resultSet.getTimestamp(ColumnConstants.REPLY_DATE)));
        contactUs.setRepliedBy(userService.getUserById(resultSet.getLong(ColumnConstants.REPLIED_BY)));
        contactUs.setRepliedStatus(resultSet.getBoolean(ColumnConstants.REPLIED_STATUS));
        contactUs.setCreatedDate(convertTimestampToZonedDateTime(resultSet.getTimestamp(ColumnConstants.CREATED_DATE)));
        return contactUs;
    }

    /**
     * Converts a SQL Timestamp object to a ZonedDateTime object using the system's default time zone.
     *
     * @param timestamp The SQL Timestamp to be converted. It can be null.
     * @return A ZonedDateTime object representing the same point in time as the provided Timestamp,
     *         or null if the input Timestamp is null.
     */
    private ZonedDateTime convertTimestampToZonedDateTime(Timestamp timestamp) {
        return timestamp != null
                ? timestamp.toInstant().atZone(ZoneId.systemDefault())
                : null;
    }

    /**
     * Retrieves a ContactUs entry from the database based on the provided ID.
     *
     * @param i The ID of the ContactUs entry to be retrieved.
     * @return A ContactUs object containing the details of the corresponding database entry,
     *         or an empty ContactUs object if no match is found or an error occurs during the retrieval process.
     */
    public ContactUs getContactUsById(int i) {
        try (PreparedStatement preparedStatement = conn.prepareStatement(GET_CONTACT_US_BY_ID)) {
            preparedStatement.setInt(1, i);
            try (ResultSet resultSet = preparedStatement.executeQuery()) {
                if (resultSet.next()) {
                    return mapResultSetToContactUs(resultSet);
                }
            }
        } catch (SQLException e) {
            handleException("Error fetching ContactUs by ID: " + i, e);
        }
        return new ContactUs(); // Return empty object if no result found or an error occurred
    }

    // Constants for column names
    private static class ColumnConstants {
        static final String ID = "id";
        static final String NAME = "name";
        static final String EMAIL = "email";
        static final String MESSAGE = "message";
        static final String APPROVED_BY = "approved_by";
        static final String APPROVED_DATE = "approval_date";
        static final String APPROVED_STATUS = "approval_status";
        static final String REPLY_MESSAGE = "replay_message";
        static final String PROGRESS_STATUS = "progress_status";
        static final String REPLY_DATE = "replay_date";
        static final String REPLIED_BY = "replay_by";
        static final String REPLIED_STATUS = "replay_status";
        static final String CREATED_DATE = "created_date";
    }

    /**
     * Approves a ContactUs entry in the database.
     *
     * @param id The id of the ContactUs entry to be approved.
     * @param approvedStatus The approval status to be set for the ContactUs entry.
     * @param approvedBy The user who approved the ContactUs entry.
     * @return A Boolean indicating whether the ContactUs entry was successfully approved.
     */
    /**
     * Approves a ContactUs entry in the database.
     *
     * @param id The ID of the ContactUs entry to be approved.
     * @param approvalStatus The approval status to be set for the ContactUs entry.
     * @param approvedBy The user ID who approved the ContactUs entry.
     * @return True if the ContactUs entry was successfully approved; otherwise, false.
     */
    public Boolean approveContactUs(Long id, Boolean approvalStatus, Long approvedBy) {
        final String SQL_APPROVE_CONTACT_US = APPROVE_CONTACT_US;

        try (PreparedStatement pstmt = conn.prepareStatement(SQL_APPROVE_CONTACT_US)) {
            pstmt.setBoolean(1, approvalStatus);
            pstmt.setLong(2, approvedBy);
            pstmt.setLong(3, id);

            int rowsAffected = pstmt.executeUpdate();
            return handleUpdateResult(rowsAffected);
        } catch (Exception e) {
            handleException("Error approving ContactUs entry", e);
            return false;
        }
    }

    /**
     * Replies to a ContactUs entry in the database.
     *
     * @param id The id of the ContactUs entry to be replied to.
     * @param replyMessage The reply message to be set for the ContactUs entry.
     * @param repliedBy The user who replied to the ContactUs entry.
     * @param repliedStatus The reply status to be set for the ContactUs entry.
     * @return A Boolean indicating whether the ContactUs entry was successfully replied to.
     */
    public Boolean replyContactUs(Long id, String replyMessage, Long repliedBy, Boolean repliedStatus) {
        try (java.sql.PreparedStatement pstmt = conn.prepareStatement(REPLY_CONTACT_US)) {
            setReplyParameters(pstmt, replyMessage, repliedBy, repliedStatus, id);
            int rowsAffected = pstmt.executeUpdate();
            return handleUpdateResult(rowsAffected);
        } catch (Exception e) {
            handleException("Error in ContactUsService replyContactUs", e);
            return false;
        }
    }

    /**
     * Populates the parameters of a prepared statement for replying to a ContactUs entry.
     *
     * @param pstmt The prepared statement to populate.
     * @param replyMessage The reply message to set in the ContactUs entry.
     * @param repliedBy The ID of the user who is replying.
     * @param repliedStatus The status indicating whether the reply has been made.
     * @param id The ID of the ContactUs entry being replied to.
     * @throws SQLException If any SQL error occurs while setting the parameters.
     */
    private void setReplyParameters(PreparedStatement pstmt, String replyMessage, Long repliedBy, Boolean repliedStatus, Long id) throws SQLException {
        pstmt.setString(1, replyMessage);
        pstmt.setLong(2, repliedBy);
        pstmt.setBoolean(3, repliedStatus);
        pstmt.setLong(4, id);
    }

    /**
     * Updates the progress status of a ContactUs entry in the database.
     *
     * @param id The id of the ContactUs entry to be updated.
     * @param progressStatus The progress status to be set for the ContactUs entry.
     * @return A Boolean indicating whether the ContactUs entry was successfully updated.
     */
    public Boolean progressContactUs(Long id, Boolean progressStatus) {
        boolean updateSuccessful = false;
        try (PreparedStatement pstmt = conn.prepareStatement(PROGRESS_CONTACT_US)) {
            pstmt.setBoolean(1, progressStatus);
            pstmt.setLong(2, id);
            int rowsAffected = pstmt.executeUpdate();
            updateSuccessful = handleUpdateResult(rowsAffected);
        } catch (Exception e) {
            handleException("Error in ContactUsService progressContactUs", e);
        }
        return updateSuccessful;
    }

    /**
     * Unapproves a ContactUs entry in the database.
     *
     * @param id The id of the ContactUs entry to be unapproved.
     * @param approvedStatus The approval status to be set for the ContactUs entry.
     * @param approvedBy The user who unapproved the ContactUs entry.
     * @return A Boolean indicating whether the ContactUs entry was successfully unapproved.
     */
    /**
     * Unapproves a ContactUs entry in the database.
     *
     * @param id The ID of the ContactUs entry to be unapproved.
     * @param approvedStatus The approval status to be set for the ContactUs entry.
     * @param approvedBy The ID of the user who unapproved the ContactUs entry.
     * @return True if the ContactUs entry was successfully unapproved; otherwise false.
     */
    public Boolean unApproveContactUs(Long id, Boolean approvedStatus, Long approvedBy) {
        try (java.sql.PreparedStatement pstmt = conn.prepareStatement(UN_APPROVE_CONTACT_US)) {
            setUnApproveParameters(pstmt, approvedStatus, approvedBy, id);
            int rowsAffected = pstmt.executeUpdate();
            System.out.println("Contact Us unapproved successfully");
            return handleUpdateResult(rowsAffected);
        } catch (Exception e) {
            handleException("Error in ContactUsService unApproveContactUs", e);
            return false;
        }
    }

    /**
     * Populates the parameters of the prepared statement for the unapproval operation.
     *
     * @param pstmt The prepared statement to populate.
     * @param approvedStatus The approval status to set.
     * @param approvedBy The ID of the user making the update.
     * @param id The ID of the ContactUs entry.
     * @throws SQLException if an SQL exception occurs.
     */
    private void setUnApproveParameters(java.sql.PreparedStatement pstmt, Boolean approvedStatus, Long approvedBy, Long id) throws SQLException {
        pstmt.setBoolean(1, approvedStatus);
        pstmt.setLong(2, approvedBy);
        pstmt.setLong(3, id);
    }


    /**
     * Retrieves the ID of the ContactUs entry associated with the given email address.
     *
     * @param email The email address used to locate the ContactUs entry.
     * @return The ID of the ContactUs entry as a Long, or null if no entry is found or an error occurs.
     */
    private static final String COLUMN_ID = "id";

    public Long getContactUsIdByEmail(String email) {
        Long contactUsEntryId = null;
        try (java.sql.PreparedStatement pstmt = conn.prepareStatement(GET_CONTACT_US_ID_BY_EMAIL)) {
            pstmt.setString(1, email);
            try (java.sql.ResultSet rs = pstmt.executeQuery()) {
                if (rs.next()) { // Use `if` instead of `while` since only one result is expected
                    contactUsEntryId = rs.getLong(COLUMN_ID);
                }
            }
        } catch (Exception e) {
            handleException("Error fetching ContactUs ID by email", e);
        }
        return contactUsEntryId;
    }


    /**
     * Updates the is_notify status of all ContactUs entries in the database to false.
     *
     * @return A Boolean indicating whether the is_notify status of all ContactUs entries was successfully updated.
     */
    public Boolean updateIsNotifiedAll() {
        try (PreparedStatement pstmt = conn.prepareStatement(UPDATE_IS_NOTIFIED_ALL)) {
            int rowsAffected = pstmt.executeUpdate();
            return handleUpdateResult(rowsAffected);
        } catch (Exception e) {
            handleException("Error in ContactUsService updateIsNotifiedAll", e);
            return false;
        }
    }

    /**
     * Retrieves the count of new ContactUs entries that have not been notified.
     *
     * @return The count of new ContactUs entries that have not been notified.
     */
    public int countNewContactUs() {
        int newContactUsCount = 0;
        try (PreparedStatement pstmt = conn.prepareStatement(COUNT_NEW_CONTACT_US);
             ResultSet rs = pstmt.executeQuery()) {
            if (rs.next()) {
                newContactUsCount = rs.getInt(1);
            }
        } catch (Exception e) {
            handleException("Error in ContactUsService countNewContactUs", e);
        }
        return newContactUsCount;
    }

    /**
     * Retrieves the count of ContactUs entries with the specified email address.
     *
     * @param email The email address used to locate the ContactUs entries.
     * @return The count of ContactUs entries with the specified email address.
     */
    public int getCountByEmail(String email) {
        int count = 0;
        try (PreparedStatement pstmt = conn.prepareStatement(GET_COUNT_BY_EMAIL)) {
            pstmt.setString(1, email);
            try (ResultSet rs = pstmt.executeQuery()) {
                if (rs.next()) {
                    count = rs.getInt(1);
                }
            }
        } catch (Exception e) {
            handleException("Error in ContactUsService getCountByEmail", e);
        }
        return count;
    }

    /**
     * Retrieves the total count of ContactUs entries in the database.
     *
     * @return The total count of ContactUs entries in the database.
     */
    public int getTotalCount() {
        int totalCount = 0;
        try (PreparedStatement pstmt = conn.prepareStatement(GET_TOTAL_COUNT);
             ResultSet rs = pstmt.executeQuery()) {
            if (rs.next()) {
                totalCount = rs.getInt(1);
            }
        } catch (Exception e) {
            handleException("Error in ContactUsService getTotalCount", e);
        }
        return totalCount;
    }
}
