﻿-- MySQL Script generated by MySQL Workbench
-- Wed May 20 16:51:05 2020
-- Model: New Model    Version: 1.0
-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
DROP SCHEMA IF EXISTS `mydb` ;

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `mydb` DEFAULT CHARACTER SET utf8 ;
-- -----------------------------------------------------
-- Schema idtech
-- -----------------------------------------------------
DROP SCHEMA IF EXISTS `idtech` ;

-- -----------------------------------------------------
-- Schema idtech
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `idtech` DEFAULT CHARACTER SET utf8 ;
USE `mydb` ;

-- -----------------------------------------------------
-- Table `mydb`.`Tasks`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`Tasks` ;

CREATE TABLE IF NOT EXISTS `mydb`.`Tasks` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `title` VARCHAR(45) NOT NULL,
  `done` TINYINT NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `id_UNIQUE` (`id` ASC))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Users`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`Users` ;

CREATE TABLE IF NOT EXISTS `mydb`.`Users` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NOT NULL,
  `password` VARCHAR(45) NOT NULL,
  `email` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `id_UNIQUE` (`id` ASC),
  UNIQUE INDEX `email_UNIQUE` (`email` ASC))
ENGINE = InnoDB;

USE `idtech` ;

-- -----------------------------------------------------
-- Table `idtech`.`area`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `idtech`.`area` ;

CREATE TABLE IF NOT EXISTS `idtech`.`area` (
  `id_area` INT NOT NULL AUTO_INCREMENT,
  `nome_area` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id_area`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `idtech`.`tipo_projeto`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `idtech`.`tipo_projeto` ;

