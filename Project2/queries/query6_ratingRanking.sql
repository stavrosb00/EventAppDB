DROP TABLE IF EXISTS TEMP_A;
CREATE TABLE TEMP_A
SELECT eventID, AVG(rating) as eventRating 
FROM review
GROUP BY eventID;

DROP TABLE IF EXISTS TEMP_B;
CREATE TABLE TEMP_B
SELECT host_userID, AVG(eventRating) as hostRating
FROM (Select userID as host_userID, host.eventID, eventRating FROM TEMP_A JOIN host ON TEMP_A.eventID = host.eventID) as T
GROUP BY host_userID;

DROP TABLE IF EXISTS TEMP_C;
CREATE TABLE TEMP_C
SELECT userID as host_userID, host.eventID, locationID, theme, description, datetime, capacity
FROM host JOIN (SELECT * FROM event WHERE isActive = 1) as T ON host.eventID = T.eventID;

SELECT locationID, eventID, theme, description, datetime, capacity
FROM (
    SELECT TEMP_B.host_userID, hostRating
    FROM TEMP_B JOIN (SELECT host_userID, MAX(hostRating) FROM TEMP_B) as T ON TEMP_B.host_userID = T.host_userID
) AS T
JOIN TEMP_C ON T.host_userID = TEMP_C.host_userID;

DROP TABLE TEMP_A;
DROP TABLE TEMP_B;
DROP TABLE TEMP_C;