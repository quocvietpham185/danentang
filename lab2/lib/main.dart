import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: const Color.fromARGB(
          255,
          52,
          56,
          58,
        ), // Màu nền của toàn bộ màn hình
        body: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // 1. Ảnh đại diện
              const CircleAvatar(
                radius: 50.0,
                // Lấy tạm ảnh đại diện từ GitHub của bạn để hiển thị
                backgroundImage: AssetImage('images/kinh.jpg'),
              ),

              // 2. Tên
              const Text(
                'Phạm Quốc Việt',
                style: TextStyle(
                  fontSize: 30.0,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),

              // 3. Vị trí/Nghề nghiệp
              Text(
                'WEB DEVELOPER INTERN',
                style: TextStyle(
                  fontSize: 16.0,
                  color: Colors.teal.shade100,
                  letterSpacing: 2.5, // Khoảng cách giữa các chữ cái
                  fontWeight: FontWeight.bold,
                ),
              ),

              // 4. Đường kẻ ngang trang trí
              SizedBox(
                height: 20.0,
                width: 150.0,
                child: Divider(color: Colors.teal.shade100),
              ),

              // 5. Thẻ thông tin Số điện thoại
              Card(
                margin: const EdgeInsets.symmetric(
                  vertical: 10.0,
                  horizontal: 25.0,
                ),
                child: ListTile(
                  leading: const Icon(Icons.phone, color: Colors.teal),
                  title: Text(
                    '+84 123 456 789',
                    style: TextStyle(
                      color: Colors.teal.shade900,
                      fontSize: 18.0,
                    ),
                  ),
                ),
              ),

              // 6. Thẻ thông tin Email
              Card(
                margin: const EdgeInsets.symmetric(
                  vertical: 10.0,
                  horizontal: 25.0,
                ),
                child: ListTile(
                  leading: const Icon(Icons.email, color: Colors.teal),
                  title: Text(
                    'viet@example.com',
                    style: TextStyle(
                      color: Colors.teal.shade900,
                      fontSize: 18.0,
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
