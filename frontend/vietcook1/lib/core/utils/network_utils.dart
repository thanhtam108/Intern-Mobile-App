import 'package:connectivity_plus/connectivity_plus.dart';

class NetworkUtils {
  // Kiểm tra trạng thái kết nối mạng
  static Future<bool> isConnected() async {
    var connectivityResult = await Connectivity().checkConnectivity();
    return connectivityResult != ConnectivityResult.none;
  }

  // Xử lý lỗi mạng
  static String handleNetworkError(int statusCode) {
    switch (statusCode) {
      case 400:
        return "Yêu cầu không hợp lệ.";
      case 401:
        return "Không có quyền truy cập.";
      case 404:
        return "Không tìm thấy tài nguyên.";
      case 500:
        return "Lỗi máy chủ.";
      default:
        return "Lỗi không xác định.";
    }
  }
}