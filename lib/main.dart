// ignore_for_file: depend_on_referenced_packages

import 'package:flutter/material.dart';
import 'package:to_do/cubit/tasks_cubbit.dart';
import 'package:to_do/view/signin_screen.dart';
import 'package:to_do/view/to_do.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'cubit/my_bloc_observer.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> main() async {
  Bloc.observer = MyBlocObserver();
  WidgetsFlutterBinding.ensureInitialized();
  final prefs = await SharedPreferences.getInstance();
  String? uid = (prefs.getString("uid"));

  await Firebase.initializeApp();
// native Splash screen (Task 1)
  runApp(MyApp(uid));
}

class MyApp extends StatelessWidget {
  const MyApp(this.uid, {Key? key}) : super(key: key);
  final String? uid;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => TaskCubit()..createDatabase(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'to do ',
        theme: ThemeData(primarySwatch: Colors.teal),
        home: uid == null ? const LoginScreenDemo() : const ToDo(),
      ),
    );
  }
}
