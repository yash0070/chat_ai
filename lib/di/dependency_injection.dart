import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../data/api/gemini_api_client.dart';
import '../data/services/local_storage_service.dart';
import '../data/services/speech_to_text_service.dart';
import '../data/services/text_to_speech_service.dart';
import '../domain/repositories/chat_repository.dart';
import '../domain/repositories/chat_repository_impl.dart';
import '../domain/usecases/send_message_usecase.dart';
import '../domain/usecases/load_chat_history_usecase.dart';
import '../domain/usecases/save_chat_history_usecase.dart';
import '../domain/usecases/clear_chat_history_usecase.dart';
import '../presentation/controllers/chat_controller.dart';

final getIt = GetIt.instance;

/// Setup dependency injection
Future<void> setupDependencies() async {
  // External dependencies
  final sharedPreferences = await SharedPreferences.getInstance();
  getIt.registerSingleton<SharedPreferences>(sharedPreferences);

  // Services
  getIt.registerLazySingleton(() => GeminiApiClient());
  getIt.registerLazySingleton(() => LocalStorageService(getIt()));
  getIt.registerLazySingleton(() => SpeechToTextService());
  getIt.registerLazySingleton(() => TextToSpeechService());

  // Repository
  getIt.registerLazySingleton<ChatRepository>(
    () => ChatRepositoryImpl(
      apiClient: getIt(),
      storageService: getIt(),
    ),
  );

  // Use cases
  getIt.registerLazySingleton(() => SendMessageUseCase(getIt()));
  getIt.registerLazySingleton(() => LoadChatHistoryUseCase(getIt()));
  getIt.registerLazySingleton(() => SaveChatHistoryUseCase(getIt()));
  getIt.registerLazySingleton(() => ClearChatHistoryUseCase(getIt()));

  // Controller
  getIt.registerLazySingleton(
    () => ChatController(
      sendMessageUseCase: getIt(),
      loadChatHistoryUseCase: getIt(),
      saveChatHistoryUseCase: getIt(),
      clearChatHistoryUseCase: getIt(),
      speechToTextService: getIt(),
      textToSpeechService: getIt(),
    ),
  );
}

