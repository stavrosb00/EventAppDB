DROP TABLE IF EXISTS TEMP_A;
CREATE TABLE TEMP_A
SELECT sponsor.sponsorID, city
FROM sponsor JOIN event_has_sponsor ON sponsor.sponsorID = event_has_sponsor.sponsorID
             JOIN event ON event_has_sponsor.eventID = event.eventID
             JOIN location ON location.locationID = event.locationID;

DROP TABLE IF EXISTS TEMP_B;
CREATE TABLE TEMP_B
SELECT DISTINCT city
FROM `event` 
JOIN LOCATION 
ON `event`.locationID = location.locationID;

DROP TABLE IF EXISTS TEMP_C;
CREATE TABLE TEMP_C
SELECT DISTINCT *
FROM (SELECT sponsorID FROM TEMP_A) AS T CROSS JOIN TEMP_B;

DROP TABLE IF EXISTS TEMP_D;
CREATE TABLE TEMP_D
SELECT DISTINCT sponsorID
FROM (SELECT * FROM TEMP_C WHERE (sponsorID, city) NOT IN (SELECT * FROM TEMP_A)) AS T;

SELECT sponsor.sponsorID, brand 
FROM (SELECT DISTINCT sponsorID FROM TEMP_A WHERE sponsorID NOT IN (SELECT sponsorID FROM TEMP_D)) AS T
      JOIN sponsor ON T.sponsorID = sponsor.sponsorID;

DROP TABLE TEMP_A;
DROP TABLE TEMP_B;
DROP TABLE TEMP_C;
DROP TABLE TEMP_D;