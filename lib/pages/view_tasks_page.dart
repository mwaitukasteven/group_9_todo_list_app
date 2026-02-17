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

  void loadTasks() {
    setState(() {
      tasks = TaskService.getTasks();
    });
  }

  @override
  void initState() {
    super.initState();
    loadTasks();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("All Tasks"),
        backgroundColor: Colors.blueGrey,
      ),
      body: ListView.builder(
        itemCount: tasks.length,
        itemBuilder: (context, index) {
          final task = tasks[index];
          return Card(
            margin: const EdgeInsets.all(10),
            color: task.isCompleted ? Colors.grey[300] : Colors.white,
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
                onChanged: (value) async {
                  task.isCompleted = value!;
                  await TaskService.updateTask(index, task);
                  loadTasks();
                },
              ),
              trailing: IconButton(
                icon: const Icon(Icons.delete, color: Colors.red),
                onPressed: () async {
                  await TaskService.deleteTask(index);
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
