// ignore_for_file: depend_on_referenced_packages

import 'package:flutter/material.dart';
import '../cubit/tasks_satate.dart';
import 'add_task_screen.dart';
import 'package:to_do/cubit/tasks_cubbit.dart';
import 'package:to_do/view/task_style.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ToDo extends StatelessWidget {
  const ToDo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showModalBottomSheet(
              isScrollControlled: true,
              context: context,
              builder: (context) => SingleChildScrollView(
                      child: Padding(
                    padding: EdgeInsets.only(
                        bottom: MediaQuery.of(context).viewInsets.bottom),
                    child: const AddTaskScreen(),
                  )));
        },
        backgroundColor: Colors.teal,
        child: BlocBuilder<TaskCubit, TaskState>(
          builder: (context, state) {
            return state is TaskAddedLoadingState
                ? const CircularProgressIndicator(
                    color: Colors.white,
                  )
                : const Icon(
                    Icons.add,
                    color: Colors.white,
                  );
          },
        ),
      ),
      backgroundColor: Colors.teal,
      appBar: AppBar(
        backgroundColor: Colors.teal,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(FontAwesomeIcons.listCheck),
          onPressed: () {
            context.read<TaskCubit>().changeTitle();
          },
        ),
        title: BlocBuilder<TaskCubit, TaskState>(
          builder: (context, state) {
            return Text(
              context.read<TaskCubit>().title,
              style: const TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
            );
          },
        ),
      ),
      body: BlocBuilder<TaskCubit, TaskState>(
        builder: (context, state) {
          print(state);
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Text(
                  "${context.read<TaskCubit>().tasks.length} Tasks",
                  style: const TextStyle(fontSize: 25, color: Colors.white),
                ),
              ),
              Expanded(
                child: Container(
                  padding: const EdgeInsets.all(20.0),
                  decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(30))),
                  child: state is CreateDataBaseLoading
                      ? const Center(child: CircularProgressIndicator())
                      : context.read<TaskCubit>().tasks.isEmpty
                          ? const Center(child: Text("No Tasks"))
                          : ListView(
                              children: context
                                  .read<TaskCubit>()
                                  .tasks
                                  .map((e) => TaskStyle(e))
                                  .toList(),
                            ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
