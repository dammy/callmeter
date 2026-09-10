# Smithery notes

Callmeter is a **remote** Streamable HTTP MCP server.

- **MCP URL:** `https://api.callmeter.dev/mcp`
- **Config schema:** see [`config-schema.json`](./config-schema.json)
- **Auth mapping:** `apiKey` → HTTP header `x-api-key`

## Publish (maintainers)

```bash
smithery mcp publish "https://api.callmeter.dev/mcp" -n @callmeter/callmeter \
  --config-schema "$(cat config-schema.json)"
```

Or use the Smithery UI: https://smithery.ai/new → enter `https://api.callmeter.dev/mcp`.

## Client behavior

- `initialize` and `tools/list` work **without** an API key (200).
- `tools/call` without payment returns **402** (x402) or with a bad key returns **401**.
- Prepaid clients send `x-api-key: YOUR_API_KEY` (or `Authorization: Bearer YOUR_API_KEY`).

See also [`glama.json`](./glama.json) for Glama registry indexing.
