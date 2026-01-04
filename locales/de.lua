--[[
    Plenix FiveM EAS - German Locale (Deutsch)
]]

Locales['de'] = {
    -- General
    ['system_name'] = 'NOTFALL-WARNSYSTEM',
    ['alert_issued_by'] = 'Warnung ausgegeben von:',
    ['timestamp'] = 'Zeit:',
    ['close'] = 'Schließen',
    ['confirm'] = 'Bestätigen',
    ['cancel'] = 'Abbrechen',
    ['send'] = 'Senden',
    ['type'] = 'Typ',
    ['message'] = 'Nachricht',
    
    -- Alert Types
    ['alert_type_default'] = 'Notfallwarnung',
    ['alert_type_nuclear'] = 'Nuklearwarnung',
    ['alert_type_tornado'] = 'Tornado-Warnung',
    ['alert_type_amber'] = 'AMBER-Warnung',
    ['alert_type_earthquake'] = 'Erdbeben-Warnung',
    ['alert_type_tsunami'] = 'Tsunami-Warnung',
    ['alert_type_fire'] = 'Brandnotfall',
    ['alert_type_police'] = 'Polizeiwarnung',
    ['alert_type_military'] = 'Militärwarnung',
    ['alert_type_weather'] = 'Unwetterwarnung',
    
    -- Priority Levels
    ['priority_low'] = 'Niedrige Priorität',
    ['priority_medium'] = 'Mittlere Priorität',
    ['priority_high'] = 'Hohe Priorität',
    ['priority_critical'] = 'KRITISCH',
    
    -- Commands
    ['cmd_help_title'] = 'EAS Befehlshilfe',
    ['cmd_help_alert'] = '/alert - Warnungsmenü öffnen',
    ['cmd_help_qalert'] = '/qalert [typ] [nachricht] - Schnellwarnung',
    ['cmd_help_alerttest'] = '/alerttest [typ] - Warnung testen (Admin)',
    ['cmd_help_list'] = '/alert list - Warnungstypen auflisten',
    
    -- Notifications
    ['notify_no_permission'] = 'Du hast keine Berechtigung, diesen Befehl zu verwenden.',
    ['notify_cooldown'] = 'Bitte warte %s Sekunden, bevor du eine weitere Warnung sendest.',
    ['notify_alert_sent'] = 'Warnung wurde an alle Spieler gesendet.',
    ['notify_alert_stopped'] = 'Die aktuelle Warnung wurde gestoppt.',
    ['notify_no_active_alert'] = 'Es gibt keine aktive Warnung zum Stoppen.',
    ['notify_invalid_type'] = 'Ungültiger Warnungstyp. Verwende /alert list um verfügbare Typen zu sehen.',
    ['notify_message_required'] = 'Bitte gib eine Nachricht für die Warnung ein.',
    ['notify_type_not_allowed'] = 'Deine Abteilung kann diese Art von Warnung nicht senden.',
    
    -- Menu
    ['menu_title'] = 'Notfall-Warnsystem',
    ['menu_select_type'] = 'Warnungstyp Auswählen',
    ['menu_enter_message'] = 'Warnungsnachricht Eingeben',
    ['menu_preview'] = 'Vorschau',
    ['menu_send_alert'] = 'Warnung Senden',
    ['menu_presets'] = 'Schnellvorlagen',
    
    -- Presets
    ['preset_lockdown'] = 'Stadt-Abriegelung',
    ['preset_evacuation'] = 'Evakuierungsbefehl',
    ['preset_allclear'] = 'Entwarnung',
    ['preset_pursuit'] = 'Aktive Verfolgung',
    ['preset_wanted'] = 'Gesuchte Person',
    
    -- Departments
    ['dept_police'] = 'Polizeiabteilung',
    ['dept_ambulance'] = 'Rettungsdienst',
    ['dept_sheriff'] = 'Sheriff-Büro',
    ['dept_fib'] = 'Bundesermittlungsbüro',
    ['dept_doj'] = 'Justizministerium',
    ['dept_governor'] = 'Landesregierung',
    ['dept_admin'] = 'Server-Administration',
    
    -- Alert Messages
    ['alert_attention'] = 'ACHTUNG',
    ['alert_this_is'] = 'Dies ist eine',
    ['alert_broadcast'] = 'Durchsage',
    ['alert_stay_calm'] = 'Bitte bleiben Sie ruhig und folgen Sie den Anweisungen.',
    ['alert_more_info'] = 'Weitere Informationen folgen.',
    
    -- Errors
    ['error_generic'] = 'Ein Fehler ist aufgetreten. Bitte versuche es erneut.',
    ['error_no_framework'] = 'Framework nicht erkannt.',
    ['error_invalid_data'] = 'Ungültige Warnungsdaten empfangen.',
}
