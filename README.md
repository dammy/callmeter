# Callmeter

**Callmeter** is a customer-facing MCP / API gateway for metered AI skills: schema, extract, screenshot, PDF, receipts, invoices, and webinfra webhook ingress/replay.

Pay with **prepaid credits** or **x402 USDC on Base**.

| Resource | URL |
|----------|-----|
| **MCP (Streamable HTTP)** | https://api.callmeter.dev/mcp |
| **OpenAPI** | https://api.callmeter.dev/openapi.json |
| **Pricing** | [pricing.md](./pricing.md) |

> This repository is **documentation and client config only**. It does not contain proprietary kernel source.

## Quick start — MCP clients

### Claude Desktop

Add a remote MCP server using Streamable HTTP. Example `claude_desktop_config.json` fragment:

```json
{
  "mcpServers": {
    "callmeter": {
      "url": "https://api.callmeter.dev/mcp",
      "headers": {
        "x-api-key": "YOUR_API_KEY"
      }
    }
  }
}
```

Replace `YOUR_API_KEY` with your prepaid key. Leave the header out to explore `tools/list` (unauthenticated); paid `tools/call` will return **402** for x402 flow.

### Cursor

In Cursor MCP settings, add a Streamable HTTP server:

```json
{
  "mcpServers": {
    "callmeter": {
      "url": "https://api.callmeter.dev/mcp",
      "headers": {
        "x-api-key": "YOUR_API_KEY"
      }
    }
  }
}
```

Same URL works for any MCP client that supports **Streamable HTTP** (POST JSON-RPC to the MCP endpoint).

### Smithery / Glama

- Config schema: [`config-schema.json`](./config-schema.json) (`apiKey` → `x-api-key`)
- Notes: [`SMITHERY.md`](./SMITHERY.md)
- Glama: [`glama.json`](./glama.json)

## Auth & billing

| Mode | How |
|------|-----|
| Prepaid | `x-api-key: YOUR_API_KEY` or `Authorization: Bearer YOUR_API_KEY` |
| x402 | Unpaid `tools/call` → **HTTP 402** + payment requirements (USDC on Base) |

- `initialize` / `tools/list` → **200** without a key  
- `tools/call` unpaid → **402**  
- Bad key → **401**

Credit peg: **1 credit = $0.01**, min top-up **$10**. See [pricing.md](./pricing.md).

## Example curls

See [`examples/`](./examples/) for scripts. Placeholders only — never commit real keys.

### tools/list (no key)

```bash
curl -sS -X POST https://api.callmeter.dev/mcp \
  -H 'content-type: application/json' \
  -H 'accept: application/json, text/event-stream' \
  -d '{"jsonrpc":"2.0","id":1,"method":"tools/list","params":{}}'
```

### Unpaid tools/call → 402 (x402)

```bash
curl -sS -i -X POST https://api.callmeter.dev/mcp \
  -H 'content-type: application/json' \
  -H 'accept: application/json, text/event-stream' \
  -d '{"jsonrpc":"2.0","id":2,"method":"tools/call","params":{"name":"schema","arguments":{"url":"https://example.com"}}}'
```

Expect **HTTP 402** with payment-required details when no prepaid key is sent.

### Prepaid schema call

```bash
curl -sS -X POST https://api.callmeter.dev/mcp \
  -H 'content-type: application/json' \
  -H 'accept: application/json, text/event-stream' \
  -H 'x-api-key: YOUR_API_KEY' \
  -d '{"jsonrpc":"2.0","id":3,"method":"tools/call","params":{"name":"schema","arguments":{"url":"https://example.com"}}}'
```

## Docs in this repo

| File | Purpose |
|------|---------|
| [pricing.md](./pricing.md) | Credit peg & published skill prices |
| [openapi.md](./openapi.md) | Points to live OpenAPI |
| [SECURITY.md](./SECURITY.md) | Vulnerability contact |
| [SMITHERY.md](./SMITHERY.md) | Registry publish notes |
| [examples/](./examples/) | Curl scripts (initialize, list, call, 402) |

## License

[MIT](./LICENSE)
