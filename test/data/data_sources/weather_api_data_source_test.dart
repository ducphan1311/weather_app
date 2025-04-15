import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:test_261224/data/data_sources/weather_api_data_source.dart';
import 'package:test_261224/domain/entities/weather_entity.dart';

import 'weather_api_data_source_test.mocks.dart';

@GenerateMocks([Dio])
void main() {
  late WeatherApiDataSource dataSource;
  late MockDio mockDio;

  setUp(() {
    mockDio = MockDio();
    dataSource = WeatherApiDataSource(mockDio);
  });

  group('getWeather', () {
    final tLatitude = 37.7749;
    final tLongitude = -122.4194;

    final tCurrentResponse = Response(
      data: {
        'main': {'temp': 25.5},
        'name': 'Test City',
      },
      statusCode: 200,
      requestOptions: RequestOptions(path: ''),
    );

    final tForecastResponse = Response(
      data: {
        'list': [
          {
            'dt': 1672531200, // 2023-01-01
            'main': {'temp': 22.0},
          },
          {
            'dt': 1672617600, // 2023-01-02
            'main': {'temp': 23.0},
          },
        ],
      },
      statusCode: 200,
      requestOptions: RequestOptions(path: ''),
    );

    test('should return WeatherEntity when API calls are successful', () async {
      // arrange
      // Sử dụng URL cụ thể thay vì any để tránh xung đột
      when(mockDio.get('https://api.openweathermap.org/data/2.5/weather',
              queryParameters: anyNamed('queryParameters')))
          .thenAnswer((_) async => tCurrentResponse);
      when(mockDio.get('https://api.openweathermap.org/data/2.5/forecast',
              queryParameters: anyNamed('queryParameters')))
          .thenAnswer((_) async => tForecastResponse);

      // act
      final result = await dataSource.getWeather(
        latitude: tLatitude,
        longitude: tLongitude,
      );

      // assert
      expect(result, isA<WeatherEntity>());
      expect(result.locationName, equals('Test City'));
      expect(result.currentTemp, equals(25.5));
    });

    test('should throw exception when current weather API call fails',
        () async {
      // arrange
      when(mockDio.get('https://api.openweathermap.org/data/2.5/weather',
              queryParameters: anyNamed('queryParameters')))
          .thenThrow(DioException(
        requestOptions: RequestOptions(path: ''),
        error: 'Failed to fetch current weather',
      ));

      // act & assert
      expect(
        () => dataSource.getWeather(
          latitude: tLatitude,
          longitude: tLongitude,
        ),
        throwsA(isA<Exception>()),
      );
    });

    test('should throw exception when forecast API call fails', () async {
      // arrange
      when(mockDio.get('https://api.openweathermap.org/data/2.5/weather',
              queryParameters: anyNamed('queryParameters')))
          .thenAnswer((_) async => tCurrentResponse);
      when(mockDio.get('https://api.openweathermap.org/data/2.5/forecast',
              queryParameters: anyNamed('queryParameters')))
          .thenThrow(DioException(
        requestOptions: RequestOptions(path: ''),
        error: 'Failed to fetch forecast',
      ));

      // act & assert
      expect(
        () => dataSource.getWeather(
          latitude: tLatitude,
          longitude: tLongitude,
        ),
        throwsA(isA<Exception>()),
      );
    });
  });
}
