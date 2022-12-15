-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema eventAppDB
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema eventAppDB
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `eventAppDB` DEFAULT CHARACTER SET utf8 ;
USE `eventAppDB` ;

-- -----------------------------------------------------
-- Table `eventAppDB`.`user`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `eventAppDB`.`user` (
  `userID` BIGINT NOT NULL,
  `email` VARCHAR(35) NOT NULL,
  `username` VARCHAR(35) NOT NULL,
  `password` VARCHAR(35) NOT NULL,
  `age` INT UNSIGNED NOT NULL,
  `gender` ENUM('Male', 'Female') NOT NULL,
  PRIMARY KEY (`userID`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `eventAppDB`.`location`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `eventAppDB`.`location` (
  `locationID` BIGINT NOT NULL,
  `city` VARCHAR(35) NOT NULL,
  `zipCode` CHAR(5) NOT NULL,
  `street` VARCHAR(35) NOT NULL,
  `address` VARCHAR(35) NOT NULL,
  PRIMARY KEY (`locationID`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `eventAppDB`.`event`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `eventAppDB`.`event` (
  `eventID` BIGINT NOT NULL,
  `isActive` BIT(1) NOT NULL,
  `datetime` DATETIME NOT NULL,
  `description` VARCHAR(500) NOT NULL,
  `capacity` INT UNSIGNED NOT NULL,
  `entryPrice` INT UNSIGNED NOT NULL,
  `theme` ENUM('Sports', 'Conferences', 'Expo', 'Concert', 'Community', 'Performing Art', 'Festival') NOT NULL,
  `locationID` BIGINT NOT NULL,
  PRIMARY KEY (`eventID`),
  INDEX `fk_event_location_idx` (`locationID` ASC) VISIBLE,
  CONSTRAINT `fk_event_location`
    FOREIGN KEY (`locationID`)
    REFERENCES `eventAppDB`.`location` (`locationID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `eventAppDB`.`sponsor`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `eventAppDB`.`sponsor` (
  `sponsorID` BIGINT NOT NULL,
  `brand` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`sponsorID`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `eventAppDB`.`post`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `eventAppDB`.`post` (
  `postID` BIGINT NOT NULL,
  `timestamp` TIMESTAMP NOT NULL,
  `text` VARCHAR(500) NOT NULL,
  `eventID` BIGINT NOT NULL,
  `userID` BIGINT NOT NULL,
  PRIMARY KEY (`postID`),
  INDEX `fk_post_event1_idx` (`eventID` ASC) VISIBLE,
  INDEX `fk_post_user1_idx` (`userID` ASC) VISIBLE,
  CONSTRAINT `fk_post_event1`
    FOREIGN KEY (`eventID`)
    REFERENCES `eventAppDB`.`event` (`eventID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_post_user1`
    FOREIGN KEY (`userID`)
    REFERENCES `eventAppDB`.`user` (`userID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `eventAppDB`.`comment`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `eventAppDB`.`comment` (
  `timestamp` TIMESTAMP NOT NULL,
  `text` VARCHAR(500) NOT NULL,
  `postID` BIGINT NOT NULL,
  `userID` BIGINT NOT NULL,
  PRIMARY KEY (`timestamp`, `postID`),
  INDEX `fk_comment_post1_idx` (`postID` ASC) VISIBLE,
  INDEX `fk_comment_user1_idx` (`userID` ASC) VISIBLE,
  CONSTRAINT `fk_comment_post1`
    FOREIGN KEY (`postID`)
    REFERENCES `eventAppDB`.`post` (`postID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_comment_user1`
    FOREIGN KEY (`userID`)
    REFERENCES `eventAppDB`.`user` (`userID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `eventAppDB`.`event_has_sponsor`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `eventAppDB`.`event_has_sponsor` (
  `eventID` BIGINT NOT NULL,
  `sponsorID` BIGINT NOT NULL,
  PRIMARY KEY (`eventID`, `sponsorID`),
  INDEX `fk_event_has_sponsor_sponsor1_idx` (`sponsorID` ASC) VISIBLE,
  INDEX `fk_event_has_sponsor_event1_idx` (`eventID` ASC) VISIBLE,
  CONSTRAINT `fk_event_has_sponsor_event1`
    FOREIGN KEY (`eventID`)
    REFERENCES `eventAppDB`.`event` (`eventID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_event_has_sponsor_sponsor1`
    FOREIGN KEY (`sponsorID`)
    REFERENCES `eventAppDB`.`sponsor` (`sponsorID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `eventAppDB`.`friendship`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `eventAppDB`.`friendship` (
  `sender_userID` BIGINT NOT NULL,
  `accepter_userID` BIGINT NOT NULL,
  `since` DATETIME NOT NULL,
  PRIMARY KEY (`sender_userID`, `accepter_userID`),
  INDEX `fk_user_has_user_user2_idx` (`accepter_userID` ASC) VISIBLE,
  INDEX `fk_user_has_user_user1_idx` (`sender_userID` ASC) VISIBLE,
  CONSTRAINT `fk_user_has_user_user1`
    FOREIGN KEY (`sender_userID`)
    REFERENCES `eventAppDB`.`user` (`userID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_user_has_user_user2`
    FOREIGN KEY (`accepter_userID`)
    REFERENCES `eventAppDB`.`user` (`userID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `eventAppDB`.`message`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `eventAppDB`.`message` (
  `sender_userID` BIGINT NOT NULL,
  `accepter_userID` BIGINT NOT NULL,
  `timestamp` TIMESTAMP NOT NULL,
  `text` VARCHAR(500) NOT NULL,
  PRIMARY KEY (`sender_userID`, `accepter_userID`, `timestamp`),
  INDEX `fk_user_has_user1_user2_idx` (`accepter_userID` ASC) VISIBLE,
  INDEX `fk_user_has_user1_user1_idx` (`sender_userID` ASC) VISIBLE,
  CONSTRAINT `fk_user_has_user1_user1`
    FOREIGN KEY (`sender_userID`)
    REFERENCES `eventAppDB`.`user` (`userID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_user_has_user1_user2`
    FOREIGN KEY (`accepter_userID`)
    REFERENCES `eventAppDB`.`user` (`userID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `eventAppDB`.`review`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `eventAppDB`.`review` (
  `eventID` BIGINT NOT NULL,
  `userID` BIGINT NOT NULL,
  `rating` INT UNSIGNED NOT NULL,
  `comment` VARCHAR(500) NOT NULL,
  PRIMARY KEY (`eventID`, `userID`),
  INDEX `fk_event_has_user_user1_idx` (`userID` ASC) VISIBLE,
  INDEX `fk_event_has_user_event1_idx` (`eventID` ASC) VISIBLE,
  CONSTRAINT `fk_event_has_user_event1`
    FOREIGN KEY (`eventID`)
    REFERENCES `eventAppDB`.`event` (`eventID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_event_has_user_user1`
    FOREIGN KEY (`userID`)
    REFERENCES `eventAppDB`.`user` (`userID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `eventAppDB`.`host`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `eventAppDB`.`host` (
  `eventID` BIGINT NOT NULL,
  `userID` BIGINT NOT NULL,
  PRIMARY KEY (`eventID`, `userID`),
  INDEX `fk_event_has_user1_user1_idx` (`userID` ASC) VISIBLE,
  INDEX `fk_event_has_user1_event1_idx` (`eventID` ASC) VISIBLE,
  CONSTRAINT `fk_event_has_user1_event1`
    FOREIGN KEY (`eventID`)
    REFERENCES `eventAppDB`.`event` (`eventID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_event_has_user1_user1`
    FOREIGN KEY (`userID`)
    REFERENCES `eventAppDB`.`user` (`userID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `eventAppDB`.`participate`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `eventAppDB`.`participate` (
  `eventID` BIGINT NOT NULL,
  `userID` BIGINT NOT NULL,
  PRIMARY KEY (`eventID`, `userID`),
  INDEX `fk_event_has_user2_user1_idx` (`userID` ASC) VISIBLE,
  INDEX `fk_event_has_user2_event1_idx` (`eventID` ASC) VISIBLE,
  CONSTRAINT `fk_event_has_user2_event1`
    FOREIGN KEY (`eventID`)
    REFERENCES `eventAppDB`.`event` (`eventID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_event_has_user2_user1`
    FOREIGN KEY (`userID`)
    REFERENCES `eventAppDB`.`user` (`userID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `eventAppDB`.`donate`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `eventAppDB`.`donate` (
  `eventID` BIGINT NOT NULL,
  `userID` BIGINT NOT NULL,
  `amount` INT UNSIGNED NOT NULL,
  PRIMARY KEY (`eventID`, `userID`),
  INDEX `fk_event_has_user3_user1_idx` (`userID` ASC) VISIBLE,
  INDEX `fk_event_has_user3_event1_idx` (`eventID` ASC) VISIBLE,
  CONSTRAINT `fk_event_has_user3_event1`
    FOREIGN KEY (`eventID`)
    REFERENCES `eventAppDB`.`event` (`eventID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_event_has_user3_user1`
    FOREIGN KEY (`userID`)
    REFERENCES `eventAppDB`.`user` (`userID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

USE `eventAppDB` ;

-- -----------------------------------------------------
-- Placeholder table for view `eventAppDB`.`activity_tracking`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `eventAppDB`.`activity_tracking` (`*` INT);

-- -----------------------------------------------------
-- Placeholder table for view `eventAppDB`.`weekly_events`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `eventAppDB`.`weekly_events` (`eventID` INT);

-- -----------------------------------------------------
-- View `eventAppDB`.`activity_tracking`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `eventAppDB`.`activity_tracking`;
USE `eventAppDB`;
CREATE  OR REPLACE VIEW `activity_tracking` AS
-- A
-- SELECT eventID, city FROM event JOIN location ON event.locationID = location.locationID  WHERE  NOW() - INTERVAL 1 WEEK < datetime AND datetime < NOW();

-- B
-- SELECT city, userID FROM participate JOIN (SELECT eventID, city FROM event JOIN location ON event.locationID = location.locationID  WHERE  NOW() - INTERVAL 1 WEEK < datetime AND datetime < NOW()) as A ON participate.eventID = A.eventID

SELECT * 
FROM (SELECT city, COUNT(*) as count FROM (SELECT city, userID FROM participate JOIN (SELECT eventID, city FROM event JOIN location ON event.locationID = location.locationID  WHERE  NOW() - INTERVAL 1 WEEK < datetime AND datetime < NOW()) as A ON participate.eventID = A.eventID) as B GROUP BY city) as T1;
-- JOIN 
-- (SELECT city, COUNT(*) as count FROM A GROUP BY city) as T2 
-- ON T1.city = T2.city;

-- -----------------------------------------------------
-- View `eventAppDB`.`weekly_events`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `eventAppDB`.`weekly_events`;
USE `eventAppDB`;
CREATE  OR REPLACE VIEW `weekly_events` AS
SELECT eventID
FROM event WHERE  NOW() - INTERVAL 1 WEEK < datetime AND datetime < NOW() AND isActive = 1;

SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
