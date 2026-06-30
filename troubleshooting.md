# Troubleshooting

This document summarizes the most common issues encountered while building the lab and how they were resolved.

---

# 1. RockYou wordlist not found

## Problem

```bash
head: cannot open '/usr/share/wordlists/rockyou.txt'
```

## Cause

The RockYou dictionary was distributed as a compressed file:

```text
rockyou.txt.gz
```

## Solution

```bash
cp /usr/share/wordlists/rockyou.txt.gz .
gunzip rockyou.txt.gz
head -n 5000 rockyou.txt > small.txt
```

---

# 2. Hydra detected an existing restore file

## Problem

Hydra displayed:

```text
Restorefile found...
```

and waited before starting.

## Cause

A previous attack had been interrupted.

Hydra automatically created:

```text
hydra.restore
```

## Solution

Start a new session:

```bash
rm hydra.restore
```

or

```bash
hydra -I ...
```

---

# 3. Brute-force password space too large

## Problem

Hydra reported:

```text
definition for password bruteforce generates more than 4 billion passwords
```

## Cause

The generated password space was unrealistic for a live demonstration.

## Solution

Instead of a full brute-force attack, a dictionary attack using a reduced RockYou wordlist was used.

---

# 4. Ollama did not return a response

## Problem

The Active Response log stopped after:

```text
OLLAMA REQUEST: sending prompt to Ollama
```

## Investigation

The REST API was tested manually:

```bash
curl http://192.168.25.141:11434/api/generate
```

The API responded correctly.

## Resolution

The Bash script was corrected and additional debug logging was added.

---

# 5. Active Response script verification

Before testing, the script was always verified using:

```bash
sudo chmod 750 /var/ossec/active-response/bin/yara_ollama.sh
sudo chown root:wazuh /var/ossec/active-response/bin/yara_ollama.sh
sudo bash -n /var/ossec/active-response/bin/yara_ollama.sh
```

This ensured:

- correct permissions,
- correct ownership,
- valid Bash syntax.

---

# 6. Debugging the Bash script

Additional log messages were introduced to identify where the execution stopped.

Examples:

```text
ACTIVE RESPONSE started
OLLAMA REQUEST
OLLAMA RAW
OLLAMA ANALYSIS
```

These entries made troubleshooting significantly easier.

---

# Lessons Learned

During this project I gained practical experience with:

- Linux troubleshooting
- Bash debugging
- Wazuh Active Response
- File Integrity Monitoring
- YARA integration
- REST API testing
- JSON parsing with jq
- Security log analysis
- AI-assisted security automation
