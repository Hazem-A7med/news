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
-  Smooth page transitions and animations

## Getting Started

### Prerequisites

- Flutter SDK (>=3.0.0)
- Dart SDK (>=3.0.0)

## Project Structure

```
lib/
├── config/          # Configuration files
├── models/          # Data models
├── providers/       # State management
├── repositories/    # Data layer
├── screens/         # UI screens
├── services/        # API services
├── utils/          # Utility functions
├── widgets/        # Reusable widgets
└── main.dart       # App entry point
```

## Dependencies

- `provider`: State management
- `dio`: HTTP client for API requests
- `url_launcher`: Opening URLs in browser
- `intl`: Date formatting
- `flutter_animate`: Animations

## Features in Detail

### Authentication
- Demo login screen with email and password validation
- Smooth transition to main app

### News Browsing
- View latest news articles
- Pull to refresh for latest content
- Infinite scroll pagination
- Category filtering
- Search functionality with debouncing

### Article Details
- Full article view with images
- Author and publication date
- Open in browser option
- Smooth transitions

### UI/UX
- Material Design 3
- Custom animations and transitions
- Error handling with retry options
- Loading states and indicators
- Image caching for performance

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

