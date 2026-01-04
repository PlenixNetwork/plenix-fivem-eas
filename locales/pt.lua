--[[
    Plenix FiveM EAS - Portuguese Locale (Português)
]]

Locales['pt'] = {
    -- General
    ['system_name'] = 'SISTEMA DE ALERTA DE EMERGÊNCIA',
    ['alert_issued_by'] = 'Alerta emitido por:',
    ['timestamp'] = 'Hora:',
    ['close'] = 'Fechar',
    ['confirm'] = 'Confirmar',
    ['cancel'] = 'Cancelar',
    ['send'] = 'Enviar',
    ['type'] = 'Tipo',
    ['message'] = 'Mensagem',
    
    -- Alert Types
    ['alert_type_default'] = 'Alerta de Emergência',
    ['alert_type_nuclear'] = 'Alerta Nuclear',
    ['alert_type_tornado'] = 'Alerta de Tornado',
    ['alert_type_amber'] = 'Alerta AMBER',
    ['alert_type_earthquake'] = 'Alerta de Terremoto',
    ['alert_type_tsunami'] = 'Alerta de Tsunami',
    ['alert_type_fire'] = 'Emergência de Incêndio',
    ['alert_type_police'] = 'Alerta Policial',
    ['alert_type_military'] = 'Alerta Militar',
    ['alert_type_weather'] = 'Alerta de Clima Severo',
    
    -- Priority Levels
    ['priority_low'] = 'Prioridade Baixa',
    ['priority_medium'] = 'Prioridade Média',
    ['priority_high'] = 'Prioridade Alta',
    ['priority_critical'] = 'CRÍTICO',
    
    -- Commands
    ['cmd_help_title'] = 'Ajuda de Comandos EAS',
    ['cmd_help_alert'] = '/alert - Abrir menu de alertas',
    ['cmd_help_qalert'] = '/qalert [tipo] [mensagem] - Alerta rápido',
    ['cmd_help_alerttest'] = '/alerttest [tipo] - Testar alerta (admin)',
    ['cmd_help_list'] = '/alert list - Listar tipos de alerta',
    
    -- Notifications
    ['notify_no_permission'] = 'Você não tem permissão para usar este comando.',
    ['notify_cooldown'] = 'Por favor aguarde %s segundos antes de enviar outro alerta.',
    ['notify_alert_sent'] = 'O alerta foi enviado para todos os jogadores.',
    ['notify_alert_stopped'] = 'O alerta atual foi interrompido.',
    ['notify_no_active_alert'] = 'Não há nenhum alerta ativo para interromper.',
    ['notify_invalid_type'] = 'Tipo de alerta inválido. Use /alert list para ver os tipos disponíveis.',
    ['notify_message_required'] = 'Por favor insira uma mensagem para o alerta.',
    ['notify_type_not_allowed'] = 'Seu departamento não pode enviar este tipo de alerta.',
    
    -- Menu
    ['menu_title'] = 'Sistema de Alerta de Emergência',
    ['menu_select_type'] = 'Selecionar Tipo de Alerta',
    ['menu_enter_message'] = 'Inserir Mensagem de Alerta',
    ['menu_preview'] = 'Visualizar',
    ['menu_send_alert'] = 'Enviar Alerta',
    ['menu_presets'] = 'Predefinições Rápidas',
    
    -- Presets
    ['preset_lockdown'] = 'Bloqueio da Cidade',
    ['preset_evacuation'] = 'Ordem de Evacuação',
    ['preset_allclear'] = 'Tudo Liberado',
    ['preset_pursuit'] = 'Perseguição Ativa',
    ['preset_wanted'] = 'Indivíduo Procurado',
    
    -- Departments
    ['dept_police'] = 'Departamento de Polícia',
    ['dept_ambulance'] = 'Serviços Médicos de Emergência',
    ['dept_sheriff'] = 'Escritório do Xerife',
    ['dept_fib'] = 'Escritório Federal de Investigação',
    ['dept_doj'] = 'Departamento de Justiça',
    ['dept_governor'] = 'Governo Estadual',
    ['dept_admin'] = 'Administração do Servidor',
    
    -- Alert Messages
    ['alert_attention'] = 'ATENÇÃO',
    ['alert_this_is'] = 'Este é um',
    ['alert_broadcast'] = 'Transmissão',
    ['alert_stay_calm'] = 'Por favor mantenha a calma e siga as instruções.',
    ['alert_more_info'] = 'Mais informações a seguir.',
    
    -- Errors
    ['error_generic'] = 'Ocorreu um erro. Por favor tente novamente.',
    ['error_no_framework'] = 'Framework não detectado.',
    ['error_invalid_data'] = 'Dados de alerta inválidos recebidos.',
}
