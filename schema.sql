CREATE DATABASE IF NOT EXISTS notes_automation;
USE notes_automation;
-- MySQL dump 10.13  Distrib 8.0.43, for Win64 (x86_64)
--
-- Host: localhost    Database: notes_automation
-- ------------------------------------------------------
-- Server version	9.4.0

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
-- Table structure for table `summarized_notes`
--

DROP TABLE IF EXISTS `summarized_notes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `summarized_notes` (
  `id` int NOT NULL AUTO_INCREMENT,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `context_type` varchar(100) DEFAULT NULL,
  `urgency` varchar(20) DEFAULT NULL,
  `action_items_count` int DEFAULT NULL,
  `raw_word_count` int DEFAULT NULL,
  `summary_word_count` int DEFAULT NULL,
  `clean_summary` text,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `summarized_notes`
--

LOCK TABLES `summarized_notes` WRITE;
/*!40000 ALTER TABLE `summarized_notes` DISABLE KEYS */;
INSERT INTO `summarized_notes` VALUES (1,'2026-11-24 09:17:52','Lab Hardware Test Log','Medium',2,26,62,'### Test Overview\n- **Device under Test:** Sensor Module v2\n- **Test Duration:** 25 minutes\n- **Input Load:** 12V\n\n### Observations\n- **Thermal:** Temperature spiked to 76°C during the test period.\n- **Power:** Observed a slight voltage dip under load conditions.\n\n### Follow-up Actions\n- Inspect voltage regulator **U3** (Scheduled: Tomorrow).\n- Retest the module with a thermal pad installed (Assigned: **Arun**).'),(2,'2026-11-24 09:35:54','Project Standup Meeting','Medium',2,22,44,'### Project Standup Summary\n\n**Backend Development**\n* **Status:** Delayed by 1 day.\n* **Issue:** Authentication bug identified.\n* **Task:** Priya is currently fixing the token refresh logic; completion expected today.\n\n**UI Development**\n* **Status:** Dashboard is ready for the demo scheduled for tomorrow morning.'),(3,'2026-11-24 09:39:21','hackathon dashboard prompt','High',4,113,231,'### Intelligent Hospitality Dashboard: Strategy & Innovation\n**Objective:** Transform a standard occupancy and profit dashboard into an AI-driven ecosystem providing market-leading insights and Nth-level data transparency.\n\n**Innovative Intelligence Features:**\n* **Predictive Demand Forecasting:** Utilize machine learning to integrate external variables (local events, flight data, weather) to forecast occupancy and revenue fluctuations.\n* **Automated Prescriptive Analytics:** Move beyond \'what happened\' to \'what to do,\' offering dynamic pricing suggestions to optimize Revenue Per Available Room (RevPAR).\n* **Sentiment-Profit Correlation:** Integrate NLP-driven guest feedback analysis to visualize how service quality directly impacts the bottom line.\n* **Digital Twin Simulations:** A \'What-If\' engine to model the financial impact of operational changes or marketing spend before execution.\n\n**Key Defining Features of Dashboard Intelligence:**\n* **Nth-Level Granularity:** A unified data architecture allowing a single-click drill-down from global portfolio KPIs to individual room-level transaction details.\n* **Real-time Anomaly Detection:** Automated alerts for unexpected shifts in booking lead times, cancellation rates, or margin leakage.\n* **Contextual External Benchmarking:** Real-time integration of competitor pricing and market occupancy for relative performance assessment.\n\n**Targeted Hospitality Roles (Top 5):**\n1. **Revenue Manager:** To execute high-frequency pricing and inventory strategies.\n2. **General Manager:** To oversee total P&L and operational efficiency.\n3. **Director of Marketing:** To analyze guest acquisition costs and campaign ROI.\n4. **Operations Manager:** To align staffing levels with predictive occupancy forecasts.\n5. **Asset Manager/Owner:** To monitor long-term capital appreciation and portfolio yield.'),(4,'2026-11-24 10:15:46','hackathon dashboard prompt','High',5,113,251,'# Intelligent Hospitality Hackathon Dashboard: Strategic Requirements\n\n## Objective\nTo develop a market-leading, profit-impacting dashboard that utilizes advanced data analytics and AI to optimize occupancy and revenue. The system must transition from descriptive reporting to prescriptive intelligence.\n\n## Defining the \'Intelligent Dashboard\'\n*   **Nth-Level Granularity:** Users must be able to drill down from high-level KPIs to granular transactional or guest-level data via a single-click interface.\n*   **Predictive Forecasting:** Moving beyond historical data to predict occupancy trends and profit margins based on market fluctuations.\n*   **Automated Anomaly Detection:** Real-time alerts for unusual booking patterns or sudden profit drops.\n\n## Innovative & Out-of-the-Box Ideas\n*   **Contextual Market Intelligence:** Integration of local event APIs (concerts, conferences, weather) to suggest dynamic pricing adjustments automatically.\n*   **Sentiment-Revenue Correlation:** Integrating NLP-processed guest reviews with financial data to visualize how service quality directly impacts the bottom line.\n*   **Digital Twin Simulation:** A \'What-If\' sandbox allowing managers to simulate the impact of pricing changes or operational shifts on occupancy before implementation.\n*   **Hyper-Personalized Upsell Engine:** AI recommendations for targeted guest offers based on real-time occupancy gaps.\n\n## Top 5 Key Roles Using the Dashboard\n1.  **General Manager (GM):** For high-level operational health and strategic oversight.\n2.  **Revenue Manager:** To manage dynamic pricing, distribution channels, and yield optimization.\n3.  **Director of Sales & Marketing:** To track campaign ROI and market penetration.\n4.  **Operations/Front Office Manager:** To manage daily occupancy, staffing levels, and guest flow.\n5.  **Financial Controller:** To monitor profit margins, cost per occupied room (CPOR), and overall financial performance.'),(5,'2026-11-24 11:20:23','Production Telemetry & Data Pipeline Incident Review','High',5,187,165,'### Incident Overview\n- **Event:** ETL job #402 (`sensor_ingest_v3`) failure at 02:15 UTC.\n- **Root Cause:** Malformed JSON and null timestamps originating from firmware v1.8.2, leading to schema drift. Initial theories regarding network timeouts on nodes B and C were dismissed.\n- **Impact:** Throughput plummeted >65% (from 12k to <4k rows/sec), creating a high risk of SLA breach for client batch #99.\n- **System Status:** Kafka broker CPU remains healthy at 38%; no restart required.\n\n### Action Items\n1. **Python Ingestion Patch (Priya):** Update the validator to quarantine `null_ts` rows rather than crashing the batch. **Deadline: 6:00 PM today.**\n2. **Firmware Rollback (Karthik):** Revert firmware v1.8.2 on test rig #4 and perform payload checksum verification.\n3. **Data Backfill (Deepa):** Recover 3.5 hours of telemetry data into MySQL `staging_db` following the validator deployment.\n4. **Stakeholder Communication (Author):** Add incident banner to Power BI executive SLA dashboard and notify Ops Lead by EOD.\n5. **Disk Maintenance:** Clean up ~40GB of temporary CSV dumps in `/tmp/test_dump_final_v2*` tomorrow morning.');
/*!40000 ALTER TABLE `summarized_notes` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2026-11-24 17:01:40
