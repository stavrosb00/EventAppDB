CREATE 
    ALGORITHM = UNDEFINED 
    DEFINER = `root`@`localhost` 
    SQL SECURITY DEFINER
VIEW `weekly_events` AS
    CREATE 
		ALGORITHM=UNDEFINED 
		DEFINER=`root`@`localhost` 
		SQL SECURITY DEFINER 
    VIEW weekly_events AS 
		select eventID AS `eventID` 
		from `event`
        where (((now() + interval 1 week) > `datetime`) and ( `datetime` > now()) and ( isActive = 1));