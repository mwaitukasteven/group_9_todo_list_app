import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/task.dart';

class ViewTasksPage extends StatefulWidget {
  const ViewTasksPage({super.key});

  @override
  State<ViewTasksPage> createState() => _ViewTasksPageState();
}

class _ViewTasksPageState extends State<ViewTasksPage> {
  List<Task> tasks = [];

  @override
  void initState() {
    super.initState();
    loadTasks();
  }

  Future<void> loadTasks() async {
    final prefs = await SharedPreferences.getInstance();
    final data = prefs.getString("tasks");

    if (data != null) {
      final decoded = jsonDecode(data);
      tasks = decoded.map<Task>((e) => Task.fromJson(e)).toList();
    }
    setState(() {});
  }

  Future<void> saveTasks() async {
    final prefs = await SharedPreferences.getInstance();
    final encoded =
        jsonEncode(tasks.map((task) => task.toJson()).toList());
    await prefs.setString("tasks", encoded);
  }

  void toggleTask(int index) {
    tasks[index].isCompleted = !tasks[index].isCompleted;
    saveTasks();
    setState(() {});
  }

  void deleteTask(int index) {
    tasks.removeAt(index);
    saveTasks();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("View Tasks"),
        backgroundColor: Color.fromARGB(255, 105, 127, 165),
      ),
      body: ListView.builder(
        itemCount: tasks.length,
        itemBuilder: (_, index) {
          return ListTile(
            leading: Checkbox(
              value: tasks[index].isCompleted,
              onChanged: (_) => toggleTask(index),
            ),
            title: Text(
              tasks[index].title,
              style: TextStyle(
                decoration: tasks[index].isCompleted
                    ? TextDecoration.lineThrough
                    : null,
              ),
            ),
            trailing: IconButton(
              icon: const Icon(Icons.delete, color: Colors.red),
              onPressed: () => deleteTask(index),
            ),
          );
        },
      ),
    );
  }
}
