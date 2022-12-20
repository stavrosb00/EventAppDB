CREATE 
    ALGORITHM = UNDEFINED 
    DEFINER = root@localhost 
    SQL SECURITY DEFINER
VIEW company_earnings AS
    SELECT 
        (t11.donationMoney * 0.02) AS donationEarnings,
        (t12.entryMoney * 0.16) AS entryEarnings
    FROM
        ((SELECT 
            SUM(t1.amount) AS donationMoney
        FROM
            (SELECT 
            donate.eventID AS eventID,
                donate.userID AS userID,
                donate.amount AS amount
        FROM
            ((SELECT 
            event.eventID AS eventID,
                event.entryPrice AS entryPrice
        FROM
            event
        WHERE
            (((NOW() - INTERVAL 56 WEEK) <= event.datetime)
                AND (event.datetime <= NOW()))) a
        JOIN donate ON ((a.eventID = donate.eventID)))) t1) t11
        JOIN (SELECT 
            SUM(t2.entryPrice) AS entryMoney
        FROM
            (SELECT 
            participate.eventID AS eventID,
                participate.userID AS userID,
                a.entryPrice AS entryPrice
        FROM
            ((SELECT 
            event.eventID AS eventID,
                event.entryPrice AS entryPrice
        FROM
            event
        WHERE
            (((NOW() - INTERVAL 56 WEEK) <= event.datetime)
                AND (event.datetime <= NOW()))) a
        JOIN participate ON ((a.eventID = participate.eventID)))) t2) t12)