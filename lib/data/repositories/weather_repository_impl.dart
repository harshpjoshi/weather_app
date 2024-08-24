import 'package:weather_app/data/data_sources/weather_remote_source.dart';
import 'package:weather_app/domain/entities/weather.dart';
import 'package:weather_app/domain/repositories/weather_repository.dart';

class WeatherRepositoryImpl implements WeatherRepository {
  final WeatherRemoteDataSource remoteDataSource;

  WeatherRepositoryImpl(this.remoteDataSource);

  @override
  Future<List<Weather>> getWeather(double lat, double lon) async {
    final weatherModels = await remoteDataSource.fetchWeather(lat, lon);
    return weatherModels
        .map((model) => Weather(
              date: model.dt_txt,
              temperature: model.main.temp,
              description: model.weather.first.description,
            ))
        .toList();
  }
}
