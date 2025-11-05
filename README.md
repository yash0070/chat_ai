# AI Chat Application

A complete Flutter chat application with clean architecture that integrates with Google's Gemini AI API.

## Features

- 🤖 **AI Chat Interface**: ChatGPT-like UI with user and AI message bubbles
- 🎤 **Voice Input**: Tap the mic icon to speak your message (speech-to-text)
- 🔊 **Text-to-Speech**: Each AI message has a sound button to hear the response
- 💾 **Chat History**: Automatically saves and loads chat history locally
- 🏗️ **Clean Architecture**: Proper separation of concerns with domain, data, and presentation layers
- 💉 **Dependency Injection**: Uses get_it for clean dependency management
- 🎨 **Modern UI**: Beautiful, minimal design with Google Fonts

## Architecture

```
lib/
├── core/                   # Core utilities and constants
│   ├── constants/         # App-wide constants
│   ├── theme/            # Theme configuration
│   └── utils/            # Utility functions
├── data/                  # Data layer
│   ├── api/              # API clients
│   ├── models/           # Data models
│   └── services/         # Services (storage, speech, tts)
├── domain/               # Domain layer
│   ├── repositories/     # Repository interfaces and implementations
│   └── usecases/        # Business logic use cases
├── presentation/         # Presentation layer
│   ├── controllers/      # GetX controllers
│   ├── views/           # Screen views
│   └── widgets/         # Reusable widgets
└── di/                   # Dependency injection setup
```

## Setup Instructions

### 1. Get Gemini API Key

1. Go to [Google AI Studio](https://makersuite.google.com/app/apikey)
2. Create a new API key
3. Copy the API key

### 2. Configure API Key

Open `lib/core/constants/app_constants.dart` and replace `YOUR_API_KEY_HERE` with your actual Gemini API key:

```dart
static const String geminiApiKey = 'YOUR_ACTUAL_API_KEY_HERE';
```

### 3. Install Dependencies

```bash
flutter pub get
```

### 4. Run the App

```bash
# For Android
flutter run

# For iOS
flutter run -d ios

# For macOS
flutter run -d macos
```

## Dependencies

- **get** (^4.6.6): State management
- **get_it** (^7.6.4): Dependency injection
- **http** (^1.1.0): HTTP client for API calls
- **speech_to_text** (^6.6.0): Voice input
- **permission_handler** (^11.0.1): Permission handling
- **flutter_tts** (^3.8.5): Text-to-speech
- **shared_preferences** (^2.2.2): Local storage
- **google_fonts** (^6.1.0): Typography

## Usage

### Sending a Message

1. Type your message in the input field at the bottom
2. Press the send button or hit Enter

### Using Voice Input

1. Tap the microphone icon
2. Grant microphone permission if prompted
3. Speak your message
4. The text will appear in the input field
5. Tap send to submit

### Listening to AI Responses

1. After receiving an AI response, tap the speaker icon on the message bubble
2. The app will read the message aloud

### Clearing Chat History

1. Tap the delete icon in the app bar
2. Confirm the action

## Project Structure Explanation

### Core Layer
- **constants/**: Application-wide constants like API URLs and keys
- **theme/**: Theme configuration including colors and text styles
- **utils/**: Helper utilities for JSON operations

### Data Layer
- **api/**: `GeminiApiClient` handles all API communication
- **models/**: `Message` model represents chat messages
- **services/**: 
  - `LocalStorageService`: Saves/loads chat history
  - `SpeechToTextService`: Handles voice input
  - `TextToSpeechService`: Handles text-to-speech

### Domain Layer
- **repositories/**: Abstract interfaces and implementations for data operations
- **usecases/**: Business logic separated into specific use cases:
  - `SendMessageUseCase`: Sends message to AI
  - `LoadChatHistoryUseCase`: Loads saved messages
  - `SaveChatHistoryUseCase`: Saves messages
  - `ClearChatHistoryUseCase`: Clears all messages

### Presentation Layer
- **controllers/**: `ChatController` manages UI state with GetX
- **views/**: `ChatScreen` is the main chat interface
- **widgets/**: 
  - `MessageBubble`: Individual message display
  - `MessageInput`: Input field with mic and send buttons

## Permissions

The app requires the following permissions:

### Android (AndroidManifest.xml)
- `INTERNET`: For API calls
- `RECORD_AUDIO`: For voice input
- `BLUETOOTH`: For audio routing
- `BLUETOOTH_CONNECT`: For audio devices

### iOS/macOS (Info.plist)
- `NSMicrophoneUsageDescription`: For voice input
- `NSSpeechRecognitionUsageDescription`: For speech recognition

## Troubleshooting

### API Key Issues
- Make sure your API key is valid and has the Gemini API enabled
- Check that you've replaced `YOUR_API_KEY_HERE` in `app_constants.dart`

### Microphone Permission Denied
- Go to device settings and manually grant microphone permission
- Restart the app after granting permission

### Text-to-Speech Not Working
- Ensure your device has TTS engine installed
- Check device volume settings

## Future Enhancements

- [ ] Support for sending images
- [ ] Markdown rendering for AI responses
- [ ] Multiple conversation threads
- [ ] Export chat history
- [ ] Dark mode
- [ ] Message search functionality
- [ ] Streaming responses

## License

MIT License - Feel free to use this code for learning and projects!

## Contributing

Contributions are welcome! Please feel free to submit a Pull Request.

