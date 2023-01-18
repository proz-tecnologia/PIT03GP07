extension DateTimeExtension on DateTime {
  String get toBRLDate {
    return "$day/$month/$year";
  }
}
