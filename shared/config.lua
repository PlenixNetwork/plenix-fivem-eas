--[[
    Plenix FiveM EAS- Configuration File
    Configure all aspects of the Emergency Alert System
]]

Config = {}

-----------------------------------------------------------
-- GENERAL SETTINGS
-----------------------------------------------------------
Config.General = {
    Debug = false,                          -- Enable debug mode for console logs
    DefaultLocale = 'en',                   -- Default language (en, es, de, fr, pt)
    Framework = 'esx',                      -- Framework: 'esx', 'qb', 'standalone'
    DefaultVolume = 1.0,                    -- Default audio volume (0.0 - 1.0)
    DefaultDuration = 25000,                -- Default alert duration in ms (25 seconds)
    CooldownEnabled = true,                 -- Enable cooldown between alerts
    CooldownTime = 30000,                   -- Cooldown time in ms (30 seconds)
    LogAlerts = true,                       -- Log alerts to server console
    DiscordWebhook = '',                    -- Discord webhook URL for logging (leave empty to disable)
}

-----------------------------------------------------------
-- PERMISSION SETTINGS
-----------------------------------------------------------
Config.Permissions = {
    UseAcePermissions = false,               -- Use ace permissions instead of job-based
    AcePermission = 'eas.use',              -- Ace permission required
    AdminPermission = 'eas.admin',          -- Admin ace permission (bypass cooldown)
    
    -- Job-based permissions (when UseAcePermissions = false)
    AllowedJobs = {
        'police',
        'ambulance',
    },
    
    -- Minimum job grade required (0 = any grade)
    MinimumJobGrade = 0,
}

-----------------------------------------------------------
-- ALERT TYPES
-- Define different types of alerts with their own styles
-----------------------------------------------------------
Config.AlertTypes = {
    ['default'] = {
        name = 'Emergency Alert',
        audio = 'eas_default',
        duration = 25000,
        priority = 'high',
        style = {
            backgroundColor = '#000000',
            borderColor = '#ff0000',
            textColor = '#ffffff',
            headerColor = '#ff0000',
            accentColor = '#ffcc00',
            animation = 'pulse',
            borderWidth = 4,
            borderStyle = 'solid'
        },
        icon = 'fa-exclamation-triangle'
    },
    
    ['nuclear'] = {
        name = 'Nuclear Alert',
        audio = 'eas_nuclear',
        duration = 35000,
        priority = 'critical',
        style = {
            backgroundColor = '#1a0a00',
            borderColor = '#ff6600',
            textColor = '#ffffff',
            headerColor = '#ff6600',
            accentColor = '#ffff00',
            animation = 'shake',
            borderWidth = 6,
            borderStyle = 'double'
        },
        icon = 'fa-radiation'
    },
    
    ['tornado'] = {
        name = 'Tornado Warning',
        audio = 'eas_tornado',
        duration = 30000,
        priority = 'high',
        style = {
            backgroundColor = '#0a0a1a',
            borderColor = '#00aaff',
            textColor = '#ffffff',
            headerColor = '#00aaff',
            accentColor = '#00ffff',
            animation = 'spin-slow',
            borderWidth = 4,
            borderStyle = 'solid'
        },
        icon = 'fa-wind'
    },
    
    ['amber'] = {
        name = 'AMBER Alert',
        audio = 'eas_amber',
        duration = 30000,
        priority = 'high',
        style = {
            backgroundColor = '#1a1000',
            borderColor = '#ffaa00',
            textColor = '#ffffff',
            headerColor = '#ffaa00',
            accentColor = '#ffffff',
            animation = 'pulse',
            borderWidth = 4,
            borderStyle = 'solid'
        },
        icon = 'fa-child'
    },
    
    ['earthquake'] = {
        name = 'Earthquake Warning',
        audio = 'eas_earthquake',
        duration = 25000,
        priority = 'high',
        style = {
            backgroundColor = '#1a0a0a',
            borderColor = '#8b4513',
            textColor = '#ffffff',
            headerColor = '#cd853f',
            accentColor = '#daa520',
            animation = 'shake-heavy',
            borderWidth = 4,
            borderStyle = 'solid'
        },
        icon = 'fa-house-crack'
    },
    
    ['tsunami'] = {
        name = 'Tsunami Warning',
        audio = 'eas_tsunami',
        duration = 30000,
        priority = 'critical',
        style = {
            backgroundColor = '#001020',
            borderColor = '#0066cc',
            textColor = '#ffffff',
            headerColor = '#0099ff',
            accentColor = '#00ccff',
            animation = 'wave',
            borderWidth = 4,
            borderStyle = 'solid'
        },
        icon = 'fa-water'
    },
    
    ['fire'] = {
        name = 'Fire Emergency',
        audio = 'eas_fire',
        duration = 25000,
        priority = 'high',
        style = {
            backgroundColor = '#1a0500',
            borderColor = '#ff3300',
            textColor = '#ffffff',
            headerColor = '#ff6600',
            accentColor = '#ffcc00',
            animation = 'flicker',
            borderWidth = 4,
            borderStyle = 'solid'
        },
        icon = 'fa-fire'
    },
    
    ['police'] = {
        name = 'Police Alert',
        audio = 'eas_police',
        duration = 20000,
        priority = 'medium',
        style = {
            backgroundColor = '#000510',
            borderColor = '#0044ff',
            textColor = '#ffffff',
            headerColor = '#3366ff',
            accentColor = '#ff0000',
            animation = 'police-flash',
            borderWidth = 4,
            borderStyle = 'solid'
        },
        icon = 'fa-shield-halved'
    },
    
    ['military'] = {
        name = 'Military Alert',
        audio = 'eas_military',
        duration = 30000,
        priority = 'critical',
        style = {
            backgroundColor = '#0a0a00',
            borderColor = '#556b2f',
            textColor = '#ffffff',
            headerColor = '#6b8e23',
            accentColor = '#9acd32',
            animation = 'pulse',
            borderWidth = 6,
            borderStyle = 'double'
        },
        icon = 'fa-jet-fighter'
    },
    
    ['weather'] = {
        name = 'Severe Weather',
        audio = 'eas_weather',
        duration = 25000,
        priority = 'medium',
        style = {
            backgroundColor = '#0a0a15',
            borderColor = '#4a4a6a',
            textColor = '#ffffff',
            headerColor = '#7a7aaa',
            accentColor = '#aaaacc',
            animation = 'fade-pulse',
            borderWidth = 4,
            borderStyle = 'solid'
        },
        icon = 'fa-cloud-bolt'
    }
}

