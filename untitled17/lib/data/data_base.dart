import 'package:hive/hive.dart';

class ToDoDataBase {
  List toDoList = [];

  final Box myBox = Hive.box('mybox');

  void createInitialData() {
    if (myBox.get('TODOLIST') == null) {
      toDoList = [
        ['Sample Task 1', false],
        ['Sample Task 2', false],
      ];
      updateDataBase();
    } else {
      loadData();
    }
  }

  void loadData() {
    toDoList = myBox.get('TODOLIST') ?? [];
  }

  void updateDataBase() {
    myBox.put('TODOLIST', toDoList);
  }
}
