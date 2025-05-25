# News App

A modern Flutter news application that fetches and displays the latest news articles using the NewsAPI. The app features a clean Material Design interface, category filtering, search functionality, and detailed article views.

## Features

-  User authentication (demo login screen)
-  Latest news articles from various sources
-  Search functionality to find specific articles
-  Category-based filtering (Technology, Sports, Entertainment, etc.)
-  Pull-to-refresh for latest content
-  Infinite scrolling for pagination
-  Open articles in browser
-  Responsive Material Design UI
-  Proper error handling and retry mechanisms
-  Image caching for better performance


### Installation

1. Clone the repository:
```bash
git clone https://github.com/yourusername/news_app.git
cd news_app
```

2. Install dependencies:
```bash
flutter pub get
```

3. Create a new file `lib/config/api_config.dart` and add your NewsAPI key:
```dart
class ApiConfig {
  static const String apiKey = 'YOUR_API_KEY_HERE';
}
```

4. Run the app:
```bash
flutter run
```

## Project Structure

```
lib/
├── models/          # Data models
├── providers/       # State management
├── repositories/    # Data layer
├── screens/         # UI screens
├── services/        # API services
├── widgets/         # Reusable widgets
└── main.dart        # App entry point
```

## Dependencies

- `provider`: State management
- `dio`: HTTP client for API requests
- `url_launcher`: Opening URLs in browser
- `intl`: Date formatting
- `flutter_animate`: Animations

## Architecture

The app follows a clean architecture pattern with:
- Repository pattern for data layer
- Provider pattern for state management
- Service layer for API communication
- Widget composition for UI

## Error Handling

The app includes comprehensive error handling:
- Network error handling with retry mechanism
- User-friendly error messages
- Loading states
- Empty state handling

## Contributing

1. Fork the repository
2. Create your feature branch (`git checkout -b feature/AmazingFeature`)
3. Commit your changes (`git commit -m 'Add some AmazingFeature'`)
4. Push to the branch (`git push origin feature/AmazingFeature`)
5. Open a Pull Request

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## Acknowledgments

- [NewsAPI](https://newsapi.org/) for providing the news data
- Flutter team for the amazing framework
- Material Design for the UI guidelines
