/*
 Date : 2021-07-07
 Name : Vishal Makwana
 Purpose : Create Database schema for EquipPoint and Create User Table
           Role Table also created for user role
           Inserted data in Role Table
 */

CREATE SCHEMA `equip_point`;

USE equip_point;

CREATE TABLE `user`
(
    `id`           BIGINT       NOT NULL AUTO_INCREMENT,
    `full_name`    VARCHAR(255) NOT NULL,
    `email`        VARCHAR(255) NOT NULL,
    `password`     VARCHAR(255) NOT NULL,
    `role`         BIGINT       NOT NULL,
    `status`       BIT          NOT NULL,
    `address`      TEXT         NULL,
    `phone`        VARCHAR(22)  NULL,
    `country`      VARCHAR(100) NULL,
    `city`         VARCHAR(100) NULL,
    `postal_code`  VARCHAR(10)  NULL,
    `is_deleted`   BIT          NULL,
    `created_date` TIMESTAMP    NOT NULL,
    `updated_date` TIMESTAMP    NULL
        PRIMARY KEY (`id`)
);


CREATE TABLE `role`
(
    `id`   BIGINT      NOT NULL AUTO_INCREMENT,
    `name` VARCHAR(50) NULL,
    PRIMARY KEY (`id`)
);



INSERT INTO `role` (`name`)
VALUES ('Admin');
INSERT INTO `role` (`name`)
VALUES ('User');

/*
 Date : 2024-12-22
    Name : Vishal Makwana
    Purpose : Create table for Equipment Category and Equipment
             Also added foreign key in USER table for role
 */

USE equip_point;

CREATE TABLE `equipment_categories`
(
    `id`           INT          NOT NULL AUTO_INCREMENT,
    `name`         VARCHAR(255) NULL,
    `description`  VARCHAR(255) NULL,
    `image`        VARCHAR(255) NULL,
    `is_deleted`   BIT          NULL,
    `created_date` TIMESTAMP    NULL,
    `updated_date` TIMESTAMP    NULL,
    PRIMARY KEY (`id`)
);


ALTER TABLE `user`
    ADD INDEX `user_id_role_id_fk_idx` (`role` ASC) VISIBLE;
;
ALTER TABLE `user`
    ADD CONSTRAINT `user_id_role_id_fk`
        FOREIGN KEY (`role`)
            REFERENCES `role` (`id`)
            ON DELETE NO ACTION
            ON UPDATE NO ACTION;

ALTER TABLE `user`
    DROP
        FOREIGN KEY `user_id_role_id_fk`;
ALTER TABLE `user`
    CHANGE COLUMN `role` `role_id` BIGINT NOT NULL;
ALTER TABLE `user`
    ADD CONSTRAINT `user_id_role_id_fk`
        FOREIGN KEY (`role_id`)
            REFERENCES `role` (`id`);


/*
 Date : 2024-12-27
    Name : Vishal Makwana
    Purpose : Added otp column in user table 
 */
ALTER TABLE `equip_point`.`user`
    ADD COLUMN `otp`              VARCHAR(255) NULL AFTER `updated_date`,
    ADD COLUMN `otp_created_date` TIMESTAMP    NULL AFTER `otp`;


/*
 Date : 05-01-2025
    Name : Vishal Makwana
    Purpose : Added scqurity question and answer
 */

CREATE TABLE security_questions
(
    id       INT AUTO_INCREMENT PRIMARY KEY,
    question VARCHAR(255) NOT NULL
);

INSERT INTO security_questions (question)
VALUES ('What is your mother\'s maiden name?'),
       ('What is the name of your first pet?'),
       ('What is the name of the city where you were born?');

INSERT INTO security_questions (question)
VALUES ('What was the name of your elementary school?'),
       ('What is the name of your favorite childhood friend?'),
       ('What is the name of the street you grew up on?'),
       ('What was your first car?'),
       ('In what city did you meet your spouse/partner?'),
       ('What is the name of your favorite book?'),
       ('What is the name of the company of your first job?'),
       ('What was the name of your first teacher?'),
       ('What is your favorite food?'),
       ('What is the name of your favorite pet?'),
       ('What was your childhood nickname?'),
       ('What was the name of your first boss?'),
       ('What is the name of the hospital where you were born?'),
       ('What is your father’s middle name?'),
       ('What was the name of your first concert?'),
       ('What is your favorite sports team?');

