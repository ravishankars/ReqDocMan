-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `mydb` DEFAULT CHARACTER SET utf8 ;
USE `mydb` ;

-- -----------------------------------------------------
-- Table `mydb`.`table1`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`table1` (
)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Application`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Application` (
  `App_ID` INT NOT NULL AUTO_INCREMENT,
  `App_Name` VARCHAR(30) NULL,
  `App_Desc` VARCHAR(512) NULL,
  `Parent_App_id` INT NULL,
  PRIMARY KEY (`App_ID`),
  INDEX `fk_Application_Application1_idx` (`Parent_App_id` ASC),
  UNIQUE INDEX `App_Name_UNIQUE` (`App_Name` ASC),
  CONSTRAINT `fk_Application_Application1`
    FOREIGN KEY (`Parent_App_id`)
    REFERENCES `mydb`.`Application` (`App_ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
COMMENT = '		';


-- -----------------------------------------------------
-- Table `mydb`.`RequirementGroup`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`RequirementGroup` (
  `ReqGroup_ID` INT NOT NULL AUTO_INCREMENT,
  `ReqGroup_Desc` VARCHAR(45) NULL,
  `App_ID` INT NOT NULL,
  PRIMARY KEY (`ReqGroup_ID`, `App_ID`),
  INDEX `fk_RulesGroup_Application1_idx` (`App_ID` ASC),
  CONSTRAINT `fk_RulesGroup_Application1`
    FOREIGN KEY (`App_ID`)
    REFERENCES `mydb`.`Application` (`App_ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`AppRules_filter`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`AppRules_filter` (
  `AppRules_filter_id` INT NOT NULL AUTO_INCREMENT,
  `AppRules_filter_name` VARCHAR(45) NULL,
  `Application_App_ID` INT NOT NULL,
  PRIMARY KEY (`AppRules_filter_id`, `Application_App_ID`),
  INDEX `fk_AppRules_filter_Application1_idx` (`Application_App_ID` ASC),
  CONSTRAINT `fk_AppRules_filter_Application1`
    FOREIGN KEY (`Application_App_ID`)
    REFERENCES `mydb`.`Application` (`App_ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`AppReqType`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`AppReqType` (
  `AppReqType_ID` INT NOT NULL,
  `App_ID` INT NOT NULL,
  `AppReq_Type_Cd` VARCHAR(45) NOT NULL,
  `AppReq_Type_Desc` VARCHAR(255) NULL,
  PRIMARY KEY (`AppReqType_ID`, `App_ID`),
  INDEX `fk_ApplicationRuleTyoe_Application1_idx` (`App_ID` ASC),
  CONSTRAINT `fk_ApplicationRuleTyoe_Application1`
    FOREIGN KEY (`App_ID`)
    REFERENCES `mydb`.`Application` (`App_ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = cp850
COMMENT = 'Rule type cane be 1. Business Rule 2. Screen Level rules 3. Text Box 4. Drop Down etc';


-- -----------------------------------------------------
-- Table `mydb`.`Requirement`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Requirement` (
  `Requirement_id` INT NOT NULL,
  `App_ID` INT NOT NULL,
  `AppRuleType_ID` INT NOT NULL,
  PRIMARY KEY (`Requirement_id`, `App_ID`, `AppRuleType_ID`),
  INDEX `fk_Requirement_Application1_idx` (`App_ID` ASC),
  INDEX `fk_Requirement_ApplicationRuleType1_idx` (`AppRuleType_ID` ASC),
  CONSTRAINT `fk_Requirement_Application1`
    FOREIGN KEY (`App_ID`)
    REFERENCES `mydb`.`Application` (`App_ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Requirement_ApplicationRuleType1`
    FOREIGN KEY (`AppRuleType_ID`)
    REFERENCES `mydb`.`AppReqType` (`AppReqType_ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Reqiuremnet_rulesgroup`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Reqiuremnet_rulesgroup` (
  `RulesGroup_ID` INT NOT NULL,
  `App_ID` INT NOT NULL,
  `Requirement_id` INT NOT NULL,
  PRIMARY KEY (`RulesGroup_ID`, `App_ID`, `Requirement_id`),
  INDEX `fk_Reqiuremnet_rulesgroup_RulesGroup1_idx` (`RulesGroup_ID` ASC, `App_ID` ASC),
  INDEX `fk_Reqiuremnet_rulesgroup_Requirement1_idx` (`Requirement_id` ASC),
  CONSTRAINT `fk_Reqiuremnet_rulesgroup_RulesGroup1`
    FOREIGN KEY (`RulesGroup_ID` , `App_ID`)
    REFERENCES `mydb`.`RequirementGroup` (`ReqGroup_ID` , `App_ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Reqiuremnet_rulesgroup_Requirement1`
    FOREIGN KEY (`Requirement_id`)
    REFERENCES `mydb`.`Requirement` (`Requirement_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`attachment`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`attachment` (
  `Attachment_id` INT NOT NULL AUTO_INCREMENT,
  `Attachment_name` VARCHAR(255) NULL,
  `attachment_type` VARCHAR(45) NULL,
  `Requirement_id` INT NOT NULL,
  `App_ID` INT NOT NULL,
  PRIMARY KEY (`Attachment_id`, `Requirement_id`, `App_ID`),
  INDEX `fk_attachment_Requirement1_idx` (`Requirement_id` ASC, `App_ID` ASC),
  CONSTRAINT `fk_attachment_Requirement1`
    FOREIGN KEY (`Requirement_id` , `App_ID`)
    REFERENCES `mydb`.`Requirement` (`Requirement_id` , `App_ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Code_Value`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Code_Value` (
  `Code_Value_Group` VARCHAR(12) NOT NULL,
  `Code_Value_Dec` VARCHAR(45) NOT NULL,
  `Code_Value_Cd` VARCHAR(12) NOT NULL,
  PRIMARY KEY (`Code_Value_Group`, `Code_Value_Cd`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Literal`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Literal` (
  `Literal_ID` INT NOT NULL,
  `App_ID` INT NOT NULL,
  `Literal_cd` VARCHAR(45) NULL,
  `Literal_Locale` VARCHAR(45) NULL COMMENT '\n\n\n',
  `Literal_text` VARCHAR(512) NULL,
  PRIMARY KEY (`Literal_ID`, `App_ID`),
  INDEX `fk_Literal_Application1_idx` (`App_ID` ASC),
  CONSTRAINT `fk_Literal_Application1`
    FOREIGN KEY (`App_ID`)
    REFERENCES `mydb`.`Application` (`App_ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
COMMENT = 'Table will store text literals like headers, messages etc. Literal_Cd + Locale should be unique for an application';


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
