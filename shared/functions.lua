--[[
    Plenix FiveM EAS - Shared Functions
    Utility functions available on both client and server
]]

EAS = EAS or {}

-----------------------------------------------------------
-- DEBUG LOGGING
-----------------------------------------------------------
function EAS.Debug(...)
    if Config.General.Debug then
        local args = {...}
        local message = '[EAS Debug] '
        for i, v in ipairs(args) do
            message = message .. tostring(v) .. ' '
        end
        print(message)
    end
end

-----------------------------------------------------------
-- GET ALERT TYPE CONFIGURATION
-----------------------------------------------------------
function EAS.GetAlertType(alertType)
    if Config.AlertTypes[alertType] then
        return Config.AlertTypes[alertType]
    end
    return Config.AlertTypes['default']
end

-----------------------------------------------------------
-- GET DEPARTMENT CONFIGURATION
-----------------------------------------------------------
function EAS.GetDepartment(departmentKey)
    if Config.Departments[departmentKey] then
        return Config.Departments[departmentKey]
    end
    return nil
end

-----------------------------------------------------------
-- CHECK IF ALERT TYPE IS VALID
-----------------------------------------------------------
function EAS.IsValidAlertType(alertType)
    return Config.AlertTypes[alertType] ~= nil
end

-----------------------------------------------------------
-- GET ALL ALERT TYPES
-----------------------------------------------------------
function EAS.GetAllAlertTypes()
    local types = {}
    for key, data in pairs(Config.AlertTypes) do
        table.insert(types, {
            key = key,
            name = data.name,
            priority = data.priority,
            icon = data.icon
        })
    end
    return types
end

-----------------------------------------------------------
-- GET PRESET
-----------------------------------------------------------
function EAS.GetPreset(presetName)
    if Config.Presets[presetName] then
        return Config.Presets[presetName]
    end
    return nil
end

-----------------------------------------------------------
-- FORMAT TIMESTAMP
-----------------------------------------------------------
function EAS.FormatTimestamp()
    -- Use server-side os.date if available, otherwise use game time
    if IsDuplicityVersion() then
        -- Server-side: os is available
        return os.date('%H:%M:%S')
    else
        -- Client-side: use game time
        local hour = GetClockHours()
        local minute = GetClockMinutes()
        local second = GetClockSeconds()
        return string.format('%02d:%02d:%02d', hour, minute, second)
    end
end

-----------------------------------------------------------
-- FORMAT DATE
-----------------------------------------------------------
function EAS.FormatDate()
    -- Use server-side os.date if available, otherwise return current date estimate
    if IsDuplicityVersion() then
        -- Server-side: os is available
        return os.date('%Y-%m-%d')
    else
        -- Client-side: use game date
        local year = GetClockYear()
        local month = GetClockMonth() + 1 -- Game months are 0-indexed
        local day = GetClockDayOfMonth()
        return string.format('%04d-%02d-%02d', year, month, day)
    end
end

-----------------------------------------------------------
-- CHECK IF DEPARTMENT CAN USE ALERT TYPE
-----------------------------------------------------------
function EAS.CanDepartmentUseAlertType(departmentKey, alertType)
    local department = EAS.GetDepartment(departmentKey)
    if not department then
        return false
    end
    
    -- 'all' means department can use any alert type
    if department.allowedAlertTypes == 'all' then
        return true
    end
    
    -- Check if alert type is in allowed list
    for _, allowed in ipairs(department.allowedAlertTypes) do
        if allowed == alertType then
            return true
        end
    end
    
    return false
end

-----------------------------------------------------------
-- STRING UTILITIES
-----------------------------------------------------------
function EAS.Trim(s)
    return s:match'^()%s*$' and '' or s:match'^%s*(.*%S)'
end

function EAS.Split(str, sep)
    local result = {}
    for match in (str .. sep):gmatch('(.-)' .. sep) do
        table.insert(result, match)
    end
    return result
end

-----------------------------------------------------------
-- TABLE UTILITIES
-----------------------------------------------------------
function EAS.TableContains(tbl, value)
    for _, v in pairs(tbl) do
        if v == value then
            return true
        end
    end
    return false
end

function EAS.TableLength(tbl)
    local count = 0
    for _ in pairs(tbl) do
        count = count + 1
    end
    return count
end

-----------------------------------------------------------
-- DEEP COPY TABLE
-----------------------------------------------------------
function EAS.DeepCopy(orig)
    local orig_type = type(orig)
    local copy
    if orig_type == 'table' then
        copy = {}
        for orig_key, orig_value in next, orig, nil do
            copy[EAS.DeepCopy(orig_key)] = EAS.DeepCopy(orig_value)
        end
        setmetatable(copy, EAS.DeepCopy(getmetatable(orig)))
    else
        copy = orig
    end
    return copy
end

-----------------------------------------------------------
-- MERGE TABLES
-----------------------------------------------------------
function EAS.MergeTables(t1, t2)
    for k, v in pairs(t2) do
        if type(v) == 'table' and type(t1[k]) == 'table' then
            EAS.MergeTables(t1[k], v)
        else
            t1[k] = v
        end
    end
    return t1
end

-----------------------------------------------------------
-- SANITIZE STRING (prevent XSS in NUI)
-----------------------------------------------------------
function EAS.SanitizeString(str)
    if type(str) ~= 'string' then
        return ''
    end
    
    str = str:gsub('&', '&amp;')
    str = str:gsub('<', '&lt;')
    str = str:gsub('>', '&gt;')
    str = str:gsub('"', '&quot;')
    str = str:gsub("'", '&#39;')
    
    return str
end
