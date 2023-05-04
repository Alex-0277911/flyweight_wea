// Pattern Flyweight використовується для оптимізації роботи з об'єктами, які
// мають велику кількість однакових властивостей. В даному випадку ми можемо
// використати Flyweight для оптимізації збереження та отримання погодних даних.

import 'dart:convert';
import 'package:http/http.dart' as http;

// У цьому прикладі клас Weather представляє об'єкт з погодними даними, що
// містить назву міста, температуру, вологість та швидкість вітру.

class Weather {
  final String cityName;
  final double temperature;
  final double humidity;
  final double windSpeed;

  Weather(this.cityName, this.temperature, this.humidity, this.windSpeed);
}

// Клас WeatherFactory виконує функцію фабрики для створення об'єктів Weather.
// Він містить приватний статичний об'єкт _weatherCache, який зберігає вже
// створені об'єкти Weather. Метод getWeather перевіряє, чи вже існує в кеші
// об'єкт з погодними даними для заданої назви міста, і якщо так, то повертає
// його. Якщо об'єкт ще не існує, він створюється за допомогою конструктора
// Weather, додається до кешу і повертається як результат

class WeatherFactory {
  static final _weatherCache = <String, Weather>{};

  static Weather getWeather(
      String cityName, double temperature, double humidity, double windSpeed) {
    return _weatherCache.putIfAbsent(
        cityName, () => Weather(cityName, temperature, humidity, windSpeed));
  }
  // putIfAbsent
  // Шукає значення [key] або додає новий запис, якщо його там немає.
  // Повертає значення, пов'язане з [key], якщо воно існує. В іншому випадку
  // викликає [ifAbsent] для отримання нового значення, асоціює [key] з цим
  // значенням, а потім повертає нове значення.
}

class WeatherApi {
  final String _apiKey = 'd7f3fb73c94b0165061b6b96fc397852';
  final String _baseUrl = 'https://api.openweathermap.org/data/2.5/weather';

  Future<Weather> getCurrentWeather(String cityName) async {
    final url = '$_baseUrl?q=$cityName&appid=$_apiKey&units=metric';
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final temperature = data['main']['temp'].toDouble();
      final humidity = data['main']['humidity'].toDouble();
      final windSpeed = data['wind']['speed'].toDouble();

      return WeatherFactory.getWeather(
          cityName, temperature, humidity, windSpeed);
    } else {
      throw Exception('Failed to load weather data');
    }
  }
}

// Ця програма виконує наступні кроки:

// Створює об'єкт WeatherApi для виклику API OpenWeatherMap.
// Встановлює назву міста Kyiv, для якого потрібно отримати погодні дані.
// Викликає метод getCurrentWeather двічі для отримання погодних даних для міста Kyiv.
// Виводить на екран дані погоди для міста Kyiv

void main() async {
  final api = WeatherApi();
  final cityName = 'Kyiv';
  final weather1 = await api.getCurrentWeather(cityName);
  final weather2 = await api.getCurrentWeather(cityName);

  print('Weather data for $cityName:');
  print('Temperature: ${weather1.temperature}°C');
  print('Humidity: ${weather1.humidity}%');
  print('Wind speed: ${weather1.windSpeed} m/s');

  print('Using the same object from cache:');
  print('Temperature: ${weather2.temperature}°C');
  print('Humidity: ${weather2.humidity}%');
  print('Wind speed: ${weather2.windSpeed} m/s');

  print('Is the same object? ${identical(weather1, weather2)}');
}
