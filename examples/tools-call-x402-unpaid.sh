#!/usr/bin/env bash
# Unpaid tools/call — expect HTTP 402 (x402 USDC on Base)
set -euo pipefail
curl -sS -i -X POST https://api.callmeter.dev/mcp \
  -H 'content-type: application/json' \
  -H 'accept: application/json, text/event-stream' \
  -d '{
    "jsonrpc": "2.0",
    "id": 2,
    "method": "tools/call",
    "params": {
      "name": "transform.json_schema",
      "arguments": { "mode": "draft", "sample": { "a": 1 } }
    }
  }'
echo
