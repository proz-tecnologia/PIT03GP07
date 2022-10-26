import 'dart:math';

abstract class RandomUtil {
  static DateTime generateRandomDate(DateTime startDate, int intervalDay) {
    var random = Random();
    Duration duration = Duration(
        days: random.nextInt(intervalDay),
        minutes: random.nextInt(Duration.minutesPerHour));
    return startDate.add(duration);
  }
}