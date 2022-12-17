-- SELECT sender_userID as userID, COUNT(accepter_userID) as friendsTotal1 FROM friendship GROUP BY sender_userID
-- SELECT accepter_userID as userID, COUNT(sender_userID) as friendsTotal2 FROM friendship GROUP BY accepter_userID

SELECT * FROM (SELECT sender_userID as userID, COUNT(accepter_userID) as friendsTotal1 FROM friendship GROUP BY sender_userID)t1
LEFT JOIN (SELECT accepter_userID as userID, COUNT(sender_userID) as friendsTotal2 FROM friendship GROUP BY accepter_userID)t2 ON t1.userID = t2.userID
UNION
SELECT * FROM (SELECT sender_userID as userID, COUNT(accepter_userID) as friendsTotal1 FROM friendship GROUP BY sender_userID)t1
RIGHT JOIN (SELECT accepter_userID as userID, COUNT(sender_userID) as friendsTotal2 FROM friendship GROUP BY accepter_userID)t2 ON t1.userID = t2.userID

-- SELECT * FROM friendship