-----------------------------------------------------------
-- DEPARTMENTS / ISSUERS
-- Who can issue alerts and how they appear
-----------------------------------------------------------
Config.Departments = {
    ['police'] = {
        name = 'Police Department',
        shortName = 'LSPD',
        allowedAlertTypes = {'default', 'police', 'amber'},
        color = '#0044ff'
    },
    ['ambulance'] = {
        name = 'Emergency Medical Services',
        shortName = 'EMS',
        allowedAlertTypes = {'default', 'fire', 'earthquake'},
        color = '#ff0000'
    },
    ['sheriff'] = {
        name = "Sheriff's Department",
        shortName = 'BCSO',
        allowedAlertTypes = {'default', 'police', 'amber', 'tornado'},
        color = '#8b4513'
    },
    ['fib'] = {
        name = 'Federal Investigation Bureau',
        shortName = 'FIB',
        allowedAlertTypes = {'default', 'police', 'nuclear', 'military', 'amber'},
        color = '#000080'
    },
    ['doj'] = {
        name = 'Department of Justice',
        shortName = 'DOJ',
        allowedAlertTypes = {'default', 'police', 'amber'},
        color = '#800000'
    },
    ['governor'] = {
        name = 'State Government',
        shortName = 'GOV',
        allowedAlertTypes = {'default', 'nuclear', 'tornado', 'tsunami', 'earthquake', 'military', 'weather', 'fire', 'amber'},
        color = '#ffd700'
    },
    ['admin'] = {
        name = 'Server Administration',
        shortName = 'ADMIN',
        allowedAlertTypes = 'all',
        color = '#ff00ff'
    }
}

-----------------------------------------------------------
-- UI SETTINGS
-----------------------------------------------------------
Config.UI = {
    Position = 'top',                       -- 'top', 'center', 'bottom'
    Width = '100%',                         -- Alert width
    MaxWidth = '1200px',                    -- Maximum width
    ShowIcon = true,                        -- Show alert type icon
    ShowTimestamp = true,                   -- Show timestamp on alert
    ShowIssuer = true,                      -- Show who issued the alert
    MarqueeSpeed = 15,                      -- Scrolling text speed (lower = faster)
    EnableSound = true,                     -- Enable alert sounds
    ShowCloseButton = false,                -- Show close button (allows players to dismiss)
    
    -- Default theme (can be changed in AlertTypes)
    DefaultTheme = {
        fontFamily = 'VCR_OSD_MONO',
        fontSize = '18px',
        headerFontSize = '24px',
        padding = '20px',
        borderRadius = '0px',
    }
}

-----------------------------------------------------------
-- COMMANDS
-----------------------------------------------------------
Config.Commands = {
    MainCommand = 'alert',                  -- Main command to open alert menu
    QuickAlertCommand = 'qalert',           -- Quick alert command: /qalert [type] [message]
    TestCommand = 'alerttest',              -- Test alert command (admin only)
    StopAlertCommand = 'stopalert',         -- Stop current alert command
    
    -- Subcommands for /alert
    Subcommands = {
        send = 'send',                      -- /alert send
        list = 'list',                      -- /alert list (list alert types)
        help = 'help',                      -- /alert help
    }
}

-----------------------------------------------------------
-- KEYBINDS
-----------------------------------------------------------
Config.Keybinds = {
    OpenMenu = '',                          -- Keybind to open alert menu (empty = disabled)
    CloseAlert = 'ESCAPE',                  -- Keybind to close alert (if ShowCloseButton is true)
}

-----------------------------------------------------------
-- PRESETS / QUICK MESSAGES
-- Pre-defined messages that can be quickly sent
-----------------------------------------------------------
Config.Presets = {
    ['lockdown'] = {
        alertType = 'police',
        title = 'City Lockdown',
        message = 'The city is under lockdown. All citizens must remain indoors until further notice.'
    },
    ['evacuation'] = {
        alertType = 'default',
        title = 'Evacuation Order',
        message = 'Immediate evacuation required. Please proceed to the nearest evacuation point.'
    },
    ['allclear'] = {
        alertType = 'default',
        title = 'All Clear',
        message = 'The emergency situation has been resolved. Resume normal activities.'
    },
    ['pursit'] = {
        alertType = 'police',
        title = 'Active Pursuit',
        message = 'Police pursuit in progress. Please clear the roads and stay safe.'
    },
    ['wanted'] = {
        alertType = 'amber',
        title = 'Wanted Individual',
        message = 'Be on the lookout for a dangerous individual. Do not approach, contact authorities immediately.'
    }
}
