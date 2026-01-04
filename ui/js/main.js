/**
 * Plenix FiveM EAS - Main JavaScript
 * Core NUI functionality and event handling
 */

// Debug mode (will be set from config)
let debugMode = false;

// Debug logging function
function debug(...args) {
    if (debugMode) {
        console.log('[EAS]', ...args);
    }
}

// State management
let state = {
    menuOpen: false,
    alertActive: false,
    selectedAlertType: 'default',
    alertTypes: [],
    presets: {},
    locale: {},
    currentAlert: null,
    progressInterval: null
};

// DOM Elements
const elements = {
    alertContainer: null,
    alertBox: null,
    menuContainer: null,
    messageInput: null,
    alertTypeGrid: null,
    presetGrid: null
};

// Initialize on DOM ready
$(document).ready(function() {
    initializeElements();
    bindEvents();
    hideAll();
});

/**
 * Initialize DOM element references
 */
function initializeElements() {
    elements.alertContainer = $('#alert-container');
    elements.alertBox = $('#alert-box');
    elements.menuContainer = $('#menu-container');
    elements.messageInput = $('#alert-message-input');
    elements.alertTypeGrid = $('#alert-type-grid');
    elements.presetGrid = $('#preset-grid');
}

/**
 * Bind event listeners
 */
function bindEvents() {
    // Close buttons
    $('#menu-close-btn').on('click', closeMenu);
    $('#alert-close-btn').on('click', closeAlert);
    
    // Menu overlay click
    $('.menu-overlay').on('click', closeMenu);
    
    // Action buttons
    $('#preview-btn').on('click', previewAlert);
    $('#send-btn').on('click', sendAlert);
    
    // Character counter
    elements.messageInput.on('input', function() {
        $('#char-count').text($(this).val().length);
    });
    
    // NUI message listener
    window.addEventListener('message', handleNUIMessage);
    
    // Keyboard shortcuts
    $(document).on('keydown', function(e) {
        if (e.key === 'Escape') {
            if (state.menuOpen) {
                closeMenu();
            }
        }
    });
}

/**
 * Handle incoming NUI messages
 */
function handleNUIMessage(event) {
    const data = event.data;
    
    // Set debug mode if passed
    if (data.debug !== undefined) {
        debugMode = data.debug;
        if (typeof audioDebugMode !== 'undefined') {
            audioDebugMode = data.debug;
        }
    }
    
    switch (data.action) {
        case 'showAlert':
            showAlert(data.data, data.locale, false, data.uiConfig);
            break;
            
        case 'hideAlert':
            hideAlert();
            break;
            
        case 'previewAlert':
            showAlert(data.data, data.locale || state.locale, true, data.uiConfig);
            break;
            
        case 'openMenu':
            openMenu(data.locale, data.presets);
            break;
            
        case 'updateAlertTypes':
            updateAlertTypes(data.data);
            break;
            
        case 'keyboardResult':
            handleKeyboardResult(data.data);
            break;
            
        case 'escapePressed':
            if (state.menuOpen) {
                closeMenu();
            }
            break;
            
        case 'setDebugMode':
            debugMode = data.enabled;
            if (typeof audioDebugMode !== 'undefined') {
                audioDebugMode = data.enabled;
            }
            break;
    }
}

/**
 * Show emergency alert
 */
