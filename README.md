# Callmeter

<!-- Smithery /badge/ returned 500 as of 2026-09-12; restore when they fix it. -->
[![Smithery](https://img.shields.io/badge/Smithery-dammyg%2Fcallmeter-0F172A?style=flat)](https://smithery.ai/servers/dammyg/callmeter)

> **First paid job:** parse a receipt → structured JSON for **~$0.10** (prepaid credits or x402 USDC on Base). Try the public demo https://api.callmeter.dev/demo/receipt-to-json then pay on `tools/call`. `tools/list` is free.

**CallMeter** is an MCP / API gateway of **useful machine work** for AI agents — jobs like **receipt → JSON**, schema transform, schema breaking-change detect, structured extract, screenshots, PDF text, invoice parsing, and durable webhook ingress/replay.

Pay per successful call with **prepaid credits** or **x402 USDC on Base** (enabling property, not the product).

| Resource | URL |
|----------|-----|
| **MCP (Streamable HTTP)** | https://api.callmeter.dev/mcp |
| **OpenAPI** | https://api.callmeter.dev/openapi.json |
| **Pricing** | [pricing.md](./pricing.md) |

> This repository is **documentation and client config only**. It does not contain proprietary kernel source.

## Receipt → JSON (Campaign DOC-RECEIPT)

Turn till slips, POS printouts, and mobile-money confirmations into `merchant` / `date` / `currency` / `total` / `line_items` JSON your agent can book.

| | |
|--|--|
| **Live demo** | https://api.callmeter.dev/demo/receipt-to-json (`DOC-RECEIPT-DEMO-01`) |
| **Skill** | `parse.receipt` — **$0.10** (10 credits) per successful parse |
| **Evidence** | Mama Chika Provisions (NG) till-style fixture → **₦61,812.50** total, VAT 7.5%, two line items, `payment.method=pos` |
| **JTBD** | [Receipt → JSON API](https://api.callmeter.dev/receipt-to-json-api) · [Nigerian receipt parser](https://api.callmeter.dev/nigerian-receipt-parser) |
| **MCP** | `tools/call` name `parse.receipt` @ https://api.callmeter.dev/mcp |
| **HTTP** | `POST /v1/docintel/extract/receipt` |

Fail-closed: empty/garbage input → null merchant, total `0`, empty `line_items` (no invented money). Africa-tuned (NGN ₦/kobo, KES M-Pesa, GHS MoMo, ZAR VAT, OPay, PalmPay, Paystack, Verve POS).

## Schema breaking-change detect

Compare two OpenAPI or JSON Schema documents and report producer-compat breaking changes. Deterministic — no LLM.

| | |
|--|--|
| **Skill** | `detect.schema_breaking_changes` — **$0.05** (5 credits / 50000 USDC atomic) |
| **MCP** | `tools/call` name `detect.schema_breaking_changes` @ https://api.callmeter.dev/mcp |
| **HTTP** | `POST /v1/agentutils/diff` |
| **Aliases** | `detect_schema_breaking_changes`, `agentutils_schema_diff` |

Body: `{before, after, mode?: auto|json-schema|openapi, include_nonbreaking?: true}`  
Out: `{mode, breaking, breaking_count, nonbreaking_count, changes[], summary}`

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
- Config / metadata: [`smithery.yaml`](./smithery.yaml), [`server-card.json`](./server-card.json)
- Notes: [`SMITHERY.md`](./SMITHERY.md)
- Glama: [`glama.json`](./glama.json)

## Auth & billing

| Mode | How |
|------|-----|
| Prepaid | `x-api-key: YOUR_API_KEY` or `Authorization: Bearer YOUR_API_KEY` |
| x402 | Unpaid `tools/call` → **HTTP 402** + payment requirements (USDC on Base) |

- Human checkout: mint an API key and buy min **$10** / 1000 credits via Paystack at https://api.callmeter.dev/signup
- `initialize` / `tools/list` → **200** without a key  
- `tools/call` unpaid → **402**  
- Bad key → **401**

Credit peg: **1 credit = $0.01**, min top-up **$10**. See [pricing.md](./pricing.md).

## MCP tools (canonical)

`extract.structured_data` · `extract.webpage` · `transform.json_schema` · `detect.schema_breaking_changes` · `capture.screenshot` · `extract.pdf` · `parse.receipt` · `parse.invoice` · `relay.webhook` · `replay.webhook`

Underscore aliases remain accepted on `tools/call` for one release.

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
  -d '{"jsonrpc":"2.0","id":2,"method":"tools/call","params":{"name":"transform.json_schema","arguments":{"mode":"draft","sample":{"a":1}}}}'
```

Expect **HTTP 402** with payment-required details when no prepaid key is sent.

### Prepaid schema call

```bash
curl -sS -X POST https://api.callmeter.dev/mcp \
  -H 'content-type: application/json' \
  -H 'accept: application/json, text/event-stream' \
  -H 'x-api-key: YOUR_API_KEY' \
  -d '{"jsonrpc":"2.0","id":3,"method":"tools/call","params":{"name":"transform.json_schema","arguments":{"mode":"draft","sample":{"a":1}}}}'
```

## Docs in this repo

| File | Purpose |
|------|---------|
| [pricing.md](./pricing.md) | Credit peg & published skill prices |
| [openapi.md](./openapi.md) | Points to live OpenAPI |
| [SECURITY.md](./SECURITY.md) | Vulnerability contact |
| [SMITHERY.md](./SMITHERY.md) | Registry publish notes |
| [smithery.yaml](./smithery.yaml) | Smithery remote MCP metadata |
| [server-card.json](./server-card.json) | Static server-card mirror |
| [examples/](./examples/) | Curl scripts (initialize, list, call, 402) |

## License

[MIT](./LICENSE)
