// ignore_for_file: depend_on_referenced_packages

import 'package:flutter/material.dart';
import 'package:custom_check_box/custom_check_box.dart';
import 'package:to_do/cubit/tasks_cubbit.dart';
import 'package:to_do/models/task_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TaskStyle extends StatefulWidget {
  const TaskStyle(this.task, {Key? key}) : super(key: key);
  final TaskModel task;

  @override
  State<TaskStyle> createState() => _TaskStyleState();
}

class _TaskStyleState extends State<TaskStyle> {
  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: Key(widget.task.id),
      background: Container(
        color: Colors.red,
      ),
      direction: DismissDirection.endToStart,
      onDismissed: (dir) {
        context.read<TaskCubit>().deleteTask(widget.task.id);
      },
      child: ListTile(
        title: Text(widget.task.name),
        subtitle: Text(widget.task.date),
        trailing: CustomCheckBox(
            value: widget.task.isDone,
            splashColor: Colors.red.withOpacity(0.4),
            splashRadius: 40,
            onChanged: (val) {
              context.read<TaskCubit>().updateTask(widget.task.id, val);
              // setState(() {
              //   widget.task.isDone = val;
              // });
            }),
      ),
    );
  }
}
