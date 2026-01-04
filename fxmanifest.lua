fx_version 'cerulean'
game 'gta5'
lua54 'yes'

name 'plenix-fivem-eas'
author 'Plenix Network'
description 'Advanced Emergency Alert System for FiveM with multiple alert types, translations, and customizable styles'
version '2.0.0'

-- Shared Scripts (loaded on both client and server)
shared_scripts {
    'shared/config.lua',
    'shared/functions.lua',
    'locales/loader.lua',
    'locales/*.lua'
}

-- Client Scripts
client_scripts {
    'client/main.lua',
    'client/nui.lua'
}

-- Server Scripts
server_scripts {
    'server/main.lua',
    'server/commands.lua'
}

-- NUI Configuration
ui_page 'ui/index.html'

-- Files accessible to NUI
files {
    -- UI Files
    'ui/index.html',
    'ui/css/main.css',
    'ui/css/animations.css',
    'ui/css/themes.css',
    'ui/js/main.js',
    'ui/js/audio.js',
    'ui/js/animations.js',
    
    -- Fonts (all font files in assets/fonts folder)
    'assets/fonts/*.ttf',
    'assets/fonts/*.otf',
    'assets/fonts/*.woff',
    'assets/fonts/*.woff2',
    
    -- Audio Files (all audio files in assets/audio folder)
    'assets/audio/*.mp3',
    'assets/audio/*.ogg',
    'assets/audio/*.wav'
}

-- Dependencies (optional, remove if not using ESX)
dependencies {
    'es_extended'
}

-- Exports
exports {
    'SendAlert',
    'SendCustomAlert',
    'IsPlayerAllowed'
}

server_exports {
    'TriggerAlert',
    'TriggerCustomAlert',
    'IsPlayerAllowed'
}
