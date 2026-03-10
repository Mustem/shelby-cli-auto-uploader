#!/usr/bin/env bash
set -euo pipefail

BASE="/mnt/c/testShelby"
INCOMING="$BASE/incoming"
PROCESSED="$BASE/processed"
LOG="$BASE/logs/upload_one_shelby.log"

mkdir -p "$INCOMING" "$PROCESSED" "$BASE/logs"

source /mnt/c/nodes/shelby-cli/start-shelby.sh

if ! command -v shelby >/dev/null 2>&1; then
  echo "[$(date '+%Y-%m-%d %H:%M:%S')] ERROR: shelby command not found" >> "$LOG"
  exit 1
fi

FILE="$(find "$INCOMING" -maxdepth 1 -type f -name 'testS*.txt' | sort | head -n 1)"

if [ -z "${FILE:-}" ]; then
  echo "[$(date '+%Y-%m-%d %H:%M:%S')] No file to upload" >> "$LOG"
  exit 0
fi

BASENAME="$(basename "$FILE")"
STAMP="$(date '+%Y%m%d-%H%M%S')"
DEST="auto-tests/${STAMP}-${BASENAME}"

echo "[$(date '+%Y-%m-%d %H:%M:%S')] Upload starting: $FILE -> $DEST" >> "$LOG"

if shelby upload --assume-yes --expiration 2026-04-10T00:00:00Z "$FILE" "$DEST" >> "$LOG" 2>&1; then
  echo "[$(date '+%Y-%m-%d %H:%M:%S')] Upload command returned success: $BASENAME" >> "$LOG"
else
  echo "[$(date '+%Y-%m-%d %H:%M:%S')] Upload command returned non-zero exit: $BASENAME" >> "$LOG"
fi

mv "$FILE" "$PROCESSED/$BASENAME"
echo "[$(date '+%Y-%m-%d %H:%M:%S')] File moved to processed/: $BASENAME" >> "$LOG"
