import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:test_261224/data/data_sources/weather_api_data_source.dart';
import 'package:test_261224/data/impl_repositories/weather_repository_impl.dart';
import 'package:test_261224/domain/entities/weather_entity.dart';

import 'weather_repository_impl_test.mocks.dart';

@GenerateMocks([WeatherApiDataSource])
void main() {
  late WeatherRepositoryImpl repository;
  late MockWeatherApiDataSource mockDataSource;

  setUp(() {
    mockDataSource = MockWeatherApiDataSource();
    repository = WeatherRepositoryImpl(mockDataSource);
  });

  group('getCurrentWeather', () {
    final tWeatherEntity = _MockWeatherEntity();

    test('should return weather data when data source call is successful', () async {
      // arrange
      when(mockDataSource.getWeather(
        latitude: anyNamed('latitude'),
        longitude: anyNamed('longitude'),
      )).thenAnswer((_) async => tWeatherEntity);

      // act
      final result = await repository.getCurrentWeather(
        latitude: 37.7749,
        longitude: -122.4194,
      );

      // assert
      expect(result, equals(tWeatherEntity));
      verify(mockDataSource.getWeather(
        latitude: 37.7749,
        longitude: -122.4194,
      ));
    });

    test('should propagate exception when data source call fails', () async {
      // arrange
      when(mockDataSource.getWeather(
        latitude: anyNamed('latitude'),
        longitude: anyNamed('longitude'),
      )).thenThrow(Exception('Failed to fetch weather data'));

      // act & assert
      expect(
        () => repository.getCurrentWeather(
          latitude: 37.7749,
          longitude: -122.4194,
        ),
        throwsA(isA<Exception>()),
      );
    });

    test('should handle null coordinates', () async {
      // arrange
      when(mockDataSource.getWeather(
        latitude: null,
        longitude: null,
      )).thenAnswer((_) async => tWeatherEntity);

      // act
      final result = await repository.getCurrentWeather();

      // assert
      expect(result, equals(tWeatherEntity));
      verify(mockDataSource.getWeather(
        latitude: null,
        longitude: null,
      ));
    });
  });
}

class _MockWeatherEntity extends WeatherEntity {
  @override
  double get currentTemp => 25.5;

  @override
  List<DailyForecastEntity> get dailyForecasts => [
        _MockDailyForecastEntity(),
        _MockDailyForecastEntity(),
      ];

  @override
  String get locationName => 'Test City';
}

class _MockDailyForecastEntity extends DailyForecastEntity {
  @override
  double get avgTemp => 22.0;

  @override
  DateTime get date => DateTime(2023, 1, 1);
}