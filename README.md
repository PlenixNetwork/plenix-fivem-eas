# 🚨 Plenix FiveM EAS - Emergency Alert System

> **Professional Emergency Alert System for FiveM Servers**

A modern, feature-rich Emergency Alert System providing professional emergency broadcasts with multiple alert types, international translations, and stunning visual effects.

---

## ✨ Key Features

- 🔴 **10 Alert Types** - Nuclear, Tornado, AMBER, Earthquake, Tsunami, Fire, Police, Military, Weather & more
- 🌍 **Multi-Language Support** - English, Spanish, French, German, Portuguese
- 🎨 **Customizable Themes** - Unique colors, animations, and icons per alert type
- 🎬 **Modern UI** - Professional broadcast-style interface with smooth animations
- 👮 **Permission System** - ACE permissions or job-based (ESX/QBCore compatible)
- 🔊 **Advanced Audio System** - 10 custom alert sounds with volume control
- ⚡ **Quick Presets** - Pre-configured messages for common emergencies
- 📊 **Discord Webhooks** - Optional logging to Discord
- 🔌 **Exports API** - Server & Client exports for extensibility
- ⏸️ **Alert Control** - Start and stop alerts with ease

---

## 📋 System Requirements

| Requirement | Details |
|---|---|
| **Framework** | ESX Legacy, QBCore, or Standalone |
| **Game Build** | GTA V (FiveM Ready) |
| **Lua Version** | 5.4 (Cerulean) |
| **Dependencies** | Optional: `es_extended` or `qb-core` |

