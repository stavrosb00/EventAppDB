SELECT A.locationID as locationID, eventID,  theme, `description`, `datetime`, capacity, entryPrice, street, address 
FROM (SELECT locationID, street, address FROM location WHERE city = 'thessaloniki')A
JOIN (SELECT * FROM `event` WHERE `datetime` >= '2022-05-14 20:00:00' AND `datetime` <= '2022-05-20 20:00:00'AND isActive = 1)B
ON A.locationID=B.locationID;