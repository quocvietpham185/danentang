// lib/screens/location_screen.dart
import 'package:flutter/material.dart';
import 'dart:ui';
import '../utilities/constants.dart';
import '../services/weather.dart';
import 'city_screen.dart';

class LocationScreen extends StatefulWidget {
  const LocationScreen({super.key, this.locationWeather});

  final dynamic locationWeather; // Biến này hứng dữ liệu được truyền sang

  @override
  State<LocationScreen> createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
  WeatherModel weather = WeatherModel();

  // Khởi tạo các biến để lưu thông tin bóc tách từ JSON
  late int temperature;
  late String weatherIcon;
  late String cityName;
  late String weatherMessage;

  @override
  void initState() {
    super.initState();
    // Bóc tách dữ liệu ngay khi màn hình khởi tạo
    updateUI(widget.locationWeather);
  }

  // Hàm bóc tách dữ liệu JSON (Rất quan trọng)
  void updateUI(dynamic weatherData) {
    setState(() {
      // Trường hợp không có mạng hoặc lỗi API
      if (weatherData == null) {
        temperature = 0;
        weatherIcon = 'Error';
        weatherMessage = 'Không thể lấy dữ liệu thời tiết';
        cityName = '';
        return;
      }

      // Đọc cấu trúc JSON của OpenWeatherMap:
      // Nhiệt độ nằm trong weatherData['main']['temp']
      double temp = weatherData['main']['temp'];
      temperature = temp.toInt();

      // Mã thời tiết nằm trong mảng weatherData['weather'][0]['id']
      var condition = weatherData['weather'][0]['id'];
      weatherIcon = weather.getWeatherIcon(condition);
      weatherMessage = weather.getMessage(temperature);

      // Tên thành phố nằm ở weatherData['name']
      cityName = weatherData['name'];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: const AssetImage('images/location_background.jpg'),
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(
              Colors.black.withOpacity(0.4), // Làm tối nền một chút để chữ nổi bật
              BlendMode.darken,
            ),
          ),
        ),
        constraints: const BoxConstraints.expand(),
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              // Hàng nút bấm (Tìm vị trí hiện tại & Mở màn hình tìm kiếm)
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    IconButton(
                      onPressed: () async {
                        // Gọi lại API cho vị trí hiện tại
                        var weatherData = await weather.getLocationWeather();
                        updateUI(weatherData);
                      },
                      icon: const Icon(Icons.near_me, size: 40.0, color: Colors.white),
                    ),
                    IconButton(
                      onPressed: () async {
                        // Mở màn hình gõ tên thành phố và chờ kết quả trả về
                        var typedName = await Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) {
                              return const CityScreen();
                            },
                          ),
                        );
                        // Nếu có gõ tên, tiến hành gọi API mới
                        if (typedName != null) {
                          var weatherData = await weather.getCityWeather(typedName);
                          updateUI(weatherData);
                        }
                      },
                      icon: const Icon(Icons.location_city, size: 40.0, color: Colors.white),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Center(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(30.0),
                    child: BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0), // Hiệu ứng mờ Glassmorphism
                      child: Container(
                        padding: const EdgeInsets.all(30.0),
                        margin: const EdgeInsets.symmetric(horizontal: 20.0),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.15),
                          borderRadius: BorderRadius.circular(30.0),
                          border: Border.all(color: Colors.white.withOpacity(0.2)),
                        ),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.baseline,
                              textBaseline: TextBaseline.alphabetic,
                              children: [
                                Text('$temperature°', style: kTempTextStyle),
                                Text(weatherIcon, style: kConditionTextStyle),
                              ],
                            ),
                            const SizedBox(height: 20),
                            Text(
                              "$weatherMessage \nở $cityName!",
                              textAlign: TextAlign.center,
                              style: kMessageTextStyle,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 50),
            ],
          ),
        ),
      ),
    );
  }
}
