/*
 Date : 2021-07-07
 Name : Vishal Makwana
 Purpose : Create Database schema for EquipPoint and Create User Table
           Role Table also created for user role
           Inserted data in Role Table
 */

CREATE SCHEMA `equip_point` ;

USE SCHEMA_NAME;

CREATE TABLE `user`
(
    `id`           BIGINT       NOT NULL AUTO_INCREMENT,
    `full_name`   VARCHAR(255) NOT NULL,
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
    `updated_date` TIMESTAMP    NULL
    PRIMARY KEY (`id`)
);


CREATE TABLE `role`
(
    `id`   BIGINT NOT NULL AUTO_INCREMENT,
    `name` VARCHAR(50) NULL,
    PRIMARY KEY (`id`)
);



INSERT INTO `role` (`name`) VALUES ('Admin');
INSERT INTO `role` (`name`) VALUES ('User');

/*
 Date : 2024-12-22
    Name : Vishal Makwana
    Purpose : Create table for Equipment Category and Equipment
             Also added foreign key in USER table for role
 */

USE SCHEMA_NAME;

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
DROP FOREIGN KEY `user_id_role_id_fk`;
ALTER TABLE `user`
    CHANGE COLUMN `role` `role_id` BIGINT NOT NULL ;
ALTER TABLE `user`
    ADD CONSTRAINT `user_id_role_id_fk`
        FOREIGN KEY (`role_id`)
            REFERENCES `role` (`id`);







