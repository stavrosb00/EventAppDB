-- eventappdb users.sql
DROP USER IF EXISTS 'admin'@'localhost';
DROP USER IF EXISTS 'analyst'@'localhost';
DROP USER IF EXISTS 'analyst'@'%';
DROP USER IF EXISTS 'participant'@'localhost';
DROP USER IF EXISTS 'participant'@'%';
DROP USER IF EXISTS 'host'@'localhost';
DROP USER IF EXISTS 'host'@'%';


CREATE USER 'admin'@'localhost' IDENTIFIED BY 'admin';
GRANT ALL PRIVILEGES ON *.* TO 'admin'@'localhost';

CREATE USER 'analyst'@'localhost' IDENTIFIED BY 'analyst';
CREATE USER 'analyst'@'%' IDENTIFIED BY 'analyst';
GRANT SELECT ON *.* TO 'analyst'@'localhost';
GRANT SELECT ON *.* TO 'analyst'@'%';

CREATE USER 'participant'@'localhost' IDENTIFIED BY 'participant';
CREATE USER 'participant'@'%' IDENTIFIED BY 'participant';
-- 
GRANT SELECT, INSERT, DELETE ON eventappdb.participate TO 'participant'@'localhost';
GRANT SELECT, UPDATE, INSERT, DELETE ON eventappdb.post TO 'participant'@'localhost';
GRANT SELECT ON eventappdb.event TO 'participant'@'localhost';
GRANT SELECT, INSERT, UPDATE, DELETE ON eventappdb.user TO 'participant'@'localhost';
GRANT SELECT, INSERT ON eventappdb.message TO 'participant'@'localhost';
GRANT SELECT, INSERT, DELETE ON eventappdb.friendship TO 'participant'@'localhost';
GRANT SELECT, INSERT ON eventappdb.review TO 'participant'@'localhost';
GRANT SELECT, UPDATE, INSERT ON eventappdb.donate TO 'participant'@'localhost';
--
GRANT SELECT, INSERT, DELETE ON eventappdb.participate TO 'participant'@'%';
GRANT SELECT, UPDATE, INSERT, DELETE ON eventappdb.post TO 'participant'@'%';
GRANT SELECT ON eventappdb.event TO 'participant'@'%';
GRANT SELECT, INSERT, UPDATE, DELETE ON eventappdb.user TO 'participant'@'%';
GRANT SELECT, INSERT ON eventappdb.message TO 'participant'@'%';
GRANT SELECT, INSERT, DELETE ON eventappdb.friendship TO 'participant'@'%';
GRANT SELECT, INSERT ON eventappdb.review TO 'participant'@'%';
GRANT SELECT, UPDATE, INSERT ON eventappdb.donate TO 'participant'@'%';

CREATE USER 'host'@'localhost' IDENTIFIED BY 'host';
CREATE USER 'host'@'%' IDENTIFIED BY 'host';
--
GRANT SELECT, INSERT, UPDATE, DELETE ON eventappdb.event TO 'host'@'localhost';
GRANT SELECT, UPDATE, INSERT, DELETE ON eventappdb.post TO 'host'@'localhost';
GRANT SELECT ON eventappdb.participate TO 'host'@'localhost';
GRANT SELECT ON eventappdb.user TO 'host'@'localhost';
GRANT SELECT ON eventappdb.location TO 'host'@'localhost';
GRANT SELECT ON eventappdb.sponsor TO 'host'@'localhost';
GRANT SELECT, INSERT, UPDATE, DELETE ON eventappdb.event_has_sponsor TO 'host'@'localhost';
--
GRANT SELECT, INSERT, UPDATE, DELETE ON eventappdb.event TO 'host'@'%';
GRANT SELECT, UPDATE, INSERT, DELETE ON eventappdb.post TO 'host'@'%';
GRANT SELECT ON eventappdb.participate TO 'host'@'%';
GRANT SELECT ON eventappdb.user TO 'host'@'%';
GRANT SELECT ON eventappdb.location TO 'host'@'%';
GRANT SELECT ON eventappdb.sponsor TO 'host'@'%';
GRANT SELECT, INSERT, UPDATE, DELETE ON eventappdb.event_has_sponsor TO 'host'@'%';