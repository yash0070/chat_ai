import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../core/constants/app_constants.dart';

/// API client for communicating with Gemini API
class GeminiApiClient {
  final http.Client _client;

  GeminiApiClient({http.Client? client}) : _client = client ?? http.Client();

  /// Send a message to Gemini API and get response
  Future<String> sendMessage(String message) async {
    try {
      final url = Uri.parse(
        '${AppConstants.geminiApiBaseUrl}/models/${AppConstants.geminiModel}:generateContent',
      );

      final headers = {
        'x-goog-api-key': AppConstants.geminiApiKey,
        'Content-Type': 'application/json',
      };

      final body = jsonEncode({
        'contents': [
          {
            'parts': [
              {'text': message}
            ]
          }
        ]
      });

      final response = await _client.post(
        url,
        headers: headers,
        body: body,
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);

        // Parse the Gemini API response
        final candidates = data['candidates'] as List?;
        if (candidates != null && candidates.isNotEmpty) {
          final content = candidates[0]['content'];
          final parts = content['parts'] as List?;
          if (parts != null && parts.isNotEmpty) {
            return parts[0]['text'] as String;
          }
        }

        throw Exception('Invalid response format from Gemini API');
      } else {
        throw Exception('Failed to get response: ${response.statusCode} - ${response.body}');
      }
    } catch (e) {
      throw Exception('Error communicating with Gemini API: $e');
    }
  }

  /// Dispose the HTTP client
  void dispose() {
    _client.close();
  }
}

