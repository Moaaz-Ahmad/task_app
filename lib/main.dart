import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_app/providers/task_bloc.dart';
import 'package:task_app/providers/task_repository.dart';
import 'package:task_app/screens/task_manager_screen.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});
  final TaskRepository taskRepository = TaskRepository();

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => TaskBloc(taskRepository),
        ),
      ],
      child: MaterialApp(
        title: 'Task App',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const TaskManagerScreen(),
      ),
    );
  }
}
