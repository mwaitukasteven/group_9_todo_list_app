import 'package:flutter/material.dart';
import '../models/task_model.dart';
import '../services/task_service.dart';
import 'add_task_page.dart';
import 'view_tasks_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Task> tasks = [];

  @override
  void initState() {
    super.initState();
    loadTasks();
  }

  void loadTasks() {
    setState(() {
      tasks = TaskService.getTasks();
    });
  }

  @override
  Widget build(BuildContext context) {
    final pendingTasks =
        tasks.where((task) => task.isCompleted == false).toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text("Pending Tasks"),
        backgroundColor: Colors.blue,
      ),
      body: ListView.builder(
        itemCount: pendingTasks.length,
        itemBuilder: (context, index) {
          final task = pendingTasks[index];
          return Card(
            child: ListTile(
              title: Text(task.title),
              trailing: Checkbox(
                value: task.isCompleted,
                onChanged: (_) {
                  TaskService.toggleTask(task);
                  loadTasks();
                },
              ),
            ),
          );
        },
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ElevatedButton(
              onPressed: () async {
                await Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const AddTaskPage()),
                );
                loadTasks();
              },
              child: const Text("Add Task"),
            ),
            const SizedBox(height: 8),
            ElevatedButton(
              onPressed: () async {
                await Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const ViewTasksPage()),
                );
                loadTasks();
              },
              child: const Text("View All Tasks"),
            ),
          ],
        ),
      ),
    );
  }
}
