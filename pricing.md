# Pricing

Default rail: **x402 USDC on Base**. Prepaid fiat top-up is **closed** until CallMeter-native fiat.

1 credit = $0.01 USD = 10000 USDC atomic (peg for metering).

See live SoT: https://api.callmeter.dev/pricing

## Credit peg

| Unit | Value |
|------|--------|
| 1 credit | **$0.01** USD |
| Prepaid fiat packs | **Unavailable** (FIAT_MIX_CLOSED) |

Signup mints ledger identity only (no card / Paystack checkout): https://api.callmeter.dev/signup

## Published skill prices (drafts)

Prices below are in USD and credit equivalents (1 credit = $0.01).

### Doc / agent utilities

| Skill | USD | Credits |
|-------|-----|---------|
| schema | $0.02 | 2 cr |
| schema breaking-change (`detect.schema_breaking_changes`) | $0.05 | 5 cr |
| extract | $0.05 | 5 cr |
| screenshot | $0.10 | 10 cr |
| pdf | $0.10 | 10 cr |

`detect.schema_breaking_changes` — `POST /v1/agentutils/diff` — $0.05 / 5 credits / 50000 USDC atomic. Aliases: `detect_schema_breaking_changes`, `agentutils_schema_diff`.

### Documents

| Skill | USD | Notes |
|-------|-----|--------|
| receipt | $0.10 | per call |
| invoice | $0.15 | per call |

### Webinfra

| Skill | USD / atomic | Notes |
|-------|--------------|--------|
| ingress | $0.0001 / 100 atomic | webhook ingress |
| replay | $0.0001 / 100 atomic | webhook replay |

## Payment modes

1. **x402 (USDC on Base) — default** — call without a key; unpaid `tools/call` / unpaid HTTP skill returns **HTTP 402** with payment requirements. Complete payment and retry with the payment signature header. Discovery: https://api.callmeter.dev/.well-known/x402
2. **Existing prepaid API key** — send `x-api-key: YOUR_API_KEY` (or `Authorization: Bearer YOUR_API_KEY`) only if balance already on ledger. New fiat top-ups closed.

Live OpenAPI: https://api.callmeter.dev/openapi.json  
MCP: https://api.callmeter.dev/mcp
