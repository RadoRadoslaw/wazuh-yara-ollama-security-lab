# Project Summary

## Objective

The goal of this project was to build a practical cybersecurity laboratory to better understand security monitoring, Linux administration, incident detection, and automation.

Rather than studying individual tools separately, I wanted to integrate them into a complete workflow similar to what a SOC analyst or Linux/DevOps engineer might encounter.

---

## Environment

The laboratory consists of three virtual machines:

- Kali Linux – attack machine
- Ubuntu Agent – monitored endpoint
- Wazuh Server – SIEM, dashboard and Ollama host

---

## Scenario 1 – SSH Dictionary Attack

This scenario demonstrates how weak passwords can be compromised using a dictionary attack with Hydra.

The objective was to:

- simulate an SSH attack,
- analyze Linux authentication logs,
- observe how Wazuh detects authentication failures,
- understand the difference between brute-force and dictionary attacks.

---

## Scenario 2 – Automated File Analysis

The second scenario demonstrates an automated security pipeline.

Workflow:

1. Wazuh detects a new file.
2. Active Response launches a custom Bash script.
3. YARA scans the file.
4. Detection results are sent to Ollama.
5. Ollama generates an AI-assisted security analysis.
6. The analysis is stored in the Active Response log.

---

## Technologies Used

- Linux
- Bash
- Wazuh
- YARA
- Hydra
- Ollama
- REST API
- jq
- Git
- GitHub

---

## Challenges

During the project I solved several practical issues, including:

- configuring Active Response,
- debugging Bash scripts,
- integrating REST API calls,
- troubleshooting Hydra sessions,
- handling compressed RockYou wordlists,
- verifying Linux permissions,
- validating Bash scripts before deployment.

---

## Skills Developed

This project helped me strengthen my practical skills in:

- Linux administration
- Security monitoring
- Bash scripting
- Log analysis
- Troubleshooting
- REST API integration
- Security automation
- AI-assisted incident analysis

---

## Future Improvements

Possible future enhancements include:

- Docker deployment
- Automated reporting
- Additional YARA rules
- MITRE ATT&CK mapping
- Threat intelligence integration
- AI-assisted alert summarization
