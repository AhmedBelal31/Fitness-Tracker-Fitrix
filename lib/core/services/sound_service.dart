import 'package:flutter/foundation.dart';
import 'package:just_audio/just_audio.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SoundService {
  static SoundService? _instance;
  AudioPlayer? _audioPlayer;
  bool _soundEnabled = true;

  static const String _soundEnabledKey = 'sound_enabled';

  SoundService._();

  static SoundService get instance {
    _instance ??= SoundService._();
    return _instance!;
  }

  /// Initialize sound service and load settings
  Future<void> init() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      _soundEnabled = prefs.getBool(_soundEnabledKey) ?? true;
      debugPrint('🔊 SoundService initialized - Enabled: $_soundEnabled');
    } catch (e) {
      debugPrint('❌ Error initializing SoundService: $e');
    }
  }

  /// Check if sound is enabled
  bool get isSoundEnabled => _soundEnabled;

  /// Enable or disable sound
  Future<void> setSoundEnabled(bool enabled) async {
    try {
      _soundEnabled = enabled;
      final prefs = await SharedPreferences.getInstance();
      await prefs.setBool(_soundEnabledKey, enabled);

      // Stop any playing sound when disabled
      if (!enabled) {
        await stopSound();
      }

      debugPrint('🔊 Sound ${enabled ? "enabled" : "disabled"}');
    } catch (e) {
      debugPrint('❌ Error setting sound enabled: $e');
    }
  }

  /// Play a sound from assets
  Future<void> playSound(String assetPath, {double volume = 1.0}) async {
    if (!_soundEnabled) {
      debugPrint('🔇 Sound disabled - skipping: $assetPath');
      return;
    }

    try {
      // Create new player for this sound
      _audioPlayer = AudioPlayer();
      await _audioPlayer!.setAsset(assetPath);
      await _audioPlayer!.setVolume(volume);
      await _audioPlayer!.play();

      debugPrint('🔊 Playing sound: $assetPath');

      // Auto-dispose after playback
      _audioPlayer!.playerStateStream.listen((state) {
        if (state.processingState == ProcessingState.completed) {
          _audioPlayer?.dispose();
          _audioPlayer = null;
        }
      });
    } catch (e) {
      debugPrint('❌ Error playing sound: $e');
    }
  }

  /// Stop currently playing sound
  Future<void> stopSound() async {
    try {
      if (_audioPlayer != null) {
        await _audioPlayer!.stop();
        await _audioPlayer!.dispose();
        _audioPlayer = null;
        debugPrint('⏹️ Sound stopped');
      }
    } catch (e) {
      debugPrint('❌ Error stopping sound: $e');
    }
  }

  /// Dispose all resources
  Future<void> dispose() async {
    await stopSound();
  }
}
