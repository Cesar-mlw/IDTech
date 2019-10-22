﻿-- MySQL Script generated by MySQL Workbench
-- Tue Oct  8 18:55:20 2019
-- Model: New Model    Version: 1.0
-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema idtech
-- -----------------------------------------------------
DROP SCHEMA IF EXISTS `idtech` ;

-- -----------------------------------------------------
-- Schema idtech
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `idtech` DEFAULT CHARACTER SET utf8 ;
USE `idtech` ;

-- -----------------------------------------------------
-- Table `idtech`.`Curso`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `idtech`.`Curso` ;

CREATE TABLE IF NOT EXISTS `idtech`.`Curso` (
  `id_curso` INT NOT NULL AUTO_INCREMENT,
  `nome_curso` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id_curso`));


-- -----------------------------------------------------
-- Table `idtech`.`Usuario`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `idtech`.`Usuario` ;

CREATE TABLE IF NOT EXISTS `idtech`.`Usuario` (
  `ra_usuario` BIGINT NOT NULL,
  `id_curso` INT NOT NULL,
  `nome_usuario` VARCHAR(90) NOT NULL,
  `email_usuario` VARCHAR(60) NOT NULL,
  `pontos_totais` FLOAT NULL DEFAULT NULL,
  `dt_entrada_usuario` DATE NOT NULL,
  `senha_usuario` VARCHAR(250) NOT NULL,
  `isAdmin` TINYINT NOT NULL,
  UNIQUE INDEX (`ra_usuario` ASC),
  PRIMARY KEY (`ra_usuario`),
  INDEX `id_curso_usuario` (`id_curso` ASC),
  CONSTRAINT `id_curso_usuario`
    FOREIGN KEY (`id_curso`)
    REFERENCES `idtech`.`Curso` (`id_curso`));


-- -----------------------------------------------------
-- Table `idtech`.`Tipo_Projeto`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `idtech`.`Tipo_Projeto` ;

CREATE TABLE IF NOT EXISTS `idtech`.`Tipo_Projeto` (
  `id_tipo_projeto` INT NOT NULL AUTO_INCREMENT,
  `nome_tipo_projeto` VARCHAR(100) NOT NULL,
  `pontos_tipo_projeto` FLOAT NOT NULL,
  PRIMARY KEY (`id_tipo_projeto`));


-- -----------------------------------------------------
-- Table `idtech`.`Area`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `idtech`.`Area` ;

CREATE TABLE IF NOT EXISTS `idtech`.`Area` (
  `id_area` INT NOT NULL AUTO_INCREMENT,
  `nome_area` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id_area`));


-- -----------------------------------------------------
-- Table `idtech`.`Projeto`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `idtech`.`Projeto` ;

CREATE TABLE IF NOT EXISTS `idtech`.`Projeto` (
  `id_projeto` BIGINT NOT NULL AUTO_INCREMENT,
  `id_tipo_projeto` INT NOT NULL,
  `ra_usuario` BIGINT NOT NULL,
  `id_area` INT NOT NULL,
  `dt_comeco_projeto` DATE NOT NULL,
  `terminado_projeto` TINYINT NOT NULL,
  `nome_projeto` VARCHAR(150) NOT NULL,
  `descricao_projeto` VARCHAR(250) NOT NULL,
  `dt_termino_projeto` DATE NULL DEFAULT NULL,
  PRIMARY KEY (`id_projeto`),
  INDEX `Projeto_fk0` (`id_tipo_projeto` ASC),
  INDEX `Projeto_fk1` (`ra_usuario` ASC),
  INDEX `Projeto_fk2` (`id_area` ASC),
  CONSTRAINT `Projeto_fk0`
    FOREIGN KEY (`id_tipo_projeto`)
    REFERENCES `idtech`.`Tipo_Projeto` (`id_tipo_projeto`),
  CONSTRAINT `Projeto_fk1`
    FOREIGN KEY (`ra_usuario`)
    REFERENCES `idtech`.`Usuario` (`ra_usuario`),
  CONSTRAINT `Projeto_fk2`
    FOREIGN KEY (`id_area`)
    REFERENCES `idtech`.`Area` (`id_area`));


-- -----------------------------------------------------
-- Table `idtech`.`Item`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `idtech`.`Item` ;

CREATE TABLE IF NOT EXISTS `idtech`.`Item` (
  `id_item` INT NOT NULL AUTO_INCREMENT,
  `nome_item` VARCHAR(45) NOT NULL,
  `img_url_item` VARCHAR(150) NOT NULL,
  UNIQUE INDEX (`img_url_item` ASC),
  PRIMARY KEY (`id_item`));


