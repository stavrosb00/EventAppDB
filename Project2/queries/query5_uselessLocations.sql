SELECT locationID
FROM location
WHERE locationID NOT IN (SELECT locationID FROM event)