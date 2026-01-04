--[[
    Plenix FiveM EAS - Spanish Locale (Español)
]]

Locales['es'] = {
    -- General
    ['system_name'] = 'SISTEMA DE ALERTA DE EMERGENCIA',
    ['alert_issued_by'] = 'Alerta emitida por:',
    ['timestamp'] = 'Hora:',
    ['close'] = 'Cerrar',
    ['confirm'] = 'Confirmar',
    ['cancel'] = 'Cancelar',
    ['send'] = 'Enviar',
    ['type'] = 'Tipo',
    ['message'] = 'Mensaje',
    
    -- Alert Types
    ['alert_type_default'] = 'Alerta de Emergencia',
    ['alert_type_nuclear'] = 'Alerta Nuclear',
    ['alert_type_tornado'] = 'Alerta de Tornado',
    ['alert_type_amber'] = 'Alerta AMBER',
    ['alert_type_earthquake'] = 'Alerta de Terremoto',
    ['alert_type_tsunami'] = 'Alerta de Tsunami',
    ['alert_type_fire'] = 'Emergencia de Incendio',
    ['alert_type_police'] = 'Alerta Policial',
    ['alert_type_military'] = 'Alerta Militar',
    ['alert_type_weather'] = 'Alerta Meteorológica Severa',
    
    -- Priority Levels
    ['priority_low'] = 'Prioridad Baja',
    ['priority_medium'] = 'Prioridad Media',
    ['priority_high'] = 'Prioridad Alta',
    ['priority_critical'] = 'CRÍTICO',
    
    -- Commands
    ['cmd_help_title'] = 'Ayuda de Comandos EAS',
    ['cmd_help_alert'] = '/alert - Abrir menú de alertas',
    ['cmd_help_qalert'] = '/qalert [tipo] [mensaje] - Alerta rápida',
    ['cmd_help_alerttest'] = '/alerttest [tipo] - Probar alerta (admin)',
    ['cmd_help_list'] = '/alert list - Listar tipos de alerta',
    
    -- Notifications
    ['notify_no_permission'] = 'No tienes permiso para usar este comando.',
    ['notify_cooldown'] = 'Por favor espera %s segundos antes de enviar otra alerta.',
    ['notify_alert_sent'] = 'La alerta ha sido enviada a todos los jugadores.',
    ['notify_alert_stopped'] = 'La alerta actual ha sido detenida.',
    ['notify_no_active_alert'] = 'No hay ninguna alerta activa para detener.',
    ['notify_invalid_type'] = 'Tipo de alerta inválido. Usa /alert list para ver los tipos disponibles.',
    ['notify_message_required'] = 'Por favor ingresa un mensaje para la alerta.',
    ['notify_type_not_allowed'] = 'Tu departamento no puede enviar este tipo de alerta.',
    
    -- Menu
    ['menu_title'] = 'Sistema de Alerta de Emergencia',
    ['menu_select_type'] = 'Seleccionar Tipo de Alerta',
    ['menu_enter_message'] = 'Ingresar Mensaje de Alerta',
    ['menu_preview'] = 'Vista Previa',
    ['menu_send_alert'] = 'Enviar Alerta',
    ['menu_presets'] = 'Preajustes Rápidos',
    
    -- Presets
    ['preset_lockdown'] = 'Cierre de Ciudad',
    ['preset_evacuation'] = 'Orden de Evacuación',
    ['preset_allclear'] = 'Todo Despejado',
    ['preset_pursuit'] = 'Persecución Activa',
    ['preset_wanted'] = 'Individuo Buscado',
    
    -- Departments
    ['dept_police'] = 'Departamento de Policía',
    ['dept_ambulance'] = 'Servicios Médicos de Emergencia',
    ['dept_sheriff'] = 'Oficina del Sheriff',
    ['dept_fib'] = 'Oficina Federal de Investigación',
    ['dept_doj'] = 'Departamento de Justicia',
    ['dept_governor'] = 'Gobierno Estatal',
    ['dept_admin'] = 'Administración del Servidor',
    
    -- Alert Messages
    ['alert_attention'] = 'ATENCIÓN',
    ['alert_this_is'] = 'Esta es una',
    ['alert_broadcast'] = 'Transmisión',
    ['alert_stay_calm'] = 'Por favor mantenga la calma y siga las instrucciones.',
    ['alert_more_info'] = 'Más información a continuación.',
    
    -- Errors
    ['error_generic'] = 'Ocurrió un error. Por favor intenta de nuevo.',
    ['error_no_framework'] = 'Framework no detectado.',
    ['error_invalid_data'] = 'Datos de alerta inválidos recibidos.',
}
