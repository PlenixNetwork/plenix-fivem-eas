/**
 * Plenix FiveM EAS- Audio Handler
 * Manages alert sounds and audio playback
 */

// Debug mode (will be set from config)
let audioDebugMode = false;

// Debug logging function
function audioDebug(...args) {
    if (audioDebugMode) {
        console.log('[EAS Audio]', ...args);
    }
}

// Audio state
const audioState = {
    currentAudio: null,
    volume: 0.5,
    fadeOutInterval: null,
    loopTimeout: null,
    alertDuration: 0,
    alertStartTime: 0,
    isLooping: false,
    audioContext: null,
    isInitialized: false
};

// Audio files mapping
const audioFiles = {
    'eas_default': 'audio-default',
    'eas_nuclear': 'audio-nuclear',
    'eas_tornado': 'audio-tornado',
    'eas_amber': 'audio-amber',
    'eas_earthquake': 'audio-earthquake',
    'eas_tsunami': 'audio-tsunami',
    'eas_fire': 'audio-fire',
    'eas_police': 'audio-police',
    'eas_military': 'audio-military',
    'eas_weather': 'audio-weather'
};

/**
 * Initialize audio context (helps with autoplay restrictions)
 */
function initAudioContext() {
    if (audioState.isInitialized) return;
    
    try {
        // Create AudioContext to unlock audio playback
        audioState.audioContext = new (window.AudioContext || window.webkitAudioContext)();
        
        // Resume context if suspended
        if (audioState.audioContext.state === 'suspended') {
            audioState.audioContext.resume();
        }
        
        audioState.isInitialized = true;
        audioDebug('AudioContext initialized');
    } catch (e) {
        audioDebug('AudioContext not available, using fallback');
    }
}

/**
 * Unlock audio playback (call on any user interaction)
 */
function unlockAudio() {
    initAudioContext();
    
    // Play and immediately pause all audio elements to unlock them
    for (const audioId of Object.values(audioFiles)) {
        const audio = document.getElementById(audioId);
        if (audio) {
            audio.muted = true;
            const playPromise = audio.play();
            if (playPromise) {
                playPromise.then(() => {
                    audio.pause();
                    audio.currentTime = 0;
                    audio.muted = false;
                }).catch(() => {
                    audio.muted = false;
                });
            }
        }
    }
}

/**
 * Play alert sound with looping support
 * @param {string} soundName - Name of the sound to play
 * @param {number} volume - Volume level (0.0 - 1.0)
 * @param {number} duration - Alert duration in ms (for looping/stopping)
 */
function playAlertSound(soundName, volume = 0.5, duration = 25000) {
    // Ensure volume is a valid number, default to 0.5 if not
    if (typeof volume !== 'number' || isNaN(volume)) {
        volume = 0.5;
    }
    
    audioDebug('playAlertSound called - sound:', soundName, 'volume:', volume, 'duration:', duration);
    
    // Initialize audio context
    initAudioContext();
    
    // Stop any currently playing audio
    stopAllSounds();
    
    // Get audio element ID - try requested sound first, fallback to default
    let audioId = audioFiles[soundName];
    let audio = audioId ? document.getElementById(audioId) : null;
    
    audioDebug('Attempting to play sound:', soundName, 'audioId:', audioId, 'element:', audio);
    
    // Check if the audio file can be played, otherwise fallback to default
    // audio.error is a MediaError object or null - check if it exists and has a code
    if (!audio || (audio.error && audio.error.code)) {
        audioDebug('Audio not available or has error, falling back to default:', soundName, audio ? audio.error : 'no element');
        audioId = audioFiles['eas_default'];
        audio = document.getElementById(audioId);
    }
    
    if (!audio) {
        audioDebug('No audio element found');
        return;
    }
    
    // Force load the audio if not ready
    if (audio.readyState < 2) {
        audioDebug('Audio not fully loaded, loading now:', soundName);
        audio.load();
    }
    
    // Set volume
    audioState.volume = Math.max(0, Math.min(1, volume));
    audio.volume = audioState.volume;
    
    // Store duration info for looping
    audioState.alertDuration = duration;
    audioState.alertStartTime = Date.now();
    audioState.isLooping = true;
    
    // Reset audio
    audio.currentTime = 0;
    
    // Handle audio ended event for looping
    audio.onended = function() {
        if (audioState.isLooping) {
            const elapsed = Date.now() - audioState.alertStartTime;
            const remaining = audioState.alertDuration - elapsed;
            
            if (remaining > 500) {
                audio.currentTime = 0;
                audio.play().catch(() => {});
            } else {
                audioState.isLooping = false;
            }
        }
    };
    
    // Try to play with multiple fallback attempts
    tryPlayAudio(audio, soundName, duration);
}

/**
 * Try to play audio with fallback attempts
 */