/*'
    `security_questions_answer` table created for security question and answer
     name : Vishal Makwana
        Date : 2025-01-05
*/
CREATE TABLE `equip_point`.`security_questions_answer`
(
    `id`           BIGINT    NOT NULL AUTO_INCREMENT,
    `question_id`  BIGINT    NOT NULL,
    `user_id`      BIGINT    NOT NULL,
    `created_date` TIMESTAMP NULL,
    PRIMARY KEY (`id`),
    INDEX `fk_user_id_idx` (`user_id` ASC) VISIBLE,
    CONSTRAINT `fk_user_id`
        FOREIGN KEY (`user_id`)
            REFERENCES `equip_point`.`user` (`id`)
            ON DELETE NO ACTION
            ON UPDATE NO ACTION,
    CONSTRAINT `fk_question_id`
        FOREIGN KEY (`question_id`)
            REFERENCES `equip_point`.`security_questions` (`id`)
            ON DELETE NO ACTION
            ON UPDATE NO ACTION
);

SHOW CREATE TABLE equip_point.security_questions_answer;

ALTER TABLE `equip_point`.`security_questions_answer`
    ADD COLUMN `answer` VARCHAR(255) NOT NULL AFTER `user_id`;


ALTER TABLE `equip_point`.`security_questions_answer`
    DROP FOREIGN KEY `fk_question_id`,
    DROP FOREIGN KEY `fk_user_id`;
ALTER TABLE `equip_point`.`security_questions_answer`
    ADD CONSTRAINT `fk_question_id`
        FOREIGN KEY (`question_id`)
            REFERENCES `equip_point`.`security_questions` (`id`)
            ON DELETE CASCADE,
    ADD CONSTRAINT `fk_user_id`
        FOREIGN KEY (`user_id`)
            REFERENCES `equip_point`.`user` (`id`)
            ON DELETE CASCADE;


/*
 Date : 2025-01-11
    Name : Vishal Makwana
    Purpose : Insert the user admin data
 */
INSERT INTO `user` (`full_name`, `email`, `password`, `role_id`, `status`, `address`, `phone`, `country`, `city`,
                    `postal_code`, `is_deleted`, `created_date`)
VALUES ('Admin', 'admin@equipoint.com', 'Admin', (select id from role where name = "admin"), true, 'USA', '123456789',
        'USA', 'USA', '123456', false, now());


/**
    * Date : 2025-01-11
    * Name : Vishal Makwana
    * Purpose : add type column in categories table
    */

ALTER TABLE `equipment_categories`
    ADD COLUMN `type` VARCHAR(255) NULL AFTER `updated_date`,
    CHANGE COLUMN `description` `description` TEXT NULL DEFAULT NULL,
    CHANGE COLUMN `image` `image` TEXT NULL DEFAULT NULL, RENAME TO `equip_point`.`categories`;

/**
  Date : 2025-02-08
    Name : Vishal Makwana
  purpose : add new contact us table
 */
CREATE TABLE `contact_us`
(
    `id`           BIGINT       NOT NULL AUTO_INCREMENT,
    `name`         VARCHAR(255) NOT NULL,
    `email`        VARCHAR(255) NOT NULL,
    `phone`        VARCHAR(22)  NULL,
    `message`      TEXT         NULL,
    `created_date` TIMESTAMP    NOT NULL,
    PRIMARY KEY (`id`)
);

/**
  Date : 2025-02-08
    Name : Vishal Makwana
  purpose : add APPROVAL_STATUS , APPROVAL_DATE , APPROVED_BY , REPLAY_MESSAGE , PROGRESS_STATUS , REPLAY_DATE , REPLAY_BY , REPLAY_STATUS in contact us table
 */
ALTER TABLE `contact_us`
    ADD COLUMN `approval_status` BOOLEAN DEFAULT false AFTER `message`,
    ADD COLUMN `approval_date`   TIMESTAMP NULL AFTER `approval_status`,
    ADD COLUMN `approved_by`     BIGINT    NULL AFTER `approval_date`,
    ADD COLUMN `replay_message`  TEXT      NULL AFTER `approved_by`,
    ADD COLUMN `progress_status` BOOLEAN default false AFTER `replay_message`,
    ADD COLUMN `replay_date`     TIMESTAMP NULL AFTER `progress_status`,
    ADD COLUMN `replay_by`       BIGINT    NULL AFTER `replay_date`,
    ADD COLUMN `replay_status`   BOOLEAN default false AFTER `replay_by`;

