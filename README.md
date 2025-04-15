# Weather App

A Flutter application that displays weather information including current temperature and forecasts.

## Features

- Display current weather information
- Show daily forecasts
- Error handling with retry functionality
- Pull-to-refresh to update weather data

## Project Architecture

This project follows Clean Architecture principles with the following layers:

- **Presentation Layer**: UI components, pages, and BLoC/Cubit state management
- **Application Layer**: Services that coordinate between UI and domain
- **Domain Layer**: Business logic, entities, and use cases
- **Data Layer**: Data sources, repositories implementations, and models

## Getting Started

### Prerequisites

- Flutter SDK (latest stable version)
- Dart SDK (latest stable version)
- An IDE (VS Code, Android Studio, or IntelliJ)
- A weather API key (from OpenWeatherMap or similar service)

### Installation

1. Clone the repository:

```bash
git clone https://github.com/yourusername/weather_app.git
cd /Users/ducphan/Desktop/Documents/Flutter_project/weather_app
```
2. Install dependencies:
```bash
flutter pub get
```
3. Create a `.env` file in the root directory and add your weather API key:
```
WEATHER_API_KEY=your_api_key_here
BASE_URL_PROD=https://api.openweathermap.org/data/2.5/
BASE_URL_STAGING=https://api.openweathermap.org/data/2.5/
BASE_URL_DEV=https://api.openweathermap.org/data/2.5/
```

4. Run the app:
```bash
flutter run
``` 
5. Enjoy!