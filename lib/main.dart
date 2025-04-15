import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import 'application/services/weather_service.dart';
import 'initialize_dependencies.dart';
import 'presentation/cubits/weather/weather_cubit.dart';
import 'presentation/pages/weather/weather_page.dart';
import 'themes.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  // Load environment variables
  await dotenv.load(fileName: '.env');
  
  // Initialize dependencies
  await initializeDependencies();
  
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Weather App',
      theme: appTheme(context),
      home: BlocProvider(
        create: (_) => WeatherCubit(getIt<WeatherService>()),
        child: const WeatherPage(),
      ),
    );
  }
}
