import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:quality_stay/presentation/home_page.dart';
import 'package:quality_stay/presentation/register_page.dart';
import 'package:http/http.dart' as http;
import 'package:quality_stay/presentation/widgets/custom_dialog.dart';
import 'package:quality_stay/services/app_component_base.dart';

import '../constants/dbkeys.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  var client = http.Client();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  bool isObscure = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: context.height * 0.3,
              width: context.width,
              decoration: const BoxDecoration(
                color: Colors.black,
              ),
              child: const Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Sign in to your',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  Text(
                    'Account',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    'Sign in to your Account',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ).paddingSymmetric(horizontal: 30).paddingOnly(bottom: 70),
            ),
            const SizedBox(
              height: 80,
            ),
            TextField(
              cursorColor: Colors.black,
              controller: nameController,
              decoration: InputDecoration(
                  label: const Text('Name'),
                  focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.black.withOpacity(0.16), width: 2)),
                  labelStyle: const TextStyle(color: Colors.black),
                  focusColor: Colors.black,
                  enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.black.withOpacity(0.16), width: 2)),
                  border: OutlineInputBorder(borderSide: BorderSide(color: Colors.black.withOpacity(0.16), width: 2))),
            ).paddingSymmetric(horizontal: 20),
            const SizedBox(
              height: 30,
            ),
            TextField(
              cursorColor: Colors.black,
              obscureText: isObscure,
              controller: passwordController,
              decoration: InputDecoration(
                  suffix: GestureDetector(
                    onTap: () {
                      setState(() {
                        isObscure = !isObscure;
                      });
                    },
                    child: const Icon(Icons.remove_red_eye),
                  ),
                  label: const Text('Password'),
                  focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.black.withOpacity(0.16), width: 2)),
                  labelStyle: const TextStyle(color: Colors.black),
                  focusColor: Colors.black,
                  enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.black.withOpacity(0.16), width: 2)),
                  border: OutlineInputBorder(borderSide: BorderSide(color: Colors.black.withOpacity(0.16), width: 2))),
            ).paddingSymmetric(horizontal: 20),
            const SizedBox(
              height: 20,
            ),
            /*const Align(
              alignment: Alignment.centerRight,
              child: Text(
                'Forgot Password?',
                style: TextStyle(color: Colors.lightGreen),
              ),
            ).paddingOnly(right: 20),*/
            const SizedBox(
              height: 20,
            ),
            GestureDetector(
              onTap: () async {
                AppBaseComponent.instance.startLoading();
                Map<String, dynamic> body = {
                  "username": nameController.text,
                  "password": passwordController.text,
                };
                var uri = Uri.parse('https://city-mania-kole.onrender.com/user/signin');
                var response = await client
                    .post(
                  uri,
                  headers: {'Content-Type': 'application/json'},
                  body: jsonEncode(body),
                )
                    .then((value) async {
                  if (value.statusCode == 200) {
                    await GetStorage().write(DBKeys.isLogin, true );
                    await GetStorage().write(DBKeys.isSkipLogin, false).then((value) {
                      Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const HomePage(),
                          ),
                          (route) => false);
                    });
                  } else {
                    CustomDialog.showCustomDialog(
                      context: context,
                      errorTitle: 'Oops!!',
                      errorMessage: jsonDecode(value.body)['message'],
                    );
                  }
                });
                AppBaseComponent.instance.stopLoading();
              },
              child: Container(
                height: 57,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.lightGreen,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Center(
                  child: Text(
                    'Login',
                    style: TextStyle(
                      fontSize: 24,
                      color: Colors.black,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ).paddingSymmetric(horizontal: 20),
            ),
            const SizedBox(
              height: 40,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  "Don't have an account?",
                  style: TextStyle(color: Colors.black, fontSize: 15, fontWeight: FontWeight.w300),
                ),
                const SizedBox(
                  width: 5,
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const RegistrationPage(),
                        ));
                  },
                  child: const Text(
                    "Register",
                    style: TextStyle(color: Colors.lightGreen, fontSize: 15, fontWeight: FontWeight.w500),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            GestureDetector(
              onTap: () async {
                /*Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const HomePage(),
                  ),
                );*/
                await GetStorage().write(DBKeys.isSkipLogin, true).then((value) {
                  Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const HomePage(),
                      ),
                      (route) => false);
                });
              },
              child: const Text(
                "Skip Login",
                style: TextStyle(color: Colors.lightGreen, fontSize: 20, fontWeight: FontWeight.w700),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
