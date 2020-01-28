-- MySQL dump 10.13  Distrib 5.7.28, for Linux (x86_64)
--
-- Host: 167.71.191.60    Database: compromiso_escolar
-- ------------------------------------------------------
-- Server version	5.7.28-0ubuntu0.18.04.4

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `ce_comuna`
--

DROP TABLE IF EXISTS `ce_comuna`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ce_comuna` (
  `id_ce_comuna` int(11) NOT NULL AUTO_INCREMENT,
  `ce_region_id_ce_region` int(11) NOT NULL,
  `ce_region_ce_pais_id_ce_pais` int(11) NOT NULL,
  PRIMARY KEY (`id_ce_comuna`),
  KEY `fk_ce_comuna_ce_region1_idx` (`ce_region_id_ce_region`,`ce_region_ce_pais_id_ce_pais`),
  CONSTRAINT `fk_ce_comuna_ce_region1` FOREIGN KEY (`ce_region_id_ce_region`, `ce_region_ce_pais_id_ce_pais`) REFERENCES `ce_region` (`id_ce_region`, `ce_pais_id_ce_pais`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `ce_curso`
--

DROP TABLE IF EXISTS `ce_curso`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ce_curso` (
  `id_ce_curso` int(11) NOT NULL AUTO_INCREMENT,
  `ce_curso_nombre` varchar(45) DEFAULT NULL,
  `ce_fk_establecimiento` int(11) DEFAULT NULL,
  `ce_docente_id_ce_docente` int(11) DEFAULT NULL,
  `ce_fk_nivel` int(11) DEFAULT NULL,
  PRIMARY KEY (`id_ce_curso`),
  KEY `fk_ce_curso_ce_docente1_idx` (`ce_docente_id_ce_docente`),
  KEY `nivel_fk` (`ce_fk_nivel`),
  KEY `establecimiento` (`ce_fk_establecimiento`),
  CONSTRAINT `establecimiento` FOREIGN KEY (`ce_fk_establecimiento`) REFERENCES `ce_establecimiento` (`id_ce_establecimiento`),
  CONSTRAINT `nivel_fk` FOREIGN KEY (`ce_fk_nivel`) REFERENCES `ce_niveles` (`ce_id_niveles`)
) ENGINE=InnoDB AUTO_INCREMENT=170 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `ce_dimension`
--

DROP TABLE IF EXISTS `ce_dimension`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ce_dimension` (
  `di_id` int(11) NOT NULL AUTO_INCREMENT,
  `di_nombre` varchar(20) NOT NULL,
  `di_codigo` varchar(5) NOT NULL,
  PRIMARY KEY (`di_id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `ce_doc_documentos`
--

DROP TABLE IF EXISTS `ce_doc_documentos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ce_doc_documentos` (
  `doc_id` int(11) NOT NULL AUTO_INCREMENT,
  `doc_nombre` varchar(255) COLLATE utf8_spanish2_ci NOT NULL,
  `doc_ruta` varchar(50) COLLATE utf8_spanish2_ci NOT NULL,
  `doc_ruta_imagen_tipo` varchar(50) COLLATE utf8_spanish2_ci NOT NULL,
  `doc_extension` varchar(20) COLLATE utf8_spanish2_ci NOT NULL,
  `doc_id_seccion` int(11) NOT NULL,
  `id_tipo_talleres` int(11) DEFAULT NULL,
  PRIMARY KEY (`doc_id`),
  KEY `doc_id_seccion` (`doc_id_seccion`),
  KEY `fk_tipo_talleres` (`id_tipo_talleres`),
  CONSTRAINT `ce_doc_documentos_ibfk_1` FOREIGN KEY (`doc_id_seccion`) REFERENCES `ce_sec_seccion` (`sec_id`),
  CONSTRAINT `fk_tipo_talleres` FOREIGN KEY (`id_tipo_talleres`) REFERENCES `tipo_talleres` (`id_tip_taller`)
) ENGINE=InnoDB AUTO_INCREMENT=20 DEFAULT CHARSET=utf8 COLLATE=utf8_spanish2_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `ce_docente`
--

