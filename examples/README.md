# Examples

Executable curl demos against the live MCP endpoint:

| Script | Purpose |
|--------|---------|
| `initialize.sh` | MCP `initialize` (no key) |
| `tools-list.sh` | MCP `tools/list` (no key) |
| `tools-call-schema-prepaid.sh` | Prepaid `tools/call` schema (`YOUR_API_KEY` / `CALLMETER_API_KEY`) |
| `tools-call-x402-unpaid.sh` | Unpaid `tools/call` → expect **402** |

```bash
chmod +x *.sh
./tools-list.sh
CALLMETER_API_KEY=YOUR_API_KEY ./tools-call-schema-prepaid.sh
./tools-call-x402-unpaid.sh
```

Never commit real API keys.
