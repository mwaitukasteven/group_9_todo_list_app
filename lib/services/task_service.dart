import 'package:hive_flutter/hive_flutter.dart';
import '../models/task_model.dart';

class TaskService {
  static const String boxName = "tasksBox";

  static Future<void> init() async {
    await Hive.initFlutter();
    await Hive.openBox(boxName);
  }

  static Box get _box => Hive.box(boxName);

  static List<Task> getTasks() {
    final data = _box.values.toList();
    return data.map((e) => Task.fromMap(Map<String, dynamic>.from(e))).toList();
  }

  static Future<void> addTask(Task task) async {
    await _box.add(task.toMap());
  }

  static Future<void> deleteTask(int index) async {
    await _box.deleteAt(index);
  }

  static Future<void> updateTask(int index, Task task) async {
    await _box.putAt(index, task.toMap());
  }
}