-- -----------------------------------------------------
-- Table `idtech`.`Item_Usuario`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `idtech`.`Item_Usuario` ;

CREATE TABLE IF NOT EXISTS `idtech`.`Item_Usuario` (
  `id_item_usuario` INT NOT NULL AUTO_INCREMENT,
  `ra_usuario` BIGINT NOT NULL,
  `id_item` INT NOT NULL,
  `dt_item` DATE NOT NULL,
  PRIMARY KEY (`id_item_usuario`),
  INDEX `ra_usuario_item_usuario` (`ra_usuario` ASC),
  INDEX `id_item_item_usuario` (`id_item` ASC),
  CONSTRAINT `ra_usuario_item_usuario`
    FOREIGN KEY (`ra_usuario`)
    REFERENCES `idtech`.`Usuario` (`ra_usuario`),
  CONSTRAINT `id_item_item_usuario`
    FOREIGN KEY (`id_item`)
    REFERENCES `idtech`.`Item` (`id_item`));


-- -----------------------------------------------------
-- Table `idtech`.`Tipo_Habilidade`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `idtech`.`Tipo_Habilidade` ;

CREATE TABLE IF NOT EXISTS `idtech`.`Tipo_Habilidade` (
  `id_tipo_habilidade` INT NOT NULL AUTO_INCREMENT,
  `nome_tipo_habilidade` VARCHAR(100) NOT NULL,
  PRIMARY KEY (`id_tipo_habilidade`));


-- -----------------------------------------------------
-- Table `idtech`.`Habilidade`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `idtech`.`Habilidade` ;

CREATE TABLE IF NOT EXISTS `idtech`.`Habilidade` (
  `id_habilidade` BIGINT NOT NULL AUTO_INCREMENT,
  `nome_habilidade` VARCHAR(100) NOT NULL,
  `ra_usuario` BIGINT NOT NULL,
  `id_tipo_habilidade` INT NOT NULL,
  PRIMARY KEY (`id_habilidade`),
  INDEX `ra_usuario_habilidade` (`ra_usuario` ASC),
  INDEX `id_tipo_habilidade_habilidade` (`id_tipo_habilidade` ASC),
  CONSTRAINT `ra_usuario_habilidade`
    FOREIGN KEY (`ra_usuario`)
    REFERENCES `idtech`.`Usuario` (`ra_usuario`),
  CONSTRAINT `id_tipo_habilidade_habilidade`
    FOREIGN KEY (`id_tipo_habilidade`)
    REFERENCES `idtech`.`Tipo_Habilidade` (`id_tipo_habilidade`));


-- -----------------------------------------------------
-- Table `idtech`.`Achievement`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `idtech`.`Achievement` ;

CREATE TABLE IF NOT EXISTS `idtech`.`Achievement` (
  `id_achievement` INT NOT NULL AUTO_INCREMENT,
  `id_area` INT NOT NULL,
  `nome_achievement` VARCHAR(90) NOT NULL,
  `descricao_achievement` VARCHAR(250) NOT NULL,
  `criterio_achievement` VARCHAR(100) NOT NULL,
  PRIMARY KEY (`id_achievement`),
  INDEX `id_area_achievement` (`id_area` ASC),
  CONSTRAINT `id_area_achievement`
    FOREIGN KEY (`id_area`)
    REFERENCES `idtech`.`Area` (`id_area`));


-- -----------------------------------------------------
-- Table `idtech`.`Achievement_Usuario`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `idtech`.`Achievement_Usuario` ;

CREATE TABLE IF NOT EXISTS `idtech`.`Achievement_Usuario` (
  `id_achievement_usuario` INT NOT NULL AUTO_INCREMENT,
  `id_achievement` INT NOT NULL,
  `ra_usuario` BIGINT NOT NULL,
  `destaque_achievement` TINYINT NOT NULL,
  `dt_achievement` DATE NOT NULL,
  PRIMARY KEY (`id_achievement_usuario`),
  INDEX `id_achievement_achievement_usuario` (`id_achievement` ASC),
  INDEX `ra_usuario_achievement` (`ra_usuario` ASC),
  CONSTRAINT `id_achievement_achievement_usuario`
    FOREIGN KEY (`id_achievement`)
    REFERENCES `idtech`.`Achievement` (`id_achievement`),
  CONSTRAINT `ra_usuario_achievement`
    FOREIGN KEY (`ra_usuario`)
    REFERENCES `idtech`.`Usuario` (`ra_usuario`));


-- -----------------------------------------------------
-- Table `idtech`.`Nacionalidade`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `idtech`.`Nacionalidade` ;