DROP TABLE IF EXISTS `ce_docente`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ce_docente` (
  `id_ce_docente` int(11) NOT NULL AUTO_INCREMENT,
  `ce_docente_nombres` varchar(75) NOT NULL,
  `ce_docente_apellidos` varchar(75) NOT NULL,
  `ce_docente_run` varchar(15) NOT NULL,
  `ce_docente_email` varchar(75) DEFAULT NULL,
  `ce_establecimiento_id_ce_establecimiento` int(11) DEFAULT NULL,
  PRIMARY KEY (`id_ce_docente`),
  KEY `fk_ce_docente_ce_establecimiento1_idx` (`ce_establecimiento_id_ce_establecimiento`)
) ENGINE=InnoDB AUTO_INCREMENT=302 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `ce_encuesta_preguntas_grupo`
--

DROP TABLE IF EXISTS `ce_encuesta_preguntas_grupo`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ce_encuesta_preguntas_grupo` (
  `id_ce_encuesta_preguntas` int(11) NOT NULL,
  `ce_grupos_id_ce_grupos` int(11) NOT NULL,
  `ce_preguntas_id_ce_preguntas` int(11) NOT NULL,
  `ce_encuestas_id_ce_encuestas` int(11) NOT NULL,
  PRIMARY KEY (`id_ce_encuesta_preguntas`),
  KEY `fk_ce_encuesta_preguntas_ce_grupos1_idx` (`ce_grupos_id_ce_grupos`),
  KEY `fk_ce_encuesta_preguntas_ce_preguntas1_idx` (`ce_preguntas_id_ce_preguntas`),
  KEY `fk_ce_encuesta_preguntas_ce_encuestas1_idx` (`ce_encuestas_id_ce_encuestas`),
  CONSTRAINT `fk_ce_encuesta_preguntas_ce_encuestas1` FOREIGN KEY (`ce_encuestas_id_ce_encuestas`) REFERENCES `ce_encuestas` (`id_ce_encuestas`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_ce_encuesta_preguntas_ce_grupos1` FOREIGN KEY (`ce_grupos_id_ce_grupos`) REFERENCES `ce_grupos` (`id_ce_grupos`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_ce_encuesta_preguntas_ce_preguntas1` FOREIGN KEY (`ce_preguntas_id_ce_preguntas`) REFERENCES `ce_preguntas` (`id_ce_preguntas`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `ce_encuesta_resultado`
--

DROP TABLE IF EXISTS `ce_encuesta_resultado`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ce_encuesta_resultado` (
  `id_ce_encuesta_resultado` int(11) NOT NULL AUTO_INCREMENT,
  `ce_participantes_token_fk` varchar(45) DEFAULT NULL,
  `fecha_inicio` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `fecha_termino` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `ce_p1` int(11) NOT NULL,
  `ce_p2` int(11) NOT NULL,
  `ce_p3` int(11) NOT NULL,
  `ce_p4` int(11) NOT NULL,
  `ce_p5` int(11) NOT NULL,
  `ce_p6` int(11) DEFAULT NULL,
  `ce_p7` int(11) NOT NULL,
  `ce_p8` int(11) NOT NULL,
  `ce_p9` int(11) NOT NULL,
  `ce_p10` int(11) NOT NULL,
  `ce_p11` int(11) NOT NULL,
  `ce_p12` int(11) NOT NULL,
  `ce_p13` int(11) NOT NULL,
  `ce_p14` int(11) NOT NULL,
  `ce_p15` int(11) NOT NULL,
  `ce_p16` int(11) NOT NULL,
  `ce_p17` int(11) NOT NULL,
  `ce_p18` int(11) NOT NULL,
  `ce_p19` int(11) NOT NULL,
  `ce_p20` int(11) NOT NULL,
  `ce_p21` int(11) NOT NULL,
  `ce_p22` int(11) NOT NULL,
  `ce_p23` int(11) NOT NULL,
  `ce_p24` int(11) NOT NULL,
  `ce_p25` int(11) NOT NULL,
  `ce_p26` int(11) NOT NULL,
  `ce_p27` int(11) NOT NULL,
  `ce_p28` int(11) NOT NULL,
  `ce_p29` int(11) NOT NULL,
  `ce_p30` int(11) NOT NULL,
  `ce_p31` int(11) NOT NULL,
  `ce_p32` int(11) NOT NULL,
  `ce_p33` int(11) NOT NULL,
  `ce_p34` int(11) NOT NULL,
  `ce_p35` int(11) NOT NULL,
  `ce_p36` int(11) NOT NULL,
  `ce_p37` int(11) NOT NULL,
  `ce_p38` int(11) NOT NULL,
  `ce_p39` int(11) NOT NULL,
  `ce_p40` int(11) NOT NULL,
  `ce_p41` int(11) NOT NULL,
  `ce_p42` int(11) NOT NULL,
  `ce_p43` int(11) NOT NULL,
  `ce_p44` int(11) NOT NULL,
  `ce_p45` int(11) NOT NULL,
  `ce_p46` int(11) NOT NULL,
  `ce_p47` int(11) NOT NULL,
  `ce_encuestas_id_ce_encuestas` int(11) DEFAULT NULL,
  PRIMARY KEY (`id_ce_encuesta_resultado`),
  UNIQUE KEY `ce_participantes_token_fk` (`ce_participantes_token_fk`),
  KEY `fk_ce_encuesta_resultado_ce_participantes1_idx` (`ce_participantes_token_fk`),
  KEY `fk_ce_encuesta_resultado_ce_encuestas1_idx` (`ce_encuestas_id_ce_encuestas`)
) ENGINE=InnoDB AUTO_INCREMENT=6210 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `ce_encuestas`
--

DROP TABLE IF EXISTS `ce_encuestas`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ce_encuestas` (
  `id_ce_encuestas` int(11) NOT NULL AUTO_INCREMENT,
  `ce_encuestas_nombre` varchar(100) NOT NULL,
  `ce_encuesta_fecha_creacion` datetime NOT NULL,
  PRIMARY KEY (`id_ce_encuestas`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `ce_estable_curso_docente`
--

DROP TABLE IF EXISTS `ce_estable_curso_docente`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ce_estable_curso_docente` (
  `id_esta_curs_doc` int(11) NOT NULL AUTO_INCREMENT,
  `ce_fk_establecimiento` int(11) DEFAULT NULL,
  `ce_fk_docente` int(11) DEFAULT NULL,
  `ce_fk_curso` int(11) DEFAULT NULL,
  `ce_fk_nivel` int(11) DEFAULT NULL,
  PRIMARY KEY (`id_esta_curs_doc`),
  KEY `ce_fk_establecimiento` (`ce_fk_establecimiento`),
  KEY `ce_fk_docente` (`ce_fk_docente`),
  KEY `ce_fk_curo` (`ce_fk_curso`),
  KEY `ce_fk_nivel` (`ce_fk_nivel`),
  CONSTRAINT `ce_estable_curso_docente_ibfk_1` FOREIGN KEY (`ce_fk_establecimiento`) REFERENCES `ce_establecimiento` (`id_ce_establecimiento`),
  CONSTRAINT `ce_estable_curso_docente_ibfk_2` FOREIGN KEY (`ce_fk_docente`) REFERENCES `ce_docente` (`id_ce_docente`),
  CONSTRAINT `ce_estable_curso_docente_ibfk_3` FOREIGN KEY (`ce_fk_curso`) REFERENCES `ce_curso` (`id_ce_curso`),
  CONSTRAINT `ce_fk_nivel` FOREIGN KEY (`ce_fk_nivel`) REFERENCES `ce_niveles` (`ce_id_niveles`)
) ENGINE=InnoDB AUTO_INCREMENT=307 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `ce_establecimiento`
--

DROP TABLE IF EXISTS `ce_establecimiento`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ce_establecimiento` (
  `id_ce_establecimiento` int(11) NOT NULL AUTO_INCREMENT,
  `ce_establecimiento_nombre` varchar(45) NOT NULL,
  `ce_establecimiento_rbd` varchar(45) NOT NULL,
  `id_pais` int(11) DEFAULT NULL,
  PRIMARY KEY (`id_ce_establecimiento`),
  KEY `fk_id_pais` (`id_pais`),
  CONSTRAINT `fk_id_pais` FOREIGN KEY (`id_pais`) REFERENCES `ce_pais` (`id_ce_pais`)
) ENGINE=InnoDB AUTO_INCREMENT=70 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `ce_establecimiento_sostenedor`
--

DROP TABLE IF EXISTS `ce_establecimiento_sostenedor`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ce_establecimiento_sostenedor` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `sostenedor_id` int(11) DEFAULT NULL,
  `establecimiento_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `ce_establecimiento_sostenedor_sostenedor` (`sostenedor_id`),
  KEY `ce_establecimiento_sostenedor_establecimiento` (`establecimiento_id`),
  CONSTRAINT `ce_establecimiento_sostenedor_establecimiento` FOREIGN KEY (`establecimiento_id`) REFERENCES `ce_establecimiento` (`id_ce_establecimiento`),
  CONSTRAINT `ce_establecimiento_sostenedor_sostenedor` FOREIGN KEY (`sostenedor_id`) REFERENCES `ce_sostenedor` (`id_soste`)
) ENGINE=InnoDB AUTO_INCREMENT=60 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `ce_etimologia`
--

DROP TABLE IF EXISTS `ce_etimologia`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ce_etimologia` (
  `id_eti` int(11) NOT NULL AUTO_INCREMENT,
  `text_1_ini` varchar(1000) COLLATE utf8mb4_spanish_ci NOT NULL,
  `text_1_intro` varchar(1000) COLLATE utf8mb4_spanish_ci NOT NULL,
  `id_pais` int(11) DEFAULT NULL,
  PRIMARY KEY (`id_eti`),
  KEY `fk_pais` (`id_pais`),
  CONSTRAINT `fk_pais` FOREIGN KEY (`id_pais`) REFERENCES `ce_pais` (`id_ce_pais`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_spanish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `ce_excepciones`
--

DROP TABLE IF EXISTS `ce_excepciones`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ce_excepciones` (
  `id_excep` int(11) NOT NULL AUTO_INCREMENT,
  `nom_excep` text COLLATE utf8_spanish_ci NOT NULL,
  PRIMARY KEY (`id_excep`)
) ENGINE=InnoDB AUTO_INCREMENT=360 DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `ce_grupos`
--

DROP TABLE IF EXISTS `ce_grupos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ce_grupos` (
  `id_ce_grupos` int(11) NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`id_ce_grupos`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `ce_niveles`
--

DROP TABLE IF EXISTS `ce_niveles`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ce_niveles` (
  `ce_id_niveles` int(11) NOT NULL AUTO_INCREMENT,
  `ce_nombre` varchar(30) NOT NULL DEFAULT '0' COMMENT 'Nombre del curso',
  `ce_fecha_ingreso` timestamp NULL DEFAULT NULL,
  `ce_fecha_actualizacion` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`ce_id_niveles`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `ce_pais`
--

DROP TABLE IF EXISTS `ce_pais`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ce_pais` (
  `id_ce_pais` int(11) NOT NULL AUTO_INCREMENT,
  `ce_pais_nombre` varchar(50) NOT NULL DEFAULT '0',
  `ce_region_id_ce_region` int(11) DEFAULT NULL,
  PRIMARY KEY (`id_ce_pais`),
  KEY `fk_ce_pais_ce_region1_idx` (`ce_region_id_ce_region`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `ce_participantes`
--

DROP TABLE IF EXISTS `ce_participantes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ce_participantes` (
  `id_ce_participantes` int(11) NOT NULL AUTO_INCREMENT,
  `ce_estado_encuesta` tinyint(1) DEFAULT NULL,
  `ce_ruta_diploma` varchar(50) DEFAULT NULL,
  `ce_participantes_nombres` varchar(70) NOT NULL,
  `ce_participantes_apellidos` varchar(70) NOT NULL,
  `ce_participantes_run` varchar(15) DEFAULT NULL,
  `ce_participantes_fecha_nacimiento` date DEFAULT NULL,
  `ce_participantes_fecha_registro` timestamp NULL DEFAULT NULL,
  `ce_participanes_token` varchar(45) DEFAULT NULL,
  `ce_ciudad` varchar(50) DEFAULT NULL,
  `ce_establecimiento_id_ce_establecimiento` int(11) DEFAULT NULL,
  `ce_docente_id_ce_docente` int(11) DEFAULT NULL,
  `ce_curso_id_ce_curso` int(11) DEFAULT NULL,
  `ce_fk_nivel` int(11) DEFAULT NULL,
  `fk_sostenedor` int(11) DEFAULT NULL,
  `ce_pais_id_ce_pais` int(11) DEFAULT NULL,
  `ce_region_id_ce_region` int(11) DEFAULT NULL,
  `ce_comuna_id_ce_comuna` int(11) DEFAULT NULL,
  `ce_region_ce_pais_id_ce_pais` int(11) DEFAULT NULL,
  `ce_participantes_fecha_actualizacion` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id_ce_participantes`),
  KEY `fk_ce_participantes_ce_comuna1_idx` (`ce_comuna_id_ce_comuna`),
  KEY `fk_ce_participantes_ce_establecimiento1_idx` (`ce_establecimiento_id_ce_establecimiento`),
  KEY `fk_ce_participantes_ce_docente1_idx` (`ce_docente_id_ce_docente`),
  KEY `fk_ce_participantes_ce_curso1_idx` (`ce_curso_id_ce_curso`),
  KEY `fk_ce_participantes_ce_pais1_idx` (`ce_pais_id_ce_pais`),
  KEY `fk_ce_participantes_ce_region1_idx` (`ce_region_id_ce_region`,`ce_region_ce_pais_id_ce_pais`),
  KEY `fk_niveles` (`ce_fk_nivel`),
  KEY `fk_sostenedor` (`fk_sostenedor`),
  CONSTRAINT `fk_niveles` FOREIGN KEY (`ce_fk_nivel`) REFERENCES `ce_niveles` (`ce_id_niveles`),
  CONSTRAINT `fk_sostenedor` FOREIGN KEY (`fk_sostenedor`) REFERENCES `ce_sostenedor` (`id_soste`)
) ENGINE=InnoDB AUTO_INCREMENT=7910 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `ce_preguntas`
--

DROP TABLE IF EXISTS `ce_preguntas`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ce_preguntas` (
  `id_ce_preguntas` int(11) NOT NULL AUTO_INCREMENT,
  `ce_pregunta_nombre` varchar(250) NOT NULL,
  `ce_orden` int(11) DEFAULT NULL,
  `ce_preguntas_codigo` varchar(10) DEFAULT NULL,
  `ce_nivel` int(11) DEFAULT NULL,
  `ce_dimension_id` int(11) DEFAULT NULL,
  `ce_pais_id_ce_pais` int(11) DEFAULT NULL,
  PRIMARY KEY (`id_ce_preguntas`),
  KEY `fk_ce_preguntas_ce_pais1_idx` (`ce_pais_id_ce_pais`),
  KEY `fk_ce_dimension` (`ce_dimension_id`),
  CONSTRAINT `fk_ce_dimension` FOREIGN KEY (`ce_dimension_id`) REFERENCES `ce_dimension` (`di_id`),
  CONSTRAINT `fk_ce_preguntas_ce_pais1` FOREIGN KEY (`ce_pais_id_ce_pais`) REFERENCES `ce_pais` (`id_ce_pais`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=308 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `ce_region`
--

DROP TABLE IF EXISTS `ce_region`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ce_region` (
  `id_ce_region` int(11) NOT NULL AUTO_INCREMENT,
  `ce_pais_id_ce_pais` int(11) NOT NULL,
  PRIMARY KEY (`id_ce_region`,`ce_pais_id_ce_pais`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `ce_rol_user`
--

DROP TABLE IF EXISTS `ce_rol_user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ce_rol_user` (
  `id_user_rol` int(11) NOT NULL AUTO_INCREMENT,
  `id_usuario_fk` int(11) NOT NULL,
  `id_roles_fk` int(11) NOT NULL,
  PRIMARY KEY (`id_user_rol`),
  KEY `id_usuario_fk` (`id_usuario_fk`),
  KEY `id_roles_fk` (`id_roles_fk`),
  CONSTRAINT `ce_rol_user_ibfk_1` FOREIGN KEY (`id_usuario_fk`) REFERENCES `ce_usuarios` (`id_usu`),
  CONSTRAINT `ce_rol_user_ibfk_2` FOREIGN KEY (`id_roles_fk`) REFERENCES `ce_roles` (`id_rol`)
) ENGINE=InnoDB AUTO_INCREMENT=421 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `ce_roles`
--

DROP TABLE IF EXISTS `ce_roles`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ce_roles` (
  `id_rol` int(11) NOT NULL AUTO_INCREMENT,
  `nombre_rol` varchar(50) NOT NULL,
  `display_nombre_rol` varchar(50) DEFAULT NULL,
  `descripcion_rol` varchar(100) NOT NULL,
  `menu` longtext,
  `modulos_usuario` varchar(1500) NOT NULL DEFAULT '0',
  `fecha_creacion_rol` timestamp NULL DEFAULT NULL,
  `fecha_actualizacion` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id_rol`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `ce_sec_seccion`
--

DROP TABLE IF EXISTS `ce_sec_seccion`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ce_sec_seccion` (
  `sec_id` int(11) NOT NULL AUTO_INCREMENT,
  `sec_nombre` varchar(50) COLLATE utf8_spanish2_ci NOT NULL,
  PRIMARY KEY (`sec_id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8 COLLATE=utf8_spanish2_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `ce_sostenedor`
--

DROP TABLE IF EXISTS `ce_sostenedor`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ce_sostenedor` (
  `id_soste` int(11) NOT NULL AUTO_INCREMENT,
  `nom_soste` varchar(100) NOT NULL,
  `apelli_soste` varchar(50) DEFAULT NULL,
  `run_soste` int(13) DEFAULT NULL,
  `fecha_registro_soste` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `usuario_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id_soste`),
  KEY `ce_sostenedor_usuario` (`usuario_id`),
  CONSTRAINT `ce_sostenedor_usuario` FOREIGN KEY (`usuario_id`) REFERENCES `ce_usuarios` (`id_usu`)
) ENGINE=InnoDB AUTO_INCREMENT=65 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `ce_usuarios`
--

DROP TABLE IF EXISTS `ce_usuarios`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ce_usuarios` (
  `id_usu` int(11) NOT NULL AUTO_INCREMENT,
  `nombre_usu` varchar(50) NOT NULL,
  `contrasena_usu` varchar(80) NOT NULL COMMENT 'La contraseña viene encryptada con hash',
  `fecha_ingreso_usu` timestamp NULL DEFAULT NULL,
  `fecha_actualizacion` timestamp NULL DEFAULT NULL,
  `fk_establecimiento` int(11) DEFAULT NULL,
  PRIMARY KEY (`id_usu`),
  UNIQUE KEY `nombre_usu` (`nombre_usu`),
  KEY `fk_establecimiento` (`fk_establecimiento`),
  CONSTRAINT `fk_establecimiento` FOREIGN KEY (`fk_establecimiento`) REFERENCES `ce_establecimiento` (`id_ce_establecimiento`)
) ENGINE=InnoDB AUTO_INCREMENT=425 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `migrations`
--

DROP TABLE IF EXISTS `migrations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `migrations` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `migration` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `batch` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=43 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `tipo_talleres`
--

DROP TABLE IF EXISTS `tipo_talleres`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tipo_talleres` (
  `id_tip_taller` int(11) NOT NULL AUTO_INCREMENT,
  `nom_taller` varchar(50) COLLATE utf8mb4_spanish_ci NOT NULL,
  PRIMARY KEY (`id_tip_taller`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_spanish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2020-01-23 15:07:22



LOCK TABLES `ce_etimologia` WRITE;
/*!40000 ALTER TABLE `ce_etimologia` DISABLE KEYS */;
INSERT INTO `ce_etimologia` VALUES (1,'<div><h2>¡Hola!</h2><p class=\"text-justify\">La encuesta que estás respondiendo es de gran utilidad para medir el compromiso que tienes con tus estudios y el colegio, y así poder saber qué estudiantes o cursos requieren un apoyo adicional. Otras preguntas buscan conocer más de ti como estudiante, de tu colegio y el apoyo que recibes. De esta manera se espera que todos y todas puedan alcanzar mayor éxito con sus estudios.</p><br><br><p>Algunas de las preguntas que te planteamos serán más complicadas que otras. Pregunta si tienes dudas. Se trata de contarnos qué sientes y piensas con sinceridad.</p></div><br><br><p>Muchas gracias por tu colaboración!</p>','<p class=\"text-justify\">A continuación, tienes una serie de preguntas, te pedimos que contestes con sinceridad, no hay respuestas buenas ni malas. Para cada pregunta marca la respuesta que estimes pertinente. En unas preguntas te pedimos que contestes pensando en la frecuencia con la que sueles sentir, pensar o hacer algunas cosas. En otras preguntas, se trata de que nos cuentes  sobre ti como estudiante, el colegio y el apoyo que recibes.</p>',1),(2,'<div><h2>¡Hola!</h2><p class=\"text-justify\">La encuesta que estás respondiendo es de gran utilidad para medir el compromiso que tienes con tus estudios y el liceo, y así poder saber qué estudiante o clases requieren un apoyo adicional. Otras preguntas buscan conocer más de ti como alumno, de tu liceo y el apoyo que recibes. De esta manera se espera que todos y todas puedan alcanzar mayor éxito con sus estudios.</p><br><br><p>Algunas de las preguntas que te planteamos serán más complicadas que otras. Pregunta si tienes dudas. Se trata de contarnos qué sientes y piensas con sinceridad.</p></div><br><br><p>¡Muchas gracias por tu colaboración!</p>','<p class=\"text-justify\">A continuación, tienes una serie de preguntas, te pedimos que contestes con sinceridad, no hay respuestas buenas ni malas. Para cada pregunta marca la respuesta que estimes pertinente. En unas preguntas te pedimos que contestes pensando en la frecuencia con la que sueles sentir, pensar o hacer algunas cosas. En otras preguntas, se trata de que nos cuentes  sobre ti como estudiante, el liceo y el apoyo que recibes.</p>',2),(3,'<div><h2>¡Hola!</h2><p class=\"text-justify\">La encuesta que estás respondiendo es de gran utilidad para medir el compromiso que tienes con tus estudios y el colegio, y así poder saber qué estudiantes o aulas requieren un apoyo adicional. Otras preguntas buscan conocer más de ti como estudiante, de tu colegio y el apoyo que recibes. De esta manera se espera que todos y todas puedan alcanzar mayor éxito con sus estudios.</p><br><br><p>Algunas de las preguntas que te planteamos serán más complicadas que otras. Pregunta si tienes dudas. Se trata de contarnos qué sientes y piensas con sinceridad.</p></div><br><br><p>¡Muchas gracias por tu colaboración!</p>','<p class=\"text-justify\">A continuación, tienes una serie de preguntas, te pedimos que contestes con sinceridad, no hay respuestas buenas ni malas. Para cada pregunta marca la respuesta que estimes pertinente. En unas preguntas te pedimos que contestes pensando en la frecuencia con la que sueles sentir, pensar o hacer algunas cosas. En otras preguntas, se trata de que nos cuentes  sobre ti como estudiante, el colegio y el apoyo que recibes.</p>',3),(4,'<div><h2>¡Hola!</h2><p class=\"text-justify\">La encuesta que estás respondiendo es de gran utilidad para medir el compromiso que tienes con tus estudios y el colegio, y así poder saber qué estudiantes o cursos requieren un apoyo adicional. Otras preguntas buscan conocer más de ti como estudiante, de tu colegio y el apoyo que recibes. De esta manera se espera que todos y todas puedan alcanzar mayor éxito con sus estudios.</p><br><br><p>Algunas de las preguntas que te planteamos serán más complicadas que otras. Pregunta si tienes dudas. Se trata de contarnos qué sientes y piensas con sinceridad.</p></div><br><br><p>¡Muchas gracias por tu colaboración!</p>','<p class=\"text-justify\">A continuación, tienes una serie de preguntas, te pedimos que contestes con sinceridad, no hay respuestas buenas ni malas. Para cada pregunta marca la respuesta que estimes pertinente. En unas preguntas te pedimos que contestes pensando en la frecuencia con la que sueles sentir, pensar o hacer algunas cosas. En otras preguntas, se trata de que nos cuentes  sobre ti como estudiante, el colegio y el apoyo que recibes.</p>',4),(5,'<div><h2>¡Hola!</h2><p class=\"text-justify\">La encuesta que estás respondiendo es de gran utilidad para medir el compromiso que tienes con tus estudios y el instituto, y así poder saber qué estudiante o clases requieren un apoyo adicional. Otras preguntas buscan conocer más de ti como estudiante, de tu instituto y el apoyo que recibes. De esta manera se espera que todos y todas puedan alcanzar mayor éxito con sus estudios.</p><br><br><p>Algunas de las preguntas que te planteamos serán más complicadas que otras. Pregunta si tienes dudas. Se trata de contarnos qué sientes y piensas con sinceridad.</p></div><br><br><p>¡Muchas gracias por tu colaboración!</p>','<p class=\"text-justify\">A continuación, tienes una serie de preguntas, te pedimos que contestes con sinceridad, no hay respuestas buenas ni malas. Para cada pregunta marca la respuesta que estimes pertinente. En unas preguntas te pedimos que contestes pensando en la frecuencia con la que sueles sentir, pensar o hacer algunas cosas. En otras preguntas, se trata de que nos cuentes  sobre ti como estudiante, el instituto y el apoyo que recibes.</p>',5);
/*!40000 ALTER TABLE `ce_etimologia` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2020-01-23 15:43:08



LOCK TABLES `tipo_talleres` WRITE;
/*!40000 ALTER TABLE `tipo_talleres` DISABLE KEYS */;
INSERT INTO `tipo_talleres` VALUES (1,'Talleres Para Aula'),(2,'Talleres Para Familia'),(3,'Otros Materiales');
/*!40000 ALTER TABLE `tipo_talleres` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2020-01-23 16:00:21


/*!40000 ALTER TABLE `ce_preguntas` DISABLE KEYS */;
INSERT INTO `ce_preguntas` VALUES (1,'Siento que soy parte del colegio',1,'ce_p1',2,1,1),(2,'Antes de una prueba, planifico cómo estudiar la materia',2,'ce_p2',2,3,1),(6,'Me escapo de clases o hago la cimarra',3,'ce_p3',2,2,1),(7,'Salgo sin pedir permiso de la sala',4,'ce_p4',2,2,1),(8,'Puedo ser yo mismo(a) en este colegio',5,'ce_p5',2,1,1),(9,'Utilizo distintos recursos (como internet o libros) para buscar información complementaria entregada por el profesor',6,'ce_p6',2,3,1),(10,'La mayoría de las cosas que aprendo en el colegio son útiles',7,'ce_p7',2,1,1),(11,'La mayoría de los profesores se preocupan de que la materia que aprendamos sea útil',8,'ce_p8',2,1,1),(12,'Llego atrasado(a) a clases',9,'ce_p9',2,2,1),(13,'Cuando estoy haciendo alguna actividad, me preocupo de entender todo lo posible',10,'ce_p10',2,3,1),(14,'Mis apoderados han sido citados por mi mala conducta',11,'ce_p11',2,2,1),(16,'Siento orgullo de estar en este colegio',12,'ce_p12',2,1,1),(18,'Me tratan con respeto en este colegio',19,'ce_p19',2,1,1),(20,'Para mí es importante lograr entender bien las tareas y la materia',20,'ce_p20',2,3,1),(21,'Sé cómo utilizar diferentes técnicas y estrategias para realizar bien mis tareas (como por ejemplo, planificar el trabajo, destacar ideas principales, discutir en grupos, etc.)',21,'ce_p21',2,3,1),(23,'Lo que aprendo en clases es importante para conseguir mis metas futuras',22,'ce_p22',2,1,1),(24,'Peleo con mis compañeros en la sala',23,'ce_p23',2,2,1),(26,'Después de terminar mis tareas reviso si están bien',24,'ce_p24',2,3,1),(27,'Mis padres o apoderados me animan a trabajar bien en la escuela',31,'ce_p31',2,4,1),(28,'Me llevo bien con mis compañeros(as) de curso',44,'ce_p44',2,5,1),(29,'Cuando tengo un problema, recibo ayuda de algún(a) profesor(a)',34,'ce_p34',2,6,1),(30,'Me llevo bien con mis profesores',37,'ce_p37',2,6,1),(31,'Los profesores se preocupan de mí no sólo como estudiante sino también como persona',38,'ce_p38',2,6,1),(32,'En mi escuela, los profesores y otros adultos tratan a todos los estudiantes con respeto',39,'ce_p39',2,6,1),(33,'En mi colegio, al menos un(a) compañeros(a) me apoya con las tareas difíciles',46,'ce_p46',2,5,1),(35,'Cuando tengo un problema, recibo ayuda de mi familia',32,'ce_p32',2,4,1),(36,'Los profesores se interesan por mí y me ayudan si tengo dificultades para hacer las tareas',36,'ce_p36',2,6,1),(37,'En este colegio, se valora la participación y la opinión de todos(as)',40,'ce_p40',2,6,1),(38,'Los profesores me alientan a realizar nuevamente una tarea si me equivoco ',35,'ce_p35',2,6,1),(39,'Después de una prueba pienso si las respuestas fueron las correctas',13,'ce_p13',2,3,1),(40,'Sé qué estrategias y hábitos de estudio tengo que cambiar para mejorar y obtener mejores calificaciones',14,'ce_p14',2,3,1),(41,'Para mí es muy importante lo que hacemos en la escuela',15,'ce_p15',2,1,1),(42,'Me porto bien en clases',16,'ce_p16',2,2,1),(43,'Cuando comienzo una tarea, pienso en las cosas que ya sé sobre el tema porque eso me ayuda a comprender mejor',17,'ce_p17',2,3,1),(44,'Cuando estudio, anoto palabras nuevas, dudas o ideas importantes',18,'ce_p18',2,3,1),(45,'Cuando finalizo una tarea, pienso si he conseguido el objetivo que me había propuesto',25,'ce_p25',2,3,1),(46,'Pongo atención a los comentarios que los profesores hacen sobre mis trabajos',26,'ce_p26',2,3,1),(47,'Siento que soy importante para el colegio',27,'ce_p27',2,1,1),(48,'Me mandan a la oficina del director o del inspector general por mi mala conducta',28,'ce_p28',2,2,1),(49,'Me siento bien en este colegio',29,'ce_p29',2,1,1),(50,'Mis compañeros(as) me apoyan y se preocupan por mí',41,'ce_p41',2,5,1),(51,'Mis compañeros(as) del colegio son importantes para mí',43,'ce_p43',2,5,1),(52,'Siento que soy importante para mis compañeros(as) del colegio',45,'ce_p45',2,5,1),(53,'Cuando no entiendo algo, mis compañeros me explican',47,'ce_p47',2,5,1),(54,'Mis profesores(as) quieren que aprenda mucho',33,'ce_p33',2,6,1),(55,'Puedo confiar en mis compañeros(as)',42,'ce_p42',2,5,1),(56,'Hablo con mi familia sobre lo que hago en la escuela',30,'ce_p30',2,4,1),(58,'Siento que soy parte del colegio',1,'ce_p1',2,1,3),(59,'Antes de un examen, planifico cómo estudiar el curso',2,'ce_p2',2,3,3),(64,'Me escapo de clases o me tiro la pera',3,'ce_p3',2,2,3),(65,'Salgo sin pedir permiso del salón',4,'ce_p4',2,2,3),(66,'Puedo ser yo mismo(a) en este colegio',5,'ce_p5',2,1,3),(67,'Utilizo distintos recursos (como internet o libros) para buscar información complementaria entregada por el profesor',6,'ce_p6',2,3,3),(68,'La mayoría de las cosas que aprendo en el colegio son útiles',7,'ce_p7',2,1,3),(69,'La mayoría de los profesores se preocupan de que el curso que aprendamos sea útil',8,'ce_p8',2,1,3),(70,'Llego tarde a clases',9,'ce_p9',2,2,3),(71,'Cuando estoy haciendo alguna actividad, me preocupo de entender todo lo posible',10,'ce_p10',2,3,3),(72,'Mis padres o apoderados han sido citados por mi mala conducta',11,'ce_p11',2,2,3),(73,'Siento orgullo de estar en este colegio',12,'ce_p12',2,1,3),(74,'Después de un examen pienso si las respuestas fueron las correctas',13,'ce_p13',2,3,3),(75,'Sé qué estrategias y hábitos de estudio tengo que cambiar para mejorar y obtener mejores notas',14,'ce_p14',2,3,3),(76,'Para mí es muy importante lo que hacemos en el colegio',15,'ce_p15',2,1,3),(77,'Me porto bien en clases',16,'ce_p16',2,2,3),(78,'Cuando comienzo una tarea, pienso en las cosas que ya sé sobre el tema porque eso me ayuda a comprender mejor',17,'ce_p17',2,3,3),(79,'Cuando estudio, anoto palabras nuevas, dudas o ideas importantes',18,'ce_p18',2,3,3),(80,'Me tratan con respeto en este colegio',19,'ce_p19',2,1,3),(81,'Para mí es importante lograr entender bien las tareas y el curso',20,'ce_p20',2,3,3),(82,'Sé cómo utilizar diferentes técnicas y estrategias para realizar bien mis tareas (como por ejemplo, planificar el trabajo, destacar ideas principales, discutir en grupos, etc)',21,'ce_p21',2,3,3),(83,'Lo que aprendo en clases es importante para conseguir mis metas futuras',22,'ce_p22',2,1,3),(84,'Peleo o discuto con mis compañeros en el salón',23,'ce_p23',2,2,3),(85,'Después de terminar mis tareas reviso si están bien',24,'ce_p24',2,3,3),(86,'Cuando finalizo una tarea, pienso si he conseguido el objetivo que me había propuesto',25,'ce_p25',2,3,3),(87,'Pongo atención a los comentarios que los profesores hacen sobre mis trabajos',26,'ce_p26',2,3,3),(88,'Siento que el colegio se interesa por mi',27,'ce_p27',2,1,3),(89,'Me mandan a la dirección o al tutor por mi mala conducta',28,'ce_p28',2,2,3),(91,'Me siento bien en este colegio',29,'ce_p29',2,1,3),(92,'Hablo con mi familia sobre lo que hago en la escuela',30,'ce_p30',2,4,3),(93,'Mis padres o apoderados me animan a trabajar bien en la escuela',31,'ce_p31',2,4,3),(94,'Cuando tengo un problema, recibo ayuda de mi familia',32,'ce_p32',2,4,3),(95,'Mis profesores(as) quieren que aprenda mucho',33,'ce_p33',2,6,3),(96,'Cuando tengo un problema, recibo ayuda de algún(a) profesor(a) ',34,'ce_p34',2,6,3),(97,'Los profesores me animan a realizar nuevamente una tarea si me equivoco ',35,'ce_p35',2,6,3),(98,'Los profesores se interesan por mí y me ayudan si tengo dificultades para hacer las tareas',36,'ce_p36',2,6,3),(99,'Me llevo bien con mis profesores',37,'ce_p37',2,6,3),(100,'Los profesores se preocupan de mí no sólo como estudiante sino también como persona',38,'ce_p38',2,6,3),(101,'En mi colegio, los profesores y otros adultos tratan a todos los estudiantes con respeto',39,'ce_p39',2,6,3),(102,'En este colegio, se valora la participación y la opinión de todos(as)',40,'ce_p40',2,6,3),(103,'Mis compañeros(as) me apoyan y se preocupan por mí',41,'ce_p41',2,5,3),(105,'Puedo confiar en mis compañeros(as)',42,'ce_p42',2,5,3),(106,'Mis compañeros(as) del colegio son importantes para mí',43,'ce_p43',2,5,3),(107,'Me llevo bien con mis compañeros(as) de aula',44,'ce_p44',2,5,3),(108,'Siento que soy importante para mis compañeros(as) del colegio',45,'ce_p45',2,5,3),(109,'En mi colegio, al menos un(a) compañeros(a) me apoya con las tareas difíciles',46,'ce_p46',2,5,3),(110,'Cuando no entiendo algo, mis compañeros me explican',47,'ce_p47',2,5,3),(111,'Siento que soy parte del liceo',1,'ce_p1',2,1,2),(112,'Antes de una prueba, organizo cómo estudiar la materia',2,'ce_p2',2,3,2),(113,'Me escapo de clase o me hago la rabona',3,'ce_p3',2,2,2),(114,'Salgo sin pedir permiso de la clase',4,'ce_p4',2,2,2),(115,'Puedo ser yo mismo(a) en este liceo',5,'ce_p5',2,1,2),(116,'Utilizo distintos recursos (como internet o libros) para buscar información complementaria a la entregada por el profesor',6,'ce_p6',2,3,2),(117,'La mayoría de las cosas que aprendo en el liceo son útiles',7,'ce_p7',2,1,2),(118,'La mayoría de los profesores se preocupan de que la materia que aprendamos sea útil',8,'ce_p8',2,1,2),(119,'Llego tarde a clase',9,'ce_p9',2,2,2),(120,'Cuando estoy haciendo alguna actividad, me preocupo de entender todo lo posible',10,'ce_p10',2,3,2),(121,'Mis padres o tutores han sido citados por mi mala conducta',11,'ce_p11',2,2,2),(122,'Siento orgullo de estar en este liceo',12,'ce_p12',2,1,2),(123,'Después de una prueba pienso si las respuestas fueron las correctas',13,'ce_p13',2,3,2),(124,'Sé qué hábitos de estudio tengo que cambiar para mejorar y obtener mejores calificaciones',14,'ce_p14',2,3,2),(125,'Para mí es muy importante lo que hacemos en el liceo',15,'ce_p15',2,1,2),(126,'Me porto bien en clase',16,'ce_p16',2,2,2),(127,'Cuando comienzo una tarea, pienso en las cosas que ya sé sobre el tema porque eso me ayuda a comprender mejor',17,'ce_p17',2,3,2),(128,'Cuando estudio, anoto palabras nuevas, dudas o ideas importantes',18,'ce_p18',2,3,2),(129,'Me tratan con respeto en este liceo',19,'ce_p19',2,1,2),(130,'Para mí es importante lograr entender bien las tareas y la materia',20,'ce_p20',2,3,2),(131,'Sé cómo utilizar diferentes técnicas para realizar bien mis tareas (como por ejemplo, organizar el trabajo, destacar ideas principales, discutir en grupos, etc)',21,'ce_p21',2,3,2),(132,'Lo que aprendo en clase   es importante para conseguir mis metas futuras',22,'ce_p22',2,1,2),(133,'Peleo con mis compañeros en la clase',23,'ce_p23',2,2,2),(134,'Después de terminar mis tareas reviso si están bien',24,'ce_p24',2,3,2),(135,'Cuando finalizo una tarea, pienso si he conseguido el objetivo que me había propuesto',25,'ce_p25',2,3,2),(136,'Pongo atención a los comentarios que los profesores hacen sobre mis trabajos',26,'ce_p26',2,3,2),(137,'Siento que soy importante para el liceo',27,'ce_p27',2,1,2),(138,'Me mandan a  la adscripción o a la dirección por mi mala conducta',28,'ce_p28',2,2,2),(139,'Me siento bien en este liceo',29,'ce_p29',2,1,2),(140,'Hablo con mi familia sobre lo que hago en el liceo',30,'ce_p30',2,4,2),(142,'Mis padres o tutores me animan a trabajar bien en el liceo',31,'ce_p31',2,4,2),(143,'Cuando tengo un problema, recibo ayuda de mi familia',32,'ce_p32',2,4,2),(144,'Mis profesores(as) quieren que aprenda mucho',33,'ce_p33',2,6,2),(145,'Cuando tengo un problema, recibo ayuda de algún(a) profesor(a)',34,'ce_p34',2,6,2),(146,'Los profesores me animan a realizar nuevamente una tarea si me equivoco',35,'ce_p35',2,6,2),(147,'Los profesores se interesan por mí y me ayudan si tengo dificultades para hacer las tareas',36,'ce_p36',2,6,2),(148,'Me llevo bien con mis profesores',37,'ce_p37',2,6,2),(149,'Los profesores se preocupan por mí no sólo como estudiante sino también como persona',38,'ce_p38',2,6,2),(150,'En mi liceo, los profesores y otros adultos tratan a todos los estudiantes con respeto',39,'ce_p39',2,6,2),(151,'En este liceo, se valora la participación y la opinión de todos(as)',40,'ce_p40',2,6,2),(152,'Mis compañeros(as) me apoyan y se preocupan por mí',41,'ce_p41',2,5,2),(153,'Puedo confiar en mis compañeros(as)',42,'ce_p42',2,5,2),(154,'Mis compañeros(as) del liceo son importantes para mí',43,'ce_p43',2,5,2),(155,'Me llevo bien con mis compañeros(as) de clase',44,'ce_p44',2,5,2),(156,'Siento que soy importante para mis compañeros(as) del liceo',45,'ce_p45',2,5,2),(157,'En mi liceo, al menos un(a) compañeros(a) me apoya con las tareas difíciles',46,'ce_p46',2,5,2),(158,'Cuando no entiendo algo, mis compañeros me explican',47,'ce_p47',2,5,2),(159,'Siento que soy parte del instituto',1,'ce_p1',2,1,5),(160,'Antes de un examen, organizo cómo estudiar la materia',2,'ce_p2',2,3,5),(161,'Me salto las clases o hago rabonas',3,'ce_p3',2,2,5),(162,'Salgo sin pedir permiso de la clase',4,'ce_p4',2,2,5),(163,'Puedo ser yo mismo(a) en este instituto',5,'ce_p5',2,1,5),(164,'Utilizo distintos recursos (como internet o libros) para buscar información complementaria a la que da el profesor/a',6,'ce_p6',2,3,5),(165,'La mayoría de las cosas que aprendo en el instituto me sirven para algo',7,'ce_p7',2,1,5),(166,'La mayoría del profesorado se preocupa de que la materia que aprendamos nos sirva para algo',8,'ce_p8',2,1,5),(167,'Llego tarde a clase',9,'ce_p9',2,2,5),(168,'Cuando estoy haciendo alguna actividad, me preocupo de entender todo lo posible',10,'ce_p10',2,3,5),(169,'Mis padres o tutores legales han sido citados por mi mala conducta',11,'ce_p11',2,2,5),(170,'Me siento orgulloso/a de estar en este instituto',12,'ce_p12',2,1,5),(171,'Después de un examen pienso si mis respuestas fueron las correctas',13,'ce_p13',2,3,5),(172,'Sé que tengo que hacer para mejorar y obtener mejores notas',14,'ce_p14',2,3,5),(173,'Para mí es muy importante lo que hacemos en el instituto',15,'ce_p15',2,1,5),(174,'Me porto bien en clase',16,'ce_p16',2,2,5),(175,'Cuando comienzo una tarea, pienso en las cosas que ya sé sobre el tema porque eso me ayuda a comprender mejor',17,'ce_p17',2,3,5),(176,'Cuando estudio, apunto palabras nuevas, dudas o ideas importantes',18,'ce_p18',2,3,5),(177,'Me tratan con respeto en este instituto',19,'ce_p19',2,1,5),(178,'Para mí es importante lograr entender bien las tareas y la materia',20,'ce_p20',2,3,5),(179,'Sé cómo utilizar diferentes técnicas para realizar bien mis tareas (como por ejemplo, planificar el trabajo, destacar ideas principales, discutir en grupos, etc)',21,'ce_p21',2,3,5),(180,'Lo que aprendo en clases es importante para mi futuro',22,'ce_p22',2,1,5),(181,'Peleo o discuto con mis compañeros/as en la clase',23,'ce_p23',2,2,5),(182,'Después de terminar mis tareas reviso si están bien',24,'ce_p24',2,3,5),(183,'Cuando finalizo una tarea, pienso si he conseguido el objetivo que me había propuesto',25,'ce_p25',2,3,5),(184,'Pongo atención a los comentarios que los profesores/as hacen sobre mis trabajos',26,'ce_p26',2,3,5),(185,'Siento que soy importante para el instituto',27,'ce_p27',2,1,5),(186,'Me mandan al despacho del director/a o del jefe de estudios por mi mala conducta',28,'ce_p28',2,2,5),(188,'Me siento bien en este instituto',29,'ce_p29',2,1,5),(189,'Hablo con mi familia sobre lo que hago en el instituto',30,'ce_p30',2,4,5),(190,'Mis padres o tutores legales me animan a trabajar bien en el instituto',31,'ce_p31',2,4,5),(191,'Cuando tengo un problema, recibo ayuda de mi familia',32,'ce_p32',2,4,5),(192,'Mis profesores/as quieren que aprenda mucho',33,'ce_p33',2,6,5),(193,'Cuando tengo un problema, recibo ayuda de algún/a profesor/a ',34,'ce_p34',2,6,5),(194,'Los profesores/as animan a realizar nuevamente una tarea si me equivoco',35,'ce_p35',2,6,5),(196,'Los profesores/as se interesan por mí y me ayudan si tengo dificultades para hacer las tareas',36,'ce_p36',2,6,5),(197,'Me llevo bien con mis profesores/as ',37,'ce_p37',2,6,5),(198,'Los profesores/as se preocupan de mí no sólo como estudiante sino también como persona',38,'ce_p38',2,6,5),(199,'En mi Instituto los profesores/as y otros adultos tratan a todos los estudiantes con respeto',39,'ce_p39',2,6,5),(200,'En este instituto, se valora la participación y la opinión de todos/as',40,'ce_p40',2,6,5),(201,'Mis compañeros/as me apoyan y se preocupan por mí',41,'ce_p41',2,5,5),(202,'Puedo confiar en mis compañeros/as',42,'ce_p42',2,5,5),(203,'Mis compañeros(as) de instituto son importantes para mí',43,'ce_p43',2,5,5),(204,'Me llevo bien con mis compañeros/as de clase',44,'ce_p44',2,5,5),(205,'Siento que soy importante para mis compañeros(as) de instituto',45,'ce_p45',2,5,5),(206,'En mi instituto, al menos un/a compañero/a me ayuda en las tareas difíciles',46,'ce_p46',2,5,5),(207,'Cuando no entiendo algo, mis compañeros/as me lo explican',47,'ce_p47',2,5,5),(208,'Siento que soy parte del colegio',1,'ce_p1',2,1,4),(209,'Antes de un examen, planeo cómo estudiar la asignatura',2,'ce_p2',2,3,4),(210,'Me escapo de clase o me echo la leva',3,'ce_p3',2,2,4),(211,'Salgo del salón de clase, sin pedir permiso',4,'ce_p4',2,2,4),(212,'Puedo ser yo mismo(a) en este colegio',5,'ce_p5',2,1,4),(213,'Utilizo distintos recursos (como internet o libros) para reforzar la información entregada por el profesor',6,'ce_p6',2,3,4),(215,'La mayoría de las cosas que aprendo en el colegio son útiles',7,'ce_p7',2,1,4),(216,'La mayoría de los profesores se preocupan de que la materia que aprendamos sea útil',8,'ce_p8',2,1,4),(217,'Llego tarde a clase',9,'ce_p9',2,2,4),(218,'Cuando estoy haciendo alguna actividad, me preocupo de entender todo lo posible',10,'ce_p10',2,3,4),(220,'Han citado a mis padres o acudientes por mi mal comportamiento',11,'ce_p11',2,2,4),(221,'Me siento orgulloso/a de estar en este colegio',12,'ce_p12',2,1,4),(222,'Después de un examen pienso si mis respuestas fueron las correctas',13,'ce_p13',2,3,4),(223,'Sé qué estrategias y hábitos de estudio tengo que cambiar para mejorar y obtener mejores calificaciones',14,'ce_p14',2,3,4),(224,'Para mí es muy importante lo que hacemos en el colegio',15,'ce_p15',2,1,4),(225,'Me porto bien en la clase',16,'ce_p16',2,2,4),(228,'Cuando comienzo una tarea, pienso en las cosas que ya sé sobre el tema porque eso me ayuda a comprender mejor',17,'ce_p17',2,3,4),(229,'Cuando estudio, anoto palabras nuevas, dudas o ideas importantes',18,'ce_p18',2,3,4),(230,'Me tratan con respeto en este colegio',19,'ce_p19',2,1,4),(231,'Para mí es importante lograr entender bien las tareas y las asignaturas',20,'ce_p20',2,3,4),(232,'Sé cómo utilizar diferentes estrategias para realizar bien mis tareas (como por ejemplo, planear el trabajo, destacar ideas principales, discutir en grupos, etc)',21,'ce_p21',2,3,4),(233,'Lo que aprendo en clase es importante para conseguir mis metas en el futuro',22,'ce_p22',2,1,4),(234,'Discuto o peleo con mis compañeros/as en el salón de clase',23,'ce_p23',2,2,4),(235,'Después de terminar mis tareas reviso si están bien',24,'ce_p24',2,3,4),(236,'Cuando termino una tarea, pienso si he conseguido lo que me había propuesto',25,'ce_p25',2,3,4),(238,'Presto atención a la opinión de los profesores sobre mis trabajos',26,'ce_p26',2,3,4),(239,'Siento que soy importante para el colegio',27,'ce_p27',2,1,4),(240,'Me mandan a la oficina del rector o del coordinador por mi mal comportamiento',28,'ce_p28',2,2,4),(241,'Me siento bien en este colegio',29,'ce_p29',2,1,4),(242,'Hablo con mi familia sobre lo que hago en el colegio',30,'ce_p30',2,4,4),(243,'Mis padres o acudientes me motivan a trabajar bien en el colegio',31,'ce_p31',2,4,4),(244,'Cuando tengo un problema, recibo ayuda de mi familia',32,'ce_p32',2,4,4),(246,'Mis profesores(as) quieren que aprenda mucho',33,'ce_p33',2,6,4),(247,'Cuando tengo un problema, recibo ayuda de algún(a) profesor(a)',34,'ce_p34',2,6,4),(248,'Los profesores me motivan a realizar de nuevo una tarea si me equivoco',35,'ce_p35',2,6,4),(249,'Los profesores se interesan por mí y me ayudan si tengo dificultades para hacer las tareas ',36,'ce_p36',2,6,4),(250,'Me llevo bien con mis profesores',37,'ce_p37',2,6,4),(251,'Mis profesores se preocupan por mí no sólo como estudiante sino también como persona',38,'ce_p38',2,6,4),(252,'En mi colegio los profesores y otros adultos tratan a todos los estudiantes con respeto',39,'ce_p39',2,6,4),(253,'En este colegio, se valora la participación y la opinión de todos(as)',40,'ce_p40',2,6,4),(254,'Mis compañeros(as) me apoyan y se preocupan por mí',41,'ce_p41',2,5,4),(255,'Puedo confiar en mis compañeros(as)',42,'ce_p42',2,5,4),(256,'Mis compañeros(as) del colegio son importantes para mí',43,'ce_p43',2,5,4),(257,'Me llevo bien con mis compañeros(as) de curso',44,'ce_p44',2,5,4),(258,'Siento que soy importante para mis compañeros(as) del colegio',45,'ce_p45',2,5,4),(259,'En mi colegio, por lo menos un(a) compañero(a) me ayuda en las tareas difíciles',46,'ce_p46',2,5,4),(260,'Cuando no entiendo algo, mis compañeros me explican',47,'ce_p47',2,5,4),(261,'Siento que soy parte de esta escuela',1,'ce_p1',1,1,1),(262,'Antes de una prueba, reviso cómo estudiar la materia',2,'ce_p2',1,3,1),(263,'Me escapo de clases o me corro de clases',3,'ce_p3',1,2,1),(264,'Salgo sin pedir permiso de la sala',4,'ce_p4',1,2,1),(265,'Puedo ser yo mismo(a) en esta escuela',5,'ce_p5',1,1,1),(266,'Uso distintos recursos (como internet o libros) para entender mejor la información entregada por el profesor (a)',6,'ce_p6',1,3,1),(267,' La mayoría de las cosas que aprendo en la escuela sirven para mi vida',7,'ce_p7',1,1,1),(268,'La mayoría de los profesores(as) se preocupan de que la materia que aprendamos sirva para mi vida ',8,'ce_p8',1,1,1),(269,'Llego atrasado(a) a clases',9,'ce_p9',1,2,1),(270,'Cuando estoy haciendo alguna actividad, me preocupo de entender lo más posible',10,'ce_p10',1,3,1),(271,'Mis apoderados han sido citados por mi mala conducta',11,'ce_p11',1,2,1),(272,'Siento orgullo de estar en esta escuela',12,'ce_p12',1,1,1),(273,'Me tratan con respeto en esta escuela',19,'ce_p19',1,1,1),(274,'Para mí es importante lograr entender bien las tareas y la materia ',20,'ce_p20',1,3,1),(275,'Sé cómo utilizar diferentes formas de estudio para realizar bien mis tareas (como por ejemplo, planificar el trabajo, repasar la materia, estudiar en grupos, etc.)',21,'ce_p21',1,3,1),(276,'Lo que aprendo en clases es importante para lograr lo que quiero en el futuro',22,'ce_p22',1,1,1),(277,'Peleo con mis compañeros en la sala',23,'ce_p23',1,2,1),(278,'Después de terminar mis tareas reviso si están bien',24,'ce_p24',1,3,1),(279,'Mis padres o apoderados(as) me animan a trabajar bien en la escuela',31,'ce_p31',1,4,1),(280,'Me llevo bien con mis compañeros(as) de curso',44,'ce_p44',1,5,1),(281,'Cuando tengo un problema, recibo ayuda de algún(a) profesor(a)  ',34,'ce_p34',1,6,1),(282,'Me llevo bien con mis profesores(as)',37,'ce_p37',1,6,1),(283,'Los profesores(as) se preocupan de mí no sólo como estudiante sino también como persona',38,'ce_p38',1,6,1),(284,'En mi escuela, los profesores(as) y otros(as) adultos(as) tratan a todos los estudiantes con respeto',39,'ce_p39',1,6,1),(285,'En mi escuela, al menos un(a) compañeros(a) me apoya con las tareas difíciles',46,'ce_p46',1,5,1),(286,'Cuando tengo un problema, recibo ayuda de mi familia',32,'ce_p32',1,4,1),(287,'Los profesores(as) se interesan por mí y me ayudan si tengo problemas para hacer las tareas ',36,'ce_p36',1,6,1),(288,'En esta escuela, se valora la participación y la opinión de todos(as)',40,'ce_p40',1,6,1),(289,'Los profesores(as) me animan a realizar nuevamente una tarea si me equivoco',35,'ce_p35',1,6,1),(290,'Después de una prueba,  reviso si las respuestas fueron las correctas',13,'ce_p13',1,3,1),(291,'Sé cómo cambiar mi manera de estudiar para mejorar y obtener mejores notas',14,'ce_p14',1,3,1),(292,'Para mí es muy importante lo que hacemos en la escuela ',15,'ce_p15',1,1,1),(293,'Me porto bien en clases',16,'ce_p16',1,2,1),(294,'Cuando comienzo una tarea, recuerdo lo que he aprendido de la materia porque eso me ayuda a comprender mejor',17,'ce_p17',1,3,1),(295,'Cuando estudio, anoto palabras nuevas, dudas o ideas importantes',18,'ce_p18',1,3,1),(296,'Cuando termino una tarea, pienso si la hice bien',25,'ce_p25',1,3,1),(297,'Pongo atención a los comentarios que los profesores hacen sobre mis trabajos',26,'ce_p26',1,3,1),(298,'Siento que soy importante para la escuela',27,'ce_p27',1,1,1),(299,'Me mandan a la oficina del director o del inspector general por mi mala conducta',28,'ce_p28',1,2,1),(300,'Me siento bien en esta escuela',29,'ce_p29',1,1,1),(301,'Mis compañeros(as) me apoyan y se preocupan por mí',41,'ce_p41',1,5,1),(302,'Mis compañeros(as) de la escuela son importantes para mí',43,'ce_p43',1,5,1),(303,'Siento que soy importante para mis compañeros(as) de la escuela',45,'ce_p45',1,4,1),(304,'Cuando no entiendo algo, mis compañeros(as) me explican',47,'ce_p47',1,5,1),(305,'Mis profesores(as) quieren que aprenda mucho',33,'ce_p33',1,6,1),(306,'Puedo confiar en mis compañeros(as)',42,'ce_p42',1,5,1),(307,'Hablo con mi familia sobre lo que hago en la escuela',30,'ce_p30',1,4,1);
/*!40000 ALTER TABLE `ce_preguntas` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;



INSERT INTO `ce_doc_documentos` VALUES (1,'COMPROMISO_ESCOLAR_PROMOCIN_DE_TRAYECTORIAS_EDUCATIVAS_Y_PREVENCIN_DE_LA_DESERCIN(youtube.com)','documentos/material/','assets/img/video-player.svg','mp4',4,NULL),(2,'Investigadores_por_el_Mundo_Dra_Mahia_Saracostti(youtube.com)','documentos/material/','assets/img/video-player.svg','mp4',4,NULL),(3,'DINAM_CONOZCO_MI_HIJO','documentos/material/','assets/img/pdf.svg','pdf',1,2),(4,'FICHA_COMUNIC_HIJOS','documentos/material/','assets/img/pdf.svg','pdf',1,2),(5,'APRENDIZAJE_SIGNIFICATIVO','documentos/material/','assets/img/pdf.svg','pdf',1,1),(6,'DINAM_RESOLUCION_CONF','documentos/material/','assets/img/pdf.svg','pdf',1,1),(7,'FICHA_MAPAS_CONCEPTUALES','documentos/material/','assets/img/pdf.svg','pdf',1,1),(8,'FICHA_SILLAS_COOPERATIVAS','documentos/material/','assets/img/pdf.svg','pdf',1,1),(9,'FICHA_TELARAÑA','documentos/material/','assets/img/pdf.svg','pdf',1,1),(10,'REP_ALTO_COMP_FACT_FACILITADORES','documentos/material/','assets/img/pdf.svg','pdf',1,3),(11,'REP_ALTO_COMP_FACT_LIMITANTES','documentos/material/','assets/img/pdf.svg','pdf',1,3),(12,'REP_BAJO_COMP_FACT_FACILITADORES','documentos/material/','assets/img/pdf.svg','pdf',1,3),(13,'REP_BAJO_COMP_FACT_LIMITANTES','documentos/material/','assets/img/pdf.svg','pdf',1,3),(14,'acciones correción- octavo','documentos/material/','assets/img/pdf.svg','pdf',1,3),(15,'FOLLETO PARA PADRES','documentos/material/','assets/img/pdf.svg','pdf',1,3),(16,'PLAN DE TRABAJO PARAPADRES Y APODERADOS 2019','documentos/material/','assets/img/pdf.svg','pdf',1,3),(17,'Investigadores por el Mundo Dra. Mahia Saracostti','documentos/material/','assets/img/video-player.svg','mp4',4,3),(18,'COMPROMISO ESCOLAR, PROMOCIÓN DE TRAYECTORIAS EDUCATIVAS Y PREVENCIÓN DE LA DESERCIÓN','documentos/material/','assets/img/video-player.svg','mp4',4,3),(19,'Manual de Usuario Plataforma Compromiso Escolar ','documentos/material/','assets/img/doc.svg','docx',2,3);
/*!40000 ALTER TABLE `ce_doc_documentos` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2020-01-23 15:37:46

-- Dump completed on 2020-01-23 15:58:10

INSERT INTO `ce_dimension` VALUES (1,'AFECTIVOS','AFEC'),(2,'CONDUCTUALES','CON'),(3,'COGNITIVOS','COG'),(4,'FAMILIA','FAM'),(5,'PARES','PAR'),(6,'PROFESORES','PROS');
/*!40000 ALTER TABLE `ce_dimension` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2020-01-23 15:26:08

INSERT INTO `ce_pais` VALUES (1,'Chile',NULL),(2,'Uruguay',NULL),(3,'Perú',NULL),(4,'Colombia',NULL),(5,'España',NULL);
/*!40000 ALTER TABLE `ce_pais` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2020-01-23 15:55:13

INSERT INTO `ce_niveles` VALUES (1,'BÁSICO','2018-12-18 01:27:01','2018-12-18 01:27:04'),(2,'MEDIO','2018-12-18 01:26:57','2018-12-18 01:26:59');
/*!40000 ALTER TABLE `ce_niveles` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2020-01-23 15:51:28

/*!40000 ALTER TABLE `ce_usuarios` DISABLE KEYS */;
INSERT INTO `ce_usuarios` VALUES (140,'administrador','2019.-deve.tic',NULL,NULL,NULL);
/*!40000 ALTER TABLE `ce_usuarios` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2020-01-23 18:41:13


/*!40000 ALTER TABLE `ce_rol_user` DISABLE KEYS */;
INSERT INTO `ce_rol_user` VALUES (140,140,4);
/*!40000 ALTER TABLE `ce_rol_user` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2020-01-23 19:01:03






