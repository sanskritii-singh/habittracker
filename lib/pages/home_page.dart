import 'package:flutter/material.dart';
import 'package:habittracker/components/habit_tile.dart';
import 'package:habittracker/components/monthly_summary.dart';
import 'package:habittracker/components/my_fab.dart';
import 'package:habittracker/components/my_alert_box.dart';
import 'package:habittracker/data/habit_database.dart';
import 'package:hive/hive.dart';
class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  HabitDatabase db = HabitDatabase();
  final _myBox= Hive.box("habit_database");

  @override
  void initState(){
    super.initState();
    if(_myBox.get("Current_Habit_List")==null) {
      db.createDefaultBox();

    }
    else{
      db.loadData();
    }
    db.updateDatabase();

    // super.initState();
  }
//checkbox was tapped
void checkBoxTapped(bool? value, int index) {
  setState(() {
    db.todaysHabitList[index][1] = value;
  });
  db.updateDatabase(); // Ensure the heatmap dataset is updated
}

//create new habit
final _newHabitNameController = TextEditingController();
void createNewHabit() {
  showDialog(
    context: context,
    builder: (context) {
      return MyAlertBox(
        controller: _newHabitNameController,
        hintText: 'Enter Habit Name',
        onSave: saveNewHabit,
        onCancel: cancelDialogBox,
      );
    },
  );
}
void saveNewHabit(){
  setState(() {
    db.todaysHabitList.add([_newHabitNameController.text,false]);
  });
  
  _newHabitNameController.clear();
  Navigator.of(context).pop();
  db.updateDatabase();
}

void cancelDialogBox(){
  _newHabitNameController.clear();
  Navigator.of(context).pop();
}
void openHabitSettings(int index){
  showDialog(context: context, builder: (context){
    return MyAlertBox(controller: _newHabitNameController,
    hintText:db.todaysHabitList[index][0] , onSave: ()=> saveExistingHabit(index), onCancel: cancelDialogBox);
  });
}
void saveExistingHabit(int index){
  setState(() {
    db.todaysHabitList[index][0] =_newHabitNameController.text;
  });
  _newHabitNameController.clear();

  Navigator.pop(context);
  db.updateDatabase();
}
void deleteHabit(int index){
  setState(() {
    db.todaysHabitList.removeAt(index);
  });
  db.updateDatabase();

}
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      floatingActionButton: MyfloatingActionButton(onPressed:createNewHabit ,),
      body: ListView(
        children: [
          MonthlySummary(datasets: db.heatMapDataSet, startDate: _myBox.get("Start_date")),
          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: db.todaysHabitList.length,
            itemBuilder: (context, index) {
            return HabitTile(habitName: db.todaysHabitList[index][0], habitCompleted: db.todaysHabitList[index][1], onChanged:(value) =>checkBoxTapped(value, index),
            settingsTapped: (context) =>openHabitSettings(index),
            deleteTapped:(context)=> deleteHabit(index) ,);
      },
        
      )
        ],


      ),
    );
  }
}