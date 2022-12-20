CREATE 
    ALGORITHM = UNDEFINED 
    DEFINER = root@localhost 
    SQL SECURITY DEFINER
VIEW activity tracking AS
    SELECT 
        t1.city AS city,
        t2.events_created AS events_created,
        t1.active_monthly_users AS active_monthly_users
    FROM
        ((SELECT 
            b.city AS city, COUNT(0) AS active_monthly_users
        FROM
            (SELECT DISTINCT
            a.city AS city, participate.userID AS userID
        FROM
            ((SELECT 
            event.eventID AS eventID, location.city AS city
        FROM
            (event
        JOIN location ON ((event.locationID = location.locationID)))
        WHERE
            ((NOW() >= event.datetime)
                AND (event.datetime >= (NOW() - INTERVAL 56 WEEK)))) a
        JOIN participate ON ((a.eventID = participate.eventID)))) b
        GROUP BY b.city) t1
        JOIN (SELECT 
            a.city AS city, COUNT(0) AS events_created
        FROM
            (SELECT 
            event.eventID AS eventID, location.city AS city
        FROM
            (event
        JOIN location ON ((event.locationID = location.locationID)))
        WHERE
            ((NOW() >= event.datetime)
                AND (event.datetime >= (NOW() - INTERVAL 56 WEEK)))) a
        GROUP BY a.city) t2 ON ((t1.city = t2.city)))