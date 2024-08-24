import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/presentation/bloc/weather_bloc.dart';
import 'package:weather_app/utils/common_methods.dart';

class WeatherPage extends StatelessWidget {
  const WeatherPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Weather Forecast'),
      ),
      body: BlocBuilder<WeatherBloc, WeatherState>(
        builder: (context, state) {
          if (state is WeatherInitial) {
            return const Center(child: Text('Please wait...'));
          } else if (state is WeatherLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is WeatherLoaded) {
            return ListView.builder(
              itemBuilder: (context, index) {
                final weather = state.weather[index];
                return ListTile(
                  leading: getWeatherIcon(weather.description),
                  title: Text(
                    weather.date,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  subtitle: Text(
                    '${weather.temperature}°C - ${weather.description}',
                    style: TextStyle(
                      color: Colors.grey[600],
                    ),
                  ),
                );
              },
              shrinkWrap: true,
              itemCount: state.weather.length,
            );
          } else if (state is WeatherError) {
            return Center(child: Text(state.message));
          }
          return Container();
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          CommonMethods.getLocationAndFetchWeather(context);
        },
        child: const Icon(Icons.refresh),
      ),
    );
  }

  Icon getWeatherIcon(String description) {
    switch (description.toLowerCase()) {
      case 'clear sky':
        return Icon(Icons.wb_sunny, color: Colors.orange);
      case 'few clouds':
        return Icon(Icons.cloud, color: Colors.grey);
      case 'scattered clouds':
        return Icon(Icons.cloud_queue, color: Colors.grey);
      case 'broken clouds':
        return Icon(Icons.cloud, color: Colors.grey[700]);
      case 'shower rain':
        return Icon(Icons.grain, color: Colors.blue);
      case 'rain':
        return Icon(Icons.beach_access, color: Colors.blue);
      case 'thunderstorm':
        return Icon(Icons.flash_on, color: Colors.yellow);
      case 'snow':
        return Icon(Icons.ac_unit, color: Colors.lightBlue);
      case 'mist':
        return Icon(Icons.blur_on, color: Colors.grey);
      default:
        return Icon(Icons.wb_cloudy, color: Colors.grey);
    }
  }
}
