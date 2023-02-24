// ignore_for_file: depend_on_referenced_packages

import 'package:bloc/bloc.dart';
import 'package:to_do/cubit/tasks_satate.dart';
import '../models/task_model.dart';

class TaskCubit extends Cubit<TaskState> {
  // state management tool
  TaskCubit() : super(TaskState());

  String title = "ToDo";

  List<TaskModel> tasks = [];

  void addTask(TaskModel task) {
    tasks.add(task);
    emit(TaskAddedState());
  }

  void changeTitle() {
    title = "New Title";
    emit(TitleAddedState());
  }
}
