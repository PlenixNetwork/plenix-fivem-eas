--[[
    Plenix FiveM EAS- Server Commands
    Command registration and handling
]]

-----------------------------------------------------------
-- MAIN ALERT COMMAND
-----------------------------------------------------------
RegisterCommand(Config.Commands.MainCommand, function(source, args, rawCommand)
    if source == 0 then
        -- Console command
        if #args < 2 then
            print('[EAS] Usage: /' .. Config.Commands.MainCommand .. ' <type> <message>')
            print('[EAS] Available types: ' .. table.concat(GetAlertTypeKeys(), ', '))
            return
        end
        
        local alertType = args[1]
        table.remove(args, 1)
        local message = table.concat(args, ' ')
        
        TriggerAlert(alertType, message, 'Console', 'admin')
        print('[EAS] Alert sent successfully.')
        return
    end
    
    -- Player command
    if not IsPlayerAllowed(source) then
        SendNotification(source, _L('notify_no_permission'), 'error')
        return
    end
    
    if #args == 0 then
        -- Open menu
        TriggerClientEvent('eas:openMenu', source)
        return
    end
    
    local subcommand = string.lower(args[1])
    
    if subcommand == Config.Commands.Subcommands.list then
        -- List available alert types
        local types = GetAlertTypeKeys()
        TriggerClientEvent('eas:showAlertTypes', source, types)
        return
    end
    
    if subcommand == Config.Commands.Subcommands.help then
        -- Show help
        TriggerClientEvent('eas:showHelp', source)
        return
    end
    
    if subcommand == Config.Commands.Subcommands.send then
        -- /alert send - open the input modal
        TriggerClientEvent('eas:openAlertInput', source)
        return
    end
end, false)

-----------------------------------------------------------
-- QUICK ALERT COMMAND
-----------------------------------------------------------
RegisterCommand(Config.Commands.QuickAlertCommand, function(source, args, rawCommand)
    if source == 0 then
        print('[EAS] This command cannot be used from console. Use /' .. Config.Commands.MainCommand .. ' instead.')
        return
    end
    
    if not IsPlayerAllowed(source) then
        SendNotification(source, _L('notify_no_permission'), 'error')
        return
    end
    
    if #args < 2 then
        SendNotification(source, 'Usage: /' .. Config.Commands.QuickAlertCommand .. ' <type> <message>', 'error')
        return
    end
    
    local alertType = args[1]
    table.remove(args, 1)
    local message = table.concat(args, ' ')
    
    -- Trigger through the normal event flow
    TriggerEvent('eas:requestAlert', alertType, message)
    -- Manually handle since we're on server
    
    -- Check cooldown
    if IsOnCooldown(source) then
        SendNotification(source, _L('notify_cooldown', GetCooldownRemaining(source)), 'error')
        return
    end
    
    -- Validate alert type
    if not EAS.IsValidAlertType(alertType) then
        SendNotification(source, _L('notify_invalid_type'), 'error')
        return
    end
    
    local department = GetPlayerDepartment(source)
    
    if department and not EAS.CanDepartmentUseAlertType(department, alertType) then
        SendNotification(source, _L('notify_type_not_allowed'), 'error')
        return
    end
    
    local playerName = GetCharacterName(source)
    
    TriggerAlert(alertType, message, playerName, department or 'unknown')
    SetCooldown(source)
    SendNotification(source, _L('notify_alert_sent'), 'success')
end, false)

-----------------------------------------------------------
-- TEST ALERT COMMAND (Admin Only)
-----------------------------------------------------------
RegisterCommand(Config.Commands.TestCommand, function(source, args, rawCommand)
    if source == 0 then
        -- Console
        local alertType = args[1] or 'default'
        TriggerAlert(alertType, 'This is a test alert from the console.', 'Console', 'admin')
        print('[EAS] Test alert sent.')
        return
    end
    
    if not IsPlayerAdmin(source) then
        SendNotification(source, _L('notify_no_permission'), 'error')
        return
    end
    
    local alertType = args[1] or 'default'
    
    if not EAS.IsValidAlertType(alertType) then
        SendNotification(source, _L('notify_invalid_type'), 'error')
        return
    end
    
    -- Send test alert only to this player
    local alertConfig = EAS.GetAlertType(alertType)
    
    local alertData = {
        type = alertType,
        alertName = alertConfig.name .. ' (TEST)',
        message = 'This is a test alert. This alert is only visible to you.',
        issuer = 'System',
        issuerDepartment = 'Test Mode',
        issuerShortName = 'TEST',
        timestamp = EAS.FormatTimestamp(),
        date = EAS.FormatDate(),
        duration = alertConfig.duration,
        priority = alertConfig.priority,
        style = alertConfig.style,
        icon = alertConfig.icon,
        audio = alertConfig.audio,
        volume = Config.General.DefaultVolume
    }
    
    TriggerClientEvent('eas:receiveAlert', source, alertData)
    SendNotification(source, 'Test alert sent (visible only to you).', 'success')
end, false)

-----------------------------------------------------------
-- STOP ALERT COMMAND
-----------------------------------------------------------
RegisterCommand(Config.Commands.StopAlertCommand, function(source, args, rawCommand)
    if source == 0 then
        -- Console command
        TriggerClientEvent('eas:stopAlert', -1)
        print('[EAS] Alert stop command sent to all players.')
        return
    end
    
    -- Player command - check permissions
    if not IsPlayerAllowed(source) then
        SendNotification(source, _L('notify_no_permission'), 'error')
        return
    end
    
    -- Stop alert for all players
    TriggerClientEvent('eas:stopAlert', -1)
    SendNotification(source, _L('notify_alert_stopped'), 'success')
    
    if Config.General.LogAlerts then
        local playerName = GetCharacterName(source) or GetPlayerName(source)
        print('[EAS] Alert stopped by: ' .. playerName)
    end
end, false)

-----------------------------------------------------------
-- PRESET COMMANDS
-----------------------------------------------------------
for presetName, presetData in pairs(Config.Presets) do
    RegisterCommand('alert' .. presetName, function(source, args, rawCommand)
        if source == 0 then
            TriggerAlert(presetData.alertType, presetData.message, 'Console', 'admin')
            print('[EAS] Preset alert "' .. presetName .. '" sent.')
            return
        end
        
        if not IsPlayerAllowed(source) then
            SendNotification(source, _L('notify_no_permission'), 'error')
            return
        end
        
        if IsOnCooldown(source) then
            SendNotification(source, _L('notify_cooldown', GetCooldownRemaining(source)), 'error')
            return
        end
        
        local department = GetPlayerDepartment(source)
        local playerName = GetCharacterName(source)
        
        TriggerAlert(presetData.alertType, presetData.message, playerName, department or 'unknown')
        SetCooldown(source)
        SendNotification(source, _L('notify_alert_sent'), 'success')
    end, false)
end

-----------------------------------------------------------
-- HELPER FUNCTIONS
-----------------------------------------------------------
function GetAlertTypeKeys()
    local keys = {}
    for key, _ in pairs(Config.AlertTypes) do
        table.insert(keys, key)
    end
    return keys
end

-----------------------------------------------------------
-- ACE PERMISSION SUGGESTIONS
-----------------------------------------------------------
-- Add these to your server.cfg:
-- add_ace group.admin eas.use allow
-- add_ace group.admin eas.admin allow
-- add_ace group.police eas.use allow
-- add_ace group.police eas.dept.police allow
-- add_ace group.ambulance eas.use allow
-- add_ace group.ambulance eas.dept.ambulance allow