function showAlert(alertData, locale, isPreview = false, uiConfig = null) {
    if (locale) {
        state.locale = locale;
    }
    
    state.currentAlert = alertData;
    state.alertActive = true;
    
    // Apply theme
    const themeClass = 'theme-' + alertData.type;
    elements.alertBox.removeClass().addClass('alert-box').addClass(themeClass);
    
    // Apply UI config width and maxWidth
    if (uiConfig) {
        if (uiConfig.Width) {
            elements.alertBox.css('width', uiConfig.Width);
        }
        if (uiConfig.MaxWidth) {
            elements.alertBox.css('max-width', uiConfig.MaxWidth);
        }
        
        // Show/hide close button based on config
        const closeBtn = $('#alert-close-btn');
        if (uiConfig.ShowCloseButton) {
            closeBtn.removeClass('hidden');
        } else {
            closeBtn.addClass('hidden');
        }
    }
    
    // Apply animation class
    if (alertData.style && alertData.style.animation) {
        elements.alertContainer.addClass('animation-' + alertData.style.animation);
    }
    
    // Update content
    $('#alert-system-name').text(locale?.system_name || 'EMERGENCY ALERT SYSTEM');
    $('#alert-type-name').text(alertData.alertName);
    $('#alert-icon').removeClass().addClass('fas ' + (alertData.icon || 'fa-exclamation-triangle'));
    $('#alert-issuer-name').text(alertData.issuerDepartment || alertData.issuer);
    $('#alert-timestamp').text(alertData.timestamp);
    $('#alert-issued-by-label').text(locale?.alert_issued_by || 'Alert issued by:');
    
    // Set message
    const messageText = $('#alert-message-text');
    messageText.text(alertData.message);
    
    // Check if message is long enough to need marquee
    if (alertData.message.length < 80) {
        messageText.addClass('no-scroll');
    } else {
        messageText.removeClass('no-scroll');
    }
    
    // Update priority badge with translated text
    const priorityBadge = $('#alert-priority');
    priorityBadge.removeClass('priority-low priority-medium priority-high priority-critical');
    priorityBadge.addClass('priority-' + alertData.priority);
    
    // Get translated priority text from locale
    const priorityKey = 'priority_' + alertData.priority;
    const priorityText = locale?.[priorityKey] || alertData.priority.toUpperCase();
    priorityBadge.text(priorityText);
    
    // Apply custom styles
    if (alertData.style) {
        applyCustomStyles(alertData.style);
    }
    
    // Position
    elements.alertContainer.removeClass('position-top position-center position-bottom');
    elements.alertContainer.addClass('position-top');
    
    // Show alert
    elements.alertContainer.removeClass('hidden');
    
    // Play sound with duration for looping/stopping
    if (!isPreview || isPreview) {
        playAlertSound(alertData.audio, alertData.volume, alertData.duration || 25000);
    }
    
    // Start progress bar
    startProgressBar(alertData.duration);
}

/**
 * Apply custom styles from config
 */
function applyCustomStyles(style) {
    const root = document.documentElement;
    
    if (style.backgroundColor) {
        root.style.setProperty('--color-bg', style.backgroundColor);
    }
    if (style.borderColor) {
        root.style.setProperty('--color-border', style.borderColor);
    }
    if (style.textColor) {
        root.style.setProperty('--color-text', style.textColor);
    }
    if (style.headerColor) {
        root.style.setProperty('--color-header', style.headerColor);
    }
    if (style.accentColor) {
        root.style.setProperty('--color-accent', style.accentColor);
    }
    if (style.borderWidth) {
        root.style.setProperty('--border-width', style.borderWidth + 'px');
    }
}

/**
 * Start progress bar animation
 */
function startProgressBar(duration) {
    const progressBar = $('#alert-progress-bar');
    progressBar.css('width', '100%');
    
    const startTime = Date.now();
    
    if (state.progressInterval) {
        clearInterval(state.progressInterval);
    }
    
    state.progressInterval = setInterval(function() {
        const elapsed = Date.now() - startTime;
        const remaining = Math.max(0, 100 - (elapsed / duration * 100));
        progressBar.css('width', remaining + '%');
        
        if (remaining <= 0) {
            clearInterval(state.progressInterval);
        }
    }, 100);
}

/**
 * Hide alert
 */
function hideAlert() {
    elements.alertBox.addClass('alert-exit');
    
    setTimeout(function() {
        elements.alertContainer.addClass('hidden');
        elements.alertBox.removeClass('alert-exit');
        elements.alertContainer.removeClass().addClass('alert-container hidden');
        state.alertActive = false;
        state.currentAlert = null;
        
        // Stop sound
        stopAllSounds();
        
        // Clear progress interval
        if (state.progressInterval) {
            clearInterval(state.progressInterval);
        }
    }, 300);
}

/**
 * Close alert (triggered by user)
 */
function closeAlert() {
    hideAlert();
    
    $.post('https://plenix-fivem-eas/closeAlert', JSON.stringify({}));
}

/**
 * Open menu
 */
