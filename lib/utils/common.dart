import 'package:http/http.dart';
import 'package:intl/intl.dart';

extension ApiRequestStatus on Response {
  bool isSuccess() {
    return statusCode == 200;
  }
}

class StringUtils {
  static String getStringValueOrDefault(String? data) {
    return data != null ? data.toString() : "";
  }

  static String convertVnCurrency(double value) {
    var result = NumberFormat.currency(locale: 'vi-VN', symbol: '₫').format(value);
    return result;
  }

  static String padLeftZero(int value, {int width = 2}) {
    var result = value.toString().padLeft(width, '0');
    return result;
  }
}

extension DateUtils on DateTime {
  String toDDMMYYYY() {
    final createdHour =
        "${day.toString().padLeft(2, '0')}/${month.toString().padLeft(2, '0')}/$year";
    return createdHour;
  }
}

extension StringExt on String {
  String getHourCreate() {
    if (isNotEmpty) {
      final datetime = DateTime.parse(this);
      final createdHour =
          "${datetime.hour.toString().padLeft(2, '0')} : ${datetime.minute.toString().padLeft(2, '0')}";
      return createdHour;
    }
    return '';
  }

  DateTime toDateTime() {
    if (isNotEmpty) {
      var dateParts = split('/').toList();
      final datetime = DateTime.utc(int.parse(dateParts[2]),
          int.parse(dateParts[1]), int.parse(dateParts[0]));
      return datetime;
    }
    return DateTime.now();
  }

  String toFormattedVNDateTime() {
    if (isNotEmpty) {
      final datetime = DateTime.parse(this);
      final createdDate =
          "${datetime.day.toString().padLeft(2, '0')}/${datetime.month.toString().padLeft(2, '0')}/${datetime.year}";
      return createdDate;
    }
    return '';
  }

  String getDateTimeCreate() {
    if (isNotEmpty) {
      final datetime = DateTime.parse(this);
      final createdDate =
          "${datetime.day.toString().padLeft(2, '0')}/${datetime.month.toString().padLeft(2, '0')}/${datetime.year}, ${datetime.hour.toString().padLeft(2, '0')}:${datetime.minute.toString().padLeft(2, '0')}";
      return createdDate;
    }
    return '';
  }
}

extension DynamicUtils on dynamic {
  String getStringValue() {
    if (this == null) {
      return "";
    }
    return toString();
  }

  int getIntValue() {
    if (this == null) return 0;
    return (this) as int;
  }

  double getDoubleValue(){
    if (this == null) return 0.0;
    return (this) as double;
  }
}
