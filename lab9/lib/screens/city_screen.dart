// lib/screens/city_screen.dart
import 'package:flutter/material.dart';
import 'dart:ui';
import '../utilities/constants.dart';

class CityScreen extends StatefulWidget {
  const CityScreen({super.key});

  @override
  State<CityScreen> createState() => _CityScreenState();
}

class _CityScreenState extends State<CityScreen> {
  late String cityName; // Biến lưu chữ người dùng gõ vào

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('images/city_background.jpg'), // Hình nền tùy chọn
            fit: BoxFit.cover,
          ),
        ),
        constraints: const BoxConstraints.expand(),
        child: SafeArea(
          child: Column(
            children: <Widget>[
              // Nút quay lại
              Align(
                alignment: Alignment.topLeft,
                child: IconButton(
                  padding: const EdgeInsets.all(20.0),
                  onPressed: () {
                    Navigator.pop(context); // Trở về màn hình trước
                  },
                  icon: const Icon(Icons.arrow_back_ios, size: 30.0, color: Colors.white),
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
                          color: Colors.black.withOpacity(0.3),
                          borderRadius: BorderRadius.circular(30.0),
                          border: Border.all(color: Colors.white.withOpacity(0.2)),
                        ),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Text(
                              'Tìm Kiếm Thành Phố',
                              style: TextStyle(
                                fontSize: 28.0,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                            const SizedBox(height: 30.0),
                            // Ô gõ chữ
                            TextField(
                              style: const TextStyle(color: Colors.black, fontSize: 18),
                              decoration: kTextFieldInputDecoration,
                              onChanged: (value) {
                                cityName = value; // Cập nhật biến cityName mỗi khi người dùng gõ
                              },
                            ),
                            const SizedBox(height: 30.0),
                            // Nút gửi đi
                            SizedBox(
                              width: double.infinity,
                              height: 55,
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.blueAccent,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(15.0),
                                  ),
                                  elevation: 5,
                                ),
                                onPressed: () {
                                  // Đóng màn hình này và trả về tên thành phố đã gõ
                                  Navigator.pop(context, cityName);
                                },
                                child: const Text('Lấy Thời Tiết', style: kButtonTextStyle),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
