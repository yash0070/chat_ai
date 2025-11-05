import 'dart:convert';

/// Utility class for JSON operations
class JsonUtils {
  /// Safely encode object to JSON string
  static String encode(dynamic object) {
    try {
      return jsonEncode(object);
    } catch (e) {
      return '{}';
    }
  }

  /// Safely decode JSON string to object
  static dynamic decode(String jsonString) {
    try {
      return jsonDecode(jsonString);
    } catch (e) {
      return null;
    }
  }

  /// Decode JSON list
  static List<dynamic> decodeList(String jsonString) {
    try {
      final decoded = jsonDecode(jsonString);
      return decoded is List ? decoded : [];
    } catch (e) {
      return [];
    }
  }
}

