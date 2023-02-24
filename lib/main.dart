// ignore_for_file: depend_on_referenced_packages

import 'package:flutter/material.dart';
import 'package:to_do/cubit/tasks_cubbit.dart';
import 'package:to_do/view/to_do.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'cubit/my_bloc_observer.dart';

void main() {
  Bloc.observer = MyBlocObserver();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => TaskCubit()..createDatabase(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'to do ',
        theme: ThemeData(primarySwatch: Colors.teal),
        home: const ToDo(),
      ),
    );
  }
}