function tryPlayAudio(audio, soundName, duration, retryCount = 0) {
    const maxRetries = 3;
    
    // Add a canplaythrough event listener for when audio is ready
    const onCanPlay = function() {
        audio.removeEventListener('canplaythrough', onCanPlay);
        audioDebug('Audio can play through, starting playback:', soundName);
        attemptPlay();
    };
    
    const attemptPlay = function() {
        const playPromise = audio.play();
        
        if (playPromise !== undefined) {
            playPromise
                .then(() => {
                    audioState.currentAudio = audio;
                    audioDebug('Playing audio successfully:', soundName);
                    
                    // Set timeout to stop audio when alert ends
                    if (audioState.loopTimeout) {
                        clearTimeout(audioState.loopTimeout);
                    }
                    audioState.loopTimeout = setTimeout(() => {
                        fadeOutAudio(500);
                    }, duration - 500);
                })
                .catch(error => {
                    audioDebug('Audio play failed:', soundName, error.message, 'retry:', retryCount);
                    
                    if (retryCount < maxRetries) {
                        // Try again after a short delay
                        setTimeout(() => {
                            tryPlayAudio(audio, soundName, duration, retryCount + 1);
                        }, 200 * (retryCount + 1));
                    } else {
                        // Fall back to default audio after max retries
                        audioDebug('Max retries reached, falling back to default audio');
                        const defaultAudio = document.getElementById(audioFiles['eas_default']);
                        if (defaultAudio && defaultAudio !== audio) {
                            defaultAudio.volume = audioState.volume;
                            defaultAudio.currentTime = 0;
                            defaultAudio.play().catch(() => {});
                            audioState.currentAudio = defaultAudio;
                        }
                    }
                });
        }
    };
    
    // If audio is already ready, play immediately
    if (audio.readyState >= 3) {
        attemptPlay();
    } else {
        // Wait for audio to be ready
        audio.addEventListener('canplaythrough', onCanPlay);
        audio.load();
        
        // Timeout fallback in case canplaythrough never fires
        setTimeout(() => {
            audio.removeEventListener('canplaythrough', onCanPlay);
            if (!audioState.currentAudio) {
                audioDebug('Audio load timeout, attempting play anyway:', soundName);
                attemptPlay();
            }
        }, 1000);
    }
}

/**
 * Stop all sounds
 */
function stopAllSounds() {
    // Clear loop timeout
    if (audioState.loopTimeout) {
        clearTimeout(audioState.loopTimeout);
        audioState.loopTimeout = null;
    }
    
    // Clear fade out interval
    if (audioState.fadeOutInterval) {
        clearInterval(audioState.fadeOutInterval);
        audioState.fadeOutInterval = null;
    }
    
    // Stop looping
    audioState.isLooping = false;
    
    // Stop current audio
    if (audioState.currentAudio) {
        audioState.currentAudio.onended = null;
        audioState.currentAudio.pause();
        audioState.currentAudio.currentTime = 0;
        audioState.currentAudio = null;
    }
    
    // Stop all audio elements
    for (const audioId of Object.values(audioFiles)) {
        const audio = document.getElementById(audioId);
        if (audio) {
            audio.onended = null;
            audio.pause();
            audio.currentTime = 0;
        }
    }
}

/**
 * Fade out current audio
 * @param {number} duration - Fade duration in ms
 */
function fadeOutAudio(duration = 1000) {
    if (!audioState.currentAudio) return;
    
    const audio = audioState.currentAudio;
    const steps = 20;
    const stepDuration = duration / steps;
    const volumeStep = audio.volume / steps;
    
    audioState.fadeOutInterval = setInterval(() => {
        if (audio.volume > volumeStep) {
            audio.volume -= volumeStep;
        } else {
            audio.volume = 0;
            audio.pause();
            audio.currentTime = 0;
            audio.volume = audioState.volume; // Reset volume
            clearInterval(audioState.fadeOutInterval);
            audioState.fadeOutInterval = null;
            audioState.currentAudio = null;
        }
    }, stepDuration);
}

/**
 * Set global volume
 * @param {number} volume - Volume level (0.0 - 1.0)
 */
function setVolume(volume) {
    audioState.volume = Math.max(0, Math.min(1, volume));
    
    if (audioState.currentAudio) {
        audioState.currentAudio.volume = audioState.volume;
    }
}

/**
 * Get current volume
 * @returns {number} Current volume level
 */
function getVolume() {
    return audioState.volume;
}

/**
 * Mute/unmute audio
 * @param {boolean} muted - Whether to mute
 */
function setMuted(muted) {
    if (audioState.currentAudio) {
        audioState.currentAudio.muted = muted;
    }
}

/**
 * Preload all audio files
 */
function preloadAudio() {
    audioDebug('Starting audio preload for', Object.keys(audioFiles).length, 'files');
    
    for (const [soundName, audioId] of Object.entries(audioFiles)) {
        const audio = document.getElementById(audioId);
        if (audio) {
            // Add error handler with detailed logging
            audio.onerror = function(e) {
                const errorCode = audio.error ? audio.error.code : 'unknown';
                const errorMessage = audio.error ? audio.error.message : 'unknown error';
                audioDebug('Failed to load audio:', soundName, audioId, 'code:', errorCode, 'message:', errorMessage, 'src:', audio.src);
            };
            
            // Add loaded handler
            audio.oncanplaythrough = function() {
                audioDebug('Audio loaded successfully:', soundName, 'duration:', audio.duration);
            };
            
            // Add loadeddata handler as backup
            audio.onloadeddata = function() {
                audioDebug('Audio data loaded:', soundName);
            };
            
            // Force load
            audio.load();
        } else {
            audioDebug('Audio element not found for:', soundName, audioId);
        }
    }
}

// Initialize on document ready
$(document).ready(function() {
    audioDebug('Initializing audio system...');
    
    preloadAudio();
    initAudioContext();
    
    // Unlock audio on any click/interaction
    $(document).one('click keydown', function() {
        unlockAudio();
    });
    
    // Also try to unlock audio immediately in FiveM NUI context
    setTimeout(function() {
        unlockAudio();
    }, 500);
});
