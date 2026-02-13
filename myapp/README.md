
 Flutter To-Do List App
To-Do List App this is a simple, clean, and efficient mobile application built using Flutter.
The app allows users to manage daily tasks easily with a smooth and responsive user interface.

This project is designed for learning and practicing Flutter concepts such as:

Stateful widgets

State management using setState()

ListView and dynamic lists

Local data persistence

Clean UI structuring

✨ Features

➕ Add new tasks

✏️ Edit tasks

✅ Mark tasks as completed

🗑️ Delete tasks

💾 Save tasks locally (data persists after restart)

📱 Responsive and modern UI

🛠️ Built With

Flutter

Dart

Hive (Local Storage)

Material Design

📂 Folder Structure
lib/
│
├── main.dart
├── models/
│     └── task_model.dart
│
├── screens/
│     └── home_screen.dart
│
├── widgets/
│     └── task_tile.dart
│
└── services/
      └── task_storage.dart

📦 Dependencies

Add these dependencies inside your pubspec.yaml file:

dependencies:
  flutter:
    sdk: flutter
  hive: ^2.2.3
  hive_flutter: ^1.1.0
  path_provider: ^2.1.1


Then run:

flutter pub get

▶️ Installation & Running

1️⃣ Clone the repository:

git clone https://github.com/mwaitukasteven/group_9_todo_list_app.git


2️⃣ Navigate into the project directory:

cd taskflow


3️⃣ Install dependencies:

flutter pub get


4️⃣ Run the application:

flutter run

🎯 How It Works

Tasks are stored locally using Hive.

When a task is added, it is saved in local storage.

The UI updates instantly using setState().

Completed tasks are visually marked.

Data remains saved even after closing the app.

🚀 Future Enhancements

📅 Add due dates

🔔 Add notifications

🌙 Dark mode

☁️ Cloud sync with Firebase

📊 Task statistics dashboard
