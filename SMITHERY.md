# Smithery notes

CallMeter is a **remote** Streamable HTTP MCP server.

- **Display name:** CallMeter
- **MCP URL:** `https://api.callmeter.dev/mcp`
- **Homepage:** https://api.callmeter.dev/
- **Repository:** https://github.com/dammy/callmeter
- **License:** MIT
- **Config schema:** see [`config-schema.json`](./config-schema.json) and [`smithery.yaml`](./smithery.yaml)
- **Server card:** live `GET https://api.callmeter.dev/.well-known/mcp/server-card.json` (static mirror: [`server-card.json`](./server-card.json))
- **Auth mapping:** `apiKey` → HTTP header `x-api-key`

## Publish (maintainers)

```bash
smithery mcp publish "https://api.callmeter.dev/mcp" -n dammyg/callmeter \
  --config-schema "$(cat config-schema.json)"
```

Or use the Smithery UI: https://smithery.ai/new → enter `https://api.callmeter.dev/mcp`.

## Client behavior

- `initialize` returns rich `instructions` + `serverInfo.title = CallMeter`.
- `initialize` and `tools/list` work **without** an API key (200).
- `prompts/list` and `resources/list` are public.
- `tools/call` without payment returns **402** (x402) or with a bad key returns **401**.
- Prepaid clients send `x-api-key: YOUR_API_KEY` (or `Authorization: Bearer YOUR_API_KEY`).

See also [`glama.json`](./glama.json) for Glama registry indexing.

## Tool names (Smithery / MCP)

Canonical `tools/list` names use Smithery-style dotted capability verbs:

- `extract.structured_data`, `extract.webpage`, `transform.json_schema`, `capture.screenshot`, `extract.pdf`
- `parse.receipt`, `parse.invoice`, `relay.webhook`, `replay.webhook`

Underscore aliases (e.g. `extract_webpage`, `parse_receipt`) and legacy product-prefixed names still resolve on `tools/call` for one release.
