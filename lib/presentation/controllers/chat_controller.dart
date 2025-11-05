import 'package:get/get.dart';
import '../../data/models/message.dart';
import '../../data/services/speech_to_text_service.dart';
import '../../data/services/text_to_speech_service.dart';
import '../../domain/usecases/send_message_usecase.dart';
import '../../domain/usecases/load_chat_history_usecase.dart';
import '../../domain/usecases/save_chat_history_usecase.dart';
import '../../domain/usecases/clear_chat_history_usecase.dart';

/// Controller for managing chat state and business logic
class ChatController extends GetxController {
  // Dependencies
  final SendMessageUseCase _sendMessageUseCase;
  final LoadChatHistoryUseCase _loadChatHistoryUseCase;
  final SaveChatHistoryUseCase _saveChatHistoryUseCase;
  final ClearChatHistoryUseCase _clearChatHistoryUseCase;
  final SpeechToTextService _speechToTextService;
  final TextToSpeechService _textToSpeechService;

  ChatController({
    required SendMessageUseCase sendMessageUseCase,
    required LoadChatHistoryUseCase loadChatHistoryUseCase,
    required SaveChatHistoryUseCase saveChatHistoryUseCase,
    required ClearChatHistoryUseCase clearChatHistoryUseCase,
    required SpeechToTextService speechToTextService,
    required TextToSpeechService textToSpeechService,
  })  : _sendMessageUseCase = sendMessageUseCase,
        _loadChatHistoryUseCase = loadChatHistoryUseCase,
        _saveChatHistoryUseCase = saveChatHistoryUseCase,
        _clearChatHistoryUseCase = clearChatHistoryUseCase,
        _speechToTextService = speechToTextService,
        _textToSpeechService = textToSpeechService;

  // Observable state
  final RxList<Message> messages = <Message>[].obs;
  final RxBool isLoading = false.obs;
  final RxBool isListening = false.obs;
  final RxString currentSpeech = ''.obs;

  @override
  void onInit() {
    super.onInit();
    _loadChatHistory();
    _initializeServices();
  }

  /// Initialize speech services
  Future<void> _initializeServices() async {
    await _speechToTextService.initialize();
    await _textToSpeechService.initialize();
  }

  /// Load chat history from storage
  Future<void> _loadChatHistory() async {
    try {
      final history = await _loadChatHistoryUseCase.execute();
      messages.value = history;
    } catch (e) {
      Get.snackbar(
        'Error',
        'Failed to load chat history: $e',
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }

  /// Send a message to the AI
  Future<void> sendMessage(String text) async {
    if (text.trim().isEmpty) return;

    // Create user message
    final userMessage = Message(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      text: text.trim(),
      isUser: true,
      timestamp: DateTime.now(),
    );

    // Add user message to list
    messages.add(userMessage);
    isLoading.value = true;

    try {
      // Send to AI and get response
      final aiMessage = await _sendMessageUseCase.execute(text.trim());
      messages.add(aiMessage);

      // Save chat history
      await _saveChatHistoryUseCase.execute(messages.toList());
    } catch (e) {
      Get.snackbar(
        'Error',
        'Failed to send message: $e',
        snackPosition: SnackPosition.BOTTOM,
        duration: const Duration(seconds: 3),
      );

      // Add error message
      messages.add(Message(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        text: 'Sorry, I encountered an error. Please try again.',
        isUser: false,
        timestamp: DateTime.now(),
      ));
    } finally {
      isLoading.value = false;
    }
  }

  /// Start voice recording
  Future<void> startListening() async {
    if (!_speechToTextService.isAvailable) {
      final initialized = await _speechToTextService.initialize();
      if (!initialized) {
        Get.snackbar(
          'Permission Required',
          'Please grant microphone permission to use voice input',
          snackPosition: SnackPosition.BOTTOM,
        );
        return;
      }
    }

    isListening.value = true;
    currentSpeech.value = '';

    await _speechToTextService.startListening(
      onResult: (text) {
        currentSpeech.value = text;
      },
    );
  }

  /// Stop voice recording
  Future<void> stopListening() async {
    await _speechToTextService.stopListening();
    isListening.value = false;
  }

  /// Speak AI message using TTS
  Future<void> speakMessage(String text) async {
    try {
      await _textToSpeechService.speak(text);
    } catch (e) {
      Get.snackbar(
        'Error',
        'Failed to speak message: $e',
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }

  /// Stop TTS
  Future<void> stopSpeaking() async {
    await _textToSpeechService.stop();
  }

  /// Clear all chat history
  Future<void> clearHistory() async {
    try {
      await _clearChatHistoryUseCase.execute();
      messages.clear();
      Get.snackbar(
        'Success',
        'Chat history cleared',
        snackPosition: SnackPosition.BOTTOM,
      );
    } catch (e) {
      Get.snackbar(
        'Error',
        'Failed to clear history: $e',
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }

  @override
  void onClose() {
    _textToSpeechService.stop();
    super.onClose();
  }
}