/**
  Date : 2025-02-08
    Name : Vishal Makwana
  purpose : replay_by , approved_by , FOREIGN KEY added TO USER TABLE in contact us table

 */
ALTER TABLE `contact_us`
    ADD INDEX `contact_us_replay_by_fk_idx` (`replay_by` ASC) VISIBLE,
    ADD INDEX `contact_us_approved_by_fk_idx` (`approved_by` ASC) VISIBLE;
ALTER TABLE `contact_us`
    ADD CONSTRAINT `contact_us_replay_by_fk`
        FOREIGN KEY (`replay_by`)
            REFERENCES `user` (`id`)
            ON DELETE NO ACTION
            ON UPDATE NO ACTION,
    ADD CONSTRAINT `contact_us_approved_by_fk`
        FOREIGN KEY (`approved_by`)
            REFERENCES `user` (`id`)
            ON DELETE NO ACTION
            ON UPDATE NO ACTION;

/**
  Date : 2025-02-08
    Name : Vishal Makwana
  purpose : add new column is_notify in contact us table
*/
ALTER TABLE `contact_us`
    ADD COLUMN `is_notify` BOOLEAN DEFAULT false AFTER `replay_status`;


/*
 * Table: email_log
 * Purpose: To store logs of emails sent by the system, including their status and any error messages.
 * Columns:
 * - id: Primary key, auto-incremented integer.
 * - recipient_email: The email address of the recipient.
 * - subject: The subject of the email.
 * - message: The content of the email.
 * - status: The status of the email (sent, failed, pending).
 * - error_message: Any error message if the email failed to send.
 * - created_at: Timestamp of when the log entry was created, defaults to the current timestamp.
 */
CREATE TABLE email_log (
                           id INT AUTO_INCREMENT PRIMARY KEY,
                           recipient_email VARCHAR(255) NOT NULL,
                           subject VARCHAR(255) NOT NULL,
                           message TEXT NOT NULL,
                           status ENUM('sent', 'failed', 'pending') DEFAULT 'pending',
                           error_message TEXT NULL,
                           created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);



CREATE TABLE history (
                         id INT AUTO_INCREMENT PRIMARY KEY,
                         table_name VARCHAR(100), -- Table affected
                         record_id INT, -- Affected record ID
                         action VARCHAR(50) NOT NULL, -- e.g., 'INSERT', 'UPDATE', 'DELETE'
                         old_data TEXT, -- Stores previous data (for UPDATE, DELETE)
                         new_data TEXT, -- Stores new data (for INSERT, UPDATE)
                         status ENUM('success', 'failed') DEFAULT 'success',
                         performed_by VARCHAR(100) NOT NULL, -- Username or email of user
                         performed_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);


/**
    * Date : 2025-02-08
    * Name : Vishal Makwana
    * Purpose : add history TRIGGER for All tables
 */

USE equip_point;
DELIMITER //
DROP TRIGGER IF EXISTS categories_history_after_insert;
CREATE TRIGGER categories_history_after_insert
    AFTER INSERT ON categories
    FOR EACH ROW
BEGIN
    INSERT INTO history (table_name, record_id, action, new_data, performed_by)
    VALUES ('categories', NEW.id, 'INSERT', CONCAT('{"name": "', NEW.name, '", "description": "', NEW.description, '", "image": "', NEW.image, '", "is_deleted": ', NEW.is_deleted, ', "created_date": "', NEW.created_date, '", "updated_date": "', NEW.updated_date, '", "type": "', NEW.type, '"}'), @current_user);
END//

DROP TRIGGER IF EXISTS categories_history_after_update;
CREATE TRIGGER categories_history_after_update
    AFTER UPDATE ON categories
    FOR EACH ROW
BEGIN
    INSERT INTO history (table_name, record_id, action, old_data, new_data, performed_by)
    VALUES ('categories', OLD.id, 'UPDATE', CONCAT('{"name": "', OLD.name, '", "description": "', OLD.description, '", "image": "', OLD.image, '", "is_deleted": ', OLD.is_deleted, ', "created_date": "', OLD.created_date, '", "updated_date": "', OLD.updated_date, '", "type": "', OLD.type, '"}'),
            CONCAT('{"name": "', NEW.name, '", "description": "', NEW.description, '", "image": "', NEW.image, '", "is_deleted": ', NEW.is_deleted, ', "created_date": "', NEW.created_date, '", "updated_date": "', NEW.updated_date, '", "type": "', NEW.type, '"}'), @current_user);
