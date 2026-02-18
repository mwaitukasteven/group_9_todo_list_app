import 'package:flutter/material.dart';
import '../models/task_model.dart';
import '../services/task_service.dart';

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

  void loadTasks() {
    setState(() {
      tasks = TaskService.getTasks();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("All Tasks")),
      body: ListView.builder(
        itemCount: tasks.length,
        itemBuilder: (context, index) {
          final task = tasks[index];
          return Card(
            child: ListTile(
              title: Text(
                task.title,
                style: TextStyle(
                  decoration: task.isCompleted
                      ? TextDecoration.lineThrough
                      : null,
                ),
              ),
              leading: Checkbox(
                value: task.isCompleted,
                onChanged: (_) {
                  TaskService.toggleTask(task);
                  loadTasks();
                },
              ),
              trailing: IconButton(
                icon: const Icon(Icons.delete, color: Colors.red),
                onPressed: () {
                  TaskService.deleteTask(task);
                  loadTasks();
                },
              ),
            ),
          );
        },
      ),
    );
  }
}
