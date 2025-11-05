import '../../data/models/message.dart';
import '../repositories/chat_repository.dart';

/// Use case for sending a message to AI
class SendMessageUseCase {
  final ChatRepository _repository;

  SendMessageUseCase(this._repository);

  /// Execute the use case
  Future<Message> execute(String userMessage) async {
    try {
      // Send message to API and get response
      final aiResponse = await _repository.sendMessage(userMessage);

      // Create AI message
      final aiMessage = Message(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        text: aiResponse,
        isUser: false,
        timestamp: DateTime.now(),
      );

      return aiMessage;
    } catch (e) {
      throw Exception('Failed to send message: $e');
    }
  }
}

