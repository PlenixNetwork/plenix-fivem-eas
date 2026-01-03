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
    
    -- Fonts
    'assets/fonts/VCR_OSD_MONO.ttf',
    'assets/fonts/Roboto-Bold.ttf',
    'assets/fonts/Roboto-Regular.ttf',
    
    -- Audio Files
    'assets/audio/eas_default.mp3',
    'assets/audio/eas_nuclear.mp3',
    'assets/audio/eas_tornado.mp3',
    'assets/audio/eas_amber.mp3',
    'assets/audio/eas_earthquake.mp3',
    'assets/audio/eas_tsunami.mp3',
    'assets/audio/eas_fire.mp3',
    'assets/audio/eas_police.mp3',
    'assets/audio/eas_military.mp3',
    'assets/audio/eas_weather.mp3'
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