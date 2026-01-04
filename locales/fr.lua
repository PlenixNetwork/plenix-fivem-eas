--[[
    Plenix FiveM EAS - French Locale (Français)
]]

Locales['fr'] = {
    -- General
    ['system_name'] = "SYSTÈME D'ALERTE D'URGENCE",
    ['alert_issued_by'] = 'Alerte émise par:',
    ['timestamp'] = 'Heure:',
    ['close'] = 'Fermer',
    ['confirm'] = 'Confirmer',
    ['cancel'] = 'Annuler',
    ['send'] = 'Envoyer',
    ['type'] = 'Type',
    ['message'] = 'Message',
    
    -- Alert Types
    ['alert_type_default'] = "Alerte d'Urgence",
    ['alert_type_nuclear'] = 'Alerte Nucléaire',
    ['alert_type_tornado'] = 'Alerte Tornade',
    ['alert_type_amber'] = 'Alerte AMBER',
    ['alert_type_earthquake'] = 'Alerte Séisme',
    ['alert_type_tsunami'] = 'Alerte Tsunami',
    ['alert_type_fire'] = "Urgence Incendie",
    ['alert_type_police'] = 'Alerte Police',
    ['alert_type_military'] = 'Alerte Militaire',
    ['alert_type_weather'] = 'Alerte Météo Sévère',
    
    -- Priority Levels
    ['priority_low'] = 'Priorité Basse',
    ['priority_medium'] = 'Priorité Moyenne',
    ['priority_high'] = 'Priorité Haute',
    ['priority_critical'] = 'CRITIQUE',
    
    -- Commands
    ['cmd_help_title'] = "Aide des Commandes EAS",
    ['cmd_help_alert'] = "/alert - Ouvrir le menu d'alertes",
    ['cmd_help_qalert'] = '/qalert [type] [message] - Alerte rapide',
    ['cmd_help_alerttest'] = '/alerttest [type] - Tester alerte (admin)',
    ['cmd_help_list'] = "/alert list - Lister les types d'alertes",
    
    -- Notifications
    ['notify_no_permission'] = "Vous n'avez pas la permission d'utiliser cette commande.",
    ['notify_cooldown'] = "Veuillez attendre %s secondes avant d'envoyer une autre alerte.",
    ['notify_alert_sent'] = "L'alerte a été envoyée à tous les joueurs.",
    ['notify_alert_stopped'] = "L'alerte actuelle a été arrêtée.",
    ['notify_no_active_alert'] = "Il n'y a pas d'alerte active à arrêter.",
    ['notify_invalid_type'] = "Type d'alerte invalide. Utilisez /alert list pour voir les types disponibles.",
    ['notify_message_required'] = "Veuillez entrer un message pour l'alerte.",
    ['notify_type_not_allowed'] = "Votre département ne peut pas envoyer ce type d'alerte.",
    
    -- Menu
    ['menu_title'] = "Système d'Alerte d'Urgence",
    ['menu_select_type'] = "Sélectionner le Type d'Alerte",
    ['menu_enter_message'] = "Entrer le Message d'Alerte",
    ['menu_preview'] = 'Aperçu',
    ['menu_send_alert'] = "Envoyer l'Alerte",
    ['menu_presets'] = 'Préréglages Rapides',
    
    -- Presets
    ['preset_lockdown'] = 'Confinement de la Ville',
    ['preset_evacuation'] = "Ordre d'Évacuation",
    ['preset_allclear'] = 'Fin de l\'Alerte',
    ['preset_pursuit'] = 'Poursuite en Cours',
    ['preset_wanted'] = 'Individu Recherché',
    
    -- Departments
    ['dept_police'] = 'Département de Police',
    ['dept_ambulance'] = "Services Médicaux d'Urgence",
    ['dept_sheriff'] = 'Bureau du Shérif',
    ['dept_fib'] = "Bureau Fédéral d'Investigation",
    ['dept_doj'] = 'Département de Justice',
    ['dept_governor'] = 'Gouvernement de l\'État',
    ['dept_admin'] = 'Administration du Serveur',
    
    -- Alert Messages
    ['alert_attention'] = 'ATTENTION',
    ['alert_this_is'] = "Ceci est une",
    ['alert_broadcast'] = 'Diffusion',
    ['alert_stay_calm'] = 'Veuillez rester calme et suivre les instructions.',
    ['alert_more_info'] = 'Plus d\'informations à suivre.',
    
    -- Errors
    ['error_generic'] = 'Une erreur s\'est produite. Veuillez réessayer.',
    ['error_no_framework'] = 'Framework non détecté.',
    ['error_invalid_data'] = "Données d'alerte invalides reçues.",
}
