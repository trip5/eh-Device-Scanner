# Build Configuration for eh Device Scanner

## Material Symbols Icon Codepoints

Devices can specify any Material Symbols icon by sending its Unicode codepoint in the `material_symbol` field.

The app accepts **multiple formats**:
- Decimal integer: `59573`
- Hex string: `"0xe8b5"` (recommended)
- Hex integer: `0xe8b5` (if your JSON library supports it)
- Decimal string: `"59573"`

**Example Device Implementation (Arduino/ESP32):**
```cpp
// Material Symbols codepoints (from https://fonts.google.com/icons)
#define ICON_RADIO 0xe03e       // Radio icon
#define ICON_SCHEDULE 0xe8b5    // Schedule icon  
#define ICON_LIGHTBULB 0xe0f0   // Lightbulb icon
#define ICON_THERMOSTAT 0xf076  // Thermostat icon

// Option 1: Send as hex string (RECOMMENDED - most compatible)
String buildDiscoveryResponse() {
  char iconHex[10];
  sprintf(iconHex, "\"0x%x\"", ICON_RADIO);  // Creates "0xe03e"
  
  return String("{") +
    "\"proto\":\"ehdp/1.0\"," +
    "\"ip\":\"" + WiFi.localIP().toString() + "\"," +
    "\"material_symbol\":" + String(iconHex) + "," +
    "\"name\":\"Kitchen Radio\"," +
    "\"project\":\"ehRadio\"," +
    "\"version\":\"1.0.0\"," +
    "\"ui_port\":80" +
  "}";
}

// Option 2: Send as decimal integer (simpler)
String buildDiscoveryResponseDecimal() {
  return String("{") +
    "\"proto\":\"ehdp/1.0\"," +
    "\"ip\":\"" + WiFi.localIP().toString() + "\"," +
    "\"material_symbol\":" + String(ICON_RADIO) + "," +  // Sends 57406
    "\"name\":\"Kitchen Radio\"," +
    "\"project\":\"ehRadio\"," +
    "\"version\":\"1.0.0\"," +
    "\"ui_port\":80" +
  "}";
}
```

**Python Example:**
```python
import json

# Material Symbols codepoint for speaker
ICON_SPEAKER = 0xe32d

# Option 1: Hex string (most compatible)
response = {
    "proto": "ehdp/1.0",
    "ip": "192.168.1.100",
    "material_symbol": f"0x{ICON_SPEAKER:x}",  # "0xe32d"
    "name": "Living Room Speaker",
    "version": "1.0.0",
    "ui_port": 8080
}

# Option 2: Decimal integer (simpler)
response = {
    "proto": "ehdp/1.0",
    "ip": "192.168.1.100",
    "material_symbol": ICON_SPEAKER,  # 58157
    "name": "Living Room Speaker",
    "version": "1.0.0",
    "ui_port": 8080
}

json.dumps(response)
```

Find icon codepoints at [Material Symbols](https://fonts.google.com/icons) - click any icon to see its codepoint.

## Icon Tree-Shaking

This app includes the **full Material Symbols font** to support dynamic icon names from ehDP device responses. To prevent Flutter from tree-shaking the icon font during release builds:

### Android Release Build (APK)
```bash
flutter build apk --release --no-tree-shake-icons
```

### Android Release Build (App Bundle for Play Store)
```bash
flutter build appbundle --release --no-tree-shake-icons
```

### iOS Release Build
```bash
flutter build ios --release --no-tree-shake-icons
```

## Why Disable Tree-Shaking?

By default, Flutter analyzes which Material icons are used in the code and only includes those specific icons in the final app, reducing the font file from ~1.6MB to just a few KB. However, since ehDP devices can specify **any** Material Symbols icon in their `material_symbol` field, we need the complete icon font available at runtime.

## Development Builds

Development builds (`flutter run` or `flutter build apk --debug`) include the full font by default, so no special flags are needed during development.

## GitHub Actions / CI/CD

When setting up automated builds, ensure the build commands include the `--no-tree-shake-icons` flag:

```yaml
- name: Build APK
  run: flutter build apk --release --no-tree-shake-icons
  
- name: Build App Bundle
  run: flutter build appbundle --release --no-tree-shake-icons
```