END//

DROP TRIGGER IF EXISTS categories_history_after_delete;
CREATE TRIGGER categories_history_after_delete
    AFTER DELETE ON categories
    FOR EACH ROW
BEGIN
    INSERT INTO history (table_name, record_id, action, old_data, performed_by)
    VALUES ('categories', OLD.id, 'DELETE', CONCAT('{"name": "', OLD.name, '", "description": "', OLD.description, '", "image": "', OLD.image, '", "is_deleted": ', OLD.is_deleted, ', "created_date": "', OLD.created_date, '", "updated_date": "', OLD.updated_date, '", "type": "', OLD.type, '"}'), @current_user);
END//

DELIMITER ;
DELIMITER //

DROP TRIGGER IF EXISTS contact_us_history_after_insert;
CREATE TRIGGER contact_us_history_after_insert
    AFTER INSERT ON contact_us
    FOR EACH ROW
BEGIN
    INSERT INTO history (table_name, record_id, action, new_data, performed_by)
    VALUES ('contact_us', NEW.id, 'INSERT', CONCAT('{"name": "', NEW.name, '", "email": "', NEW.email, '", "phone": "', NEW.phone, '", "message": "', NEW.message, '", "approval_status": ', NEW.approval_status, ', "approval_date": "', NEW.approval_date, '", "approved_by": ', NEW.approved_by, ', "replay_message": "', NEW.replay_message, '", "progress_status": ', NEW.progress_status, ', "replay_date": "', NEW.replay_date, '", "replay_by": ', NEW.replay_by, ', "replay_status": ', NEW.replay_status, ', "is_notify": ', NEW.is_notify, ', "created_date": "', NEW.created_date, '"}'), @current_user);
END//


DROP TRIGGER IF EXISTS contact_us_history_after_update;
CREATE TRIGGER contact_us_history_after_update
    AFTER UPDATE ON contact_us
    FOR EACH ROW
BEGIN
    INSERT INTO history (table_name, record_id, action, old_data, new_data, performed_by)
    VALUES ('contact_us', OLD.id, 'UPDATE', CONCAT('{"name": "', OLD.name, '", "email": "', OLD.email, '", "phone": "', OLD.phone, '", "message": "', OLD.message, '", "approval_status": ', OLD.approval_status, ', "approval_date": "', OLD.approval_date, '", "approved_by": ', OLD.approved_by, ', "replay_message": "', OLD.replay_message, '", "progress_status": ', OLD.progress_status, ', "replay_date": "', OLD.replay_date, '", "replay_by": ', OLD.replay_by, ', "replay_status": ', OLD.replay_status, ', "is_notify": ', OLD.is_notify, ', "created_date": "', OLD.created_date, '"}'),
            CONCAT('{"name": "', NEW.name, '", "email": "', NEW.email, '", "phone": "', NEW.phone, '", "message": "', NEW.message, '", "approval_status": ', NEW.approval_status, ', "approval_date": "', NEW.approval_date, '", "approved_by": ', NEW.approved_by, ', "replay_message": "', NEW.replay_message, '", "progress_status": ', NEW.progress_status, ', "replay_date": "', NEW.replay_date, '", "replay_by": ', NEW.replay_by, ', "replay_status": ', NEW.replay_status, ', "is_notify": ', NEW.is_notify, ', "created_date": "', NEW.created_date, '"}'), @current_user);
END//

DROP TRIGGER IF EXISTS contact_us_history_after_delete;
CREATE TRIGGER contact_us_history_after_delete
    AFTER DELETE ON contact_us
    FOR EACH ROW
