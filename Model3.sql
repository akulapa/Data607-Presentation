-- MySQL Script generated by MySQL Workbench
-- 04/03/17 18:47:35
-- Model: New Model    Version: 1.0
-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';

-- -----------------------------------------------------
-- Schema model3
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema model3
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `model3` DEFAULT CHARACTER SET utf8 ;
USE `model3` ;

-- -----------------------------------------------------
-- Table `model3`.`age`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `model3`.`age` (
  `idAge` INT(11) NOT NULL,
  `ageDesc` VARCHAR(30) NULL DEFAULT NULL,
  PRIMARY KEY (`idAge`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `model3`.`answer`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `model3`.`answer` (
  `idAnswer` INT(11) NOT NULL,
  `answerDesc` VARCHAR(45) NULL DEFAULT NULL,
  PRIMARY KEY (`idAnswer`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `model3`.`gender`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `model3`.`gender` (
  `idGender` INT(11) NOT NULL,
  `genderDesc` VARCHAR(10) NULL DEFAULT NULL,
  PRIMARY KEY (`idGender`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `model3`.`question`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `model3`.`question` (
  `idQuestion` INT(11) NOT NULL,
  `questionDesc` VARCHAR(4000) NULL DEFAULT NULL,
  PRIMARY KEY (`idQuestion`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `model3`.`survey_fact`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `model3`.`survey_fact` (
  `idSurvey_Fact` INT(11) NOT NULL,
  `idQuestion` INT(11) NULL DEFAULT NULL,
  `idAnswer` INT(11) NULL DEFAULT NULL,
  `idGender` INT(11) NULL DEFAULT NULL,
  `gender_response_count` INT(11) NULL DEFAULT NULL,
  `gender_response_percentage` VARCHAR(5) NULL DEFAULT NULL,
  `idAge` INT(11) NOT NULL,
  `age_response_count` INT(11) NULL DEFAULT NULL,
  `age_response_percentage` VARCHAR(5) NULL DEFAULT NULL,
  PRIMARY KEY (`idSurvey_Fact`),
  INDEX `sf1_idx` (`idQuestion` ASC),
  INDEX `sf2_idx` (`idAnswer` ASC),
  INDEX `sf3_idx` (`idGender` ASC),
  INDEX `sf4_idx` (`idAge` ASC),
  CONSTRAINT `sf1`
    FOREIGN KEY (`idQuestion`)
    REFERENCES `model3`.`question` (`idQuestion`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `sf2`
    FOREIGN KEY (`idAnswer`)
    REFERENCES `model3`.`answer` (`idAnswer`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `sf3`
    FOREIGN KEY (`idAge`)
    REFERENCES `model3`.`age` (`idAge`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `sf4`
    FOREIGN KEY (`idGender`)
    REFERENCES `model3`.`gender` (`idGender`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;


INSERT INTO question
SELECT * FROM `model1`.`question`

INSERT INTO answer
SELECT * FROM `model1`.`answer`

INSERT INTO age
SELECT * FROM `model1`.`age`

INSERT INTO gender
SELECT * FROM `model1`.`gender`

INSERT INTO survey_fact(idSurvey_Fact, idQuestion, idAnswer, idGender, gender_response_count, gender_response_percentage,
idAge, age_response_count, age_response_percentage)

SELECT DISTINCT (@rownum:=@rownum+1) as idSurvey_Fact, g.idQuestion, g.idAnswer, g.idGender, g.response_count, g.response_percentage,
a.idAge, a.response_count, a.response_percentage 
FROM model1.age_fact a 
JOIN model1.gender_fact g ON a.idQuestion = g.idQuestion AND a.idAnswer = g.idAnswer,
(SELECT @rownum:=0) r 
