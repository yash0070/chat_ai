import '../../data/api/gemini_api_client.dart';
import '../../data/models/message.dart';
import '../../data/services/local_storage_service.dart';
import 'chat_repository.dart';

/// Implementation of ChatRepository
class ChatRepositoryImpl implements ChatRepository {
  final GeminiApiClient _apiClient;
  final LocalStorageService _storageService;

  ChatRepositoryImpl({
    required GeminiApiClient apiClient,
    required LocalStorageService storageService,
  })  : _apiClient = apiClient,
        _storageService = storageService;

  @override
  Future<String> sendMessage(String message) async {
    return await _apiClient.sendMessage(message);
  }

  @override
  Future<List<Message>> loadChatHistory() async {
    return await _storageService.loadChatHistory();
  }

  @override
  Future<void> saveChatHistory(List<Message> messages) async {
    await _storageService.saveChatHistory(messages);
  }

  @override
  Future<void> clearChatHistory() async {
    await _storageService.clearChatHistory();
  }
}

