DROP TABLE IF EXISTS TEMP_A;
CREATE TABLE TEMP_A
SELECT sender_userID, COUNT(accepter_userID) as friendsTotalSent 
FROM friendship 
GROUP BY sender_userID;
 
DROP TABLE IF EXISTS TEMP_B;
CREATE TABLE TEMP_B
SELECT accepter_userID, COUNT(sender_userID) as friendsTotalAccepted
FROM friendship 
GROUP BY accepter_userID;

DROP TABLE IF EXISTS TEMP_C;
CREATE TABLE TEMP_C
SELECT * FROM TEMP_A LEFT JOIN TEMP_B ON TEMP_A.sender_userID = TEMP_B.accepter_userID 
UNION
SELECT * FROM TEMP_A RIGHT JOIN TEMP_B ON TEMP_A.sender_userID = TEMP_B.accepter_userID;

DROP TABLE IF EXISTS TEMP_D;
CREATE TABLE TEMP_D
SELECT accepter_userID as userID, friendsTotalAccepted
FROM TEMP_C
WHERE friendsTotalSent IS NULL;
ALTER TABLE TEMP_D 
ADD friendsTotalSent REAL DEFAULT 0;

DROP TABLE IF EXISTS TEMP_E;
CREATE TABLE TEMP_E
SELECT sender_userID as userID, friendsTotalSent
FROM TEMP_C
WHERE friendsTotalAccepted IS NULL;
ALTER TABLE TEMP_E 
ADD friendsTotalAccepted REAL DEFAULT 0;

DROP TABLE IF EXISTS TEMP_F;
CREATE TABLE TEMP_F
SELECT sender_userID as userID, friendsTotalSent, friendsTotalAccepted
FROM TEMP_C
WHERE friendsTotalAccepted IS NOT NULL AND friendsTotalSent IS NOT NULL;

SELECT userID, friendsTotalAccepted + friendsTotalSent as friendsTotal
FROM TEMP_D
UNION 
SELECT userID, friendsTotalAccepted + friendsTotalSent as friendsTotal
FROM TEMP_E
UNION 
SELECT userID, friendsTotalAccepted + friendsTotalSent as friendsTotal
FROM TEMP_F;

DROP TABLE TEMP_A;
DROP TABLE TEMP_B;
DROP TABLE TEMP_C;
DROP TABLE TEMP_D;
DROP TABLE TEMP_E;
DROP TABLE TEMP_F;