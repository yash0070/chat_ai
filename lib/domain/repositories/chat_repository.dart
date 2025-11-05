import '../../data/models/message.dart';

/// Repository interface for chat operations
abstract class ChatRepository {
  /// Send a message to the AI and get response
  Future<String> sendMessage(String message);

  /// Load chat history from local storage
  Future<List<Message>> loadChatHistory();

  /// Save chat history to local storage
  Future<void> saveChatHistory(List<Message> messages);

  /// Clear chat history
  Future<void> clearChatHistory();
}
