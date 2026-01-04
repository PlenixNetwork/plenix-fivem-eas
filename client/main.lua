--[[
    Plenix FiveM EAS - Client Main
    Core client-side functionality
]]

local Framework = nil
local isAlertActive = false
local currentAlert = nil

-----------------------------------------------------------
-- FRAMEWORK INITIALIZATION
-----------------------------------------------------------
Citizen.CreateThread(function()
    if Config.General.Framework == 'esx' then
        if GetResourceState('es_extended') == 'started' then
            Framework = exports['es_extended']:getSharedObject()
            EAS.Debug('ESX Framework loaded on client')
        end
    elseif Config.General.Framework == 'qb' then
        if GetResourceState('qb-core') == 'started' then
            Framework = exports['qb-core']:GetCoreObject()
            EAS.Debug('QBCore Framework loaded on client')
        end
    end
end)

-----------------------------------------------------------
-- KEYBIND REGISTRATION
-----------------------------------------------------------
if Config.Keybinds.OpenMenu and Config.Keybinds.OpenMenu ~= '' then
    RegisterCommand('+eas_openmenu', function()
        TriggerServerEvent('eas:getAlertTypes')
        -- Menu opening is handled via NUI callback
    end, false)
    
    RegisterKeyMapping('+eas_openmenu', 'Open Emergency Alert System', 'keyboard', Config.Keybinds.OpenMenu)
end

-----------------------------------------------------------
-- ALERT RECEIVING
-----------------------------------------------------------
RegisterNetEvent('eas:receiveAlert', function(alertData)
    if not alertData then
        EAS.Debug('Received invalid alert data')
        return
    end
    
    EAS.Debug('Received alert:', alertData.type)
    
    currentAlert = alertData
    isAlertActive = true
    
    -- Send to NUI with UI config
    SendNUIMessage({
        action = 'showAlert',
        data = alertData,
        locale = GetLocaleData(),
        debug = Config.General.Debug,
        uiConfig = Config.UI
    })
    
    -- Auto-hide after duration
    SetTimeout(alertData.duration or Config.General.DefaultDuration, function()
        if isAlertActive and currentAlert and currentAlert.timestamp == alertData.timestamp then
            CloseAlert()
        end
    end)
end)

-----------------------------------------------------------
-- MENU EVENTS
-----------------------------------------------------------
RegisterNetEvent('eas:openMenu', function()
    TriggerServerEvent('eas:getAlertTypes')
    
    Citizen.Wait(100)
    
    SendNUIMessage({
        action = 'openMenu',
        locale = GetLocaleData(),
        presets = Config.Presets,
        debug = Config.General.Debug
    })
    
    SetNuiFocus(true, true)
end)

RegisterNetEvent('eas:openAlertInput', function()
    TriggerServerEvent('eas:getAlertTypes')
end)

RegisterNetEvent('eas:receiveAlertTypes', function(alertTypes)
    SendNUIMessage({
        action = 'updateAlertTypes',
        data = alertTypes
    })
end)

RegisterNetEvent('eas:showAlertTypes', function(types)
    local message = 'Available alert types: ' .. table.concat(types, ', ')
    ShowNotification(message)
end)

RegisterNetEvent('eas:showHelp', function()
    ShowNotification(_L('cmd_help_alert'))
    Citizen.Wait(500)
    ShowNotification(_L('cmd_help_qalert'))
    Citizen.Wait(500)
    ShowNotification(_L('cmd_help_list'))
end)

-----------------------------------------------------------
-- KEYBOARD INPUT (Legacy support)
-----------------------------------------------------------
function OpenKeyboardInput(title, maxLength)
    DisplayOnscreenKeyboard(1, "FMMC_KEY_TIP8", "", title or "", "", "", "", maxLength or 500)
    
    while UpdateOnscreenKeyboard() == 0 do
        DisableAllControlActions(0)
        Citizen.Wait(0)
    end
    
    if UpdateOnscreenKeyboard() == 1 then
        return GetOnscreenKeyboardResult()
    end
    
    return nil
end

-----------------------------------------------------------
-- HELPER FUNCTIONS
-----------------------------------------------------------
function CloseAlert()
    isAlertActive = false
    currentAlert = nil
    
    SendNUIMessage({
        action = 'hideAlert'
    })
end

function GetLocaleData()
    local localeData = {}
    local locale = Locales[CurrentLocale] or Locales['en'] or {}
    
    for key, value in pairs(locale) do
        localeData[key] = value
    end
    
    return localeData
end

function ShowNotification(message)
    if Framework then
        if Config.General.Framework == 'esx' then
            exports['es_extended']:ShowNotification(message)
        elseif Config.General.Framework == 'qb' then
            exports['qb-core']:Notify(message)
        end
    else
        SetNotificationTextEntry('STRING')
        AddTextComponentString(message)
        DrawNotification(false, false)
    end
end

-----------------------------------------------------------
-- NOTIFICATIONS FROM SERVER
-----------------------------------------------------------
RegisterNetEvent('eas:notification', function(message, type)
    ShowNotification(message)
end)

-----------------------------------------------------------
-- STOP ALERT EVENT
-----------------------------------------------------------
RegisterNetEvent('eas:stopAlert', function()
    EAS.Debug('Received stop alert command')
    CloseAlert()
end)

-----------------------------------------------------------
-- EXPORTS
-----------------------------------------------------------
function SendAlert(alertType, message)
    TriggerServerEvent('eas:requestAlert', alertType, message)
end

function SendCustomAlert(customData)
    -- For client-side custom alerts, forward to server
    TriggerServerEvent('eas:requestCustomAlert', customData)
end

function IsPlayerAllowed()
    -- This needs to check with server
    local result = nil
    local callback = function(allowed)
        result = allowed
    end
    
    TriggerServerEvent('eas:checkPermission', callback)
    
    local timeout = 50
    while result == nil and timeout > 0 do
        Citizen.Wait(100)
        timeout = timeout - 1
    end
    
    return result or false
end

exports('SendAlert', SendAlert)
exports('SendCustomAlert', SendCustomAlert)
exports('IsPlayerAllowed', IsPlayerAllowed)
