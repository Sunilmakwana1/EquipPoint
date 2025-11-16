# EquipPoint - Deployment Guide

## Table of Contents
1. [Prerequisites](#prerequisites)
2. [Database Setup](#database-setup)
3. [Application Configuration](#application-configuration)
4. [Building the Application](#building-the-application)
5. [Deploying to Tomcat](#deploying-to-tomcat)
6. [Post-Deployment Configuration](#post-deployment-configuration)
7. [Security Hardening](#security-hardening)
8. [Monitoring & Maintenance](#monitoring--maintenance)
9. [Troubleshooting](#troubleshooting)

---

## Prerequisites

### System Requirements

- **Java**: JDK 17 or higher
- **Database**: MySQL 8.0 or higher
- **Application Server**: Apache Tomcat 10.x
- **Build Tool**: Gradle 8.x
- **Operating System**: Linux, macOS, or Windows

### Software Installation

#### Install Java 17

```bash
# Ubuntu/Debian
sudo apt update
sudo apt install openjdk-17-jdk

# macOS (using Homebrew)
brew install openjdk@17

# Verify installation
java -version
```

#### Install MySQL

```bash
# Ubuntu/Debian
sudo apt install mysql-server

# macOS (using Homebrew)
brew install mysql

# Start MySQL service
sudo systemctl start mysql  # Linux
brew services start mysql   # macOS
```

#### Install Apache Tomcat 10

```bash
# Download Tomcat 10
wget https://downloads.apache.org/tomcat/tomcat-10/v10.1.x/bin/apache-tomcat-10.1.x.tar.gz

# Extract
tar -xzf apache-tomcat-10.1.x.tar.gz

# Move to installation directory
sudo mv apache-tomcat-10.1.x /opt/tomcat

# Set environment variable
export CATALINA_HOME=/opt/tomcat
```

---

## Database Setup

### Step 1: Create Database User

```sql
-- Connect to MySQL as root
mysql -u root -p

-- Create database user
CREATE USER 'equippoint_user'@'localhost' IDENTIFIED BY 'SecurePassword123!';

-- Grant privileges
GRANT ALL PRIVILEGES ON equip_point.* TO 'equippoint_user'@'localhost';
FLUSH PRIVILEGES;
```

### Step 2: Run Database Schema

```bash
# Navigate to project directory
cd /path/to/EquipPoint

# Import enhanced schema
mysql -u equippoint_user -p < src/main/java/com/equip/point/database_enhanced_schema.sql
```

### Step 3: Verify Database Setup

```sql
-- Connect to database
mysql -u equippoint_user -p equip_point

-- Verify tables
SHOW TABLES;

-- Check default admin user
SELECT id, full_name, email, role_id FROM user WHERE email = 'admin@equippoint.com';

-- Check permissions
SELECT * FROM permission LIMIT 10;

-- Check role assignments
SELECT * FROM role_permission WHERE role_id = 1 LIMIT 10;
```

### Step 4: Backup Database

```bash
# Create backup directory
mkdir -p /backup/equippoint

# Backup database
mysqldump -u equippoint_user -p equip_point > /backup/equippoint/equippoint_$(date +%Y%m%d).sql

# Set up automated daily backups
echo "0 2 * * * mysqldump -u equippoint_user -pYourPassword equip_point > /backup/equippoint/equippoint_\$(date +\%Y\%m\%d).sql" | crontab -
```

---

## Application Configuration

### Step 1: Update Database Credentials

Edit `src/main/java/com/equip/point/util/DbConstant.java`:

```java
package com.equip.point.util;

public class DbConstant {
    public static final String DRIVER_NAME = "com.mysql.cj.Driver";
    public static final String URL = "jdbc:mysql://localhost:3306/equip_point?useSSL=true&serverTimezone=UTC";
    public static final String USERNAME = "equippoint_user";
    public static final String PASSWORD = "SecurePassword123!";
}
```

⚠️ **Security Best Practice**: Use environment variables for production:

```java
public class DbConstant {
    public static final String DRIVER_NAME = "com.mysql.cj.Driver";
    public static final String URL = System.getenv("DB_URL");
    public static final String USERNAME = System.getenv("DB_USERNAME");
    public static final String PASSWORD = System.getenv("DB_PASSWORD");
}
```

Then set environment variables:

```bash
export DB_URL="jdbc:mysql://localhost:3306/equip_point?useSSL=true&serverTimezone=UTC"
export DB_USERNAME="equippoint_user"
export DB_PASSWORD="SecurePassword123!"
```

### Step 2: Configure Security Settings

Review and adjust settings in:

**SecurityFilter.java**:
```java
private static final int MAX_LOGIN_ATTEMPTS = 5;
private static final long RATE_LIMIT_DURATION_MS = 15 * 60 * 1000; // 15 minutes
private static final long SESSION_TIMEOUT_MS = 30 * 60 * 1000; // 30 minutes
```

**BCrypt Settings** (SecurityUtil.java):
```java
// Salt rounds (higher = more secure but slower)
return BCrypt.hashpw(plainPassword, BCrypt.gensalt(12));
```

### Step 3: Configure Logging

Create or update `log4j2.xml` in `src/main/resources`:

```xml
<?xml version="1.0" encoding="UTF-8"?>
<Configuration status="WARN">
    <Appenders>
        <Console name="Console" target="SYSTEM_OUT">
            <PatternLayout pattern="%d{yyyy-MM-dd HH:mm:ss} %-5p %c{1}:%L - %m%n"/>
        </Console>
        <RollingFile name="RollingFile" fileName="logs/equippoint.log"
                     filePattern="logs/equippoint-%d{yyyy-MM-dd}.log">
            <PatternLayout pattern="%d{yyyy-MM-dd HH:mm:ss} %-5p %c{1}:%L - %m%n"/>
            <Policies>
                <TimeBasedTriggeringPolicy interval="1" modulate="true"/>
            </Policies>
        </RollingFile>
    </Appenders>
    <Loggers>
        <Root level="info">
            <AppenderRef ref="Console"/>
            <AppenderRef ref="RollingFile"/>
        </Root>
    </Loggers>
</Configuration>
```

---

## Building the Application

### Step 1: Clean and Build

```bash
# Navigate to project directory
cd /path/to/EquipPoint

# Make gradlew executable
chmod +x gradlew

# Clean build
./gradlew clean

# Build WAR file
./gradlew build

# The WAR file will be created at:
# build/libs/EquipPoint-1.0-SNAPSHOT.war
```

### Step 2: Verify Build

```bash
# Check WAR file size (should be several MB)
ls -lh build/libs/EquipPoint-1.0-SNAPSHOT.war

# Verify WAR contents
jar -tf build/libs/EquipPoint-1.0-SNAPSHOT.war | head -20
```

---

## Deploying to Tomcat

### Method 1: Manual Deployment

```bash
# Stop Tomcat
$CATALINA_HOME/bin/shutdown.sh

# Remove old deployment (if exists)
rm -rf $CATALINA_HOME/webapps/EquipPoint*

# Copy WAR file
cp build/libs/EquipPoint-1.0-SNAPSHOT.war $CATALINA_HOME/webapps/EquipPoint.war

# Start Tomcat
$CATALINA_HOME/bin/startup.sh

# Monitor deployment
tail -f $CATALINA_HOME/logs/catalina.out
```

### Method 2: Tomcat Manager Deployment

1. Access Tomcat Manager: `http://localhost:8080/manager/html`
2. Login with manager credentials
3. Upload WAR file using the web interface
4. Click "Deploy"

### Method 3: Automated Deployment Script

Create `deploy.sh`:

```bash
#!/bin/bash

# Configuration
WAR_FILE="build/libs/EquipPoint-1.0-SNAPSHOT.war"
TOMCAT_HOME="/opt/tomcat"
APP_NAME="EquipPoint"

# Build application
echo "Building application..."
./gradlew clean build

if [ $? -ne 0 ]; then
    echo "Build failed!"
    exit 1
fi

# Stop Tomcat
echo "Stopping Tomcat..."
$TOMCAT_HOME/bin/shutdown.sh

# Wait for shutdown
sleep 5

# Remove old deployment
echo "Removing old deployment..."
rm -rf $TOMCAT_HOME/webapps/$APP_NAME*

# Copy new WAR
echo "Deploying new WAR..."
cp $WAR_FILE $TOMCAT_HOME/webapps/$APP_NAME.war

# Start Tomcat
echo "Starting Tomcat..."
$TOMCAT_HOME/bin/startup.sh

# Monitor logs
echo "Deployment complete. Monitoring logs..."
tail -f $TOMCAT_HOME/logs/catalina.out
```

Make executable and run:

```bash
chmod +x deploy.sh
./deploy.sh
```

---

## Post-Deployment Configuration

### Step 1: Verify Application

```bash
# Check if application is running
curl http://localhost:8080/EquipPoint/

# Check login page
curl http://localhost:8080/EquipPoint/login/login.jsp

# Check API endpoint (should redirect to login)
curl -I http://localhost:8080/EquipPoint/api/auth
```

### Step 2: Change Default Admin Password

1. Login with default credentials:
   - Email: admin@equippoint.com
   - Password: Admin@123

2. Navigate to profile/settings
3. Change password to a strong, unique password
4. Logout and login with new password

### Step 3: Test Security Features

**Test Rate Limiting**:
```bash
# Make multiple failed login attempts
for i in {1..6}; do
    curl -X POST http://localhost:8080/EquipPoint/api/auth \
        -d "email=test@test.com&password=wrong" \
        -w "\nStatus: %{http_code}\n"
    sleep 1
done
# 6th attempt should return 429
```

**Test Session Timeout**:
1. Login to application
2. Wait 30 minutes (or adjust timeout for testing)
3. Try to access a protected page
4. Should redirect to login with timeout message

**Test CSRF Protection**:
```bash
# Attempt to submit form without CSRF token
curl -X POST http://localhost:8080/EquipPoint/api/someAction \
    -d "data=test" \
    -w "\nStatus: %{http_code}\n"
# Should fail or redirect
```

### Step 4: Configure SSL/TLS (Production)

#### Generate SSL Certificate

```bash
# Using Let's Encrypt (recommended)
sudo certbot certonly --standalone -d yourdomain.com

# Or generate self-signed certificate for testing
keytool -genkey -alias tomcat -keyalg RSA -keystore /opt/tomcat/conf/keystore.jks
```

#### Configure Tomcat SSL

Edit `$CATALINA_HOME/conf/server.xml`:

```xml
<Connector port="8443" protocol="org.apache.coyote.http11.Http11NioProtocol"
           maxThreads="150" SSLEnabled="true">
    <SSLHostConfig>
        <Certificate certificateKeystoreFile="/opt/tomcat/conf/keystore.jks"
                     type="RSA" 
                     certificateKeystorePassword="your_keystore_password" />
    </SSLHostConfig>
</Connector>
```

Restart Tomcat:
```bash
$CATALINA_HOME/bin/shutdown.sh
$CATALINA_HOME/bin/startup.sh
```

#### Enable HSTS Header

Uncomment in `SecurityFilter.java`:
```java
response.setHeader("Strict-Transport-Security", "max-age=31536000; includeSubDomains");
```

Rebuild and redeploy.

---

## Security Hardening

### Step 1: Secure Tomcat

**Remove default applications**:
```bash
rm -rf $CATALINA_HOME/webapps/docs
rm -rf $CATALINA_HOME/webapps/examples
rm -rf $CATALINA_HOME/webapps/host-manager
rm -rf $CATALINA_HOME/webapps/manager  # if not needed
```

**Disable directory listing** in `web.xml`:
```xml
<init-param>
    <param-name>listings</param-name>
    <param-value>false</param-value>
</init-param>
```

**Set secure headers** (already implemented in SecurityFilter)

### Step 2: File Permissions

```bash
# Set proper ownership
sudo chown -R tomcat:tomcat $CATALINA_HOME

# Restrict permissions
sudo chmod 750 $CATALINA_HOME/bin/*.sh
sudo chmod 640 $CATALINA_HOME/conf/*
sudo chmod 750 $CATALINA_HOME/webapps
```

### Step 3: Database Security

```sql
-- Disable remote root login
UPDATE mysql.user SET Host='localhost' WHERE User='root';

-- Remove anonymous users
DELETE FROM mysql.user WHERE User='';

-- Remove test database
DROP DATABASE IF EXISTS test;

-- Apply changes
FLUSH PRIVILEGES;
```

### Step 4: Firewall Configuration

```bash
# Ubuntu/Debian (UFW)
sudo ufw allow 80/tcp
sudo ufw allow 443/tcp
sudo ufw allow 22/tcp  # SSH
sudo ufw enable

# CentOS/RHEL (firewalld)
sudo firewall-cmd --permanent --add-service=http
sudo firewall-cmd --permanent --add-service=https
sudo firewall-cmd --permanent --add-service=ssh
sudo firewall-cmd --reload
```

---

## Monitoring & Maintenance

### Application Monitoring

**Monitor Tomcat Logs**:
```bash
# Real-time monitoring
tail -f $CATALINA_HOME/logs/catalina.out

# Check for errors
grep ERROR $CATALINA_HOME/logs/catalina.out

# Check application logs
tail -f logs/equippoint.log
```

**Monitor Audit Logs**:
```sql
-- Recent security events
SELECT * FROM audit_log 
WHERE created_date > DATE_SUB(NOW(), INTERVAL 24 HOUR)
ORDER BY created_date DESC;

-- Failed logins in last hour
SELECT * FROM audit_log 
WHERE action = 'LOGIN_FAILED' 
AND created_date > DATE_SUB(NOW(), INTERVAL 1 HOUR);
```

### Performance Monitoring

**Monitor Database Connections**:
```sql
SHOW PROCESSLIST;
SHOW STATUS LIKE 'Threads_connected';
```

**Monitor Memory Usage**:
```bash
# Tomcat memory usage
ps aux | grep tomcat

# JVM heap usage
jmap -heap <tomcat_pid>
```

### Maintenance Tasks

**Daily**:
- Monitor error logs
- Check disk space
- Review failed login attempts

**Weekly**:
- Review audit logs
- Check application performance
- Review security alerts

**Monthly**:
- Update dependencies
- Backup database
- Review and rotate logs

**Quarterly**:
- Security audit
- Performance optimization
- Update documentation

---

## Troubleshooting

### Common Issues

#### Application Won't Start

**Check logs**:
```bash
tail -100 $CATALINA_HOME/logs/catalina.out
```

**Common causes**:
- Database connection failure
- Port already in use
- Insufficient memory
- Missing dependencies

**Solutions**:
```bash
# Check database connectivity
mysql -u equippoint_user -p -h localhost equip_point

# Check port availability
netstat -tulpn | grep 8080

# Increase Tomcat memory (in catalina.sh)
JAVA_OPTS="-Xms512m -Xmx2048m"
```

#### Database Connection Errors

**Error**: `Communications link failure`

**Solution**:
```bash
# Check MySQL is running
sudo systemctl status mysql

# Start MySQL
sudo systemctl start mysql

# Verify connection
mysql -u equippoint_user -p -h localhost
```

#### Login Failures

**Check user exists**:
```sql
SELECT * FROM user WHERE email = 'admin@equippoint.com';
```

**Reset admin password**:
```java
// Generate BCrypt hash for new password
String hash = SecurityUtil.hashPassword("NewPassword123!");
System.out.println(hash);
```

```sql
-- Update password in database
UPDATE user 
SET password = '[generated_bcrypt_hash]' 
WHERE email = 'admin@equippoint.com';
```

#### Rate Limiting Issues

**Clear rate limits**:
Restart Tomcat to clear in-memory rate limit tracking:
```bash
$CATALINA_HOME/bin/shutdown.sh
$CATALINA_HOME/bin/startup.sh
```

#### Session Timeout Issues

**Check session configuration**:
```java
// In SecurityFilter.java
private static final long SESSION_TIMEOUT_MS = 30 * 60 * 1000; // Adjust as needed
```

---

## Production Checklist

Before going to production:

- [ ] Database backups configured
- [ ] SSL/TLS enabled
- [ ] Default admin password changed
- [ ] Environment variables configured
- [ ] Firewall rules configured
- [ ] Monitoring set up
- [ ] Log rotation configured
- [ ] Error pages customized
- [ ] Security headers verified
- [ ] Rate limiting tested
- [ ] CSRF protection verified
- [ ] Audit logging tested
- [ ] Backup and recovery tested
- [ ] Documentation updated

---

## Support

For deployment issues:
- Check application logs
- Review audit logs
- Verify database connectivity
- Check Tomcat configuration
- Review security settings

For security concerns:
- Review `SECURITY_IMPLEMENTATION.md`
- Check audit logs for suspicious activity
- Contact security team

**Remember**: Always test in a staging environment before deploying to production!
