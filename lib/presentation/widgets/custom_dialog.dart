import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomDialog {
  static void showCustomDialog({
    required BuildContext context,
    required String errorTitle,
    required String errorMessage,
    VoidCallback? onTap,
  }) {
    showDialog(
      context: context,
      builder: (context) {
        return Scaffold(
          backgroundColor: Colors.transparent,
          body: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Column(
              children: [
                Container(
                  decoration: const BoxDecoration(
                    color: Colors.lightGreen,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20),
                    ),
                  ),
                  child: Center(
                    child: Text(
                      errorTitle,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ).paddingSymmetric(horizontal: 20, vertical: 20),
                ),
                const SizedBox(
                  height: 20,
                ),
                Container(
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20),
                    ),
                  ),
                  child: Center(
                    child: Text(
                      errorMessage,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                Align(
                  alignment: Alignment.center,
                  child: GestureDetector(
                    onTap: onTap ?? () {
                      Navigator.pop(context);
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.lightGreen,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: const Text(
                        'OK',
                        style: TextStyle(color: Colors.white, fontSize: 15, fontWeight: FontWeight.w300),
                      ).paddingSymmetric(horizontal: 60,vertical: 15),
                    ),
                  ),
                )
              ],
            ),
          ).paddingSymmetric(vertical: context.height * 0.35, horizontal: context.width * 0.2),
        );
      },
    );
  }
}
