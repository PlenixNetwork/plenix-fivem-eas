--[[
    Plenix FiveM EAS- Locale Loader
    Handles loading and retrieval of translations
]]

Locales = Locales or {}
CurrentLocale = Config.General.DefaultLocale or 'en'

-----------------------------------------------------------
-- LOCALE FUNCTIONS
-----------------------------------------------------------

-- Get a translated string
function _L(key, ...)
    local locale = Locales[CurrentLocale]
    
    if not locale then
        locale = Locales['en']
    end
    
    if not locale then
        return key
    end
    
    local translation = locale[key]
    
    if not translation then
        -- Try English as fallback
        if Locales['en'] and Locales['en'][key] then
            translation = Locales['en'][key]
        else
            return key
        end
    end
    
    -- Handle format arguments
    local args = {...}
    if #args > 0 then
        return string.format(translation, table.unpack(args))
    end
    
    return translation
end

-- Set the current locale
function SetLocale(locale)
    if Locales[locale] then
        CurrentLocale = locale
        EAS.Debug('Locale set to:', locale)
        return true
    end
    return false
end

-- Get current locale
function GetLocale()
    return CurrentLocale
end

-- Get all available locales
function GetAvailableLocales()
    local available = {}
    for key, _ in pairs(Locales) do
        table.insert(available, key)
    end
    return available
end

-- Check if locale exists
function LocaleExists(locale)
    return Locales[locale] ~= nil
end

-- Add translations to a locale
function AddLocale(locale, translations)
    if not Locales[locale] then
        Locales[locale] = {}
    end
    
    for key, value in pairs(translations) do
        Locales[locale][key] = value
    end
end
