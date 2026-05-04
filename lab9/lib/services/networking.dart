import 'package:http/http.dart' as http;
import 'dart:convert'; // Thư viện giải mã JSON có sẵn của Dart

class NetworkHelper {
  NetworkHelper(this.url);

  final String url;

  // Lấy dữ liệu từ API
  Future<dynamic> getData() async {
    http.Response response = await http.get(Uri.parse(url));

    // Mã 200 nghĩa là OK (thành công)
    if (response.statusCode == 200) {
      String data = response.body;
      return jsonDecode(
        data,
      ); // Dịch chuỗi String thành kiểu Map/List trong Dart
    } else {
      print(response.statusCode);
      return null;
    }
  }
}
