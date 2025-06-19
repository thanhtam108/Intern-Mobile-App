import 'package:intl/intl.dart';

class DateTimeUtils {
  // Chuyển đổi DateTime thành chuỗi định dạng
  static String formatDate(DateTime date, {String format = 'yyyy-MM-dd'}) {
    return DateFormat(format).format(date);
  }

  // Tính toán khoảng thời gian (ví dụ: "2 ngày trước")
  static String timeAgo(DateTime date) {
    final duration = DateTime.now().difference(date);
    if (duration.inDays > 0) {
      return "${duration.inDays} ngày trước";
    } else if (duration.inHours > 0) {
      return "${duration.inHours} giờ trước";
    } else if (duration.inMinutes > 0) {
      return "${duration.inMinutes} phút trước";
    } else {
      return "Vừa xong";
    }
  }
}