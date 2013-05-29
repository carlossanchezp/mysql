SET FOREIGN_KEY_CHECKS=0;

SET SQL_MODE="NO_AUTO_VALUE_ON_ZERO";

SET AUTOCOMMIT=0;
START TRANSACTION;

CREATE DATABASE  `pruebas` ;

USE `pruebas` ;

CREATE TABLE  `usuarios` (
 `IDUsuario` INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY ,
 `Nick` VARCHAR( 20 ) NOT NULL ,
 `Nombre` VARCHAR( 30 ) NULL DEFAULT NULL ,
 `Apellidos` VARCHAR( 60 ) NULL DEFAULT NULL ,
 `FechaNacimiento` DATE NULL DEFAULT NULL ,
UNIQUE (
`Nick`
)
) ENGINE = INNODB;

CREATE TABLE `comentarios` (
  `IDComentario` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `IDUsuario` int(10) unsigned NOT NULL,
  `Titulo` varchar(150) NOT NULL,
  `Comentario` text,
  PRIMARY KEY (`IDComentario`),
  KEY `IDUsuario` (`IDUsuario`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

ALTER TABLE `comentarios`  ADD CONSTRAINT `comentarios_ibfk_1` FOREIGN KEY (`IDUsuario`) REFERENCES `usuarios` (`IDUsuario`) ON DELETE CASCADE ON UPDATE CASCADE;

INSERT INTO `usuarios` (`IDUsuario`, `Nick`, `Nombre`, `Apellidos`, `FechaNacimiento`) VALUES 
(1, 'emacs', 'Pepe', 'González', NULL),
(2, 'rasputin', 'Adolfo', NULL, '1991-10-08'),
(3, 'torpedo', NULL, NULL, NULL),
(4, 'lucas', 'Lucas', 'Grijander', '1980-08-18');

INSERT INTO `comentarios` (`IDComentario`, `IDUsuario`, `Titulo`, `Comentario`) VALUES 
(1, 1, 'Comentario 1', 'Comentario 1'),
(2, 1, 'Comentario 2', NULL),
(3, 3, 'Comentario 3', 'Comentario 3'),
(4, 4, 'Comentario 4', 'Comentario 4');

SET FOREIGN_KEY_CHECKS=1;

COMMIT;