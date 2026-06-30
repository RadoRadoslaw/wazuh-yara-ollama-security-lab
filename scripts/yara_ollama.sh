#!/bin/bash

LOG="/var/ossec/logs/active-responses.log"
RULES="/home/rado/eicar_rule.yar"
OLLAMA_URL="http://192.168.25.141:11434/api/generate"
MODEL="llama3.2:latest"

echo "$(date) ACTIVE RESPONSE: yara_ollama.sh started" >> "$LOG"

read INPUT_JSON

FILE=$(echo "$INPUT_JSON" | jq -r '.parameters.alert.syscheck.path // empty')

echo "$(date) scanning file: $FILE" >> "$LOG"

RESULT=$(yara "$RULES" "$FILE" 2>&1)

if [ -n "$RESULT" ]; then
  echo "$(date) YARA DETECTION: $RESULT" >> "$LOG"

  PROMPT="You are a SOC analyst.

This is a YARA detection result:
$RESULT

Important:
EICAR is a known antivirus test file used to simulate malware.

Provide:
- what was detected
- risk level (low/medium/high)
- recommended action
- note if this is likely a test file (EICAR)"

  echo "$(date) OLLAMA REQUEST: sending prompt to Ollama" >> "$LOG"

  RAW_RESPONSE=$(jq -n \
    --arg model "$MODEL" \
    --arg prompt "$PROMPT" \
    '{model: $model, prompt: $prompt, stream: false}' \
    | curl -s --max-time 30 "$OLLAMA_URL" \
      -H "Content-Type: application/json" \
      -d @-)

  echo "$(date) OLLAMA RAW: $RAW_RESPONSE" >> "$LOG"

  AI_RESPONSE=$(echo "$RAW_RESPONSE" | jq -r '.response // empty')

  echo "$(date) OLLAMA ANALYSIS: $AI_RESPONSE" >> "$LOG"
else
  echo "$(date) YARA clean: $FILE" >> "$LOG"
fi

exit 0
