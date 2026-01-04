--[[
    Plenix FiveM EAS - English Locale
]]

Locales['en'] = {
    -- General
    ['system_name'] = 'EMERGENCY ALERT SYSTEM',
    ['alert_issued_by'] = 'Alert issued by:',
    ['timestamp'] = 'Time:',
    ['close'] = 'Close',
    ['confirm'] = 'Confirm',
    ['cancel'] = 'Cancel',
    ['send'] = 'Send',
    ['type'] = 'Type',
    ['message'] = 'Message',
    
    -- Alert Types
    ['alert_type_default'] = 'Emergency Alert',
    ['alert_type_nuclear'] = 'Nuclear Alert',
    ['alert_type_tornado'] = 'Tornado Warning',
    ['alert_type_amber'] = 'AMBER Alert',
    ['alert_type_earthquake'] = 'Earthquake Warning',
    ['alert_type_tsunami'] = 'Tsunami Warning',
    ['alert_type_fire'] = 'Fire Emergency',
    ['alert_type_police'] = 'Police Alert',
    ['alert_type_military'] = 'Military Alert',
    ['alert_type_weather'] = 'Severe Weather Alert',
    
    -- Priority Levels
    ['priority_low'] = 'Low Priority',
    ['priority_medium'] = 'Medium Priority',
    ['priority_high'] = 'High Priority',
    ['priority_critical'] = 'CRITICAL',
    
    -- Commands
    ['cmd_help_title'] = 'EAS Command Help',
    ['cmd_help_alert'] = '/alert - Open alert menu',
    ['cmd_help_qalert'] = '/qalert [type] [message] - Quick alert',
    ['cmd_help_alerttest'] = '/alerttest [type] - Test alert (admin)',
    ['cmd_help_list'] = '/alert list - List available alert types',
    
    -- Notifications
    ['notify_no_permission'] = 'You do not have permission to use this command.',
    ['notify_cooldown'] = 'Please wait %s seconds before sending another alert.',
    ['notify_alert_sent'] = 'Alert has been sent to all players.',
    ['notify_alert_stopped'] = 'The current alert has been stopped.',
    ['notify_no_active_alert'] = 'There is no active alert to stop.',
    ['notify_invalid_type'] = 'Invalid alert type. Use /alert list to see available types.',
    ['notify_message_required'] = 'Please enter a message for the alert.',
    ['notify_type_not_allowed'] = 'Your department cannot send this type of alert.',
    
    -- Menu
    ['menu_title'] = 'Emergency Alert System',
    ['menu_select_type'] = 'Select Alert Type',
    ['menu_enter_message'] = 'Enter Alert Message',
    ['menu_preview'] = 'Preview',
    ['menu_send_alert'] = 'Send Alert',
    ['menu_presets'] = 'Quick Presets',
    
    -- Presets
    ['preset_lockdown'] = 'City Lockdown',
    ['preset_evacuation'] = 'Evacuation Order',
    ['preset_allclear'] = 'All Clear',
    ['preset_pursuit'] = 'Active Pursuit',
    ['preset_wanted'] = 'Wanted Individual',
    
    -- Departments
    ['dept_police'] = 'Police Department',
    ['dept_ambulance'] = 'Emergency Medical Services',
    ['dept_sheriff'] = "Sheriff's Department",
    ['dept_fib'] = 'Federal Investigation Bureau',
    ['dept_doj'] = 'Department of Justice',
    ['dept_governor'] = 'State Government',
    ['dept_admin'] = 'Server Administration',
    
    -- Alert Messages
    ['alert_attention'] = 'ATTENTION',
    ['alert_this_is'] = 'This is a',
    ['alert_broadcast'] = 'Broadcast',
    ['alert_stay_calm'] = 'Please remain calm and follow instructions.',
    ['alert_more_info'] = 'More information will follow.',
    
    -- Errors
    ['error_generic'] = 'An error occurred. Please try again.',
    ['error_no_framework'] = 'Framework not detected.',
    ['error_invalid_data'] = 'Invalid alert data received.',
}
