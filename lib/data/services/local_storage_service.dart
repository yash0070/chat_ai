import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import '../models/message.dart';
import '../../core/constants/app_constants.dart';

/// Local storage service for persisting chat history
class LocalStorageService {
  final SharedPreferences _prefs;

  LocalStorageService(this._prefs);

  /// Save chat history to local storage
  Future<void> saveChatHistory(List<Message> messages) async {
    try {
      final jsonList = messages.map((msg) => msg.toJson()).toList();
      final jsonString = jsonEncode(jsonList);
      await _prefs.setString(AppConstants.chatHistoryKey, jsonString);
    } catch (e) {
      throw Exception('Failed to save chat history: $e');
    }
  }

  /// Load chat history from local storage
  Future<List<Message>> loadChatHistory() async {
    try {
      final jsonString = _prefs.getString(AppConstants.chatHistoryKey);
      if (jsonString == null || jsonString.isEmpty) {
        return [];
      }

      final jsonList = jsonDecode(jsonString) as List;
      return jsonList
          .map((json) => Message.fromJson(json as Map<String, dynamic>))
          .toList();
    } catch (e) {
      return [];
    }
  }

  /// Clear chat history
  Future<void> clearChatHistory() async {
    await _prefs.remove(AppConstants.chatHistoryKey);
  }
}