BEGIN
    INSERT INTO history (table_name, record_id, action, old_data, performed_by)
    VALUES ('contact_us', OLD.id, 'DELETE', CONCAT('{"name": "', OLD.name, '", "email": "', OLD.email, '", "phone": "', OLD.phone, '", "message": "', OLD.message, '", "approval_status": ', OLD.approval_status, ', "approval_date": "', OLD.approval_date, '", "approved_by": ', OLD.approved_by, ', "replay_message": "', OLD.replay_message, '", "progress_status": ', OLD.progress_status, ', "replay_date": "', OLD.replay_date, '", "replay_by": ', OLD.replay_by, ', "replay_status": ', OLD.replay_status, ', "is_notify": ', OLD.is_notify, ', "created_date": "', OLD.created_date, '"}'), @current_user);
END//

DELIMITER ;
DELIMITER //

DROP TRIGGER IF EXISTS email_log_history_after_insert;
CREATE TRIGGER email_log_history_after_insert
    AFTER INSERT ON email_log
    FOR EACH ROW
BEGIN
    INSERT INTO history (table_name, record_id, action, new_data, performed_by)
    VALUES ('email_log', NEW.id, 'INSERT', CONCAT('{"recipient_email": "', NEW.recipient_email, '", "subject": "', NEW.subject, '", "message": "', NEW.message, '", "status": "', NEW.status, '", "error_message": "', NEW.error_message, '", "created_at": "', NEW.created_at, '"}'), @current_user);
END//

DROP TRIGGER IF EXISTS email_log_history_after_update;
CREATE TRIGGER email_log_history_after_update
    AFTER UPDATE ON email_log
    FOR EACH ROW
BEGIN
    INSERT INTO history (table_name, record_id, action, old_data, new_data, performed_by)
    VALUES ('email_log', OLD.id, 'UPDATE', CONCAT('{"recipient_email": "', OLD.recipient_email, '", "subject": "', OLD.subject, '", "message": "', OLD.message, '", "status": "', OLD.status, '", "error_message": "', OLD.error_message, '", "created_at": "', OLD.created_at, '"}'),
            CONCAT('{"recipient_email": "', NEW.recipient_email, '", "subject": "', NEW.subject, '", "message": "', NEW.message, '", "status": "', NEW.status, '", "error_message": "', NEW.error_message, '", "created_at": "', NEW.created_at, '"}'), @current_user);
END//

DROP TRIGGER IF EXISTS email_log_history_after_delete;
CREATE TRIGGER email_log_history_after_delete
    AFTER DELETE ON email_log
    FOR EACH ROW
BEGIN
    INSERT INTO history (table_name, record_id, action, old_data, performed_by)
    VALUES ('email_log', OLD.id, 'DELETE', CONCAT('{"recipient_email": "', OLD.recipient_email, '", "subject": "', OLD.subject, '", "message": "', OLD.message, '", "status": "', OLD.status, '", "error_message": "', OLD.error_message, '", "created_at": "', OLD.created_at, '"}'), @current_user);
END//

DELIMITER ;
DELIMITER //

DROP TRIGGER IF EXISTS role_history_after_insert;
CREATE TRIGGER role_history_after_insert
    AFTER INSERT ON role
    FOR EACH ROW
BEGIN
    INSERT INTO history (table_name, record_id, action, new_data, performed_by)
    VALUES ('role', NEW.id, 'INSERT', CONCAT('{"name": "', NEW.name, '"}'), @current_user);
END//

DROP TRIGGER IF EXISTS role_history_after_update;
CREATE TRIGGER role_history_after_update
    AFTER UPDATE ON role
    FOR EACH ROW
BEGIN
    INSERT INTO history (table_name, record_id, action, old_data, new_data, performed_by)
    VALUES ('role', OLD.id, 'UPDATE', CONCAT('{"name": "', OLD.name, '"}'),
            CONCAT('{"name": "', NEW.name, '"}'), @current_user);
END//

DROP TRIGGER IF EXISTS role_history_after_delete;
CREATE TRIGGER role_history_after_delete
    AFTER DELETE ON role
    FOR EACH ROW
BEGIN
    INSERT INTO history (table_name, record_id, action, old_data, performed_by)
    VALUES ('role', OLD.id, 'DELETE', CONCAT('{"name": "', OLD.name, '"}'), @current_user);
END//

DELIMITER ;
DELIMITER //

DROP TRIGGER IF EXISTS security_questions_history_after_insert;
CREATE TRIGGER security_questions_history_after_insert
    AFTER INSERT ON security_questions
    FOR EACH ROW
BEGIN
    INSERT INTO history (table_name, record_id, action, new_data, performed_by)
    VALUES ('security_questions', NEW.id, 'INSERT', CONCAT('{"question": "', NEW.question, '"}'), @current_user);
