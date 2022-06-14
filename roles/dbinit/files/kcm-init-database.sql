-- create the database
CREATE DATABASE IF NOT EXISTS kcm DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
USE kcm;

-- create the users the database
CREATE USER IF NOT EXISTS 'kcm_user'@'%' IDENTIFIED BY 'Kylin123.';
GRANT USAGE ON *.* TO 'kcm_user'@'%';
DROP USER 'kcm_user'@'%';

CREATE USER 'kcm_user'@'%' IDENTIFIED BY 'Kylin123.';
GRANT CREATE, ALTER, INDEX, LOCK TABLES, REFERENCES, UPDATE, DELETE, DROP, SELECT, INSERT ON `kcm`.* TO 'kcm_user'@'%';

FLUSH PRIVILEGES;
