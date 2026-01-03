--[[
    Plenix FiveM EAS- Server Main
    Core server-side functionality
]]

local Framework = nil
local PlayerCooldowns = {}

-----------------------------------------------------------
-- FRAMEWORK INITIALIZATION
-----------------------------------------------------------
Citizen.CreateThread(function()
    if Config.General.Framework == 'esx' then
        -- ESX Framework
        if GetResourceState('es_extended') == 'started' then
            Framework = exports['es_extended']:getSharedObject()
            EAS.Debug('ESX Framework loaded')
        end
    elseif Config.General.Framework == 'qb' then
        -- QBCore Framework
        if GetResourceState('qb-core') == 'started' then
            Framework = exports['qb-core']:GetCoreObject()
            EAS.Debug('QBCore Framework loaded')
        end
    end
    
    if not Framework and Config.General.Framework ~= 'standalone' then
        print('[EAS] Warning: Framework not found. Running in standalone mode.')
    end
end)

-----------------------------------------------------------
-- PERMISSION CHECKING
-----------------------------------------------------------
function IsPlayerAllowed(source)
    if Config.Permissions.UseAcePermissions then
        return IsPlayerAceAllowed(source, Config.Permissions.AcePermission)
    else
        return IsPlayerJobAllowed(source)
    end
end

function IsPlayerAdmin(source)
    if Config.Permissions.UseAcePermissions then
        return IsPlayerAceAllowed(source, Config.Permissions.AdminPermission)
    end
    return false
end

function IsPlayerAceAllowed(source, permission)
    return IsPlayerAceAllowed(source, permission)
end

function IsPlayerJobAllowed(source)
    if not Framework then
        return false
    end
    
    local player = nil
    local jobName = nil
    local jobGrade = 0
    
    if Config.General.Framework == 'esx' then
        player = Framework.GetPlayerFromId(source)
        if player then
            jobName = player.job.name
            jobGrade = player.job.grade
        end
    elseif Config.General.Framework == 'qb' then
        player = Framework.Functions.GetPlayer(source)
        if player then
            jobName = player.PlayerData.job.name
            jobGrade = player.PlayerData.job.grade.level
        end
    end
    
    if not jobName then
        return false
    end
    
    -- Check if job is in allowed list
    for _, allowedJob in ipairs(Config.Permissions.AllowedJobs) do
        if jobName == allowedJob then
            -- Check minimum grade
            if jobGrade >= Config.Permissions.MinimumJobGrade then
                return true
            end
        end
    end
    
    return false
end

function GetPlayerDepartment(source)
    if Config.Permissions.UseAcePermissions then
        -- For ace permissions, check which department the player has
        for deptKey, _ in pairs(Config.Departments) do
            if IsPlayerAceAllowed(source, 'eas.dept.' .. deptKey) then
                return deptKey
            end
        end
        -- Default to admin if they have general permission
        if IsPlayerAceAllowed(source, Config.Permissions.AdminPermission) then
            return 'admin'
        end
        return nil
    else
        -- Get from framework
        if not Framework then
            return nil
        end
        
        local jobName = nil
        
        if Config.General.Framework == 'esx' then
            local player = Framework.GetPlayerFromId(source)
            if player then
                jobName = player.job.name
            end
        elseif Config.General.Framework == 'qb' then
            local player = Framework.Functions.GetPlayer(source)
            if player then
                jobName = player.PlayerData.job.name
            end
        end
        
        return jobName
    end
end

function GetCharacterName(source)
    local name = GetPlayerName(source) -- Native FiveM function
    
    if Framework then
        if Config.General.Framework == 'esx' then
            local player = Framework.GetPlayerFromId(source)
            if player then
                name = player.getName()
            end
        elseif Config.General.Framework == 'qb' then
            local player = Framework.Functions.GetPlayer(source)
            if player then
                name = player.PlayerData.charinfo.firstname .. ' ' .. player.PlayerData.charinfo.lastname
            end
        end
    end
    
    return name or 'Unknown'