END//

DROP TRIGGER IF EXISTS security_questions_history_after_update;
CREATE TRIGGER security_questions_history_after_update
    AFTER UPDATE ON security_questions
    FOR EACH ROW
BEGIN
    INSERT INTO history (table_name, record_id, action, old_data, new_data, performed_by)
    VALUES ('security_questions', OLD.id, 'UPDATE', CONCAT('{"question": "', OLD.question, '"}'),
            CONCAT('{"question": "', NEW.question, '"}'), @current_user);
END//

DROP TRIGGER IF EXISTS security_questions_history_after_delete;
CREATE TRIGGER security_questions_history_after_delete
    AFTER DELETE ON security_questions
    FOR EACH ROW
BEGIN
    INSERT INTO history (table_name, record_id, action, old_data, performed_by)
    VALUES ('security_questions', OLD.id, 'DELETE', CONCAT('{"question": "', OLD.question, '"}'), @current_user);
END//

DELIMITER ;
DELIMITER //

DROP TRIGGER IF EXISTS security_questions_answer_history_after_insert;
CREATE TRIGGER security_questions_answer_history_after_insert
    AFTER INSERT ON security_questions_answer
    FOR EACH ROW
BEGIN
    INSERT INTO history (table_name, record_id, action, new_data, performed_by)
    VALUES ('security_questions_answer', NEW.id, 'INSERT', CONCAT('{"question_id": ', NEW.question_id, ', "user_id": ', NEW.user_id, ', "answer": "', NEW.answer, '", "created_date": "', NEW.created_date, '"}'), @current_user);
END//

DROP TRIGGER IF EXISTS security_questions_answer_history_after_update;
CREATE TRIGGER security_questions_answer_history_after_update
    AFTER UPDATE ON security_questions_answer
    FOR EACH ROW
BEGIN
    INSERT INTO history (table_name, record_id, action, old_data, new_data, performed_by)
    VALUES ('security_questions_answer', OLD.id, 'UPDATE',
            CONCAT('{"question_id": ', OLD.question_id, ', "user_id": ', OLD.user_id, ', "answer": "', OLD.answer, '", "created_date": "', OLD.created_date, '"}'),
            CONCAT('{"question_id": ', NEW.question_id, ', "user_id": ', NEW.user_id, ', "answer": "', NEW.answer, '", "created_date": "', NEW.created_date, '"}'), @current_user);
END//

DROP TRIGGER IF EXISTS security_questions_answer_history_after_delete;
CREATE TRIGGER security_questions_answer_history_after_delete
    AFTER DELETE ON security_questions_answer
    FOR EACH ROW
BEGIN
    INSERT INTO history (table_name, record_id, action, old_data, performed_by)
    VALUES ('security_questions_answer', OLD.id, 'DELETE',
            CONCAT('{"question_id": ', OLD.question_id, ', "user_id": ', OLD.user_id, ', "answer": "', OLD.answer, '", "created_date": "', OLD.created_date, '"}'), @current_user);
END//

DELIMITER ;
DELIMITER //

DROP TRIGGER IF EXISTS  user_history_after_insert;
CREATE TRIGGER user_history_after_insert
    AFTER INSERT ON user
    FOR EACH ROW
BEGIN
    INSERT INTO history (table_name, record_id, action, new_data, performed_by)
    VALUES ('user', NEW.id, 'INSERT', CONCAT('{"full_name": "', NEW.full_name, '", "email": "', NEW.email, '", "role_id": ', NEW.role_id, ', "status": ', NEW.status, ', "address": "', NEW.address, '", "phone": "', NEW.phone, '", "country": "', NEW.country, '", "city": "', NEW.city, '", "postal_code": "', NEW.postal_code, '", "is_deleted": ', NEW.is_deleted, ', "created_date": "', NEW.created_date, '", "updated_date": "', NEW.updated_date, '", "otp": "', NEW.otp, '", "otp_created_date": "', NEW.otp_created_date, '"}'), @current_user);
END//

DROP TRIGGER IF EXISTS  user_history_after_update;
CREATE TRIGGER user_history_after_update
    AFTER UPDATE ON user
    FOR EACH ROW
