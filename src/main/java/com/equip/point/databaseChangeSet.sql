/*
 Date : 2021-07-07
 Name : Vishal Makwana
 Purpose : Create Database schema for EquipPoint and Create User Table
           Role Table also created for user role
           Inserted data in Role Table
 */

CREATE SCHEMA `equip_point`;

USE
SCHEMA_NAME;

CREATE TABLE `user`
(
    `id`           BIGINT       NOT NULL AUTO_INCREMENT,
    `full_name`    VARCHAR(255) NOT NULL,
    `email`        VARCHAR(255) NOT NULL,
    `password`     VARCHAR(255) NOT NULL,
    `role`         BIGINT       NOT NULL,
    `status`       BIT          NOT NULL,
    `address`      TEXT NULL,
    `phone`        VARCHAR(22) NULL,
    `country`      VARCHAR(100) NULL,
    `city`         VARCHAR(100) NULL,
    `postal_code`  VARCHAR(10) NULL,
    `is_deleted`   BIT NULL,
    `created_date` TIMESTAMP    NOT NULL,
    `updated_date` TIMESTAMP NULL
    PRIMARY KEY (`id`)
);


CREATE TABLE `role`
(
    `id`   BIGINT NOT NULL AUTO_INCREMENT,
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

USE
SCHEMA_NAME;

CREATE TABLE `equipment_categories`
(
    `id`           INT NOT NULL AUTO_INCREMENT,
    `name`         VARCHAR(255) NULL,
    `description`  VARCHAR(255) NULL,
    `image`        VARCHAR(255) NULL,
    `is_deleted`   BIT NULL,
    `created_date` TIMESTAMP NULL,
    `updated_date` TIMESTAMP NULL,
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
    ADD COLUMN `otp` VARCHAR(255) NULL AFTER `updated_date`,
ADD COLUMN `otp_created_date` TIMESTAMP NULL AFTER `otp`;


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

INSERT INTO security_questions (question) VALUES
('What was the name of your elementary school?'),
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

// Security Question Answer Table

CREATE TABLE `equip_point`.`security_questions_answer` (
  `id` BIGINT NOT NULL AUTO_INCREMENT,
  `question_id` BIGINT NOT NULL,
  `user_id` BIGINT NOT NULL,
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
    INSERT INTO `user` (`full_name`, `email`, `password`, `role_id`, `status`, `address`, `phone`, `country`, `city`, `postal_code`, `is_deleted`, `created_date`) VALUES ('Admin', 'admin@equipoint.com', 'Admin', (select id from role where name = "admin"), true, 'USA', '123456789', 'USA', 'USA', '123456', false, now());


/**
    * Date : 2025-01-11
    * Name : Vishal Makwana
    * Purpose : add type column in categories table
    */

    ALTER TABLE `equipment_categories`
ADD COLUMN `type` VARCHAR(255) NULL AFTER `updated_date`,
CHANGE COLUMN `description` `description` TEXT NULL DEFAULT NULL ,
CHANGE COLUMN `image` `image` TEXT NULL DEFAULT NULL , RENAME TO  `equip_point`.`categories` ;




