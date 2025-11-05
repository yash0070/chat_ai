import 'package:speech_to_text/speech_to_text.dart' as stt;
import 'package:permission_handler/permission_handler.dart';

/// Service for handling speech-to-text functionality
class SpeechToTextService {
  final stt.SpeechToText _speech;
  bool _isInitialized = false;

  SpeechToTextService({stt.SpeechToText? speech})
      : _speech = speech ?? stt.SpeechToText();

  /// Initialize the speech recognition service
  Future<bool> initialize() async {
    if (_isInitialized) return true;

    // Request microphone permission
    final status = await Permission.microphone.request();
    if (!status.isGranted) {
      return false;
    }

    _isInitialized = await _speech.initialize(
      onError: (error) => print('Speech recognition error: $error'),
      onStatus: (status) => print('Speech recognition status: $status'),
    );

    return _isInitialized;
  }

  /// Start listening for speech
  Future<void> startListening({
    required Function(String) onResult,
  }) async {
    if (!_isInitialized) {
      await initialize();
    }

    if (_isInitialized && !_speech.isListening) {
      await _speech.listen(
        onResult: (result) {
          onResult(result.recognizedWords);
        },
        listenFor: const Duration(seconds: 30),
        pauseFor: const Duration(seconds: 3),
        listenOptions: stt.SpeechListenOptions(
          partialResults: true,
          cancelOnError: true,
          listenMode: stt.ListenMode.confirmation,
        ),
      );
    }
  }

  /// Stop listening
  Future<void> stopListening() async {
    if (_speech.isListening) {
      await _speech.stop();
    }
  }

  /// Check if currently listening
  bool get isListening => _speech.isListening;

  /// Check if available
  bool get isAvailable => _isInitialized;
}
