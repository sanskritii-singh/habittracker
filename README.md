# Habit Tracker App

This is a Flutter-based **Habit Tracker App** designed to help users monitor daily habits, track progress over time, and visualize performance using a heatmap. The app uses the **Hive** database for efficient local storage of habit data.

---

## Features

- **Daily Habit List**
  - Add, complete, and manage daily habits with ease.

- **Progress Tracking**
  - Automatically calculate the percentage of completed habits daily.

- **Heatmap Visualization**
  - View your habit completion trends over time with a dynamic heatmap.

- **Local Data Persistence**
  - Data is stored locally using Hive, ensuring quick access and offline availability.

---

## Key Functionalities

### 1. **Default Habit Setup**
The app initializes with default habits if it's the first time the app is being used:
```dart
void createDefaultBox() {
  if (_myBox.get("Start_Date") == null) {
    todaysHabitList = [
      ["Run", false],
      ["Read", false],
    ];
    _myBox.put("Start_Date", todaysDateFormatted());
  }
}
```

### 2. **Daily Habit Loading**
The app ensures the daily habit list is refreshed and loaded correctly:
```dart
void loadData() {
  var data = _myBox.get(todaysDateFormatted());
  if (data != null && data is List) {
    todaysHabitList = data;
  } else {
    todaysHabitList = _myBox.get("Current_Habit_List")?.map((e) => [e[0], false]).toList() ?? [];
  }
}
```

### 3. **Heatmap Data Calculation**
The app dynamically calculates the percentage of habits completed daily and updates the heatmap:
```dart
void loadHeatMap() {
  DateTime startDate = createDateTimeObject(_myBox.get("Start_Date") ?? todaysDateFormatted());
  int daysInBetween = DateTime.now().difference(startDate).inDays;

  for (int i = 0; i < daysInBetween + 1; i++) {
    String yyyyMMdd = convertDateTimeToString(startDate.add(Duration(days: i)));

    double strengthAsPercent = double.parse(
      _myBox.get("PERCENTAGE_SUMMARY_$yyyyMMdd")?.toString() ?? "0.0"
    );

    heatMapDataSet[DateTime(
      startDate.add(Duration(days: i)).year,
      startDate.add(Duration(days: i)).month,
      startDate.add(Duration(days: i)).day
    )] = (10 * strengthAsPercent).toInt();
  }
}
```

---

## Setup and Installation

### Prerequisites
- **Flutter SDK** installed ([installation guide](https://flutter.dev/docs/get-started/install)).
- **Hive** and **Hive Flutter** packages included in your project dependencies.

### Steps
1. Clone the repository:
   ```bash
   git clone https://github.com/your-username/habit-tracker.git
   cd habit-tracker
   ```

2. Install dependencies:
   ```bash
   flutter pub get
   ```

3. Run the app:
   ```bash
   flutter run
   ```

---

## Folder Structure
```
lib/
├── main.dart                # App entry point
├── datetime/
│   └── date_time.dart       # Helper functions for date formatting
├── database/
│   └── habit_database.dart  # Core database logic for habits
├── ui/
│   └── heatmap.dart         # UI for displaying the heatmap
├── widgets/
│   └── habit_tile.dart      # Custom widget for habit items
```

---

## Dependencies
The app relies on the following dependencies:

- [**hive_flutter**](https://pub.dev/packages/hive_flutter): Lightweight and blazing fast key-value database.
- [**flutter**](https://flutter.dev/): UI toolkit for building beautiful, natively compiled applications.

Add them to your `pubspec.yaml` file:
```yaml
dependencies:
  flutter:
    sdk: flutter
  hive_flutter: ^1.1.0
```

---

## Known Issues
- The app may throw a **`type 'Null' is not a subtype of type 'String'`** error if Hive keys are not properly initialized. Make sure to use the `createDefaultBox()` method during app startup to avoid this issue.
- Debugging tips:
  - Use the `debugDatabase()` method to inspect Hive data values.

---

## Contribution
Contributions are welcome! Feel free to open issues or submit pull requests.

### Steps to Contribute
1. Fork the repository.
2. Create a new branch for your feature/fix:
   ```bash
   git checkout -b feature-name
   ```
3. Commit your changes and push:
   ```bash
   git commit -m "Added a new feature"
   git push origin feature-name
   ```
4. Open a pull request and describe your changes.

---

## License
This project is licensed under the MIT License. See the `LICENSE` file for details.



