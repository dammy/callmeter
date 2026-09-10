#!/usr/bin/env bash
# MCP tools/list (no API key required)
set -euo pipefail
curl -sS -X POST https://api.callmeter.dev/mcp \
  -H 'content-type: application/json' \
  -H 'accept: application/json, text/event-stream' \
  -d '{"jsonrpc":"2.0","id":1,"method":"tools/list","params":{}}'
echo
