// Return today's date formatted as yyyyMMdd
String todaysDateFormatted() {
  // Today
  var dateTimeObject = DateTime.now();

  // Year in the format yyyy
  String year = dateTimeObject.year.toString();

  // Month in the format mm
  String month = dateTimeObject.month.toString();
  if (month.length == 1) {
    month = '0$month';
  }

  // Day in the format dd
  String day = dateTimeObject.day.toString();
  if (day.length == 1) {
    day = '0$day';
  }

  // Final format
  String yyyymmdd = year + month + day;

  return yyyymmdd;
}

// Convert string yyyyMMdd to DateTime object
DateTime createDateTimeObject(String yyyymmdd) {
  int yyyy = int.parse(yyyymmdd.substring(0, 4));
  int mm = int.parse(yyyymmdd.substring(4, 6));
  int dd = int.parse(yyyymmdd.substring(6, 8));
  DateTime dateTimeObject=DateTime(yyyy, mm, dd);


  return dateTimeObject;
}

// Convert DateTime object to string yyyyMMdd
String convertDateTimeToString(DateTime dateTime) {
  // Year in the format yyyy
  String year = dateTime.year.toString();

  // Month in the format mm
  String month = dateTime.month.toString();
  if (month.length == 1) {
    month = '0$month';
  }

  // Day in the format dd
  String day = dateTime.day.toString();
  if (day.length == 1) {
    day = '0$day';
  }

  // Final format
  String yyyymmdd=year + month + day;
  return yyyymmdd;
}
