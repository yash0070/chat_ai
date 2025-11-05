import '../repositories/chat_repository.dart';

/// Use case for clearing chat history
class ClearChatHistoryUseCase {
  final ChatRepository _repository;

  ClearChatHistoryUseCase(this._repository);

  /// Execute the use case
  Future<void> execute() async {
    try {
      await _repository.clearChatHistory();
    } catch (e) {
      throw Exception('Failed to clear chat history: $e');
    }
  }
}
