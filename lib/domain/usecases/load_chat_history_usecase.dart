import '../../data/models/message.dart';
import '../repositories/chat_repository.dart';

/// Use case for loading chat history
class LoadChatHistoryUseCase {
  final ChatRepository _repository;

  LoadChatHistoryUseCase(this._repository);

  /// Execute the use case
  Future<List<Message>> execute() async {
    try {
      return await _repository.loadChatHistory();
    } catch (e) {
      throw Exception('Failed to load chat history: $e');
    }
  }
}

