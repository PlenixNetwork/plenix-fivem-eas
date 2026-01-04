/**
 * Plenix FiveM EAS - Animation Handler
 * Manages UI animations and effects
 */

// Animation configuration
const animationConfig = {
    alertEnterDuration: 400,
    alertExitDuration: 300,
    menuEnterDuration: 300,
    menuExitDuration: 200
};

/**
 * Apply animation to element
 * @param {jQuery} element - Element to animate
 * @param {string} animationName - Animation class name
 * @param {number} duration - Animation duration in ms
 * @returns {Promise} Resolves when animation completes
 */
function applyAnimation(element, animationName, duration) {
    return new Promise(resolve => {
        element.addClass(animationName);
        
        setTimeout(() => {
            element.removeClass(animationName);
            resolve();
        }, duration);
    });
}

/**
 * Animate alert entrance
 * @param {string} position - Position (top, center, bottom)
 */
function animateAlertEnter(position = 'top') {
    const container = $('#alert-container');
    const animClass = 'alert-enter-' + position;
    
    container.addClass(animClass);
    
    setTimeout(() => {
        container.removeClass(animClass);
    }, animationConfig.alertEnterDuration);
}

/**
 * Animate alert exit
 */
function animateAlertExit() {
    const box = $('#alert-box');
    
    return new Promise(resolve => {
        box.addClass('alert-exit');
        
        setTimeout(() => {
            box.removeClass('alert-exit');
            resolve();
        }, animationConfig.alertExitDuration);
    });
}

/**
 * Trigger shake effect
 * @param {jQuery} element - Element to shake
 * @param {number} intensity - Shake intensity (1-10)
 */
function triggerShake(element, intensity = 5) {
    const keyframes = [
        { transform: 'translateX(0)' },
        { transform: `translateX(-${intensity}px)` },
        { transform: `translateX(${intensity}px)` },
        { transform: `translateX(-${intensity}px)` },
        { transform: `translateX(${intensity}px)` },
        { transform: 'translateX(0)' }
    ];
    
    element[0].animate(keyframes, {
        duration: 500,
        easing: 'ease-in-out'
    });
}

/**
 * Trigger pulse effect
 * @param {jQuery} element - Element to pulse
 * @param {string} color - Glow color
 */
function triggerPulse(element, color = '#ff0000') {
    const keyframes = [
        { boxShadow: `0 0 10px ${color}` },
        { boxShadow: `0 0 30px ${color}, 0 0 60px ${color}` },
        { boxShadow: `0 0 10px ${color}` }
    ];
    
    element[0].animate(keyframes, {
        duration: 1000,
        easing: 'ease-in-out'
    });
}

/**
 * Trigger flash effect
 * @param {jQuery} element - Element to flash
 */
function triggerFlash(element) {
    const originalOpacity = element.css('opacity');
    
    const keyframes = [
        { opacity: 1 },
        { opacity: 0.5 },
        { opacity: 1 },
        { opacity: 0.5 },
        { opacity: 1 }
    ];
    
    element[0].animate(keyframes, {
        duration: 500,
        easing: 'steps(5)'
    });
}

/**
 * Create particle effect
 * @param {jQuery} container - Container element
 * @param {Object} options - Particle options
 */
function createParticles(container, options = {}) {
    const defaults = {
        count: 20,
        color: '#ff0000',
        size: 5,
        duration: 2000
    };
    
    const config = { ...defaults, ...options };
    
    for (let i = 0; i < config.count; i++) {
        const particle = $('<div>')
            .addClass('particle')
            .css({
                position: 'absolute',
                width: config.size + 'px',
                height: config.size + 'px',
                background: config.color,
                borderRadius: '50%',
                left: Math.random() * 100 + '%',
                top: Math.random() * 100 + '%',
                opacity: 1
            });
        
        container.append(particle);
        
        // Animate particle
        particle[0].animate([
            { transform: 'scale(1)', opacity: 1 },
            { transform: 'scale(0)', opacity: 0 }
        ], {
            duration: config.duration,
            easing: 'ease-out'
        }).onfinish = () => particle.remove();
    }
}

/**
 * Start continuous animation
 * @param {jQuery} element - Element to animate
 * @param {string} type - Animation type
 */
function startContinuousAnimation(element, type) {
    element.addClass('animation-' + type);
}

/**
 * Stop continuous animation
 * @param {jQuery} element - Element
 * @param {string} type - Animation type
 */
function stopContinuousAnimation(element, type) {
    element.removeClass('animation-' + type);
}

/**
 * Animate text reveal
 * @param {jQuery} element - Text element
 * @param {string} text - Text to reveal
 * @param {number} speed - Reveal speed (ms per character)
 */
function animateTextReveal(element, text, speed = 50) {
    element.text('');
    let index = 0;
    
    const interval = setInterval(() => {
        if (index < text.length) {
            element.text(element.text() + text[index]);
            index++;
        } else {
            clearInterval(interval);
        }
    }, speed);
    
    return interval;
}

/**
 * Animate counter
 * @param {jQuery} element - Counter element
 * @param {number} start - Start value
 * @param {number} end - End value
 * @param {number} duration - Duration in ms
 */
function animateCounter(element, start, end, duration) {
    const range = end - start;
    const startTime = performance.now();
    
    function update() {
        const elapsed = performance.now() - startTime;
        const progress = Math.min(elapsed / duration, 1);
        const value = Math.round(start + (range * progress));
        
        element.text(value);
        
        if (progress < 1) {
            requestAnimationFrame(update);
        }
    }
    
    requestAnimationFrame(update);
}

/**
 * Apply glitch effect
 * @param {jQuery} element - Element
 * @param {number} duration - Duration in ms
 */
function applyGlitchEffect(element, duration = 500) {
    element.addClass('glitch-effect');
    
    setTimeout(() => {
        element.removeClass('glitch-effect');
    }, duration);
}

/**
 * Apply scanline effect
 * @param {jQuery} element - Element
 * @param {boolean} enable - Enable/disable
 */
function applyScanlineEffect(element, enable = true) {
    if (enable) {
        element.addClass('scanline-effect');
    } else {
        element.removeClass('scanline-effect');
    }
}