CREATE TABLE IF NOT EXISTS `idtech`.`tipo_projeto` (
  `id_tipo_projeto` INT NOT NULL AUTO_INCREMENT,
  `nome_tipo_projeto` VARCHAR(100) NOT NULL,
  `pontos_tipo_projeto` FLOAT NOT NULL,
  PRIMARY KEY (`id_tipo_projeto`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `idtech`.`achievement`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `idtech`.`achievement` ;

CREATE TABLE IF NOT EXISTS `idtech`.`achievement` (
  `id_achievement` INT NOT NULL AUTO_INCREMENT,
  `id_area` INT NOT NULL,
  `nome_achievement` VARCHAR(90) NOT NULL,
  `descricao_achievement` VARCHAR(250) NOT NULL,
  `criterio_achievement` INT NOT NULL,
  `id_tipo_projeto_achievement` INT NOT NULL,
  PRIMARY KEY (`id_achievement`),
  INDEX `id_area_achievement` (`id_area` ASC),
  INDEX `id_tipo_projeto_achievement_idx` (`id_tipo_projeto_achievement` ASC),
  CONSTRAINT `id_area_achievement`
    FOREIGN KEY (`id_area`)
    REFERENCES `idtech`.`area` (`id_area`),
  CONSTRAINT `id_tipo_projeto_achievement`
    FOREIGN KEY (`id_tipo_projeto_achievement`)
    REFERENCES `idtech`.`tipo_projeto` (`id_tipo_projeto`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `idtech`.`curso`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `idtech`.`curso` ;

CREATE TABLE IF NOT EXISTS `idtech`.`curso` (
  `id_curso` INT NOT NULL AUTO_INCREMENT,
  `nome_curso` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id_curso`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `idtech`.`usuario`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `idtech`.`usuario` ;

CREATE TABLE IF NOT EXISTS `idtech`.`usuario` (
  `ra_usuario` BIGINT NOT NULL,
  `id_curso` INT NOT NULL,
  `nome_usuario` VARCHAR(90) NOT NULL,
  `email_usuario` VARCHAR(60) NOT NULL,
  `moedas_usuario` FLOAT NOT NULL,
  `dt_entrada_usuario` DATE NOT NULL,
  `senha_usuario` VARCHAR(250) NOT NULL,
  `isAdmin` TINYINT NOT NULL,
  PRIMARY KEY (`ra_usuario`),
  UNIQUE INDEX `ra_usuario` (`ra_usuario` ASC),
  INDEX `id_curso_usuario` (`id_curso` ASC),
  CONSTRAINT `id_curso_usuario`
    FOREIGN KEY (`id_curso`)
    REFERENCES `idtech`.`curso` (`id_curso`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `idtech`.`achievement_usuario`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `idtech`.`achievement_usuario` ;

CREATE TABLE IF NOT EXISTS `idtech`.`achievement_usuario` (
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
    REFERENCES `idtech`.`achievement` (`id_achievement`),
  CONSTRAINT `ra_usuario_achievement`
    FOREIGN KEY (`ra_usuario`)
    REFERENCES `idtech`.`usuario` (`ra_usuario`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `idtech`.`pais`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `idtech`.`pais` ;

CREATE TABLE IF NOT EXISTS `idtech`.`pais` (
  `id_pais` INT NOT NULL AUTO_INCREMENT,
  `nome_pais` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id_pais`),
  UNIQUE INDEX `id_cidade_UNIQUE` (`id_pais` ASC))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `idtech`.`estado`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `idtech`.`estado` ;

CREATE TABLE IF NOT EXISTS `idtech`.`estado` (
  `id_estado` INT NOT NULL AUTO_INCREMENT,
  `nome_estado` VARCHAR(45) NOT NULL,
  `id_pais_estado` INT NOT NULL,
  PRIMARY KEY (`id_estado`),
  UNIQUE INDEX `id_cidade_UNIQUE` (`id_estado` ASC),
  INDEX `id_pais_estado_idx` (`id_pais_estado` ASC),
  CONSTRAINT `id_pais_estado`
    FOREIGN KEY (`id_pais_estado`)
    REFERENCES `idtech`.`pais` (`id_pais`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `idtech`.`cidade`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `idtech`.`cidade` ;

CREATE TABLE IF NOT EXISTS `idtech`.`cidade` (
  `id_cidade` INT NOT NULL AUTO_INCREMENT,
  `nome_cidade` VARCHAR(45) NOT NULL,
  `id_estado_cidade` INT NOT NULL,
  PRIMARY KEY (`id_cidade`),
  UNIQUE INDEX `id_cidade_UNIQUE` (`id_cidade` ASC),
  INDEX `id_estado_cidade_idx` (`id_estado_cidade` ASC),
  CONSTRAINT `id_estado_cidade`
    FOREIGN KEY (`id_estado_cidade`)
    REFERENCES `idtech`.`estado` (`id_estado`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `idtech`.`endereco`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `idtech`.`endereco` ;

CREATE TABLE IF NOT EXISTS `idtech`.`endereco` (
  `id_endereco` INT NOT NULL AUTO_INCREMENT,
  `logradouro_endereco` VARCHAR(100) NOT NULL,
  `numero_endereco` INT NOT NULL,
  `complemento_endereco` VARCHAR(45) NULL DEFAULT NULL,
  `id_cidade_endereco` INT NOT NULL,
  PRIMARY KEY (`id_endereco`),
  UNIQUE INDEX `id_endereco_UNIQUE` (`id_endereco` ASC),
  INDEX `id_cidade_endereco_idx` (`id_cidade_endereco` ASC),
  CONSTRAINT `id_cidade_endereco`
    FOREIGN KEY (`id_cidade_endereco`)
    REFERENCES `idtech`.`cidade` (`id_cidade`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `idtech`.`nacionalidade`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `idtech`.`nacionalidade` ;

CREATE TABLE IF NOT EXISTS `idtech`.`nacionalidade` (
  `id_nacionalidade` INT NOT NULL AUTO_INCREMENT,
  `nome_nacionalidade` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id_nacionalidade`),
  UNIQUE INDEX `id_nacionalidade_UNIQUE` (`id_nacionalidade` ASC))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `idtech`.`dados_curriculo`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `idtech`.`dados_curriculo` ;

CREATE TABLE IF NOT EXISTS `idtech`.`dados_curriculo` (
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
  CONSTRAINT `endereco_dados_curriculo`
    FOREIGN KEY (`endereco_dados_curriculo`)
    REFERENCES `idtech`.`endereco` (`id_endereco`),
  CONSTRAINT `nacionalidade_dados_curriculo`
    FOREIGN KEY (`nacionalidade_dados_curriculo`)
    REFERENCES `idtech`.`nacionalidade` (`id_nacionalidade`),
  CONSTRAINT `ra_usuario`
    FOREIGN KEY (`ra_usuario`)
    REFERENCES `idtech`.`usuario` (`id_curso`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `idtech`.`tipo_habilidade`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `idtech`.`tipo_habilidade` ;

CREATE TABLE IF NOT EXISTS `idtech`.`tipo_habilidade` (
  `id_tipo_habilidade` INT NOT NULL AUTO_INCREMENT,
  `nome_tipo_habilidade` VARCHAR(100) NOT NULL,
  PRIMARY KEY (`id_tipo_habilidade`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `idtech`.`habilidade`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `idtech`.`habilidade` ;

CREATE TABLE IF NOT EXISTS `idtech`.`habilidade` (
  `id_habilidade` BIGINT NOT NULL AUTO_INCREMENT,
  `nome_habilidade` VARCHAR(100) NOT NULL,
  `ra_usuario` BIGINT NOT NULL,
  `id_tipo_habilidade` INT NOT NULL,
  PRIMARY KEY (`id_habilidade`),
  INDEX `ra_usuario_habilidade` (`ra_usuario` ASC),
  INDEX `id_tipo_habilidade_habilidade` (`id_tipo_habilidade` ASC),
  CONSTRAINT `id_tipo_habilidade_habilidade`
    FOREIGN KEY (`id_tipo_habilidade`)
    REFERENCES `idtech`.`tipo_habilidade` (`id_tipo_habilidade`),
  CONSTRAINT `ra_usuario_habilidade`
    FOREIGN KEY (`ra_usuario`)
    REFERENCES `idtech`.`usuario` (`ra_usuario`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `idtech`.`item`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `idtech`.`item` ;

CREATE TABLE IF NOT EXISTS `idtech`.`item` (
  `id_item` INT NOT NULL AUTO_INCREMENT,
  `nome_item` VARCHAR(45) NOT NULL,
  `img_url_item` VARCHAR(250) NOT NULL,
  `preco_item` FLOAT NOT NULL,
  `id_area` INT NOT NULL,
  PRIMARY KEY (`id_item`),
  UNIQUE INDEX `img_url_item` (`img_url_item` ASC),
  INDEX `id_area_item_idx` (`id_area` ASC),
  CONSTRAINT `id_area_item`
    FOREIGN KEY (`id_area`)
    REFERENCES `idtech`.`area` (`id_area`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `idtech`.`item_usuario`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `idtech`.`item_usuario` ;

CREATE TABLE IF NOT EXISTS `idtech`.`item_usuario` (
  `id_item_usuario` INT NOT NULL AUTO_INCREMENT,
  `ra_usuario` BIGINT NOT NULL,
  `id_item` INT NOT NULL,
  `dt_item` DATE NOT NULL,
  `cellx_item` FLOAT NULL DEFAULT NULL,
  `celly_item` FLOAT NULL DEFAULT NULL,
  `width` FLOAT NOT NULL,
  `height` FLOAT NOT NULL,
  `positioned_item` TINYINT NOT NULL,
  PRIMARY KEY (`id_item_usuario`),
  INDEX `ra_usuario_item_usuario` (`ra_usuario` ASC),
  INDEX `id_item_item_usuario` (`id_item` ASC),
  CONSTRAINT `id_item_item_usuario`
    FOREIGN KEY (`id_item`)
    REFERENCES `idtech`.`item` (`id_item`),
  CONSTRAINT `ra_usuario_item_usuario`
    FOREIGN KEY (`ra_usuario`)
    REFERENCES `idtech`.`usuario` (`ra_usuario`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `idtech`.`projeto`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `idtech`.`projeto` ;

CREATE TABLE IF NOT EXISTS `idtech`.`projeto` (
  `id_projeto` BIGINT NOT NULL AUTO_INCREMENT,
  `id_tipo_projeto` INT NOT NULL,
  `ra_usuario` BIGINT NOT NULL,
  `id_area` INT NOT NULL,
  `dt_comeco_projeto` DATE NOT NULL,
  `terminado_projeto` TINYINT NOT NULL,
  `nome_projeto` VARCHAR(150) NOT NULL,
  `descricao_projeto` VARCHAR(250) NOT NULL,
  `dt_termino_projeto` DATE NULL DEFAULT NULL,
  `exibir_projeto` TINYINT NOT NULL DEFAULT '0',
  PRIMARY KEY (`id_projeto`),
  INDEX `Projeto_fk0` (`id_tipo_projeto` ASC),
  INDEX `Projeto_fk1` (`ra_usuario` ASC),
  INDEX `Projeto_fk2` (`id_area` ASC),
  CONSTRAINT `Projeto_fk0`
    FOREIGN KEY (`id_tipo_projeto`)
    REFERENCES `idtech`.`tipo_projeto` (`id_tipo_projeto`),
  CONSTRAINT `Projeto_fk1`
    FOREIGN KEY (`ra_usuario`)
    REFERENCES `idtech`.`usuario` (`ra_usuario`),
  CONSTRAINT `Projeto_fk2`
    FOREIGN KEY (`id_area`)
    REFERENCES `idtech`.`area` (`id_area`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `idtech`.`noticia`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `idtech`.`noticia` ;

CREATE TABLE IF NOT EXISTS `idtech`.`noticia` (
  `id_noticia` INT NOT NULL AUTO_INCREMENT,
  `chamada_noticia` VARCHAR(45) NOT NULL,
  `corpo_noticia` VARCHAR(500) NOT NULL,
  `imagem_noticia_url` VARCHAR(45),
  `data_publicacao` DATE NOT NULL,
  `ra_usuario` BIGINT NOT NULL,
  PRIMARY KEY (`id_noticia`),
  UNIQUE INDEX `id_noticia_UNIQUE` (`id_noticia` ASC),
  CONSTRAINT `ra_usuario_noticia`
    FOREIGN KEY (`ra_usuario`)
    REFERENCES `idtech`.`usuario` (`ra_usuario`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