end

-----------------------------------------------------------
-- COOLDOWN MANAGEMENT
-----------------------------------------------------------
function IsOnCooldown(source)
    if not Config.General.CooldownEnabled then
        return false
    end
    
    if IsPlayerAdmin(source) then
        return false
    end
    
    local cooldown = PlayerCooldowns[source]
    if cooldown and (GetGameTimer() - cooldown) < Config.General.CooldownTime then
        return true
    end
    
    return false
end

function GetCooldownRemaining(source)
    local cooldown = PlayerCooldowns[source]
    if cooldown then
        local remaining = Config.General.CooldownTime - (GetGameTimer() - cooldown)
        return math.ceil(remaining / 1000)
    end
    return 0
end

function SetCooldown(source)
    PlayerCooldowns[source] = GetGameTimer()
end

-----------------------------------------------------------
-- ALERT FUNCTIONS
-----------------------------------------------------------
function TriggerAlert(alertType, message, issuer, issuerDepartment, targetPlayers)
    local alertConfig = EAS.GetAlertType(alertType)
    local department = EAS.GetDepartment(issuerDepartment) or {name = issuerDepartment, shortName = issuerDepartment}
    
    local alertData = {
        type = alertType,
        alertName = alertConfig.name,
        message = EAS.SanitizeString(message),
        issuer = issuer,
        issuerDepartment = department.name,
        issuerShortName = department.shortName,
        timestamp = EAS.FormatTimestamp(),
        date = EAS.FormatDate(),
        duration = alertConfig.duration,
        priority = alertConfig.priority,
        style = alertConfig.style,
        icon = alertConfig.icon,
        audio = alertConfig.audio,
        volume = Config.General.DefaultVolume
    }
    
    -- Send to target players or all
    if targetPlayers then
        for _, playerId in ipairs(targetPlayers) do
            TriggerClientEvent('eas:receiveAlert', playerId, alertData)
        end
    else
        TriggerClientEvent('eas:receiveAlert', -1, alertData)
    end
    
    -- Logging
    if Config.General.LogAlerts then
        print(string.format('[EAS] Alert sent - Type: %s | Issuer: %s | Message: %s', alertType, issuer, message))
    end
    
    -- Discord webhook logging
    if Config.General.DiscordWebhook and Config.General.DiscordWebhook ~= '' then
        SendDiscordLog(alertData)
    end
    
    return true
end

function TriggerCustomAlert(customData)
    local alertData = {
        type = customData.type or 'default',
        alertName = customData.alertName or 'Custom Alert',
        message = EAS.SanitizeString(customData.message or ''),
        issuer = customData.issuer or 'System',
        issuerDepartment = customData.issuerDepartment or 'System',
        issuerShortName = customData.issuerShortName or 'SYS',
        timestamp = EAS.FormatTimestamp(),
        date = EAS.FormatDate(),
        duration = customData.duration or Config.General.DefaultDuration,
        priority = customData.priority or 'medium',
        style = customData.style or Config.AlertTypes['default'].style,
        icon = customData.icon or 'fa-exclamation-triangle',
        audio = customData.audio or 'eas_default',
        volume = customData.volume or Config.General.DefaultVolume
    }
    
    TriggerClientEvent('eas:receiveAlert', -1, alertData)
    
    return true
end

-----------------------------------------------------------
-- DISCORD WEBHOOK
-----------------------------------------------------------
function SendDiscordLog(alertData)
    local embed = {
        {
            ["title"] = "🚨 " .. alertData.alertName,
            ["description"] = alertData.message,
            ["color"] = 16711680,
            ["fields"] = {
                {
                    ["name"] = "Issued By",
                    ["value"] = alertData.issuer .. " (" .. alertData.issuerDepartment .. ")",
                    ["inline"] = true
                },
                {
                    ["name"] = "Priority",
                    ["value"] = alertData.priority,
                    ["inline"] = true
                },
                {
                    ["name"] = "Time",
                    ["value"] = alertData.date .. " " .. alertData.timestamp,
                    ["inline"] = true
                }
            },
            ["footer"] = {
                ["text"] = "Plenix FiveM EAS v2.0"
            }
        }
    }
    
    PerformHttpRequest(Config.General.DiscordWebhook, function(err, text, headers) end, 'POST', json.encode({
        username = "Emergency Alert System",
        embeds = embed
    }), { ['Content-Type'] = 'application/json' })
