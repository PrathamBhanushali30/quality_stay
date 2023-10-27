import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:quality_stay/presentation/widgets/custom_dialog.dart';
import '../services/app_component_base.dart';

class RegistrationPage extends StatefulWidget {
  const RegistrationPage({super.key});

  @override
  State<RegistrationPage> createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage> {
  var client = http.Client();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                    'Register',
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
                    'Create your Account',
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
              height: 30,
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
              decoration: InputDecoration(
                  label: const Text('E-mail'),
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
              obscureText: true,
              controller: passwordController,
              decoration: InputDecoration(
                  label: const Text('Password'),
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
              obscureText: true,
              decoration: InputDecoration(
                  label: const Text('Confirm Password'),
                  focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.black.withOpacity(0.16), width: 2)),
                  labelStyle: const TextStyle(color: Colors.black),
                  focusColor: Colors.black,
                  enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.black.withOpacity(0.16), width: 2)),
                  border: OutlineInputBorder(borderSide: BorderSide(color: Colors.black.withOpacity(0.16), width: 2))),
            ).paddingSymmetric(horizontal: 20),
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
                var uri = Uri.parse('https://city-mania-kole.onrender.com/user/signup');
                var response = await client
                    .post(
                  uri,
                  headers: {'Content-Type': 'application/json'},
                  body: jsonEncode(body),
                )
                    .then((value) {
                  if (value.statusCode == 200) {
                    Navigator.pop(context);
                  } else if (value.statusCode == 201) {
                    CustomDialog.showCustomDialog(
                        context: context,
                        errorTitle: 'Bravo!!',
                        errorMessage: jsonDecode(value.body)['msg'],
                        onTap: () {
                          Navigator.pop(context);
                          Navigator.pop(context);
                        });
                  } else {
                    CustomDialog.showCustomDialog(
                      context: context,
                      errorTitle: 'Oops!!',
                      errorMessage: jsonDecode(value.body)['msg'],
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
                    'Register',
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
              height: 30,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  "I have an account?",
                  style: TextStyle(color: Colors.black, fontSize: 15, fontWeight: FontWeight.w300),
                ),
                const SizedBox(
                  width: 5,
                ),
                GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: const Text(
                      "Log in",
                      style: TextStyle(color: Colors.lightGreen, fontSize: 15, fontWeight: FontWeight.w500),
                    )),
              ],
            )
          ],
        ),
      ),
    );
  }
}
