import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:untitled17/data/data_base.dart';
import 'package:untitled17/util/diolog_box.dart';
import 'package:untitled17/util/todo_tile.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  final mybox = Hive.box('mybox');

  ToDoDataBase db = ToDoDataBase();

  final TextEditingController controller = TextEditingController();

  @override
  void initState() {
    super.initState();

    if (mybox.get('TODOLİST') == null) {
      db.createInitialData();
    } else {
      db.loadData();
    }
  }

  void checkBoxChanged(bool value, int index) {
    setState(() {
      db.toDoList[index][1] = !db.toDoList[index][1];
    });
    db.updateDataBase();
  }

  void saveNewTask() {
    if (controller.text.isNotEmpty) {
      setState(() {
        db.toDoList.add([controller.text, false]);
        controller.clear();
      });
      db.updateDataBase();
    }
    Navigator.of(context).pop();
  }


  void createNewTask() {
    showDialog(
      context: context,
      builder: (context) {
        return DiologBox(
          controller: controller,
          onCancel: () => Navigator.of(context).pop(),
          onSave: saveNewTask,
        );
      },
    );
  }

  void deleteTask(int index) {
    setState(() {
      db.toDoList.removeAt(index);
    });
    db.updateDataBase();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.yellow[200],
      appBar: AppBar(
        backgroundColor: Colors.yellow[400],
        title: const Text(
          'To-Do List',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        elevation: 0,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: createNewTask,
        backgroundColor: Colors.yellow[600],
        child: const Icon(Icons.add, color: Colors.black),
      ),
      body: db.toDoList.isEmpty
          ? Center(
        child: Text(
          'No tasks yet! Tap + to add a task.',
          style: TextStyle(color: Colors.grey[700], fontSize: 16),
        ),
      )
          : ListView.builder(
        itemCount: db.toDoList.length,
        itemBuilder: (context, index) {
          return TodoTile(
            taskName: db.toDoList[index][0],
            taskCompleted: db.toDoList[index][1],
            onChanged: (value) => checkBoxChanged(value!, index),
            deleteFunction: (context) => deleteTask(index),
          );
        },
      ),
    );
  }
}
