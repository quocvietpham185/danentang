// lib/services/weather.dart
import 'location.dart';
import 'networking.dart';
import '../utilities/constants.dart';

class WeatherModel {
  // Lấy thời tiết dựa trên tên thành phố (khi người dùng gõ tìm kiếm)
  Future<dynamic> getCityWeather(String cityName) async {
    var url = '$kOpenWeatherMapURL?q=$cityName&appid=$kApiKey&units=metric';
    NetworkHelper networkHelper = NetworkHelper(url);
    var weatherData = await networkHelper.getData();
    return weatherData;
  }

  // Lấy thời tiết dựa trên GPS hiện tại
  Future<dynamic> getLocationWeather() async {
    Location location = Location();
    await location.getCurrentLocation(); // Chờ lấy xong GPS

    // Tham số units=metric để lấy nhiệt độ theo độ C (Celsius)
    var url =
        '$kOpenWeatherMapURL?lat=${location.latitude}&lon=${location.longitude}&appid=$kApiKey&units=metric';
    NetworkHelper networkHelper = NetworkHelper(url);
    var weatherData = await networkHelper.getData(); // Chờ gọi API xong
    return weatherData;
  }

  // Chuyển mã ID thời tiết (từ API) thành Icon
  String getWeatherIcon(int condition) {
    if (condition < 300) return '🌩';
    if (condition < 400) return '🌧';
    if (condition < 600) return '☔️';
    if (condition < 700) return '☃️';
    if (condition < 800) return '🌫';
    if (condition == 800) return '☀️';
    if (condition <= 804) return '☁️';
    return '🤷‍';
  }

  // Tạo thông báo dựa trên nhiệt độ
  String getMessage(int temp) {
    if (temp > 25) return 'Đến lúc ăn kem rồi';
    if (temp > 20) return 'Thời tiết thật đẹp';
    if (temp < 10) return 'Nhớ mặc áo ấm nhé';
    return 'Hãy mang theo áo khoác mỏng';
  }
}
