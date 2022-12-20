SELECT A.userID as userID, username, email
FROM(SELECT userID FROM participate WHERE eventID = 1)A
JOIN (SELECT userID, username, email FROM user)B
ON A.userID=B.userID;
