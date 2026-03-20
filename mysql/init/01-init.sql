-- Create the database if it doesn't exist
CREATE DATABASE IF NOT EXISTS `finance_payment` CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- Grant all privileges to root user on the database
GRANT ALL PRIVILEGES ON `finance_payment`.* TO 'root'@'%';
FLUSH PRIVILEGES;