end

-----------------------------------------------------------
-- NOTIFICATION HELPER
-----------------------------------------------------------
function SendNotification(source, message, type)
    if Framework then
        if Config.General.Framework == 'esx' then
            TriggerClientEvent('esx:showNotification', source, message)
        elseif Config.General.Framework == 'qb' then
            TriggerClientEvent('QBCore:Notify', source, message, type or 'primary')
        end
    else
        TriggerClientEvent('eas:notification', source, message, type)
    end
end

-----------------------------------------------------------
-- EVENTS
-----------------------------------------------------------
RegisterNetEvent('eas:requestAlert', function(alertType, message)
    local source = source
    
    -- Check permission
    if not IsPlayerAllowed(source) then
        SendNotification(source, _L('notify_no_permission'), 'error')
        return
    end
    
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
    
    -- Validate message
    if not message or message == '' then
        SendNotification(source, _L('notify_message_required'), 'error')
        return
    end
    
    -- Get player department
    local department = GetPlayerDepartment(source)
    
    -- Check if department can use this alert type
    if department and not EAS.CanDepartmentUseAlertType(department, alertType) then
        SendNotification(source, _L('notify_type_not_allowed'), 'error')
        return
    end
    
    -- Get player name for issuer
    local playerName = GetCharacterName(source)
    
    -- Send alert
    TriggerAlert(alertType, message, playerName, department or 'unknown')
    
    -- Set cooldown
    SetCooldown(source)
    
    -- Confirm to sender
    SendNotification(source, _L('notify_alert_sent'), 'success')
end)

RegisterNetEvent('eas:requestPreset', function(presetName)
    local source = source
    
    -- Check permission
    if not IsPlayerAllowed(source) then
        SendNotification(source, _L('notify_no_permission'), 'error')
        return
    end
    
    -- Check cooldown
    if IsOnCooldown(source) then
        SendNotification(source, _L('notify_cooldown', GetCooldownRemaining(source)), 'error')
        return
    end
    
    -- Get preset
    local preset = EAS.GetPreset(presetName)
    if not preset then
        SendNotification(source, _L('notify_invalid_type'), 'error')
        return
    end
    
    -- Get player info
    local department = GetPlayerDepartment(source)
    local playerName = GetCharacterName(source)
    
    -- Send alert
    TriggerAlert(preset.alertType, preset.message, playerName, department or 'unknown')
    
    -- Set cooldown
    SetCooldown(source)
    
    SendNotification(source, _L('notify_alert_sent'), 'success')
end)

RegisterNetEvent('eas:getAlertTypes', function()
    local source = source
    local department = GetPlayerDepartment(source)
    local allowedTypes = {}
    
    for key, data in pairs(Config.AlertTypes) do
        if EAS.CanDepartmentUseAlertType(department, key) or department == 'admin' then
            table.insert(allowedTypes, {
                key = key,
                name = data.name,
                icon = data.icon,
                priority = data.priority
            })
        end
    end
    
    TriggerClientEvent('eas:receiveAlertTypes', source, allowedTypes)
end)

-----------------------------------------------------------
-- EXPORTS
-----------------------------------------------------------
exports('TriggerAlert', TriggerAlert)
exports('TriggerCustomAlert', TriggerCustomAlert)
exports('IsPlayerAllowed', IsPlayerAllowed)

-----------------------------------------------------------
-- CLEANUP ON PLAYER DROP
-----------------------------------------------------------
AddEventHandler('playerDropped', function()
    local source = source
    PlayerCooldowns[source] = nil
end)
