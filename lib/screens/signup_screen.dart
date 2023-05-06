import 'package:agri_hack/screens/home_screen.dart';
import 'package:agri_hack/screens/login_screen.dart';
import 'package:agri_hack/services/auth_services.dart';
import 'package:agri_hack/services/firestore_services.dart';
import 'package:agri_hack/services/showSnackbar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../widgets/text_field_input.dart';
import '../widgets/textforminput.dart';

class ScreenSignUp extends StatefulWidget {
  const ScreenSignUp({super.key});

  @override
  State<ScreenSignUp> createState() => _ScreenSignUpState();
}

class _ScreenSignUpState extends State<ScreenSignUp> {
  TextEditingController _nameEditingController = TextEditingController();
  TextEditingController _emailEditingController = TextEditingController();
  TextEditingController _passwordEditingController = TextEditingController();
  TextEditingController _krishibhavanController = TextEditingController();

  bool _isLoading = false;

  void _login() async {
    Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => const ScreenLogin()));
  }

  void signUp() async {
    String email = _emailEditingController.text.trim();

    setState(() {
      _isLoading = true;
    });

    bool isEmailAlreadyRegistered =
        await FirestoreServices().checkForEmail(email);
    if (isEmailAlreadyRegistered) {
      showSnackbar(context, "Email already in use.");

      setState(() {
        _isLoading = false;
      });
      return;
    }

    String res = await AuthServices().signUpUser(
      _nameEditingController.text.trim(),
      email,
      _passwordEditingController.text.trim(),
      _krishibhavanController.text.trim(),
    );

    setState(() {
      _isLoading = false;
    });

    if (res == 'success') {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => const ScreenHome()));
    } else {
      showSnackbar(context, res);
    }
  }

  @override
  void dispose() {
    _nameEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff121421),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Register 📜",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 32.w,
                      fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 20.w,
                ),
                TextFormInput(
                  hintText: "Name",
                  textEditingController: _nameEditingController,
                  textInputType: TextInputType.name,
                  style: const TextStyle(color: Colors.white),
                ),
                SizedBox(
                  height: 10.w,
                ),
                TextFormInput(
                    textEditingController: _emailEditingController,
                    hintText: "Email Address",
                    style: const TextStyle(color: Colors.white),
                    textInputType: TextInputType.emailAddress),
                SizedBox(
                  height: 10.w,
                ),
                TextFormInput(
                    textEditingController: _passwordEditingController,
                    hintText: "Password",
                    style: const TextStyle(color: Colors.white),
                    isPass: true,
                    textInputType: TextInputType.text),
                SizedBox(
                  height: 10.w,
                ),
                TextFormInput(
                    textEditingController: _krishibhavanController,
                    hintText: "Krishibhavan",
                    style: const TextStyle(color: Colors.white),
                    textInputType: TextInputType.text),
                ElevatedButton(
                    onPressed: () {
                      signUp();
                    },
                    child: _isLoading
                        ? const Center(
                            child: CircularProgressIndicator(
                              color: Colors.white,
                            ),
                          )
                        : Center(child: const Text("Sign Up"))),
                Row(
                  children: [
                    const Text(
                      "Already have an account? ",
                      style: TextStyle(color: Colors.white),
                    ),
                    TextButton(
                      onPressed: _login,
                      child: const Text("Login instead"),
                    )
                  ],
                )
              ]),
        ),
      ),
    );
  }
}
