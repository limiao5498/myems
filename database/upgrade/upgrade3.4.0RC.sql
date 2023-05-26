-- ---------------------------------------------------------------------------------------------------------------------
-- WARNING: BACKUP YOUR DATABASE BEFORE UPGRADING
-- THIS SCRIPT IS ONLY FOR UPGRADING 3.3.0 TO 3.4.0RC
-- THE CURRENT VERSION CAN BE FOUND AT `myems_system_db`.`tbl_versions`
-- ---------------------------------------------------------------------------------------------------------------------

START TRANSACTION;

-- ---------------------------------------------------------------------------------------------------------------------
-- Table `myems_system_db`.`tbl_commands`
-- ---------------------------------------------------------------------------------------------------------------------
DROP TABLE IF EXISTS `myems_system_db`.`tbl_commands` ;

CREATE TABLE IF NOT EXISTS `myems_system_db`.`tbl_commands` (
  `id` BIGINT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(255) NOT NULL,
  `uuid` CHAR(36) NOT NULL,
  `topic` VARCHAR(255) NOT NULL,
  `payload` LONGTEXT NOT NULL COMMENT 'MUST be in JSON format',
  `set_value` DECIMAL(18, 3) NULL COMMENT 'If not null, the $s1 in payload will be replaced with this value',
  `description` VARCHAR(255) ,
  PRIMARY KEY (`id`));
CREATE INDEX `tbl_commands_index_1` ON  `myems_system_db`.`tbl_commands` (`name`);

-- ---------------------------------------------------------------------------------------------------------------------
-- Table `myems_system_db`.`tbl_microgrids`
-- ---------------------------------------------------------------------------------------------------------------------
DROP TABLE IF EXISTS `myems_system_db`.`tbl_microgrids` ;

CREATE TABLE IF NOT EXISTS `myems_system_db`.`tbl_microgrids` (
  `id` BIGINT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(255) NOT NULL,
  `uuid` CHAR(36) NOT NULL,
  `address` VARCHAR(255) NOT NULL,
  `latitude` DECIMAL(9, 6) NOT NULL,
  `longitude` DECIMAL(9, 6) NOT NULL,
  `capacity` DECIMAL(18, 3) NOT NULL,
  `microgrid_type_id` BIGINT NOT NULL,
  `microgrid_owner_type_id` BIGINT NOT NULL,
  `is_input_counted` BOOL NOT NULL,
  `is_output_counted` BOOL NOT NULL,
  `contact_id` BIGINT NOT NULL,
  `cost_center_id` BIGINT NOT NULL,
  `description` VARCHAR(255),
  PRIMARY KEY (`id`));
CREATE INDEX `tbl_microgrids_index_1` ON  `myems_system_db`.`tbl_microgrids`   (`name`);


-- ---------------------------------------------------------------------------------------------------------------------
-- Table `myems_system_db`.`tbl_microgrid_architecture_types`
-- ---------------------------------------------------------------------------------------------------------------------
DROP TABLE IF EXISTS `myems_system_db`.`tbl_microgrid_architecture_types` ;

CREATE TABLE IF NOT EXISTS `myems_system_db`.`tbl_microgrid_architecture_types` (
  `id` BIGINT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(255) NOT NULL,
  `uuid` CHAR(36) NOT NULL,
  `description` VARCHAR(255) NOT NULL,
  `simplified_code` VARCHAR(255) NOT NULL,
  PRIMARY KEY (`id`));
CREATE INDEX `tbl_microgrid_architecture_types_index_1` ON  `myems_system_db`.`tbl_microgrid_architecture_types`   (`name`);


-- ---------------------------------------------------------------------------------------------------------------------
-- Default data for table `myems_system_db`.`tbl_microgrid_architecture_types`
-- ---------------------------------------------------------------------------------------------------------------------

INSERT INTO `myems_system_db`.`tbl_microgrid_architecture_types`
(`id`, `name`, `uuid`, `description`, `simplified_code`)
VALUES
(1, 'Battery+PV+Load+Grid', '0683741e-df76-4b43-b0c3-4851d20767ca', 'Battery+PV+Load+Grid', 'BPLG'),
(2, 'Battery+Load+Grid', 'b8f0bc44-f9f8-4dfd-9b08-271ee1627a46', 'Battery+Load+Grid', 'BLG'),
(3, 'PV+Load+Grid', 'd067d432-bc04-4184-81a1-df3fb2f30480', 'PV+Load+Grid', 'PLG');