BEGIN
    INSERT INTO history (table_name, record_id, action, old_data, new_data, performed_by)
    VALUES ('user', OLD.id, 'UPDATE',
            CONCAT('{"full_name": "', OLD.full_name, '", "email": "', OLD.email, '", "role_id": ', OLD.role_id, ', "status": ', OLD.status, ', "address": "', OLD.address, '", "phone": "', OLD.phone, '", "country": "', OLD.country, '", "city": "', OLD.city, '", "postal_code": "', OLD.postal_code, '", "is_deleted": ', OLD.is_deleted, ', "created_date": "', OLD.created_date, '", "updated_date": "', OLD.updated_date, '", "otp": "', OLD.otp, '", "otp_created_date": "', OLD.otp_created_date, '"}'),
            CONCAT('{"full_name": "', NEW.full_name, '", "email": "', NEW.email, '", "role_id": ', NEW.role_id, ', "status": ', NEW.status, ', "address": "', NEW.address, '", "phone": "', NEW.phone, '", "country": "', NEW.country, '", "city": "', NEW.city, '", "postal_code": "', NEW.postal_code, '", "is_deleted": ', NEW.is_deleted, ', "created_date": "', NEW.created_date, '", "updated_date": "', NEW.updated_date, '", "otp": "', NEW.otp, '", "otp_created_date": "', NEW.otp_created_date, '"}'), @current_user);
END//

DROP TRIGGER IF EXISTS  user_history_after_delete;
CREATE TRIGGER user_history_after_delete
    AFTER DELETE ON user
    FOR EACH ROW
BEGIN
    INSERT INTO history (table_name, record_id, action, old_data, performed_by)
    VALUES ('user', OLD.id, 'DELETE',
            CONCAT('{"full_name": "', OLD.full_name, '", "email": "', OLD.email, '", "role_id": ', OLD.role_id, ', "status": ', OLD.status, ', "address": "', OLD.address, '", "phone": "', OLD.phone, '", "country": "', OLD.country, '", "city": "', OLD.city, '", "postal_code": "', OLD.postal_code, '", "is_deleted": ', OLD.is_deleted, ', "created_date": "', OLD.created_date, '", "updated_date": "', OLD.updated_date, '", "otp": "', OLD.otp, '", "otp_created_date": "', OLD.otp_created_date, '"}'), @current_user);
END//

DELIMITER ;

/**
  Date : 2025-02-08
    Name : Vishal Makwana
  purpose : History table performed_by column default value changed to system
*/


ALTER TABLE `equip_point`.`history`
    CHANGE COLUMN `table_name` `table_name` VARCHAR(100) NOT NULL ,
    CHANGE COLUMN `performed_by` `performed_by` VARCHAR(100) NOT NULL DEFAULT 'system' ;



ALTER TABLE `equip_point`.`categories`
    CHANGE COLUMN `id` `id` BIGINT NOT NULL AUTO_INCREMENT ;


CREATE TABLE `equipments` (
                              `id` int NOT NULL AUTO_INCREMENT,
                              `model` varchar(255) NOT NULL,
                              `manufacturing_year` int NOT NULL,
                              `operating_weight` decimal(10,2) NOT NULL DEFAULT '0.00',
                              `engine_power` decimal(10,2) NOT NULL DEFAULT '0.00',
                              `fuel_type` varchar(50) NOT NULL DEFAULT '0.00',
                              `rental_rate` decimal(10,2) DEFAULT '0.00',
                              `availability_status` enum('Available','Booked','Under Maintenance') NOT NULL,
                              `location` varchar(255) NOT NULL,
                              `rental_period` bigint DEFAULT '0',
                              `booked_status` enum('Booked','Available') DEFAULT 'Available',
                              `last_serviced_date` date DEFAULT NULL,
                              `notes` text,
                              `equipment_categories_id` bigint DEFAULT NULL,
                              `user_id` bigint DEFAULT NULL,
                              `created_date` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
                              `updated_date` timestamp NULL DEFAULT NULL,
                              `is_active` bit(1) DEFAULT b'0',
                              PRIMARY KEY (`id`),
                              KEY `user_id_idx` (`user_id`),
                              KEY `categories_id_idx` (`equipment_categories_id`),
                              CONSTRAINT `categories_id` FOREIGN KEY (`equipment_categories_id`) REFERENCES `categories` (`id`),
                              CONSTRAINT `user_id` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci