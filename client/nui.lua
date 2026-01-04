--[[
    Plenix FiveM EAS - Client NUI
    NUI callbacks and interactions
]]

-----------------------------------------------------------
-- NUI CALLBACKS
-----------------------------------------------------------

-- Close menu callback
RegisterNUICallback('closeMenu', function(data, cb)
    SetNuiFocus(false, false)
    cb('ok')
end)

-- Close alert callback
RegisterNUICallback('closeAlert', function(data, cb)
    CloseAlert()
    cb('ok')
end)

-- Send alert callback
RegisterNUICallback('sendAlert', function(data, cb)
    if not data.alertType or not data.message then
        cb({ success = false, error = 'Missing data' })
        return
    end
    
    TriggerServerEvent('eas:requestAlert', data.alertType, data.message)
    SetNuiFocus(false, false)
    cb({ success = true })
end)

-- Send preset callback
RegisterNUICallback('sendPreset', function(data, cb)
    if not data.presetName then
        cb({ success = false, error = 'Missing preset name' })
        return
    end
    
    TriggerServerEvent('eas:requestPreset', data.presetName)
    SetNuiFocus(false, false)
    cb({ success = true })
end)

-- Get alert types callback
RegisterNUICallback('getAlertTypes', function(data, cb)
    TriggerServerEvent('eas:getAlertTypes')
    cb('ok')
end)

-- Preview alert callback (local only)
RegisterNUICallback('previewAlert', function(data, cb)
    local alertType = data.alertType or 'default'
    local alertConfig = EAS.GetAlertType(alertType)
    
    if not alertConfig then
        alertConfig = {
            name = 'Emergency Alert',
            priority = 'high',
            style = {},
            icon = 'fa-exclamation-triangle',
            audio = 'eas_default'
        }
    end
    
    local previewData = {
        type = alertType,
        alertName = (alertConfig.name or 'Alert') .. ' (PREVIEW)',
        message = data.message or 'This is a preview of the alert message.',
        issuer = 'Preview',
        issuerDepartment = 'Preview Mode',
        issuerShortName = 'PREV',
        timestamp = EAS.FormatTimestamp() or '00:00:00',
        date = EAS.FormatDate() or '2026-01-01',
        duration = 5000, -- Short duration for preview
        priority = alertConfig.priority or 'high',
        style = alertConfig.style or {},
        icon = alertConfig.icon or 'fa-exclamation-triangle',
        audio = alertConfig.audio or 'eas_default',
        volume = (Config.General.DefaultVolume or 0.8) * 0.5 -- Lower volume for preview
    }
    
    SendNUIMessage({
        action = 'previewAlert',
        data = previewData,
        locale = GetLocaleData(),
        debug = Config.General.Debug,
        uiConfig = Config.UI
    })
    
    cb({ success = true })
end)

-- Open keyboard input callback
RegisterNUICallback('openKeyboard', function(data, cb)
    SetNuiFocus(false, false)
    
    Citizen.CreateThread(function()
        local input = OpenKeyboardInput(data.title or 'Enter message', data.maxLength or 500)
        
        if input then
            SendNUIMessage({
                action = 'keyboardResult',
                data = {
                    success = true,
                    input = input
                }
            })
        else
            SendNUIMessage({
                action = 'keyboardResult',
                data = {
                    success = false
                }
            })
        end
        
        -- Re-enable NUI focus for menu
        Citizen.Wait(100)
        SetNuiFocus(true, true)
    end)
    
    cb('ok')
end)

-- Get config callback
RegisterNUICallback('getConfig', function(data, cb)
    cb({
        ui = Config.UI,
        alertTypes = Config.AlertTypes,
        presets = Config.Presets,
        locale = GetLocaleData()
    })
end)

-- Play sound callback
RegisterNUICallback('playSound', function(data, cb)
    -- Sound is handled in NUI/JavaScript
    cb('ok')
end)

-- Escape key handling
Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        
        if IsControlJustPressed(0, 200) then -- ESC key
            SendNUIMessage({
                action = 'escapePressed'
            })
        end
    end
end)

-----------------------------------------------------------
-- FOCUS MANAGEMENT
-----------------------------------------------------------
local menuOpen = false

RegisterNUICallback('menuOpened', function(data, cb)
    menuOpen = true
    cb('ok')
end)

RegisterNUICallback('menuClosed', function(data, cb)
    menuOpen = false
    SetNuiFocus(false, false)
    cb('ok')
end)

-- Disable controls while menu is open
Citizen.CreateThread(function()
    while true do
        if menuOpen then
            DisableControlAction(0, 1, true) -- Look Left/Right
            DisableControlAction(0, 2, true) -- Look Up/Down
            DisableControlAction(0, 142, true) -- MeleeAttackAlternate
            DisableControlAction(0, 18, true) -- Enter
            DisableControlAction(0, 322, true) -- ESC
            DisableControlAction(0, 106, true) -- VehicleMouseControlOverride
        end
        Citizen.Wait(0)
    end
end)
