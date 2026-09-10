#!/usr/bin/env bash
# MCP initialize (no API key required)
set -euo pipefail
curl -sS -X POST https://api.callmeter.dev/mcp \
  -H 'content-type: application/json' \
  -H 'accept: application/json, text/event-stream' \
  -d '{
    "jsonrpc": "2.0",
    "id": 0,
    "method": "initialize",
    "params": {
      "protocolVersion": "2024-11-05",
      "capabilities": {},
      "clientInfo": { "name": "callmeter-examples", "version": "0.1.0" }
    }
  }'
echo
