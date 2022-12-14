-- MySQL dump 10.13  Distrib 8.0.31, for Win64 (x86_64)
--
-- Host: localhost    Database: banco_teste
-- ------------------------------------------------------
-- Server version	8.0.31

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `clientes`
--

DROP TABLE IF EXISTS `clientes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `clientes` (
  `idCliente` int NOT NULL AUTO_INCREMENT,
  `nome` varchar(100) NOT NULL,
  `cidade` varchar(100) NOT NULL,
  `uf` varchar(2) NOT NULL,
  PRIMARY KEY (`idCliente`)
) ENGINE=InnoDB AUTO_INCREMENT=26 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `clientes`
--

LOCK TABLES `clientes` WRITE;
/*!40000 ALTER TABLE `clientes` DISABLE KEYS */;
INSERT INTO `clientes` VALUES (1,'Zeta Sistema de Ensino de Birigui Ltda','Birigui','SP'),(2,'Banco J Safra SA','São Paulo','SP'),(3,'Romeiro Barboza Calcados e Aces Ltda','Birigui','SP'),(4,'Editora Lista Mais Eirelli EPP','Presidente Prudente','SP'),(5,'BRNPAR Empreendimentos Imobiliarios LTDA','Araras','SP'),(6,'Escritorio Contabi Serviços Contabeis Ltda','Birigui','SP'),(7,'Engeuni Engenharia Ltda','Birigui','SP'),(8,'Noele Fogaça','Birigui','SP'),(9,'Banco Mercantil do Brasil','Birigui','SP'),(10,'Camara Municipal de Birigui','Birigui','SP'),(11,'Isa Rocha','Birigui','SP'),(12,'MS Marketing e Desenvolvimento Ltda ME','Birigui','SP'),(13,'Ssoil Energy S.A','Coroados','SP'),(14,'Igarata Turismo Eireli ME','Corumbá','MS'),(15,'D.A. Aviação LTDA','Birigui','SP'),(16,'D A Aviaçao Ltda','Birigui','SP'),(17,'Lowell Cosméticos do Brasil Ltda','Itapira','SP'),(18,'Sabioni Correspondente Ltda','Birigui','SP'),(19,'LC Componentes e Acessorios para Calçados Ltda','Birigui','SP'),(20,'Buendia Distribuidora de Produtos Agropecuarios','Araçatuba','SP'),(21,'Iguarias Boteco Chiq Comercial Ltda ME','Birigui','SP'),(22,'JR Shoes Comercio de Calçados Ltda','Birigui','SP'),(23,'Fabrica La Femme Calçados','Birigui','SP'),(24,'LIKE Produção Audiovisual Eireli EPP','Campinas','SP'),(25,'Duetto Pérola Spe incorporação e construção Ltda','Birigui','SP');
/*!40000 ALTER TABLE `clientes` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2022-12-14  0:36:43