CREATE TABLE IF NOT EXISTS `idtech`.`Nacionalidade` (
  `id_nacionalidade` INT NOT NULL AUTO_INCREMENT,
  `nome_nacionalidade` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id_nacionalidade`),
  UNIQUE INDEX `id_nacionalidade_UNIQUE` (`id_nacionalidade` ASC))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `idtech`.`Pais`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `idtech`.`Pais` ;

CREATE TABLE IF NOT EXISTS `idtech`.`Pais` (
  `id_pais` INT NOT NULL AUTO_INCREMENT,
  `nome_pais` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id_pais`),
  UNIQUE INDEX `id_cidade_UNIQUE` (`id_pais` ASC))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `idtech`.`Estado`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `idtech`.`Estado` ;

CREATE TABLE IF NOT EXISTS `idtech`.`Estado` (
  `id_estado` INT NOT NULL AUTO_INCREMENT,
  `nome_estado` VARCHAR(45) NOT NULL,
  `id_pais_estado` INT NOT NULL,
  PRIMARY KEY (`id_estado`),
  UNIQUE INDEX `id_cidade_UNIQUE` (`id_estado` ASC),
  INDEX `id_pais_estado_idx` (`id_pais_estado` ASC),
  CONSTRAINT `id_pais_estado`
    FOREIGN KEY (`id_pais_estado`)
    REFERENCES `idtech`.`Pais` (`id_pais`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `idtech`.`Cidade`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `idtech`.`Cidade` ;

CREATE TABLE IF NOT EXISTS `idtech`.`Cidade` (
  `id_cidade` INT NOT NULL AUTO_INCREMENT,
  `nome_cidade` VARCHAR(45) NOT NULL,
  `id_estado_cidade` INT NOT NULL,
  PRIMARY KEY (`id_cidade`),
  UNIQUE INDEX `id_cidade_UNIQUE` (`id_cidade` ASC),
  INDEX `id_estado_cidade_idx` (`id_estado_cidade` ASC),
  CONSTRAINT `id_estado_cidade`
    FOREIGN KEY (`id_estado_cidade`)
    REFERENCES `idtech`.`Estado` (`id_estado`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `idtech`.`Endereco`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `idtech`.`Endereco` ;

CREATE TABLE IF NOT EXISTS `idtech`.`Endereco` (
  `id_endereco` INT NOT NULL AUTO_INCREMENT,
  `logradouro_endereco` VARCHAR(100) NOT NULL,
  `numero_endereco` INT NOT NULL,
  `complemento_endereco` VARCHAR(45) NULL,
  `id_cidade_endereco` INT NOT NULL,
  PRIMARY KEY (`id_endereco`),
  UNIQUE INDEX `id_endereco_UNIQUE` (`id_endereco` ASC),
  INDEX `id_cidade_endereco_idx` (`id_cidade_endereco` ASC),
  CONSTRAINT `id_cidade_endereco`
    FOREIGN KEY (`id_cidade_endereco`)
    REFERENCES `idtech`.`Cidade` (`id_cidade`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `idtech`.`Dados_Curriculo`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `idtech`.`Dados_Curriculo` ;

CREATE TABLE IF NOT EXISTS `idtech`.`Dados_Curriculo` (
  `id_dados_curriculo` INT NOT NULL AUTO_INCREMENT,
  `nome_completo_dados_curriculo` VARCHAR(85) NOT NULL,
  `nacionalidade_dados_curriculo` INT NOT NULL,
  `endereco_dados_curriculo` INT NOT NULL,
  `email_dados_curriculo` INT NOT NULL,
  `telefone_dados_curriculo` VARCHAR(75) NOT NULL,
  `sinopse_dados_curriculo` VARCHAR(255) NOT NULL,
  `ra_usuario` INT NOT NULL,
  PRIMARY KEY (`id_dados_curriculo`),
  UNIQUE INDEX `id_dados_curriculos_UNIQUE` (`id_dados_curriculo` ASC),
  INDEX `ra_usuario_idx` (`ra_usuario` ASC),
  INDEX `nacionalidade_dados_curriculo_idx` (`nacionalidade_dados_curriculo` ASC),
  INDEX `endereco_dados_curriculo_idx` (`endereco_dados_curriculo` ASC),
  CONSTRAINT `ra_usuario`
    FOREIGN KEY (`ra_usuario`)
    REFERENCES `idtech`.`Usuario` (`id_curso`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `nacionalidade_dados_curriculo`
    FOREIGN KEY (`nacionalidade_dados_curriculo`)
    REFERENCES `idtech`.`Nacionalidade` (`id_nacionalidade`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `endereco_dados_curriculo`
    FOREIGN KEY (`endereco_dados_curriculo`)
    REFERENCES `idtech`.`Endereco` (`id_endereco`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
