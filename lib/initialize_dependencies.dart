import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'application/services/local_service.dart';
import 'data/impl_repositories/weather_repository_impl.dart';
import 'flavor.dart';

import 'application/services/weather_service.dart';
import 'data/data_sources/weather_api_data_source.dart';
import 'domain/repositories/weather_repository.dart';
import 'domain/usecases/get_weather_usecase.dart';
import 'presentation/cubits/weather/weather_cubit.dart';

final sl = GetIt.I;
final getIt = GetIt.instance;

Future initializeDependencies() async {
  final baseUrl = Flavor.instance.baseURL;

  //region local IO
  final sharedPres = await SharedPreferences.getInstance();
  sl.registerLazySingleton<SharedPreferences>(() => sharedPres);
  sl.registerLazySingleton(() => LocalService());
  //endregion

  //region network server
  Dio dio = Dio(BaseOptions(baseUrl: baseUrl))
    ..interceptors.add(LogInterceptor(requestBody: true, responseBody: true));

  sl.registerLazySingleton(() => dio);
  //endregion

  // region Data sources
  getIt.registerLazySingleton<WeatherApiDataSource>(
        () => WeatherApiDataSource(getIt<Dio>()),
  );
  //endregion

  //region repo
  getIt.registerLazySingleton<WeatherRepository>(
        () => WeatherRepositoryImpl(getIt<WeatherApiDataSource>()),
  );
  //endregion

  //region Use cases
  getIt.registerLazySingleton<GetWeatherUseCase>(
        () => GetWeatherUseCase(getIt<WeatherRepository>()),
  );
  //endregion

  //region service
  getIt.registerLazySingleton<WeatherService>(
        () => WeatherService(getIt<GetWeatherUseCase>()),
  );
  //endregion

  //region state
  getIt.registerFactory<WeatherCubit>(
        () => WeatherCubit(getIt<WeatherService>()),
  );
  //endregion
}

