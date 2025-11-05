import '../../data/models/message.dart';
import '../repositories/chat_repository.dart';

/// Use case for saving chat history
class SaveChatHistoryUseCase {
  final ChatRepository _repository;

  SaveChatHistoryUseCase(this._repository);

  /// Execute the use case
  Future<void> execute(List<Message> messages) async {
    try {
      await _repository.saveChatHistory(messages);
    } catch (e) {
      throw Exception('Failed to save chat history: $e');
    }
  }
}

