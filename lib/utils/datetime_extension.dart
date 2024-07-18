import 'package:festivals_exam_4/data/models/festival_model.dart';

extension DateTimeExtension on List<dynamic> {
  DateTime toDateTime() {
    if (this.length != 5) {
      throw ArgumentError(
          'List must contain exactly 5 elements: [year, month, day, hour, minute]');
    }

    return DateTime(
      int.parse(this[0]),
      int.parse(this[1]),
      int.parse(this[2]),
      int.parse(this[3]),
      int.parse(
        this[4],
      ),
    );
  }

}


extension DateExtensions on DateTime {
  bool isWithinNext7Days() {
    // Get the current date
    DateTime currentDate = DateTime.now();

    // Calculate the date 7 days from now
    DateTime sevenDaysFromNow = currentDate.add(Duration(days: 7));

    // Check if this date is within the next 7 days
    return this.isAfter(currentDate) && this.isBefore(sevenDaysFromNow);
  }
}

// extension FestivalExtension on List<FestivalModel> {
//   List<FestivalModel> getFestivalsOfPrevious7Days() {
//     DateTime now = DateTime.now();
//     DateTime sevenDaysAgo = now.subtract(Duration(days: 7));

//     return this.where((festival) =>
//       festival.date.isAfter(sevenDaysAgo) && festival.date.isBefore(now)).toList();
//   }
// }


extension DateTimeFormatter on DateTime {
  String formatDateWithWeekday() {
    // Define weekdays and months for formatting
    List<String> weekdays = ['Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday', 'Sunday'];
    List<String> months = ['January', 'February', 'March', 'April', 'May', 'June', 'July', 'August', 'September', 'October', 'November', 'December'];

    // Extract components from DateTime
    int day = this.day;
    int weekdayIndex = this.weekday - 1; // Dart's weekday starts from Sunday (1) to Saturday (7)
    String weekday = weekdays[weekdayIndex];
    int year = this.year;
    int monthIndex = this.month - 1; // Dart's month starts from January (1) to December (12)
    String month = months[monthIndex];

    // Format into desired string
    return '$weekday, $month $day, $year';
  }
}


void main(List<String> args) {}
