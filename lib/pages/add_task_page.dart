import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/task.dart';

class AddTaskPage extends StatefulWidget {
  const AddTaskPage({super.key});

  @override
  State<AddTaskPage> createState() => _AddTaskPageState();
}

class _AddTaskPageState extends State<AddTaskPage> {
  final controller = TextEditingController();
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
    } else {
      tasks = [
        Task(title: "Buy groceries"),
        Task(title: "Finish homework"),
        Task(title: "Workout"),
        Task(title: "Read book"),
        Task(title: "Call friend"),
      ];
      saveTasks();
    }
  }

  Future<void> saveTasks() async {
    final prefs = await SharedPreferences.getInstance();
    final encoded =
        jsonEncode(tasks.map((task) => task.toJson()).toList());
    await prefs.setString("tasks", encoded);
  }

  void addTask() {
    if (controller.text.isEmpty) return;

    tasks.add(Task(title: controller.text));
    controller.clear();
    saveTasks();

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("Task Added")),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add Task"),
        backgroundColor: Colors.green,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            TextField(
              controller: controller,
              decoration: const InputDecoration(
                hintText: "Enter task title",
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: addTask,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
                minimumSize: const Size.fromHeight(50),
              ),
              child: const Text("Save Task"),
            ),
          ],
        ),
      ),
    );
  }
}