### Frameworks
Choose one:
- [ESX Legacy](https://github.com/esx-framework/esx-legacy) ⭐ Recommended
- [QBCore](https://github.com/qbcore-framework)
- **Standalone** (no framework required)

---

## 🚀 Installation

### Step 1: Download/Clone
```bash
# Option A: Using Git
cd resources/[scripts]
git clone https://github.com/PlenixNetwork/plenix-fivem-eas.git

# Option B: Manual Download
# 1. Download the latest release
# 2. Extract to resources/[scripts]/plenix-fivem-eas
```

### Step 2: Add Assets
#### Audio Files
Place audio files in `assets/audio/`:
- `eas_default.mp3` - Default alert sound
- `eas_nuclear.mp3` - Nuclear alert sound
- `eas_tornado.mp3` - Tornado alert sound
- `eas_earthquake.mp3` - Earthquake alert sound
- `eas_tsunami.mp3` - Tsunami alert sound
- `eas_weather.mp3` - Weather alert sound
- `eas_fire.mp3` - Fire emergency sound
- `eas_amber.mp3` - AMBER alert sound
- `eas_police.mp3` - Police alert sound
- `eas_military.mp3` - Military alert sound

*(See `assets/audio/README.md` for format specifications)*

#### Font Files
Place fonts in `assets/fonts/`:
- `VCR_OSD_MONO.ttf`
- `Roboto-Regular.ttf`
- `Roboto-Bold.ttf`

### Step 3: Configure server.cfg
```lua
# Start framework first
ensure es_extended       # or 'ensure qb-core'

# Then start EAS
ensure plenix-fivem-eas
```

### Step 4: Set Permissions (Optional)
Add to your `server.cfg`:
```lua
# Admin permissions
add_ace group.admin eas.use allow
add_ace group.admin eas.admin allow
add_ace group.admin eas.dept.admin allow

# Police department
add_ace group.police eas.use allow
add_ace group.police eas.dept.police allow

# Emergency Medical Services
add_ace group.ambulance eas.use allow
add_ace group.ambulance eas.dept.ambulance allow

# Fire Department (optional)
add_ace group.fire eas.use allow
add_ace group.fire eas.dept.fire allow
```

---

## 🎮 Usage Guide

### User Commands

| Command | Description | Permission |
|---------|-------------|-----------|
| `/alert` | Open alert menu | Allowed Jobs |
| `/alert help` | Display help information | Allowed Jobs |
| `/alert list` | List all alert types | Allowed Jobs |
| `/alert send` | Send alert with custom message | Allowed Jobs |
| `/qalert [type] [message]` | Quick alert command | Allowed Jobs |
| `/alerttest [type]` | Test alert (visible to you only) | Admin Only |
| `/stopalert` | Stop current active alert | Allowed Jobs |

### Quick Preset Commands

| Command | Alert Type | Message |
|---------|-----------|---------|
| `/alertlockdown` | Police | City Lockdown |
| `/alertevacuation` | Default | Evacuation Order |
| `/alertallclear` | Default | All Clear |
| `/alertpursuit` | Police | Active Pursuit |
| `/alertwanted` | AMBER | Wanted Individual |

### Example: Sending an Alert
```
1. Type: /alert
2. Select alert type from menu
3. Enter your message
4. Click "Send Alert"
5. Alert broadcasts to all players
```

---

## 🎨 Alert Types & Themes

| Type | Icon | Animation | Priority | Duration |
|------|------|-----------|----------|----------|
| 🔴 **Default** | ⚠️ | Pulse | High | 25s |
| ☢️ **Nuclear** | ☢️ | Shake | Critical | 90s |
| 🌪️ **Tornado** | 💨 | Spin | High | 30s |
| 👶 **AMBER** | 👶 | Pulse | High | 30s |
| 📍 **Earthquake** | 🏚️ | Heavy Shake | High | 25s |
| 🌊 **Tsunami** | 💧 | Wave | Critical | 30s |
| 🔥 **Fire** | 🔥 | Flicker | High | 25s |
| 🚔 **Police** | 🛡️ | Flash | Medium | 20s |
| ✈️ **Military** | ✈️ | Pulse | Critical | 30s |
| ⛈️ **Weather** | ⛈️ | Fade Pulse | Medium | 25s |

---

## ⚙️ Configuration

Edit `shared/config.lua` to customize behavior:

```lua
Config.General = {
    Debug = false,                    -- Enable debug logging
    DefaultLocale = 'en',             -- en, es, de, fr, pt
    Framework = 'esx',                -- 'esx', 'qb', 'standalone'
    DefaultVolume = 1.0,              -- Audio volume (0.0 - 1.0)
    DefaultDuration = 25000,          -- Alert duration in ms
    CooldownEnabled = true,           -- Prevent alert spam
    CooldownTime = 30000,             -- 30 seconds between alerts
    LogAlerts = true,                 -- Log alerts to console
    DiscordWebhook = '',              -- Discord webhook URL (optional)
}

Config.Permissions = {
    UseAcePermissions = false,        -- Use ACE or job-based
    AcePermission = 'eas.use',       -- ACE permission name
    AdminPermission = 'eas.admin',   -- Admin ACE permission
    
    AllowedJobs = {
        'police',
        'ambulance',
    },
    MinimumJobGrade = 0,              -- Min job grade (0 = any)
}
```

---

## 🔌 Developer API

### Client-Side Exports

```lua
-- Send an alert (requires permission)
exports['plenix-fivem-eas']:SendAlert('nuclear', 'Nuclear threat detected!')

-- Send custom alert with all properties
exports['plenix-fivem-eas']:SendCustomAlert({
    type = 'nuclear',
    message = 'Custom message',
    issuer = 'Police',
    department = 'police'
})

-- Check if player has permission
local allowed = exports['plenix-fivem-eas']:IsPlayerAllowed()
```

### Server-Side Exports

```lua
-- Trigger alert for all players
exports['plenix-fivem-eas']:TriggerAlert('tornado', 'Tornado approaching!', 'NWS', 'admin')

-- Trigger custom alert
exports['plenix-fivem-eas']:TriggerCustomAlert({
    type = 'earthquake',
    message = 'Earthquake detected',
    issuer = 'USGS',
    department = 'admin',
    volume = 0.8
})

-- Check player permissions
local allowed = exports['plenix-fivem-eas']:IsPlayerAllowed(source)
```

### Usage Example
```lua
-- Server script
AddEventHandler('myevent:triggeralert', function()
    exports['plenix-fivem-eas']:TriggerAlert(
        'police',
        'Active armed robbery in progress!',
        'Dispatch',
        'police'
    )
end)
```

---

## 🌐 Languages Supported

The system supports **5 languages** with complete translations:

- 🇬🇧 **English** (en)
- 🇪🇸 **Spanish** (es)
- 🇩🇪 **German** (de)
- 🇫🇷 **French** (fr)
- 🇵🇹 **Portuguese** (pt)

Change the default language in `Config.General.DefaultLocale`

---

## 🐛 Troubleshooting

### Audio Not Playing?
- ✅ Verify audio files exist in `assets/audio/`
- ✅ Enable Debug Mode: Set `Config.General.Debug = true`
- ✅ Check browser console (F8) for audio errors
- ✅ Ensure audio file formats are MP3
- ✅ Check volume settings: `Config.General.DefaultVolume`

### Alert Not Showing?
- ✅ Check player has required permissions
- ✅ Verify framework is loaded: `Config.General.Framework`
- ✅ Check cooldown isn't active: `CooldownTime`
- ✅ Review console for errors

### Permissions Not Working?
- ✅ Restart server after changing permissions
- ✅ Verify job name matches `Config.Permissions.AllowedJobs`
- ✅ Check minimum job grade: `Config.Permissions.MinimumJobGrade`
- ✅ If using ACE: Verify permissions in `server.cfg`

---

## 💡 Tips & Best Practices

1. **Test First**: Use `/alerttest` before sending live alerts
2. **Cooldown**: Enable cooldown to prevent alert spam
3. **Audio**: Keep audio files under 2MB for faster loading
4. **Permissions**: Use ACE permissions for better control
5. **Presets**: Create custom presets for common alerts
6. **Debug Mode**: Enable for testing, disable for production
7. **Discord Logging**: Add webhook for alert tracking

---

## 🔐 Security Notes

- ✅ Permission checks on both client and server
- ✅ Cooldown system prevents spam
- ✅ Admin-only test command
- ✅ Stop alert command requires permission
- ✅ Framework-agnostic design
- ✅ Proper error handling

---

## 👥 Credits

- **Developed by**: Plenix Network
- **Icons**: [Font Awesome](https://fontawesome.com)
- **Concept**: Emergency Alert System (EAS)
- **Inspired by**: Real-world emergency broadcast systems

---

## 📄 License

This project is licensed under the **MIT License**.