function openMenu(locale, presets) {
    // Unlock audio when menu opens (user interaction)
    if (typeof unlockAudio === 'function') {
        unlockAudio();
    }
    
    if (locale) {
        state.locale = locale;
        updateMenuLocale(locale);
    }
    
    if (presets) {
        state.presets = presets;
        populatePresets(presets);
    }
    
    state.menuOpen = true;
    elements.menuContainer.removeClass('hidden');
    
    // Reset form
    elements.messageInput.val('');
    $('#char-count').text('0');
    state.selectedAlertType = 'default';
    
    // Request alert types
    $.post('https://plenix-fivem-eas/getAlertTypes', JSON.stringify({}));
    $.post('https://plenix-fivem-eas/menuOpened', JSON.stringify({}));
}

/**
 * Update menu with locale strings
 */
function updateMenuLocale(locale) {
    $('#menu-title').text(locale.menu_title || 'Emergency Alert System');
    $('#menu-select-type-label').text(locale.menu_select_type || 'Select Alert Type');
    $('#menu-message-label').text(locale.menu_enter_message || 'Alert Message');
    $('#menu-presets-label').text(locale.menu_presets || 'Quick Presets');
    $('#preview-label').text(locale.menu_preview || 'Preview');
    $('#send-label').text(locale.menu_send_alert || 'Send Alert');
}

/**
 * Close menu
 */
function closeMenu() {
    state.menuOpen = false;
    elements.menuContainer.addClass('hidden');
    
    $.post('https://plenix-fivem-eas/closeMenu', JSON.stringify({}));
    $.post('https://plenix-fivem-eas/menuClosed', JSON.stringify({}));
}

/**
 * Update alert types in grid
 */
function updateAlertTypes(types) {
    state.alertTypes = types;
    elements.alertTypeGrid.empty();
    
    types.forEach(function(type) {
        const item = $('<div>')
            .addClass('alert-type-item')
            .attr('data-type', type.key)
            .html(`
                <i class="fas ${type.icon || 'fa-exclamation-triangle'}"></i>
                <span>${type.name}</span>
            `);
        
        if (type.key === state.selectedAlertType) {
            item.addClass('selected');
        }
        
        item.on('click', function() {
            selectAlertType(type.key);
        });
        
        elements.alertTypeGrid.append(item);
    });
}

/**
 * Select alert type
 */
function selectAlertType(type) {
    state.selectedAlertType = type;
    
    $('.alert-type-item').removeClass('selected');
    $(`.alert-type-item[data-type="${type}"]`).addClass('selected');
}

/**
 * Populate presets
 */
function populatePresets(presets) {
    elements.presetGrid.empty();
    
    for (const [key, preset] of Object.entries(presets)) {
        const item = $('<div>')
            .addClass('preset-item')
            .attr('data-preset', key)
            .html(`
                <i class="fas fa-bolt"></i>
                ${preset.title}
            `);
        
        item.on('click', function() {
            sendPreset(key);
        });
        
        elements.presetGrid.append(item);
    }
}

/**
 * Preview alert
 */
function previewAlert() {
    const message = elements.messageInput.val().trim() || 'This is a preview of the alert message.';
    
    $.post('https://plenix-fivem-eas/previewAlert', JSON.stringify({
        alertType: state.selectedAlertType,
        message: message
    }));
}

/**
 * Send alert
 */
function sendAlert() {
    const message = elements.messageInput.val().trim();
    
    if (!message) {
        // Show error - message required
        alert(state.locale.notify_message_required || 'Please enter a message.');
        return;
    }
    
    $.post('https://plenix-fivem-eas/sendAlert', JSON.stringify({
        alertType: state.selectedAlertType,
        message: message
    }), function(response) {
        if (response.success) {
            closeMenu();
        }
    });
}

/**
 * Send preset
 */
function sendPreset(presetName) {
    $.post('https://plenix-fivem-eas/sendPreset', JSON.stringify({
        presetName: presetName
    }), function(response) {
        if (response.success) {
            closeMenu();
        }
    });
}

/**
 * Handle keyboard result
 */
function handleKeyboardResult(data) {
    if (data.success && data.input) {
        elements.messageInput.val(data.input);
        $('#char-count').text(data.input.length);
    }
}

/**
 * Hide all UI elements
 */
function hideAll() {
    elements.alertContainer.addClass('hidden');
    elements.menuContainer.addClass('hidden');
}
