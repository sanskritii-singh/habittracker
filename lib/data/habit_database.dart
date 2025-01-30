
import 'package:habittracker/datetime/date_time.dart';
import 'package:hive_flutter/hive_flutter.dart';

final _myBox = Hive.box("habit_database");

class HabitDatabase {
  List todaysHabitList = [];
  Map<DateTime, int> heatMapDataSet = {};

  void createDefaultBox() {
    if (_myBox.get("Start_Date") == null) {
      todaysHabitList = [
        ["Run", false],
        ["Read", false],
      ];
      _myBox.put("Start_Date", todaysDateFormatted());
    }
  }

  void loadData() {
  // Safely retrieve today's habit list
  var data = _myBox.get(todaysDateFormatted());
  if (data != null && data is List) {
    todaysHabitList = data;
  } else {
    // Default to current habit list or empty
    todaysHabitList = _myBox.get("Current_Habit_List")?.map((e) => [e[0], false]).toList() ?? [];
  }
}

  void updateDatabase() {
    _myBox.put(todaysDateFormatted(), todaysHabitList);
    _myBox.put("Current_Habit_List", todaysHabitList);
    calculateHabitPercentages();
    loadHeatMap();
  }

  void calculateHabitPercentages(){
    int countCompleted=0;
    for(int i=0;i<todaysHabitList.length;i++){
      if(todaysHabitList[i][1]==true){
        countCompleted++;
      }
    }
  String percent=todaysHabitList.isEmpty?'0.0'
     :(countCompleted/todaysHabitList.length).toStringAsFixed(1);
     _myBox.put("PERCENTAGE_SUMMARY_${todaysDateFormatted()}", percent);
   }
  void loadHeatMap() {
  DateTime startDate = createDateTimeObject(_myBox.get("Start_Date") ?? todaysDateFormatted());
  int daysInBetween = DateTime.now().difference(startDate).inDays;

  for (int i = 0; i < daysInBetween + 1; i++) {
    String yyyyMMdd = convertDateTimeToString(startDate.add(Duration(days: i)));

    double strengthAsPercent = double.parse(
      _myBox.get("PERCENTAGE_SUMMARY_$yyyyMMdd")?.toString() ?? "0.0"
    );

    int year = startDate.add(Duration(days: i)).year;
    int month = startDate.add(Duration(days: i)).month;
    int day = startDate.add(Duration(days: i)).day;

    heatMapDataSet[DateTime(year, month, day)] = (10 * strengthAsPercent).toInt();
  }
}
}