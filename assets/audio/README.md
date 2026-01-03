# Audio Files for EAS FiveM

This folder should contain the audio files for the emergency alert system.

## Required Audio Files

Place the following MP3 files in this directory:

| Filename | Description | Suggested Duration |
|----------|-------------|-------------------|
| `eas_default.mp3` | Standard emergency alert tone | 20-30 seconds |
| `eas_nuclear.mp3` | Nuclear/radiological emergency tone | 25-35 seconds |
| `eas_tornado.mp3` | Tornado warning siren | 20-30 seconds |
| `eas_amber.mp3` | AMBER Alert tone | 20-30 seconds |
| `eas_earthquake.mp3` | Earthquake warning tone | 20-25 seconds |
| `eas_tsunami.mp3` | Tsunami warning siren | 25-30 seconds |
| `eas_fire.mp3` | Fire emergency alarm | 20-25 seconds |
| `eas_police.mp3` | Police alert tone | 15-20 seconds |
| `eas_military.mp3` | Military alert/air raid siren | 25-30 seconds |
| `eas_weather.mp3` | Severe weather alert tone | 20-25 seconds |

## Audio Recommendations

### Format
- **Format:** MP3 (recommended for best compatibility)
- **Bitrate:** 128-192 kbps
- **Sample Rate:** 44.1 kHz
- **Channels:** Stereo or Mono

### Sources
You can find royalty-free emergency alert sounds from:
- [Freesound.org](https://freesound.org) - Search for "EAS", "emergency alert", "siren"
- [Zapsplat](https://www.zapsplat.com) - Search for "alarm", "siren", "alert"
- [YouTube Audio Library](https://studio.youtube.com/channel/audio) - Some alarm sounds available

### Creating Custom Tones
You can use audio editing software like:
- [Audacity](https://www.audacityteam.org/) (Free)
- Adobe Audition
- FL Studio

### Tips
1. **Normalize audio levels** - Keep all audio files at similar volume levels
2. **Add fade out** - End with a 1-2 second fade out for smoother transitions
3. **Keep it professional** - Use authentic-sounding emergency tones
4. **Test in-game** - Verify audio plays correctly at different volume settings

## Default Audio (Fallback)

If you only want to use one audio file, rename it to `eas_default.mp3` and all alert types will use this sound.

## Volume Settings

Volume can be configured in `shared/config.lua`:
```lua
Config.General.DefaultVolume = 0.8 -- 80% volume
```

Individual players can have alerts at different volumes if configured.
