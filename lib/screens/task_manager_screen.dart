import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:task_app/models/task.dart';
import 'package:task_app/providers/task_bloc.dart';

class TaskManagerScreen extends StatefulWidget {
  const TaskManagerScreen({super.key});

  @override
  State<TaskManagerScreen> createState() => _TaskManagerScreenState();
}

enum TaskFilter { all, notDone, done }

class _TaskManagerScreenState extends State<TaskManagerScreen> {
  TaskFilter currentFilter = TaskFilter.all;

  List<Task> get filteredTasks {
    final state = context.watch<TaskBloc>().state;
    if (state is TaskLoaded) {
      switch (currentFilter) {
        case TaskFilter.notDone:
          return state.tasks.where((task) => !task.isDone).toList();
        case TaskFilter.done:
          return state.tasks.where((task) => task.isDone).toList();
        default:
          return state.tasks;
      }
    }
    return [];
  }

  @override
  void initState() {
    super.initState();
    context.read<TaskBloc>().add(LoadTasks());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Task Manager'),
        backgroundColor: Platform.isAndroid ? Colors.blue : Colors.white,
        foregroundColor: Platform.isAndroid ? Colors.white : Colors.black,
        elevation: Platform.isAndroid ? 4 : 0,
      ),
      body: BlocBuilder<TaskBloc, TaskState>(
        builder: (context, state) {
          if (state is TaskLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is TaskLoaded) {
            return Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    children: TaskFilter.values.map((filter) {
                      return Expanded(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 5.0),
                          child: ElevatedButton(
                            onPressed: () => setState(() => currentFilter = filter),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: currentFilter == filter ? Colors.green : Colors.grey,
                            ),
                            child: Text(filter == TaskFilter.all
                                ? 'All'
                                : filter == TaskFilter.notDone
                                    ? 'Not Done'
                                    : 'Done'),
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                ),
                Expanded(
                  child: filteredTasks.isEmpty
                      ? const Center(
                          child: Padding(
                            padding: EdgeInsets.all(16.0),
                            child: Text('No tasks to display'),
                          ),
                        )
                      : ListView.builder(
                          itemCount: filteredTasks.length,
                          itemBuilder: (context, index) {
                            final task = filteredTasks[index];
                            return Slidable(
                              key: Key(task.id),
                              endActionPane: ActionPane(
                                motion: const ScrollMotion(),
                                dismissible: DismissiblePane(onDismissed: () {
                                  context.read<TaskBloc>().add(DeleteTask(task.id));
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: const Text('Task deleted'),
                                      action: SnackBarAction(
                                        label: 'Undo',
                                        onPressed: () {
                                          context.read<TaskBloc>().add(AddTask(task));
                                        },
                                      ),
                                    ),
                                  );
                                }),
                                children: [
                                  SlidableAction(
                                    onPressed: (_) {
                                      context.read<TaskBloc>().add(DeleteTask(task.id));
                                      ScaffoldMessenger.of(context).showSnackBar(
                                        SnackBar(
                                          content: const Text('Task deleted'),
                                          action: SnackBarAction(
                                            label: 'Undo',
                                            onPressed: () {
                                              context.read<TaskBloc>().add(AddTask(task));
                                            },
                                          ),
                                        ),
                                      );
                                    },
                                    backgroundColor: const Color(0xFFFE4A49),
                                    foregroundColor: Colors.white,
                                    icon: Icons.delete,
                                    label: 'Delete',
                                  ),
                                ],
                              ),
                              child: Card(
                                margin: const EdgeInsets.all(10),
                                color: task.isDone ? Colors.green[50] : null,
                                child: ListTile(
                                  title: Text(
                                    task.title,
                                    style: TextStyle(
                                      decoration: task.isDone ? TextDecoration.lineThrough : null,
                                    ),
                                  ),
                                  subtitle: Text('Due Date: ${task.dueDate.toLocal().toShortDateString()}'),
                                  trailing: IconButton(
                                    icon: Icon(
                                      task.isDone ? Icons.check_box : Icons.check_box_outline_blank,
                                      color: task.isDone ? Colors.green : null,
                                    ),
                                    onPressed: () {
                                      context.read<TaskBloc>().add(UpdateTask(task.copyWith(isDone: !task.isDone)));
                                    },
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                ),
              ],
            );
          } else {
            return const Center(child: Text('Failed to load tasks'));
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) {
              String title = '';
              DateTime dueDate = DateTime.now();
              return AlertDialog(
                title: const Text('Create New Task'),
                content: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TextField(
                      decoration: const InputDecoration(labelText: 'Task Title'),
                      onChanged: (value) => title = value,
                    ),
                    const SizedBox(height: 10),
                    InputDatePickerFormField(
                      firstDate: DateTime.now(),
                      lastDate: DateTime(2025),
                      initialDate: DateTime.now(),
                      onDateSaved: (value) => dueDate = value,
                    ),
                  ],
                ),
                actions: [
                  TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: const Text('Cancel'),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      if (title.isNotEmpty) {
                        final newTask = Task(
                          id: DateTime.now().toString(), // Unique ID for the task
                          title: title,
                          isDone: false,
                          dueDate: dueDate,
                        );
                        context.read<TaskBloc>().add(AddTask(newTask));
                        Navigator.pop(context);
                      }
                    },
                    style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
                    child: const Text('Save Task'),
                  ),
                ],
              );
            },
          );
        },
        backgroundColor: Colors.green,
        child: Icon(Platform.isAndroid ? Icons.add : Icons.add_box_outlined),
      ),
    );
  }
}

extension DateTimeExtension on DateTime {
  String toShortDateString() {
    return "$year-$month-$day";
  }
}
