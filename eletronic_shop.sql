-- MySQL dump 10.13  Distrib 8.0.46, for Win64 (x86_64)
--
-- Host: localhost    Database: eletronic_shop
-- ------------------------------------------------------
-- Server version	8.0.46

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
-- Table structure for table `celular`
--

DROP TABLE IF EXISTS `celular`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `celular` (
  `id_eletronico` int NOT NULL,
  `memoria_ram` int NOT NULL,
  `taxa_imposto` decimal(4,2) DEFAULT '1.05',
  PRIMARY KEY (`id_eletronico`),
  CONSTRAINT `celular_ibfk_1` FOREIGN KEY (`id_eletronico`) REFERENCES `eletronico` (`id_eletronico`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `celular`
--

LOCK TABLES `celular` WRITE;
/*!40000 ALTER TABLE `celular` DISABLE KEYS */;
INSERT INTO `celular` VALUES (1,8,1.05),(2,12,1.05),(3,6,1.05);
/*!40000 ALTER TABLE `celular` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cliente`
--

DROP TABLE IF EXISTS `cliente`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `cliente` (
  `id_cliente` int NOT NULL AUTO_INCREMENT,
  `nome` varchar(100) NOT NULL,
  `email` varchar(100) NOT NULL,
  `telefone` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`id_cliente`),
  UNIQUE KEY `email` (`email`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cliente`
--

LOCK TABLES `cliente` WRITE;
/*!40000 ALTER TABLE `cliente` DISABLE KEYS */;
INSERT INTO `cliente` VALUES (1,'João Silva','joao@email.com','11988887777'),(2,'Maria Oliveira','maria@email.com','11977776666'),(3,'Carlos Souza','carlos@email.com','11966665555'),(4,'Ana Costa','ana@email.com','11955554444'),(5,'Lucas Pereira','lucas@email.com','11944443333');
/*!40000 ALTER TABLE `cliente` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `eletronico`
--

DROP TABLE IF EXISTS `eletronico`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `eletronico` (
  `id_eletronico` int NOT NULL AUTO_INCREMENT,
  `nome` varchar(100) NOT NULL,
  `marca` varchar(50) NOT NULL,
  `preco_base` decimal(10,2) NOT NULL,
  `prazo_garantia_meses` int NOT NULL,
  `termos_garantia` text NOT NULL,
  PRIMARY KEY (`id_eletronico`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `eletronico`
--

LOCK TABLES `eletronico` WRITE;
/*!40000 ALTER TABLE `eletronico` DISABLE KEYS */;
INSERT INTO `eletronico` VALUES (1,'iPhone 15','Apple',5000.00,12,'Garantia de 12 meses contra defeitos de fabrica, garantia oferecida pelo fabricante !'),(2,'Galaxy S24','Samsung',4200.00,12,'Garantia de 12 meses contra defeitos de fabrica, garantia oferecida pelo fabricante !'),(3,'Redmi Note 13','Xiaomi',1500.00,12,'Garantia de 12 meses contra defeitos de fabrica, garantia oferecida pelo fabricante !'),(4,'MacBook Air M2','Apple',8000.00,24,'Garantia de 24 meses contra defeitos de fabrica, garantia oferecida pelo fabricante !'),(5,'Dell Inspiron 15','Dell',3500.00,24,'Garantia de 24 meses contra defeitos de fabrica, garantia oferecida pelo fabricante !'),(6,'Lenovo Legion 5','Lenovo',6000.00,24,'Garantia de 24 meses contra defeitos de fabrica, garantia oferecida pelo fabricante !');
/*!40000 ALTER TABLE `eletronico` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `item_venda`
--

DROP TABLE IF EXISTS `item_venda`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `item_venda` (
  `id_item` int NOT NULL AUTO_INCREMENT,
  `id_venda` int NOT NULL,
  `id_eletronico` int NOT NULL,
  `quantidade` int NOT NULL,
  `preco_praticado` decimal(10,2) NOT NULL,
  PRIMARY KEY (`id_item`),
  KEY `id_venda` (`id_venda`),
  KEY `id_eletronico` (`id_eletronico`),
  CONSTRAINT `item_venda_ibfk_1` FOREIGN KEY (`id_venda`) REFERENCES `venda` (`id_venda`),
  CONSTRAINT `item_venda_ibfk_2` FOREIGN KEY (`id_eletronico`) REFERENCES `eletronico` (`id_eletronico`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `item_venda`
--

LOCK TABLES `item_venda` WRITE;
/*!40000 ALTER TABLE `item_venda` DISABLE KEYS */;
INSERT INTO `item_venda` VALUES (1,1,1,1,5250.00),(2,2,4,1,8800.00),(3,3,3,1,1575.00),(4,4,5,1,3850.00),(5,5,6,1,6600.00);
/*!40000 ALTER TABLE `item_venda` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `notebook`
--

DROP TABLE IF EXISTS `notebook`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `notebook` (
  `id_eletronico` int NOT NULL,
  `processador` varchar(50) NOT NULL,
  `taxa_imposto` decimal(4,2) DEFAULT '1.10',
  PRIMARY KEY (`id_eletronico`),
  CONSTRAINT `notebook_ibfk_1` FOREIGN KEY (`id_eletronico`) REFERENCES `eletronico` (`id_eletronico`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `notebook`
--

LOCK TABLES `notebook` WRITE;
/*!40000 ALTER TABLE `notebook` DISABLE KEYS */;
INSERT INTO `notebook` VALUES (4,'Apple M2',1.10),(5,'Intel Core i5',1.10),(6,'AMD Ryzen 7',1.10);
/*!40000 ALTER TABLE `notebook` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `venda`
--

DROP TABLE IF EXISTS `venda`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `venda` (
  `id_venda` int NOT NULL AUTO_INCREMENT,
  `id_cliente` int NOT NULL,
  `data_venda` datetime NOT NULL,
  `valor_total` decimal(10,2) NOT NULL,
  PRIMARY KEY (`id_venda`),
  KEY `id_cliente` (`id_cliente`),
  CONSTRAINT `venda_ibfk_1` FOREIGN KEY (`id_cliente`) REFERENCES `cliente` (`id_cliente`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `venda`
--

LOCK TABLES `venda` WRITE;
/*!40000 ALTER TABLE `venda` DISABLE KEYS */;
INSERT INTO `venda` VALUES (1,1,'2026-10-01 10:30:00',5250.00),(2,2,'2026-10-02 14:15:00',8800.00),(3,3,'2026-10-03 16:45:00',1575.00),(4,4,'2026-10-05 11:00:00',3850.00),(5,5,'2026-10-07 09:20:00',6600.00);
/*!40000 ALTER TABLE `venda` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2026-10-12 12:55:32
