import 'package:weather_app/domain/entities/weather.dart';
import 'package:weather_app/domain/repositories/weather_repository.dart';

class GetWeather {
  final WeatherRepository repository;

  GetWeather(this.repository);

  Future<List<Weather>> call(double lat, double lon) {
    return repository.getWeather(lat, lon);
  }
}