-- ---------------------------------------------------------------------------------------------------------------------
-- Table `myems_system_db`.`tbl_microgrid_owner_types`
-- ---------------------------------------------------------------------------------------------------------------------
DROP TABLE IF EXISTS `myems_system_db`.`tbl_microgrid_owner_types` ;

CREATE TABLE IF NOT EXISTS `myems_system_db`.`tbl_microgrid_owner_types` (
  `id` BIGINT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(255) NOT NULL,
  `uuid` CHAR(36) NOT NULL,
  `description` VARCHAR(255) NOT NULL,
  `simplified_code` VARCHAR(255) NOT NULL,
  PRIMARY KEY (`id`));
CREATE INDEX `tbl_microgrid_owner_types_index_1` ON  `myems_system_db`.`tbl_microgrid_owner_types`   (`name`);

-- ---------------------------------------------------------------------------------------------------------------------
-- Default data for table `myems_system_db`.`tbl_microgrid_owner_types`
-- ---------------------------------------------------------------------------------------------------------------------

INSERT INTO `myems_system_db`.`tbl_microgrid_owner_types`
(`id`, `name`, `uuid`, `description`, `simplified_code`)
VALUES
(1, 'Residential', 'b0b5334a-99a6-4a34-b99f-7c6c6f423c47', 'Residential', 'RES'),
(2, 'Commerical', '0017276e-8541-48fc-ae0a-b04d6c31db2d', 'Commerical', 'COM'),
(3, 'Industrial', 'e99fceda-1b34-4b6a-8bd2-c8532c835322', 'Industry', 'IND');


-- ---------------------------------------------------------------------------------------------------------------------
-- Table `myems_system_db`.`tbl_microgrids_batteries`
-- ---------------------------------------------------------------------------------------------------------------------
DROP TABLE IF EXISTS `myems_system_db`.`tbl_microgrids_batteries` ;

CREATE TABLE IF NOT EXISTS `myems_system_db`.`tbl_microgrids_batteries` (
  `id` BIGINT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(255) NOT NULL,
  `uuid` CHAR(36) NOT NULL,
  `microgrid_id` BIGINT NOT NULL,
  `capacity` DECIMAL(18, 3) NOT NULL,
  PRIMARY KEY (`id`));
CREATE INDEX `tbl_microgrids_batteries_index_1` ON  `myems_system_db`.`tbl_microgrids_batteries`   (`name`);

-- ---------------------------------------------------------------------------------------------------------------------
-- Table `myems_system_db`.`tbl_microgrids_photovoltaics`
-- ---------------------------------------------------------------------------------------------------------------------
DROP TABLE IF EXISTS `myems_system_db`.`tbl_microgrids_photovoltaics` ;

CREATE TABLE IF NOT EXISTS `myems_system_db`.`tbl_microgrids_photovoltaics` (
  `id` BIGINT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(255) NOT NULL,
  `uuid` CHAR(36) NOT NULL,
  `microgrid_id` BIGINT NOT NULL,
  `capacity` DECIMAL(18, 3) NOT NULL,
  PRIMARY KEY (`id`));
CREATE INDEX `tbl_microgrids_photovoltaics_index_1` ON  `myems_system_db`.`tbl_microgrids_photovoltaics`   (`name`);

-- ---------------------------------------------------------------------------------------------------------------------
-- Table `myems_system_db`.`tbl_microgrids_sensors`
-- ---------------------------------------------------------------------------------------------------------------------
DROP TABLE IF EXISTS `myems_system_db`.`tbl_microgrids_sensors` ;

CREATE TABLE IF NOT EXISTS `myems_system_db`.`tbl_microgrids_sensors` (
  `id` BIGINT NOT NULL AUTO_INCREMENT,
  `microgrid_id` BIGINT NOT NULL,
  `sensor_id` BIGINT NOT NULL,
  PRIMARY KEY (`id`));
CREATE INDEX `tbl_microgrids_sensors_index_1` ON  `myems_system_db`.`tbl_microgrids_sensors`   (`microgrid_id`);

-- UPDATE VERSION NUMBER
UPDATE `myems_system_db`.`tbl_versions` SET version='3.4.0RC', release_date='2023-06-16' WHERE id=1;

COMMIT;