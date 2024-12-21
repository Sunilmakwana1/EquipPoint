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






