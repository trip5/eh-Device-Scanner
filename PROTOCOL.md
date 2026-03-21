# ehDP (eh Device Protocol) Specification v1.0

## Overview

The ehDP protocol enables IoT devices to announce their presence and capabilities on a local network via UDP broadcast. Devices respond to discovery requests with JSON-formatted metadata.

## Discovery Process

1. **Scanner → Broadcast**: Send UDP packet containing `EHDP_DISCOVER` to port **11867** on broadcast addresses (255.255.255.255 and interface-specific broadcasts)
2. **Device → Response**: Devices reply with JSON payload to the sender's address
3. **Scanner**: Parse JSON responses and display discovered devices

## JSON Response Format

### Required Fields

| Field | Type | Description | Example |
|-------|------|-------------|---------|
| `proto` | string | Protocol identifier and version (must start with `ehdp/`) | `"ehdp/1.0"` |
| `ip` | string | Device's current IPv4 address | `"192.168.1.100"` |

### Optional Fields

| Field | Type | Description | Example |
|-------|------|-------------|---------|
| `material_symbol` | integer or string | [Material Symbols](https://fonts.google.com/icons) codepoint - accepts decimal integer, hex string, or decimal string | `59573`, `0xe8b5`, `"0xe8b5"`, `"59573"` |
| `project` | string | Project or software name | `"ehRadio"`, `"WLED"` |
| `firmware` | string | Firmware variant or build name | `"ESP32S3OLED"` |
| `name` | string | User-assigned device label | `"Kitchen Radio"` |
| `version` | string or number | Firmware/software version - accepts string or numeric format | `"2.1.0"`, `2.1`, `"1.0"` |
| `mdns` | string | mDNS hostname (without .local suffix) | `"mydevice"` |
| `ui_port` | integer or string | HTTP port for web UI - accepts integer or numeric string (0 or omit if no web UI) | `80`, `"80"`, `8080`, `"8080"` |
| `capabilities` | array[string] | Additional capability tags | `["mqtt", "homeassistant"]` |

## Display Priority

### Device Icon
1. If `material_symbol` is specified → Use the Material Symbols icon at that codepoint
2. Else → Use generic device icon (codepoint `0xe1b1` / `57777`)

### Device Name Display
Display uses the first available field:
1. `name` (user label) - **Bold**
2. `project` (software name) - Bold if name not present
3. `firmware` (build variant) - Bold if name and project not present
4. Show all three fields if available, with only the top priority one bolded

## Flexible Field Types

The scanner accepts multiple data types for numeric fields to accommodate different device implementations and JSON libraries:

**Fields Accepting Multiple Types:**
- **`material_symbol`**: Integer, hex string (`"0xe8b5"`), or decimal string (`"59573"`)
- **`ui_port`**: Integer (`80`) or numeric string (`"80"`)
- **`version`**: String (`"1.0.0"`) or number (`1.0`)

This flexibility allows devices to send fields in the most convenient format for their programming environment without requiring type conversion.

## Material Symbols Icon Codepoints

The `material_symbol` field accepts the Unicode codepoint from Google's **Material Symbols** font in multiple formats:

**Supported Formats:**
1. **Decimal integer**: `59573`
2. **Hex integer** (in JSON): `0xe8b5` (Note: Not all JSON parsers support this)
3. **Hex string**: `"0xe8b5"` or `"0xE8B5"` (Recommended for compatibility)
4. **Decimal string**: `"59573"`

**Finding Icon Codepoints:**
1. Visit [Material Symbols](https://fonts.google.com/icons)
2. Search for your desired icon (e.g., "schedule", "radio", "camera")
3. Click on the icon to see details
4. The codepoint is shown (e.g., `e8b5` for schedule)
5. Add `0x` prefix: `0xe8b5` or convert to decimal: `59573`
6. Send as hex string `"0xe8b5"` (recommended) or decimal `59573`

**Recommendation:** Use hex strings (`"0xe8b5"`) for maximum compatibility across all JSON parsers and programming languages.

**Common Icon Codepoints (Material Symbols):**
- **Schedule**: `0xe8b5` / `59573`
- **Radio**: `0xe03e` / `57406`
- **Lightbulb**: `0xe0f0` / `57584`  
- **Router**: `0xe328` / `58152`
- **Speaker**: `0xe32d` / `58157`
- **Thermostat**: `0xf076` / `61558`
- **Sensors**: `0xe51e` / `58654`
- **Camera**: `0xe3af` / `58287`
- **Tv**: `0xe333` / `58163`
- **Power**: `0xe63c` / `58940`
- **Devices**: `0xe1b1` / `57777` (default icon)

The app supports **all** Material Symbols icons without any limitations.

## Example Responses

### Minimal Response
```json
{
  "proto": "ehdp/1.0",
  "ip": "192.168.1.100"
}
```

### Full-Featured Device
```json
{
  "proto": "ehdp/1.0",
  "ip": "192.168.1.100",
  "material_symbol": "0xe03e",
  "project": "ehRadio",
  "firmware": "ESP32S3OLED",
  "name": "Kitchen Radio",
  "version": "2.1.0",
  "mdns": "kitchen-radio",
  "ui_port": 80,
  "capabilities": ["mqtt", "homeassistant"]
}
```

### Clock with Custom Icon (Decimal Format)
```json
{
  "proto": "ehdp/1.0",
  "ip": "192.168.1.50",
  "material_symbol": 59573,
  "project": "VFD16-Clock-HA",
  "name": "Desk Clock",
  "version": "1.0.0",
  "ui_port": 80
}
```

### Device with Flexible Types (Strings as Numbers)
```json
{
  "proto": "ehdp/1.0",
  "ip": "192.168.1.75",
  "material_symbol": "0xe0f0",
  "name": "Smart Bulb",
  "version": 2.5,
  "ui_port": "8080"
}
```

## Network Requirements

- UDP port **11867** must be open for discovery broadcasts
- Devices should respond within **3 seconds** of receiving `EHDP_DISCOVER`
- If a web UI is provided, HTTP server must be accessible on the specified `ui_port`

## Protocol Version

Current version: **ehdp/1.0**

The `proto` field must start with `ehdp/` followed by the version number. Future versions may extend fields while maintaining backward compatibility.

## License & Trademark

The ehDP protocol specification is open for implementation. The "eh Device Scanner" application is licensed under LGPL-2.1 with trademark protection on the name "eh Device Scanner".
