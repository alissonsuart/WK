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
-- Table structure for table `produtos`
--

DROP TABLE IF EXISTS `produtos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `produtos` (
  `idProduto` int NOT NULL AUTO_INCREMENT,
  `descricao` varchar(50) NOT NULL,
  `preco` decimal(15,2) NOT NULL,
  PRIMARY KEY (`idProduto`)
) ENGINE=InnoDB AUTO_INCREMENT=26 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `produtos`
--

LOCK TABLES `produtos` WRITE;
/*!40000 ALTER TABLE `produtos` DISABLE KEYS */;
INSERT INTO `produtos` VALUES (1,'BOLO - BEM CASADO FRACIONADO',71.00),(2,'KC20-AGUA DE COCO KERO COCO 200ML',3.30),(3,'AGUA DE COCO SOCOCO 200ML',2.95),(4,'AGUA DE COCO KERO COCO 330ML',4.75),(5,'AGUA - CRYSTAL COM GAS PET 500ML',2.00),(6,'AGUA - CRYSTAL SEM GAS PET 500ML',1.80),(7,'SUCO ALL - CAJU 1L',12.15),(8,'SUCO ALL - CAJU 300ML',6.10),(9,'SUCO ALL - MARACUJA 300ML',6.10),(10,'DEL VALE FRUT 450ML UVA',3.40),(11,'DEL VALE - 200ML - UVA',2.70),(12,'DEL VALE - 1 LT - ABACAXI',8.25),(13,'DEL VALE - 1 LT - GOIABA',8.25),(14,'DEL VALE - 1 LT - LARANJA',8.60),(15,'DEL VALE - 1 LT - MANGA',8.60),(16,'DEL VALE - 1 LT - PESSEGO',8.60),(17,'DEL VALE - 1 LT - UVA',8.85),(18,'SUCO ALL - LARANJA 1 L',12.15),(19,'DEL VALE - LATA 290ML - GOIABA',3.60),(20,'DEL VALE - LATA 290ML  - MARACUJA',3.60),(21,'DEL VALE - LATA 290ML - MANGA',3.25),(22,'DEL VALE - LATA 290ML - UVA',3.60),(23,'DEL VALE - 1 LT - MARACUJA',7.60),(24,'SUCO ALL - TAMARINDO 300ML',6.10),(25,'SUCO ALL - MANGA 300ML',6.10);
/*!40000 ALTER TABLE `produtos` ENABLE KEYS */;
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
