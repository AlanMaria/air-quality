import 'package:agri_hack/screens/home_screen.dart';
import 'package:agri_hack/screens/signup_screen.dart';
import 'package:agri_hack/services/auth_services.dart';
import 'package:agri_hack/services/firestore_services.dart';
import 'package:agri_hack/services/showSnackbar.dart';
import 'package:agri_hack/widgets/text_field_input.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../widgets/textforminput.dart';

class ScreenLogin extends StatefulWidget {
  const ScreenLogin({super.key});

  @override
  State<ScreenLogin> createState() => ScreenLoginState();
}

class ScreenLoginState extends State<ScreenLogin> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passController = TextEditingController();

  bool _isLoading = false;

  _loginUser() async {
    String email = _emailController.text.trim();

    setState(() {
      _isLoading = true;
    });

    bool isRegistered = await FirestoreServices().checkForEmail(email);
    if (!isRegistered) {
      setState(() {
        _isLoading = false;
      });
      showSnackbar(context, "No such user, please sign up");
      return;
    }

    String res =
        await AuthServices().loginUser(email, _passController.text.trim());

    setState(() {
      _isLoading = false;
    });

    if (res == "success") {
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: ((context) => ScreenHome())));
    } else {
      showSnackbar(context, res);
    }
  }

  void _signupUser() {
    Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => const ScreenSignUp()));
  }

  @override
  void dispose() {
    _passController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color(0xff121421),
        body: Center(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Dhrishti 🧑‍🌾",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 34.w,
                        fontWeight: FontWeight.bold)),
                SizedBox(
                  height: 20.w,
                ),
                TextFormInput(
                  textEditingController: _emailController,
                  hintText: "Email",
                  textInputType: TextInputType.emailAddress,
                  isNumber: true,
                  style: const TextStyle(color: Colors.white),
                ),
                SizedBox(
                  height: 10.w,
                ),
                TextFormInput(
                  textEditingController: _passController,
                  hintText: "Password",
                  isPass: true,
                  textInputType: TextInputType.text,
                  isNumber: true,
                  style: const TextStyle(color: Colors.white),
                ),
                SizedBox(
                  height: 10.h,
                ),
                Center(
                  child: ElevatedButton(
                    onPressed: () {
                      _loginUser();
                    },
                    child: _isLoading
                        ? const CircularProgressIndicator(
                            color: Colors.white,
                          )
                        : const Text("Login"),
                  ),
                ),
                SizedBox(
                  height: 10.h,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      "Don't have an account? ",
                      style: TextStyle(color: Colors.white),
                    ),
                    TextButton(
                        onPressed: _signupUser,
                        child: const Text("Register Today"))
                  ],
                ),
              ],
            ),
          ),
        ));
  }
}
