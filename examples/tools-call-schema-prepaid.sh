#!/usr/bin/env bash
# Prepaid tools/call for schema — replace YOUR_API_KEY (never commit a real key)
set -euo pipefail
API_KEY="${CALLMETER_API_KEY:-YOUR_API_KEY}"
if [[ "$API_KEY" == "YOUR_API_KEY" ]]; then
  echo "Set CALLMETER_API_KEY or edit YOUR_API_KEY placeholder before running." >&2
fi
curl -sS -X POST https://api.callmeter.dev/mcp \
  -H 'content-type: application/json' \
  -H 'accept: application/json, text/event-stream' \
  -H "x-api-key: ${API_KEY}" \
  -d '{
    "jsonrpc": "2.0",
    "id": 3,
    "method": "tools/call",
    "params": {
      "name": "transform.json_schema",
      "arguments": { "mode": "draft", "sample": { "a": 1 } }
    }
  }'
echo
