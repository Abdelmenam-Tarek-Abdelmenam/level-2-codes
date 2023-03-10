// ignore_for_file: depend_on_referenced_packages

import 'package:bloc/bloc.dart';
import 'package:to_do/cubit/tasks_satate.dart';
import '../models/task_model.dart';
import 'package:sqflite/sqflite.dart';

class TaskCubit extends Cubit<TaskState> {
  // state management tool
  TaskCubit() : super(TaskState());

  late Database _database;

  String title = "ToDo";

  List<TaskModel> tasks = [];

  void deleteTask(String id) {
    _database.delete("Tasks", where: "id=$id");
    tasks.removeWhere((element) => element.id == id);
    emit(TaskDeleteDone());
  }

  void updateTask(String id, bool value) {
    _database
        .update("Tasks", {"isDone": value ? 1 : 0}, where: "id=$id")
        .then((value) {
      print("I finished");
    }); // Future (Async function) 1 sec

    print("I here");
    int index = tasks.indexWhere((element) => element.id == id);
    tasks[index].isDone = value;
    emit(TaskUpdateDone());
  }

  void addTask(TaskModel task) async {
    emit(TaskAddedLoadingState());

    await _database.insert('Tasks', {
      "id": task.id,
      "name": task.name,
      "date": task.date,
      "isDone": task.isDone ? 1 : 0
    });

    tasks.add(task);

    emit(TaskAddedState());
  }

  void changeTitle() {
    title = "New Title";
    emit(TitleAddedState());
  }

  void createDatabase() async {
    emit(CreateDataBaseLoading());

    _database = await openDatabase("database.db", version: 1,
        onCreate: (Database db, int version) async {
      await db.execute(
          'CREATE TABLE Tasks (id TEXT, name TEXT, date TEXT, isDone INTEGER)');
    });

    List<Map<String, dynamic>> data = await _database.query("Tasks");
    tasks = data
        .map((e) => TaskModel(
            id: e['id'],
            name: e['name'],
            date: e['date'],
            isDone: e['isDone'] == 1))
        .toList();
    emit(CreateDataBaseDone());
  }
}
