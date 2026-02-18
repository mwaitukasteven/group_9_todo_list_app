import '../models/task_model.dart';

class TaskService {
  static final List<Task> _tasks = [
    Task(title: "Complete Flutter Assignment"),
    Task(title: "Read Hive Documentation"),
    Task(title: "Design App UI"),
    Task(title: "Test Application"),
    Task(title: "Push Project to GitHub"),
  ];

  static List<Task> getTasks() {
    return _tasks;
  }

  static Future<void> addTask(Task task) async {
    _tasks.add(task);
  }

  static void deleteTask(Task task) {
    _tasks.remove(task);
  }

  static void toggleTask(Task task) {
    task.isCompleted = !task.isCompleted;
  }
}
