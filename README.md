# Coffee Shop Flutter App

A Flutter application built with Clean Architecture, Riverpod for state management, and GoRouter for navigation.

## Architecture

This app follows Clean Architecture principles with three main layers:

### Domain Layer
- **Entities**: Core business objects (User, CoffeeType, Location, Order, Review)
- **Repositories**: Abstract interfaces defining data operations
- **Use Cases**: Business logic (can be added as needed)

### Data Layer
- **Models**: Data models extending entities with JSON serialization
- **Data Sources**: Remote (HTTP) and Local (SharedPreferences) data sources
- **Repository Implementations**: Concrete implementations of domain repositories

### Presentation Layer
- **Screens**: UI screens for different features
- **Widgets**: Reusable UI components
- **Providers**: Riverpod providers for state management

## Features

- ✅ Authentication (Login/Register)
- ✅ Coffee Types browsing with search and filters
- ✅ Location selection
- ✅ Order management
- ✅ Reviews and ratings
- ✅ Favorites
- ✅ Profile management

## Setup

1. Install dependencies:
```bash
flutter pub get
```

2. Generate code (for JSON serialization):
```bash
flutter pub run build_runner build --delete-conflicting-outputs
```

3. Update API base URL in `lib/core/constants/api_constants.dart` if needed

4. Run the app:
```bash
flutter run
```

## Dependencies

- **flutter_riverpod**: State management
- **go_router**: Navigation
- **http**: HTTP client
- **shared_preferences**: Local storage
- **json_annotation**: JSON serialization

## Project Structure

```
lib/
├── core/
│   ├── constants/     # API constants
│   ├── di/            # Dependency injection
│   ├── errors/        # Error handling
│   ├── router/        # GoRouter configuration
│   └── utils/         # Utilities
├── data/
│   ├── datasources/   # Remote and local data sources
│   ├── models/        # Data models
│   └── repositories/  # Repository implementations
├── domain/
│   ├── entities/      # Business entities
│   └── repositories/  # Repository interfaces
└── presentation/
    ├── providers/     # Riverpod providers
    ├── screens/       # UI screens
    └── widgets/       # Reusable widgets
```

## Notes

- The app connects to the Vapor backend API
- Authentication tokens are stored locally using SharedPreferences
- All API calls are handled through the repository pattern
- State management is done with Riverpod providers
