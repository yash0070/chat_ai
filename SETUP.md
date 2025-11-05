# Quick Setup Guide

## Step 1: Install Dependencies

The dependencies are already added. Just run:

```bash
flutter pub get
```

## Step 2: Add Your Gemini API Key

**IMPORTANT:** You must add your Gemini API key for the app to work!

1. Get your API key from: https://makersuite.google.com/app/apikey
2. Open: `lib/core/constants/app_constants.dart`
3. Replace this line:
   ```dart
   static const String geminiApiKey = 'YOUR_API_KEY_HERE';
   ```
   With your actual key:
   ```dart
   static const String geminiApiKey = 'AIzaSy...your_actual_key_here';
   ```

## Step 3: Run the App

```bash
# For Android
flutter run

# For iOS
flutter run -d ios

# For macOS
flutter run -d macos
```

## Testing Features

### 1. Text Chat
- Type a message in the input field
- Press send or hit Enter
- Wait for AI response

### 2. Voice Input
- Tap the microphone icon
- Grant permission when prompted
- Speak your message
- The text appears in the input field
- Tap send

### 3. Text-to-Speech
- After receiving an AI response
- Tap the speaker icon on the AI message bubble
- Listen to the AI response

### 4. Chat History
- Messages are automatically saved
- Close and reopen the app to see history persisted
- Tap the delete icon in app bar to clear history

## Folder Structure Overview

```
lib/
├── core/                          # Core utilities
│   ├── constants/
│   │   └── app_constants.dart    # ⚠️ ADD YOUR API KEY HERE
│   ├── theme/
│   │   └── app_theme.dart        # UI theme configuration
│   └── utils/
│       └── json_utils.dart       # JSON helper utilities
│
├── data/                          # Data layer
│   ├── api/
│   │   └── gemini_api_client.dart        # Gemini API integration
│   ├── models/
│   │   └── message.dart                  # Message data model
│   └── services/
│       ├── local_storage_service.dart    # Chat history storage
│       ├── speech_to_text_service.dart   # Voice input
│       └── text_to_speech_service.dart   # Audio output
│
├── domain/                        # Business logic layer
│   ├── repositories/
│   │   ├── chat_repository.dart          # Repository interface
│   │   └── chat_repository_impl.dart     # Repository implementation
│   └── usecases/
│       ├── send_message_usecase.dart
│       ├── load_chat_history_usecase.dart
│       ├── save_chat_history_usecase.dart
│       └── clear_chat_history_usecase.dart
│
├── presentation/                  # UI layer
│   ├── controllers/
│   │   └── chat_controller.dart          # GetX state management
│   ├── views/
│   │   └── chat_screen.dart              # Main chat screen
│   └── widgets/
│       ├── message_bubble.dart           # Message display widget
│       └── message_input.dart            # Input field widget
│
├── di/                            # Dependency injection
│   └── dependency_injection.dart         # GetIt setup
│
└── main.dart                      # App entry point
```

## Key Implementation Details

### Clean Architecture
- **Presentation Layer**: UI and state management
- **Domain Layer**: Business logic and use cases
- **Data Layer**: API calls, models, and services

### State Management (GetX)
- Reactive state updates with `.obs` observables
- Automatic UI refresh with `Obx()` widget
- Clean separation of UI and business logic

### Dependency Injection (get_it)
- All dependencies registered in `dependency_injection.dart`
- Singleton pattern for services
- Easy to test and maintain

### API Integration
- Clean HTTP client wrapper
- Error handling with try-catch
- JSON parsing for Gemini responses

### Local Storage
- Uses SharedPreferences
- Automatic save after each message
- Load on app startup

### Voice Features
- Microphone permission handling
- Real-time speech recognition
- Text-to-speech for AI responses

## Common Issues & Solutions

### Issue: "API Key Invalid"
**Solution:** Make sure you've added your actual Gemini API key in `app_constants.dart`

### Issue: "Microphone Permission Denied"
**Solution:** 
- Android: Go to Settings > Apps > Chat AI > Permissions > Microphone
- iOS: Go to Settings > Privacy > Microphone > Chat AI

### Issue: "No AI Response"
**Solution:**
- Check internet connection
- Verify API key is valid
- Check console for error messages

### Issue: "Text-to-Speech Not Working"
**Solution:**
- Check device volume
- Ensure device has TTS engine installed
- Try restarting the app

## Code Quality Notes

The analyzer shows 11 informational warnings (not errors):
- 2 print statements (for debugging speech recognition)
- 9 deprecation warnings for newer Flutter APIs
- These don't affect functionality and can be ignored for now

## Next Steps

1. ✅ Add your Gemini API key
2. ✅ Run `flutter pub get`
3. ✅ Run the app with `flutter run`
4. ✅ Test all features
5. 🎉 Enjoy your AI chat app!

## Architecture Benefits

✅ **Maintainable**: Clear separation of concerns
✅ **Testable**: Each layer can be tested independently  
✅ **Scalable**: Easy to add new features
✅ **Clean**: Follows SOLID principles
✅ **Professional**: Industry-standard architecture

## Contact & Support

For issues or questions, refer to the main README.md file.

