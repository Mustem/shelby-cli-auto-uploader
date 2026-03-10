#!/usr/bin/env bash
set -euo pipefail

BASE="/mnt/c/testShelby"
INCOMING="$BASE/incoming"
LOG="$BASE/logs/make_test_file.log"
COUNTER_FILE="$BASE/counter.txt"

mkdir -p "$INCOMING" "$BASE/logs"

if [ ! -f "$COUNTER_FILE" ]; then
  echo "0" > "$COUNTER_FILE"
fi

LAST_NUM=$(cat "$COUNTER_FILE")
NEXT_NUM=$((LAST_NUM + 1))
STAMP=$(date '+%Y-%m-%d %H:%M:%S')
FILENAME="testS${NEXT_NUM}.txt"
FILEPATH="$INCOMING/$FILENAME"

TARGET_KB=$(( RANDOM % 50 + 1 ))
TARGET_BYTES=$(( TARGET_KB * 1024 ))

cat > "$FILEPATH" <<HEADER
Shelby automated test document
Sequence: $NEXT_NUM
Created at: $STAMP
Host: $(hostname)
Target size: ${TARGET_KB}KB

This file is generated automatically for Shelby upload testing.
The content focuses on web3, blockchain infrastructure, decentralized storage,
validator operations, AI x crypto, and open networks.

HEADER

PARAGRAPHS=(
"Web3 infrastructure depends on reliable nodes, strong networking, clear observability, and consistent operational discipline. A healthy node environment usually includes process monitoring, log inspection, disk awareness, and network verification."

"Decentralized storage systems aim to distribute data across independent participants so that information remains available even if a subset of the network becomes unreliable. This model increases resilience and reduces single points of failure."

"Validators and node operators often focus on uptime, sync health, signing stability, peer quality, and safe key management. Even small operational mistakes such as incorrect file permissions or weak backup hygiene can become major reliability risks."

"Blockchain ecosystems typically combine execution, settlement, storage, indexing, and user interfaces. When one layer behaves inconsistently, the user may see confusing results such as failed messages even though some state transitions were partially completed."

"AI and crypto projects often intersect around decentralized compute, verifiable inference, agent coordination, and on-chain reputation. These designs attempt to align incentives between compute providers, protocol participants, and application builders."

"Distributed systems require careful testing because client-side success and backend completion are not always identical. A command-line tool may return an error while the remote service still creates an object or records a state transition."

"Wallet management in web3 should separate operational funds from long-term holdings. A dedicated working wallet reduces blast radius and helps keep experiments, testing, and automation isolated from more important balances."

"Test environments are useful for checking workflows such as file creation, batching, scheduling, and monitoring. They help identify whether a problem comes from the local machine, the command-line client, or the remote service endpoint."

"Reliable automation usually includes guardrails: create data, attempt upload once, record outcome, avoid duplicate retries, and preserve logs. This is especially important when an action may consume balance or trigger rate limits."

"Node operators often prefer step-by-step workflows because they reduce the risk of overlapping processes, path confusion, or accidental changes to unrelated services. Isolated directories and controlled startup scripts make troubleshooting easier."
)

while [ "$(wc -c < "$FILEPATH")" -lt "$TARGET_BYTES" ]; do
  INDEX=$(( RANDOM % ${#PARAGRAPHS[@]} ))
  echo "${PARAGRAPHS[$INDEX]}" >> "$FILEPATH"
  echo >> "$FILEPATH"
done

truncate -s "$TARGET_BYTES" "$FILEPATH"

echo "$NEXT_NUM" > "$COUNTER_FILE"
echo "[$STAMP] Created $FILEPATH (${TARGET_KB}KB)" >> "$LOG"
