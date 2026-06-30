# Wazuh + YARA + Ollama Security Lab

## Overview

This repository documents a security laboratory built to practice Linux administration, security monitoring, automation, and basic DevOps concepts.

The lab consists of three virtual machines connected in an isolated environment:

- Kali Linux – attack workstation
- Ubuntu Agent – monitored Linux endpoint
- Wazuh Server – SIEM, log management, and AI analysis server

The project demonstrates two independent security scenarios commonly encountered in Security Operations Centers (SOC).

---

## Architecture

```
                    +------------------+
                    |   Kali Linux     |
                    |      Hydra       |
                    +--------+---------+
                             |
                     SSH Dictionary Attack
                             |
                             v
                    +------------------+
                    |  Ubuntu Agent    |
                    | Wazuh Agent/FIM  |
                    +--------+---------+
                             |
                     File Events / Logs
                             |
                             v
                    +------------------+
                    |  Wazuh Server    |
                    | Active Response  |
                    +--------+---------+
                             |
                    +--------+--------+
                    |                 |
                  YARA           Ollama AI
                    |                 |
                    +--------+--------+
                             |
                     Security Analysis
```

---

## Scenario 1 – SSH Dictionary Attack Detection

This scenario demonstrates how authentication attacks can be detected and investigated.

### Workflow

1. A dictionary attack is launched from Kali Linux using Hydra.
2. Hydra attempts to authenticate to the Ubuntu Agent via SSH.
3. Ubuntu records failed and successful authentication attempts.
4. Wazuh collects and correlates authentication events.
5. The attack can be investigated using Linux authentication logs and the Wazuh dashboard.

---

## Scenario 2 – File Integrity Monitoring with AI-assisted Analysis

This scenario demonstrates an automated incident detection and analysis pipeline.

### Workflow

1. An EICAR test file is created on the Ubuntu Agent.
2. Wazuh File Integrity Monitoring detects the file creation.
3. Active Response automatically executes a custom Bash script.
4. YARA scans the file for known malware signatures.
5. Detection results are sent to a locally hosted Ollama model through its REST API.
6. Ollama generates an AI-assisted security assessment.
7. The analysis is written to the Active Response log.

---

## Technologies

- Linux
- Wazuh SIEM
- File Integrity Monitoring (FIM)
- Active Response
- Bash
- YARA
- Ollama
- REST API
- jq
- Hydra
- SSH
- Git

---

## Skills Demonstrated

- Linux administration
- Security monitoring
- Bash scripting
- File Integrity Monitoring
- Active Response automation
- YARA integration
- REST API integration
- AI-assisted security analysis
- Log analysis
- Troubleshooting
- Incident investigation

---

## Educational Purpose

This project was created to gain hands-on experience with:

- Linux administration
- Security monitoring
- SOC workflows
- Detection engineering
- Bash automation
- AI integration in cybersecurity
- Troubleshooting distributed systems
