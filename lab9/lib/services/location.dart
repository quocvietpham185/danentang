import 'package:geolocator/geolocator.dart';

class Location {
  double? latitude;
  double? longitude;

  // Từ khóa 'Future' cho biết hàm này sẽ cần một khoảng thời gian để hoàn thành
  Future<void> getCurrentLocation() async {
    try {
      // Yêu cầu quyền truy cập vị trí trước
      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          print("Quyền vị trí bị từ chối");
          return;
        }
      }

      // Lấy tọa độ (cấu hình độ chính xác thấp để lấy nhanh hơn)
      Position position = await Geolocator.getCurrentPosition(
        locationSettings: const LocationSettings(
          accuracy: LocationAccuracy.low,
        ),
      );

      latitude = position.latitude;
      longitude = position.longitude;
    } catch (e) {
      print(e);
    }
  }
}
