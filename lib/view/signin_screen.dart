// ignore_for_file: depend_on_referenced_packages

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:to_do/view/to_do.dart';

import '../components/my_button.dart';
import '../components/my_field.dart';
import '../toast_helper.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginScreenDemo extends StatefulWidget {
  const LoginScreenDemo({Key? key}) : super(key: key);

  @override
  State<LoginScreenDemo> createState() => _LoginScreenDemoState();
}

class _LoginScreenDemoState extends State<LoginScreenDemo> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passController = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  bool isHiden = true;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(15),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  "SignUp",
                  style: TextStyle(
                      color: Colors.teal,
                      fontSize: 24,
                      fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  height: 20,
                ),
                Form(
                  key: formKey,
                  child: Column(
                    // COMPONENTS
                    children: [
                      MyFiled(
                          controller: emailController,
                          label: "User Email",
                          icon: Icons.email,
                          validatorText: "Email can't be empty"),
                      const SizedBox(
                        height: 20,
                      ),
                      MyFiled(
                          controller: passController,
                          label: "Password",
                          suffixIcon: IconButton(
                            icon: Icon(
                                isHiden ? Icons.lock : Icons.lock_open_sharp),
                            onPressed: () {
                              // condition ? true : false
                              isHiden = !isHiden;
                              setState(() {});
                            },
                          ),
                          icon: isHiden ? Icons.lock : Icons.lock_open_sharp,
                          validatorText: "Password can't be empty"),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                MyButton(() async {
                  // 1 - sign up
                  // Signing Cubit (Loading )
                  if (formKey.currentState!.validate()) {
                    try {
                      UserCredential userCred = await FirebaseAuth.instance
                          .signInWithEmailAndPassword(
                              email: emailController.text,
                              password: passController.text);
                      // Obtain shared preferences.
                      final prefs = await SharedPreferences.getInstance();

                      // Save an integer value to 'counter' key.
                      await prefs.setString('uid', userCred.user!.uid);

                      Navigator.of(context).push(
                          MaterialPageRoute(builder: (ctx) => const ToDo()));
                    } on FirebaseException catch (err) {
                      showToast(err.message!);
                    } catch (err) {
                      print("Error Happened");
                      print(err);
                      showToast(err.toString());
                    }
                  }
                }, "Login"),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
