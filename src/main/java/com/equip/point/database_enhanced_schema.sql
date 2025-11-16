/*
 * EquipPoint - Enhanced Database Schema
 * Date: 2025-01-16
 * Purpose: Complete database schema with security enhancements, RBAC, and audit logging
 * 
 * This script includes:
 * - All existing tables from the original schema
 * - New tables for enhanced security and RBAC
 * - Enhanced indexes for performance
 * - Comprehensive audit logging
 * - Security best practices implementation
 */

-- ============================================
-- PART 1: BASE SCHEMA (Existing Tables)
-- ============================================

CREATE SCHEMA IF NOT EXISTS `equip_point`;
USE equip_point;

-- Role table (existing)
CREATE TABLE IF NOT EXISTS `role` (
    `id` BIGINT NOT NULL AUTO_INCREMENT,
    `name` VARCHAR(50) NOT NULL UNIQUE,
    `description` VARCHAR(255) NULL,
    `created_date` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    `updated_date` TIMESTAMP NULL ON UPDATE CURRENT_TIMESTAMP,
    PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Insert default roles if they don't exist
INSERT IGNORE INTO `role` (`name`, `description`) VALUES 
('Admin', 'System administrator with full access'),
('User', 'Regular user with limited access');

-- User table (existing with enhancements)
CREATE TABLE IF NOT EXISTS `user` (
    `id` BIGINT NOT NULL AUTO_INCREMENT,
    `full_name` VARCHAR(255) NOT NULL,
    `email` VARCHAR(255) NOT NULL UNIQUE,
    `password` VARCHAR(255) NOT NULL,
    `role_id` BIGINT NOT NULL,
    `status` BIT NOT NULL DEFAULT 1,
    `address` TEXT NULL,
    `phone` VARCHAR(22) NULL,
    `country` VARCHAR(100) NULL,
    `city` VARCHAR(100) NULL,
    `postal_code` VARCHAR(10) NULL,
    `is_deleted` BIT DEFAULT 0,
    `created_date` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    `updated_date` TIMESTAMP NULL ON UPDATE CURRENT_TIMESTAMP,
    `otp` VARCHAR(255) NULL,
    `otp_created_date` TIMESTAMP NULL,
    `last_login` TIMESTAMP NULL,
    `failed_login_attempts` INT DEFAULT 0,
    `account_locked_until` TIMESTAMP NULL,
    PRIMARY KEY (`id`),
    INDEX `idx_email` (`email`),
    INDEX `idx_phone` (`phone`),
    INDEX `idx_role_id` (`role_id`),
    CONSTRAINT `fk_user_role` FOREIGN KEY (`role_id`) 
        REFERENCES `role` (`id`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Security questions table (existing)
CREATE TABLE IF NOT EXISTS `security_questions` (
    `id` INT NOT NULL AUTO_INCREMENT,
    `question` VARCHAR(255) NOT NULL UNIQUE,
    `is_active` BIT DEFAULT 1,
    `created_date` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Insert security questions if they don't exist
INSERT IGNORE INTO `security_questions` (`question`) VALUES
('What is your mother''s maiden name?'),
('What is the name of your first pet?'),
('What is the name of the city where you were born?'),
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
('What is your father''s middle name?'),
('What was the name of your first concert?'),
('What is your favorite sports team?');

-- Security questions answer table (existing)
CREATE TABLE IF NOT EXISTS `security_questions_answer` (
    `id` BIGINT NOT NULL AUTO_INCREMENT,
    `question_id` BIGINT NOT NULL,
    `user_id` BIGINT NOT NULL,
    `answer` VARCHAR(255) NOT NULL,
    `created_date` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (`id`),
    INDEX `idx_user_id` (`user_id`),
    INDEX `idx_question_id` (`question_id`),
    CONSTRAINT `fk_sqa_user` FOREIGN KEY (`user_id`) 
        REFERENCES `user` (`id`) ON DELETE CASCADE,
    CONSTRAINT `fk_sqa_question` FOREIGN KEY (`question_id`) 
        REFERENCES `security_questions` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Categories table (existing)
CREATE TABLE IF NOT EXISTS `categories` (
    `id` BIGINT NOT NULL AUTO_INCREMENT,
    `name` VARCHAR(255) NOT NULL,
    `description` TEXT NULL,
    `image` TEXT NULL,
    `type` VARCHAR(255) NULL,
    `is_deleted` BIT DEFAULT 0,
    `created_date` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    `updated_date` TIMESTAMP NULL ON UPDATE CURRENT_TIMESTAMP,
    PRIMARY KEY (`id`),
    INDEX `idx_type` (`type`),
    INDEX `idx_is_deleted` (`is_deleted`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Equipments table (existing)
CREATE TABLE IF NOT EXISTS `equipments` (
    `id` BIGINT NOT NULL AUTO_INCREMENT,
    `model` VARCHAR(255) NOT NULL,
    `manufacturing_year` INT NOT NULL,
    `operating_weight` DECIMAL(10,2) NOT NULL DEFAULT 0.00,
    `engine_power` DECIMAL(10,2) NOT NULL DEFAULT 0.00,
    `fuel_type` VARCHAR(50) NOT NULL DEFAULT 'Diesel',
    `rental_rate` DECIMAL(10,2) DEFAULT 0.00,
    `availability_status` ENUM('Available','Booked','Under Maintenance') NOT NULL DEFAULT 'Available',
    `location` VARCHAR(255) NOT NULL,
    `rental_period` BIGINT DEFAULT 0,
    `booked_status` ENUM('Booked','Available') DEFAULT 'Available',
    `last_serviced_date` DATE NULL,
    `notes` TEXT NULL,
    `equipment_categories_id` BIGINT NULL,
    `user_id` BIGINT NULL,
    `created_date` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    `updated_date` TIMESTAMP NULL ON UPDATE CURRENT_TIMESTAMP,
    `is_active` BIT DEFAULT 1,
    PRIMARY KEY (`id`),
    INDEX `idx_category` (`equipment_categories_id`),
    INDEX `idx_user` (`user_id`),
    INDEX `idx_availability` (`availability_status`),
    INDEX `idx_location` (`location`),
    CONSTRAINT `fk_equipment_category` FOREIGN KEY (`equipment_categories_id`) 
        REFERENCES `categories` (`id`) ON DELETE SET NULL,
    CONSTRAINT `fk_equipment_user` FOREIGN KEY (`user_id`) 
        REFERENCES `user` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Booking table (if not exists)
CREATE TABLE IF NOT EXISTS `booking` (
    `id` BIGINT NOT NULL AUTO_INCREMENT,
    `user_id` BIGINT NOT NULL,
    `equipment_id` BIGINT NOT NULL,
    `start_date` DATE NOT NULL,
    `end_date` DATE NOT NULL,
    `total_cost` DECIMAL(10,2) NOT NULL,
    `status` ENUM('Pending','Confirmed','Cancelled','Completed') DEFAULT 'Pending',
    `notes` TEXT NULL,
    `created_date` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    `updated_date` TIMESTAMP NULL ON UPDATE CURRENT_TIMESTAMP,
    PRIMARY KEY (`id`),
    INDEX `idx_user` (`user_id`),
    INDEX `idx_equipment` (`equipment_id`),
    INDEX `idx_dates` (`start_date`, `end_date`),
    INDEX `idx_status` (`status`),
    CONSTRAINT `fk_booking_user` FOREIGN KEY (`user_id`) 
        REFERENCES `user` (`id`) ON DELETE CASCADE,
    CONSTRAINT `fk_booking_equipment` FOREIGN KEY (`equipment_id`) 
        REFERENCES `equipments` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Contact us table (existing)
CREATE TABLE IF NOT EXISTS `contact_us` (
    `id` BIGINT NOT NULL AUTO_INCREMENT,
    `name` VARCHAR(255) NOT NULL,
    `email` VARCHAR(255) NOT NULL,
    `phone` VARCHAR(22) NULL,
    `message` TEXT NULL,
    `approval_status` BOOLEAN DEFAULT false,
    `approval_date` TIMESTAMP NULL,
    `approved_by` BIGINT NULL,
    `replay_message` TEXT NULL,
    `progress_status` BOOLEAN DEFAULT false,
    `replay_date` TIMESTAMP NULL,
    `replay_by` BIGINT NULL,
    `replay_status` BOOLEAN DEFAULT false,
    `is_notify` BOOLEAN DEFAULT false,
    `created_date` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (`id`),
    INDEX `idx_email` (`email`),
    INDEX `idx_approval_status` (`approval_status`),
    INDEX `idx_replay_by` (`replay_by`),
    INDEX `idx_approved_by` (`approved_by`),
    CONSTRAINT `fk_contact_replay_by` FOREIGN KEY (`replay_by`) 
        REFERENCES `user` (`id`) ON DELETE SET NULL,
    CONSTRAINT `fk_contact_approved_by` FOREIGN KEY (`approved_by`) 
        REFERENCES `user` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Email log table (existing)
CREATE TABLE IF NOT EXISTS `email_log` (
    `id` INT NOT NULL AUTO_INCREMENT,
    `recipient_email` VARCHAR(255) NOT NULL,
    `subject` VARCHAR(255) NOT NULL,
    `message` TEXT NOT NULL,
    `status` ENUM('sent', 'failed', 'pending') DEFAULT 'pending',
    `error_message` TEXT NULL,
    `created_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (`id`),
    INDEX `idx_recipient` (`recipient_email`),
    INDEX `idx_status` (`status`),
    INDEX `idx_created` (`created_at`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- History table (existing)
CREATE TABLE IF NOT EXISTS `history` (
    `id` INT NOT NULL AUTO_INCREMENT,
    `table_name` VARCHAR(100) NOT NULL,
    `record_id` INT NULL,
    `action` VARCHAR(50) NOT NULL,
    `old_data` TEXT NULL,
    `new_data` TEXT NULL,
    `status` ENUM('success', 'failed') DEFAULT 'success',
    `performed_by` VARCHAR(100) NOT NULL DEFAULT 'system',
    `performed_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (`id`),
    INDEX `idx_table_record` (`table_name`, `record_id`),
    INDEX `idx_performed_by` (`performed_by`),
    INDEX `idx_performed_at` (`performed_at`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ============================================
-- PART 2: NEW TABLES FOR RBAC AND SECURITY
-- ============================================

-- Permission table for granular access control
CREATE TABLE IF NOT EXISTS `permission` (
    `id` BIGINT NOT NULL AUTO_INCREMENT,
    `name` VARCHAR(100) NOT NULL UNIQUE,
    `description` VARCHAR(255) NULL,
    `resource` VARCHAR(100) NOT NULL,
    `action` VARCHAR(50) NOT NULL,
    `created_date` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    `updated_date` TIMESTAMP NULL ON UPDATE CURRENT_TIMESTAMP,
    PRIMARY KEY (`id`),
    INDEX `idx_resource_action` (`resource`, `action`),
    UNIQUE KEY `uk_permission` (`resource`, `action`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Role-Permission mapping table
CREATE TABLE IF NOT EXISTS `role_permission` (
    `id` BIGINT NOT NULL AUTO_INCREMENT,
    `role_id` BIGINT NOT NULL,
    `permission_id` BIGINT NOT NULL,
    `created_date` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (`id`),
    UNIQUE KEY `uk_role_permission` (`role_id`, `permission_id`),
    INDEX `idx_role` (`role_id`),
    INDEX `idx_permission` (`permission_id`),
    CONSTRAINT `fk_rp_role` FOREIGN KEY (`role_id`) 
        REFERENCES `role` (`id`) ON DELETE CASCADE,
    CONSTRAINT `fk_rp_permission` FOREIGN KEY (`permission_id`) 
        REFERENCES `permission` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Audit log table for security events
CREATE TABLE IF NOT EXISTS `audit_log` (
    `id` BIGINT NOT NULL AUTO_INCREMENT,
    `user_id` BIGINT NULL,
    `action` VARCHAR(100) NOT NULL,
    `resource` VARCHAR(100) NULL,
    `resource_id` VARCHAR(100) NULL,
    `ip_address` VARCHAR(45) NULL,
    `user_agent` VARCHAR(255) NULL,
    `status` ENUM('success', 'failure', 'warning') NOT NULL,
    `details` TEXT NULL,
    `created_date` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (`id`),
    INDEX `idx_user` (`user_id`),
    INDEX `idx_action` (`action`),
    INDEX `idx_resource` (`resource`),
    INDEX `idx_status` (`status`),
    INDEX `idx_created` (`created_date`),
    CONSTRAINT `fk_audit_user` FOREIGN KEY (`user_id`) 
        REFERENCES `user` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Session management table for security
CREATE TABLE IF NOT EXISTS `user_session` (
    `id` BIGINT NOT NULL AUTO_INCREMENT,
    `user_id` BIGINT NOT NULL,
    `session_id` VARCHAR(255) NOT NULL UNIQUE,
    `ip_address` VARCHAR(45) NOT NULL,
    `user_agent` VARCHAR(255) NULL,
    `created_date` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    `last_activity` TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    `is_active` BIT DEFAULT 1,
    PRIMARY KEY (`id`),
    INDEX `idx_user` (`user_id`),
    INDEX `idx_session` (`session_id`),
    INDEX `idx_active` (`is_active`),
    CONSTRAINT `fk_session_user` FOREIGN KEY (`user_id`) 
        REFERENCES `user` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ============================================
-- PART 3: DEFAULT PERMISSIONS AND ASSIGNMENTS
-- ============================================

-- Insert default permissions
INSERT IGNORE INTO `permission` (`name`, `description`, `resource`, `action`) VALUES
-- User management permissions
('user.view', 'View users', 'user', 'view'),
('user.create', 'Create new users', 'user', 'create'),
('user.edit', 'Edit user details', 'user', 'edit'),
('user.delete', 'Delete users', 'user', 'delete'),

-- Equipment management permissions
('equipment.view', 'View equipment', 'equipment', 'view'),
('equipment.create', 'Add new equipment', 'equipment', 'create'),
('equipment.edit', 'Edit equipment details', 'equipment', 'edit'),
('equipment.delete', 'Delete equipment', 'equipment', 'delete'),

-- Category management permissions
('category.view', 'View categories', 'category', 'view'),
('category.create', 'Create new categories', 'category', 'create'),
('category.edit', 'Edit categories', 'category', 'edit'),
('category.delete', 'Delete categories', 'category', 'delete'),

-- Booking management permissions
('booking.view', 'View bookings', 'booking', 'view'),
('booking.view.all', 'View all bookings', 'booking', 'view_all'),
('booking.create', 'Create new bookings', 'booking', 'create'),
('booking.edit', 'Edit bookings', 'booking', 'edit'),
('booking.cancel', 'Cancel bookings', 'booking', 'cancel'),
('booking.approve', 'Approve bookings', 'booking', 'approve'),

-- Vendor management permissions
('vendor.view', 'View vendors', 'vendor', 'view'),
('vendor.create', 'Add new vendors', 'vendor', 'create'),
('vendor.edit', 'Edit vendor details', 'vendor', 'edit'),
('vendor.delete', 'Delete vendors', 'vendor', 'delete'),

-- Contact management permissions
('contact.view', 'View contact messages', 'contact', 'view'),
('contact.reply', 'Reply to contact messages', 'contact', 'reply'),
('contact.approve', 'Approve contact messages', 'contact', 'approve'),

-- Report permissions
('report.view', 'View reports', 'report', 'view'),
('report.export', 'Export reports', 'report', 'export'),

-- System permissions
('system.settings', 'Manage system settings', 'system', 'settings'),
('system.audit', 'View audit logs', 'system', 'audit'),
('permission.manage', 'Manage permissions', 'permission', 'manage');

-- Assign all permissions to Admin role
INSERT IGNORE INTO `role_permission` (`role_id`, `permission_id`)
SELECT r.id, p.id
FROM `role` r, `permission` p
WHERE r.name = 'Admin';

-- Assign basic permissions to User role
INSERT IGNORE INTO `role_permission` (`role_id`, `permission_id`)
SELECT r.id, p.id
FROM `role` r, `permission` p
WHERE r.name = 'User' 
  AND p.resource IN ('equipment', 'booking', 'category')
  AND p.action IN ('view', 'create');

-- ============================================
-- PART 4: INSERT DEFAULT ADMIN USER
-- ============================================

-- Note: This will insert an admin user with a BCrypt hashed password
-- Default password is: Admin@123
-- Hash generated using BCrypt with salt rounds = 12
INSERT IGNORE INTO `user` (
    `full_name`, `email`, `password`, `role_id`, `status`, 
    `address`, `phone`, `country`, `city`, `postal_code`, 
    `is_deleted`, `created_date`
) VALUES (
    'System Administrator',
    'admin@equippoint.com',
    '$2a$12$LQv3c1yqBWVHxkd0LHAkCOYz6TtxMQJqhN8/LewY5lM7MKJ7nXzZ2', -- Admin@123
    (SELECT id FROM role WHERE name = 'Admin'),
    1,
    'Main Office',
    '+1234567890',
    'USA',
    'New York',
    '10001',
    0,
    NOW()
);

-- ============================================
-- PART 5: CREATE VIEWS FOR REPORTING
-- ============================================

-- View for user permissions
CREATE OR REPLACE VIEW `v_user_permissions` AS
SELECT 
    u.id as user_id,
    u.full_name,
    u.email,
    r.name as role_name,
    p.name as permission_name,
    p.resource,
    p.action
FROM user u
INNER JOIN role r ON u.role_id = r.id
INNER JOIN role_permission rp ON r.id = rp.role_id
INNER JOIN permission p ON rp.permission_id = p.id
WHERE u.is_deleted = 0;

-- View for equipment availability
CREATE OR REPLACE VIEW `v_equipment_availability` AS
SELECT 
    e.id,
    e.model,
    c.name as category_name,
    e.availability_status,
    e.rental_rate,
    e.location,
    COUNT(b.id) as total_bookings,
    u.full_name as owner_name
FROM equipments e
LEFT JOIN categories c ON e.equipment_categories_id = c.id
LEFT JOIN booking b ON e.id = b.equipment_id
LEFT JOIN user u ON e.user_id = u.id
WHERE e.is_active = 1
GROUP BY e.id;

-- ============================================
-- END OF ENHANCED SCHEMA
-- ============================================
