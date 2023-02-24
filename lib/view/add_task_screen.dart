// ignore_for_file: depend_on_referenced_packages

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:to_do/cubit/tasks_cubbit.dart';
import '../models/task_model.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddTaskScreen extends StatefulWidget {
  const AddTaskScreen({Key? key}) : super(key: key);

  @override
  State<AddTaskScreen> createState() => _AddTaskScreenState();
}

class _AddTaskScreenState extends State<AddTaskScreen> {
  final TextEditingController controller = TextEditingController();
  String? date;
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            const Text(
              "Add New Task",
              style: TextStyle(
                  fontSize: 30,
                  color: Colors.teal,
                  fontWeight: FontWeight.bold),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Form(
                key: formKey,
                child: TextFormField(
                  controller: controller,
                  autofocus: true,
                  textAlign: TextAlign.center,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Name can't be empty";
                    } else {
                      return null;
                    }
                  },
                ),
              ),
            ),
            InkWell(
              onTap: () async {
                DateTime? value = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime(1900),
                    lastDate: DateTime(3000));

                if (value != null) {
                  date = DateFormat("dd-MM-yyyy").format(value);
                  setState(() {});
                }
              },
              child: Container(
                height: 30,
                width: 140,
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.black),
                    borderRadius: BorderRadius.circular(5)),
                child: Center(
                    child: Text(
                  date ?? "Pick Date",
                  style: const TextStyle(fontWeight: FontWeight.bold),
                )),
              ),
            ),
            ElevatedButton(
                onPressed: () {
                  if (formKey.currentState!.validate()) {
                    if (date == null) {
                      Fluttertoast.showToast(
                          msg: "Date can't be empty",
                          toastLength: Toast.LENGTH_SHORT,
                          gravity: ToastGravity.BOTTOM,
                          timeInSecForIosWeb: 1,
                          backgroundColor: Colors.red,
                          textColor: Colors.white,
                          fontSize: 16.0);
                    } else {
                      context.read<TaskCubit>().addTask(TaskModel(
                          id: DateTime.now().millisecondsSinceEpoch.toString(),
                          name: controller.text,
                          date: date!,
                          isDone: false));
                      Navigator.of(context).pop();
                    }
                  }
                },
                child: const Text(
                  "Add",
                ))
          ],
        ),
      ),
    );
  }
}
