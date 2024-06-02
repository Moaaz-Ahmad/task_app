import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:task_app/models/task.dart';
import 'package:task_app/providers/task_repository.dart';

part 'task_event.dart';
part 'task_state.dart';

class TaskBloc extends Bloc<TaskEvent, TaskState> {
  final TaskRepository taskRepository;

  TaskBloc(this.taskRepository) : super(TaskLoading()) {
    on<LoadTasks>(_onLoadTasks);
    on<AddTask>(_onAddTask);
    on<UpdateTask>(_onUpdateTask);
    on<DeleteTask>(_onDeleteTask);
    on<TasksUpdated>(_onTasksUpdated);
  }

  void _onLoadTasks(LoadTasks event, Emitter<TaskState> emit) {
    taskRepository.getTasks().listen((tasks) {
      add(TasksUpdated(tasks));
    });
  }

  void _onAddTask(AddTask event, Emitter<TaskState> emit) async {
    await taskRepository.addTask(event.task);
  }

  void _onUpdateTask(UpdateTask event, Emitter<TaskState> emit) async {
    await taskRepository.updateTask(event.task);
  }

  void _onDeleteTask(DeleteTask event, Emitter<TaskState> emit) async {
    await taskRepository.deleteTask(event.taskId);
  }

  void _onTasksUpdated(TasksUpdated event, Emitter<TaskState> emit) {
    emit(TaskLoaded(event.tasks));
  }
}
