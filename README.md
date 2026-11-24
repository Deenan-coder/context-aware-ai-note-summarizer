[Readme-.md](https://github.com/user-attachments/files/35329221/Readme-.md)
# Context-Aware AI Note Summarizer & Automated Data Logging Pipeline

An end-to-end automated data pipeline built with **n8n**, **LLMs (Google Gemini)**, **JavaScript**, **MySQL**, and the **Telegram Bot API**. This system converts unstructured, messy field notes, meeting dumps, and incident logs into structured, context-aware summaries while simultaneously logging quantitative text-compression and urgency metrics into a relational database for downstream analytics.

---

## Problem Statement
Manual documentation of technical tests, standup meetings, and production incident calls is slow, inconsistent, and difficult to query later. Unstructured text trapped in chat logs lacks metadata (such as urgency levels, action item counts, and concise summaries), preventing teams from tracking operational trends in BI tools like Power BI.

## Solution & Impact
* **Automated Structuring:** Ingests raw text via Telegram (`Context:` and `Notes:` format) and uses context-aware prompt engineering to produce clean, bulleted summaries without hallucinating external facts.
* **Quantitative Telemetry:** Tracks `raw_word_count`, `summary_word_count`, `urgency`, and `action_items_count` for every submission to measure information compression and operational priority.
* **End-to-End Speed:** Reduces manual note structuring and database record-keeping from **~10–15 minutes** per incident report to **<10 seconds** automated execution.

---

## Pipeline Architecture

```text
[Telegram Trigger] 
       │  (Receives raw message via HTTPS Webhook / Cloudflare Tunnel)
       ▼
[Parse Input (JS)] 
       │  (Extracts Context, isolates raw notes, calculates raw_word_count)
       ▼
[Basic LLM Chain] 
       │  (Generates context-specific summary + strict JSON metadata)
       ▼
[Format Metrics (JS)] 
       │  (Sanitizes JSON, computes summary_word_count, structures payload)
       ▼
[MySQL Insert] 
       │  (Logs structured row into notes_automation.summarized_notes)
       ▼
[Telegram Reply] 
          (Escapes HTML entities, formats bold headings, delivers to user)
```

### Engineering Highlights
* **Deterministic JSON Extraction:** Enforces strict JSON schema output from the LLM (`clean_summary`, `urgency`, `action_items_count`) with regex fallback sanitization in JavaScript.
* **Resilient Telegram Delivery:** Escapes special characters (`&`, `<`, `>`) and converts Markdown headings/bold markers into Telegram-safe HTML `<b>` tags to prevent entity-parsing failures on complex technical logs.
* **Containerized Persistence:** Deployed locally using Docker with persistent volumes (`n8n_data`) and bridged to host MySQL (`host.docker.internal`).

---

## Tech Stack
* **Workflow Orchestration:** n8n (Self-hosted via Docker)
* **AI / LLM:** Google Gemini Chat Model (LangChain Basic LLM Chain)
* **Data Transformation:** JavaScript (Regex parsing & JSON validation)
* **Database:** MySQL 9.4 (`notes_automation` schema)
* **Interface & Tunneling:** Telegram Bot API, Cloudflare Tunnel (`cloudflared`)

---

## Database Schema & Analytics (`MySQL`)

The pipeline logs every processed note into `notes_automation.summarized_notes` (see `schema.sql` for the full DDL script):

| Column | Type | Description |
| :--- | :--- | :--- |
| `id` | `INT (PK, Auto)` | Unique record identifier |
| `created_at` | `TIMESTAMP` | Automated UTC/local ingestion timestamp |
| `context_type` | `VARCHAR(100)` | Domain/category (e.g., *Lab Hardware Test Log*, *Incident Review*) |
| `urgency` | `VARCHAR(20)` | AI-classified priority (`Low`, `Medium`, `High`) |
| `action_items_count` | `INT` | Number of follow-up tasks extracted |
| `raw_word_count` | `INT` | Word count of original unstructured input |
| `summary_word_count` | `INT` | Word count of generated structured summary |
| `clean_summary` | `TEXT` | Formatted summary text |

### Sample Analytical Query (For Power BI / Reporting)
```sql
SELECT 
    context_type,
    COUNT(*) AS total_logs,
    ROUND(AVG(raw_word_count), 1) AS avg_input_words,
    ROUND(AVG(summary_word_count), 1) AS avg_output_words,
    SUM(action_items_count) AS total_action_items
FROM notes_automation.summarized_notes
GROUP BY context_type;
```

---

## Setup & Installation

1. **Database Setup:** Execute `schema.sql` in MySQL Workbench to create the `notes_automation` database and `summarized_notes` table.
2. **Start HTTPS Tunnel:** Expose local port `5678` using Cloudflare Tunnel:
   ```bash
   cloudflared tunnel --url http://localhost:5678
   ```
3. **Launch n8n via Docker:**
   ```bash
   docker run -it --rm --name n8n -p 5678:5678 -e WEBHOOK_URL="<YOUR_CLOUDFLARE_HTTPS_URL>" -v n8n_data:/home/node/.n8n docker.n8n.io/n8nio/n8n
   ```
4. **Import Workflow:** Open `http://localhost:5678`, import `workflow.json`, configure your **Telegram Bot API**, **Google Gemini API**, and **MySQL** (`host.docker.internal`) credentials, and activate the workflow.

---

## Repository Structure
```text
├── workflow.json      # Exported n8n 6-node automation workflow
├── schema.sql         # MySQL database and table DDL script
└── README.md          # Project documentation and architecture guide
```
