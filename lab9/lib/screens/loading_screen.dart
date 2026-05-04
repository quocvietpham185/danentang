// lib/screens/loading_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart'; // Import hiệu ứng Loading
import '../services/weather.dart';
import 'location_screen.dart';

class LoadingScreen extends StatefulWidget {
  const LoadingScreen({super.key});

  @override
  State<LoadingScreen> createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  @override
  void initState() {
    super.initState();
    getLocationData(); // Gọi hàm lấy dữ liệu ngay khi màn hình vừa mở lên
  }

  void getLocationData() async {
    WeatherModel weatherModel = WeatherModel();
    // Đợi quá trình lấy GPS và gọi API hoàn tất
    var weatherData = await weatherModel.getLocationWeather();

    // Kiểm tra context có còn mounted không trước khi chuyển trang (Best practice)
    if (!mounted) return;

    // Chuyển sang màn hình LocationScreen và "gửi" cục data json đi theo
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) {
          return LocationScreen(locationWeather: weatherData);
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Color(0xFF1E3C72), Color(0xFF2A5298)],
          ),
        ),
        child: const Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SpinKitDoubleBounce(color: Colors.white, size: 100.0),
              SizedBox(height: 30),
              Text(
                'Đang tải dữ liệu thời tiết...',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18.0,
                  fontWeight: FontWeight.w500,
                  letterSpacing: 1.2,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
