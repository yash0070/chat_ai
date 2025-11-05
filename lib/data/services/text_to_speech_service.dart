import 'package:flutter_tts/flutter_tts.dart';

/// Service for handling text-to-speech functionality
class TextToSpeechService {
  final FlutterTts _tts;
  bool _isInitialized = false;

  TextToSpeechService({FlutterTts? tts}) : _tts = tts ?? FlutterTts();

  /// Initialize the TTS service
  Future<void> initialize() async {
    if (_isInitialized) return;

    await _tts.setLanguage('en-US');
    await _tts.setSpeechRate(0.5);
    await _tts.setVolume(1.0);
    await _tts.setPitch(1.0);

    _isInitialized = true;
  }

  /// Speak the given text
  Future<void> speak(String text) async {
    if (!_isInitialized) {
      await initialize();
    }

    if (text.isNotEmpty) {
      await _tts.speak(text);
    }
  }

  /// Stop speaking
  Future<void> stop() async {
    await _tts.stop();
  }

  /// Check if currently speaking
  Future<bool> isSpeaking() async {
    return await _tts.isLanguageAvailable('en-US');
  }
}

