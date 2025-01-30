import 'package:flutter/material.dart';
import 'package:flutter_heatmap_calendar/flutter_heatmap_calendar.dart';
// import 'package:habittracker/datetime/date_time.dart';

class MonthlySummary extends StatelessWidget {
  final Map<DateTime, int>? datasets;
  final String startDate;

  const MonthlySummary({
    super.key,
    required this.datasets,
    required this.startDate,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 25, bottom: 25),
      child: HeatMap(
        startDate: createDateTimeObject(startDate),
        endDate: DateTime.now().add(Duration(days: 0)),
        datasets: datasets,
        colorMode: ColorMode.color,
        defaultColor: Colors.grey[200],
        textColor: Colors.white,
        showColorTip: false,
        showText: true,
        scrollable: true,
        size: 30,
        colorsets: const {
          1: Color.fromARGB(20, 238, 108, 77),
          3: Color.fromARGB(40, 238, 108, 77),
          5: Color.fromARGB(60, 238, 108, 77),
          7: Color.fromARGB(80, 238, 108, 77),
          9: Color.fromARGB(100, 238, 108, 77),
        },
      ),
    );
  }

  DateTime createDateTimeObject(String date) {
    // Add your implementation for creating a DateTime object from the string
    // Example:
    return DateTime.parse(date);
  }
}
