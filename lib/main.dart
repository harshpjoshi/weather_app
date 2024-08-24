import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:path_provider/path_provider.dart';
import 'package:weather_app/data/data_sources/weather_remote_source.dart';
import 'package:weather_app/data/repositories/weather_repository_impl.dart';
import 'package:weather_app/domain/use_cases/get_weather.dart';
import 'package:weather_app/presentation/bloc/weather_bloc.dart';
import 'package:weather_app/presentation/pages/weather_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  HydratedBloc.storage = await HydratedStorage.build(
    storageDirectory: kIsWeb
        ? HydratedStorage.webStorageDirectory
        : await getApplicationDocumentsDirectory(),
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final dio = Dio();
    final weatherRemoteDataSource = WeatherRemoteDataSource(dio);
    final weatherRepository = WeatherRepositoryImpl(weatherRemoteDataSource);
    final getWeather = GetWeather(weatherRepository);

    return MaterialApp(
      home: BlocProvider(
        create: (_) => WeatherBloc(getWeather),
        child: const WeatherPage(),
      ),
    );
  }
}
