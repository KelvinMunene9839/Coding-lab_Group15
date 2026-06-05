# Kenyatta National Hospital System — Coding Lab Group 15

A bash-scripted hospital monitoring system that simulates patient sensor data, manages log rotation, and generates clinical reports.

---

## Group Roles

| Member | Name | Role | Contribution |
|--------|------|------|-------------|
| M1 | Sage Lessly Rusagara | The Architect | `hospital_admin.sh` — system initialization |
| M2 | Liza Joella Ituze | The Security Lead | `hospital_admin.sh` — security hardening |
| M3 | Lana Lysley Keza | The Orchestrator | `hospital_admin.sh` — service setup |
| M4 | Liliose Muhimpundu Gashugi | The Archivist | `hospital_archive.sh` — log rotation & archiving |
| M5 | Rusagara Lessly Sage | Clinical Analyst | `hospital_analysis.sh` — critical vitals report |
| M6 | Kelvin Munene Nyagah | Facility Auditor | `hospital_analysis.sh` — water audit, `.gitignore`, `README.md` |

---

## Project Structure

```
Coding-lab_Group15/
├── hospital_system.py      # Engine — simulates sensor data (heart rate, temp, water)
├── hospital_admin.sh       # M1-M3 — initializes directories and secures permissions
├── hospital_archive.sh     # M4   — rotates and archives active logs
├── hospital_analysis.sh    # M5-M6 — generates critical alerts and water audit report
├── .gitignore              # Excludes logs and generated reports
└── README.md               # This file
```

Generated at runtime (excluded from git):

```
active_logs/                # Live sensor logs written by the engine
archived_logs/              # Timestamped rotated log copies
reports/                    # Analysis output files
```

---

## Quick Start (Full Workflow)

Run these steps in order:

```bash
# 1. Initialize directories and secure permissions
chmod +x hospital_admin.sh
./hospital_admin.sh

# 2. Start the sensor engine (runs in background)
python3 hospital_system.py start

# 3. Let it collect data for a few seconds, then archive logs
chmod +x hospital_archive.sh
./hospital_archive.sh

# 4. Run analysis and generate reports
chmod +x hospital_analysis.sh
./hospital_analysis.sh

# 5. Stop the engine when done
python3 hospital_system.py stop
```

---

## Script 1: `hospital_system.py` — The Engine

Simulates three categories of hospital sensor devices writing to `active_logs/`:

| Log file | Devices | Data range | Status levels |
|----------|---------|-----------|---------------|
| `heart_rate_log.log` | 5 × `WARD_A_HR_*` | 45–150 BPM | NORMAL / WARNING / CRITICAL |
| `temperature_log.log` | 5 × `WARD_B_TEMP_*` | 34.5–40.5 °C | NORMAL / WARNING / CRITICAL |
| `water_usage_log.log` | `FACILITY_WATER_MAIN`, `ICU_WATER_RESERVE` | 5–45 L/min | NORMAL / HIGH_USAGE |

The engine writes one row per device per second and runs as a background daemon.

```bash
python3 hospital_system.py start   # Launch the daemon
python3 hospital_system.py stop    # Terminate the daemon
```

---

## Script 2: `hospital_admin.sh` — System Setup (M1–M3)

### M1 — Directory Initialization

`initialize_system()` creates the three required directories if they do not exist:

- `active_logs/` — live incoming sensor data
- `archived_logs/` — rotated historical logs
- `reports/` — generated analysis files

### M2 / M3 — Security Hardening

`secure_data()` sets `chmod 700` on `active_logs/`, restricting access to the owner only.

```bash
chmod +x hospital_admin.sh
./hospital_admin.sh
```

---

## Script 3: `hospital_archive.sh` — Log Rotation (M4)

Rotates every `.log` file out of `active_logs/` and into `archived_logs/` with a timestamp suffix, then recreates empty log files so the engine can continue writing without interruption.

**Archive naming format:** `<name>_YYYYMMDD_HHMM.log`

**Example:**
```
active_logs/heart_rate_log.log  →  archived_logs/heart_rate_20260605_1430.log
```

```bash
chmod +x hospital_archive.sh
./hospital_archive.sh
```

---

## Script 4: `hospital_analysis.sh` — Reporting (M5–M6)

### M5 — Critical Vitals Report

`process_vitals()` scans both `heart_rate_log.log` and `temperature_log.log` for `CRITICAL` entries and writes a summary to `reports/critical_alerts.txt`.

Report columns: `Timestamp | Device_ID | Value`

### M6 — Water Usage Audit

`water_audit()` filters `water_usage_log.log` for `ICU_WATER_RESERVE` readings and computes:

- Total records
- Total usage (litres)
- Average usage per reading (litres)

```bash
chmod +x hospital_analysis.sh
./hospital_analysis.sh
```

---

## .gitignore

The following paths are excluded from version control because they are generated at runtime:

| Path | Reason |
|------|--------|
| `active_logs/` | Live sensor data — changes every second |
| `archived_logs/` | Rotated log archives — can be large |
| `reports/` | Generated analysis output |
| `/tmp/hospital_system.pid` | Daemon PID file |
| `__pycache__/`, `*.pyc` | Python bytecode |
| `.DS_Store`, `Thumbs.db` | OS-generated metadata |
| `.vscode/`, `.idea/` | Local editor config |
