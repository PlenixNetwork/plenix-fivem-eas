# Fonts for EAS FiveM

This folder should contain the font files used by the emergency alert UI.

## Required Fonts

| Filename | Description |
|----------|-------------|
| `VCR_OSD_MONO.ttf` | Classic EAS-style monospace font (main alert font) |
| `Roboto-Regular.ttf` | Secondary font for UI elements |
| `Roboto-Bold.ttf` | Bold variant for headings |

## Downloading Fonts

### VCR OSD Mono
This font mimics the classic VCR/broadcast display look.
- Download from: [DaFont](https://www.dafont.com/vcr-osd-mono.font)
- Or search for "VCR OSD Mono" font

### Roboto
Google's open-source font family.
- Download from: [Google Fonts](https://fonts.google.com/specimen/Roboto)
- Select "Regular 400" and "Bold 700" weights

## Installation

1. Download the fonts from the sources above
2. Place the `.ttf` files in this folder
3. Ensure the filenames match exactly:
   - `VCR_OSD_MONO.ttf`
   - `Roboto-Regular.ttf`
   - `Roboto-Bold.ttf`

## Custom Fonts

You can use your own fonts by:
1. Adding the font file to this folder
2. Updating `ui/css/main.css` with the new @font-face declaration
3. Updating the CSS variables to use your new font

Example:
```css
@font-face {
    font-family: 'YourCustomFont';
    src: url('../assets/fonts/YourCustomFont.ttf') format('truetype');
}

:root {
    --font-primary: 'YourCustomFont', 'Courier New', monospace;
}
```
