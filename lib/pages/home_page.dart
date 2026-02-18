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
        title: const Text("Welcome to task manager"),
        backgroundColor: Colors.blue,
      ),
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          children: [

          
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: () async {
                      await Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const AddTaskPage(),
                        ),
                      );
                      loadTasks();
                    },
                    child: const Text("Add Task"),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () async {
                      await Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const ViewTasksPage(),
                        ),
                      );
                      loadTasks();
                    },
                    child: const Text("View All Tasks"),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 15),

            Expanded(
              child: pendingTasks.isEmpty
                  ? const Center(
                      child: Text(
                        "No pending tasks",
                        style: TextStyle(fontSize: 16),
                      ),
                    )
                  : ListView.builder(
                      itemCount: pendingTasks.length,
                      itemBuilder: (context, index) {
                        final task = pendingTasks[index];
                        return Card(
                          child: ListTile(
                            title: Text(
                              task.title,
                              style: const TextStyle(fontSize: 16),
                            ),
                          ),
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
