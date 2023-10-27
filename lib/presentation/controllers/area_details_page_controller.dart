import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:quality_stay/constants/dbkeys.dart';
import 'package:quality_stay/presentation/login_page.dart';
import 'package:quality_stay/presentation/widgets/title_text.dart';
import '../../services/app_component_base.dart';

class AreaDetailsPageController extends GetxController {
  var client = http.Client();
  RxBool isLoading = true.obs;

  ScrollController scrollController = ScrollController();
  TextEditingController reviewController = TextEditingController();
  TextEditingController editReviewController = TextEditingController();

  @override
  void dispose() {
    reviewController.dispose();
    super.dispose();
  }

  void addReview({required String text, required String areaId}) async {
    AppBaseComponent.instance.startLoading();
    isLoading.value = true;
    var uri = Uri.parse(
      'https://city-mania-kole.onrender.com/review/create',
    );
    Map<String, dynamic> body = {"text": text, "area": areaId};
    final response = await client.post(
      uri,
      headers: {'Content-Type': 'application/json', 'auth-token': GetStorage().read(DBKeys.token)},
      body: jsonEncode(body),
    );
    print(response.statusCode);
    if (response.statusCode == 200) {
      Get.back();
    }
    if (response.statusCode == 401) {
      Get.offAll(() => const LoginPage());
    }
    AppBaseComponent.instance.stopLoading();
    isLoading.value = false;
  }

  void deleteReview({required String reviewId}) async {
    AppBaseComponent.instance.startLoading();
    isLoading.value = true;
    var uri = Uri.parse(
      'https://city-mania-kole.onrender.com/review/delete/$reviewId',
    );
    final response = await client.delete(
      uri,
      headers: {'Content-Type': 'application/json', 'auth-token': GetStorage().read(DBKeys.token)},
    );
    print(response.statusCode);
    if (response.statusCode == 200) {
      Get.back();
    }
    if (response.statusCode == 401) {
      if (jsonDecode(response.body)['msg'] == "You cannot delete other user's review.") {
        showSnackBar(jsonDecode(response.body)['msg'].toString());
      } else {
        Get.offAll(() => const LoginPage());
      }
    }
    AppBaseComponent.instance.stopLoading();
    isLoading.value = false;
  }

  void editReview({required String reviewId, required String msg}) async {
    AppBaseComponent.instance.startLoading();
    isLoading.value = true;
    var uri = Uri.parse(
      'https://city-mania-kole.onrender.com/review/update/$reviewId',
    );
    Map<String,dynamic> body ={
      "text" : msg
    };
    final response = await client.post(
      uri,
      headers: {'Content-Type': 'application/json', 'auth-token': GetStorage().read(DBKeys.token)},
      body: jsonEncode(body),
    );
    print(response.statusCode);
    if (response.statusCode == 200) {
      print(jsonDecode(response.body));
      Get.back();
      Get.back();
    }
    if (response.statusCode == 401) {
      if (jsonDecode(response.body)['msg'] == "You cannot update other user's review.") {
        showSnackBar(jsonDecode(response.body)['msg'].toString());
      } else {
        Get.offAll(() => const LoginPage());
      }
    }
    AppBaseComponent.instance.stopLoading();
    isLoading.value = false;
  }

  void showSnackBar(String msg) {
    Get.showSnackbar(GetSnackBar(
      message: msg,
      backgroundColor: Colors.green,
      duration: const Duration(seconds: 2),
    ));
  }

  void showBottomSheet(String msg,AreaDetailsPageController areaController,String reviewId) {
    editReviewController.text = msg;
    Get.bottomSheet(
      EditBottomSheet(
        msg: msg,
        reviewController: editReviewController,
        areaController: areaController,
        reviewId: reviewId,
      ),
      barrierColor: Colors.transparent,
      isScrollControlled: false,
    );
  }
}

class EditBottomSheet extends StatelessWidget {
  const EditBottomSheet({super.key, required this.msg, required this.reviewController, required this.areaController, required this.reviewId});

  final String msg;
  final TextEditingController reviewController;
  final AreaDetailsPageController areaController;
  final String reviewId;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: Get.height * 0.4,
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: const BorderRadius.only(
            topRight: Radius.circular(30),
            topLeft: Radius.circular(30),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.16),
              spreadRadius: 1,
              blurRadius: 1,
              offset: const Offset(0, -2),
            ),
          ]),
      child: Column(
        children: [
          const SizedBox(
            height: 30,
          ),
          const TitleText(text: 'Edit Review'),
          const SizedBox(
            height: 30,
          ),
          Container(
            decoration: BoxDecoration(
              border: Border.all(color: Colors.black),
              borderRadius: BorderRadius.circular(10),
            ),
            child: TextField(
              decoration: const InputDecoration(
                hintText: 'Add Review',
                border: InputBorder.none,
              ),
              controller: reviewController,
              cursorColor: Colors.green,
            ).paddingSymmetric(horizontal: 10),
          ).paddingSymmetric(horizontal: 15),
          const SizedBox(
            height: 30,
          ),
          GestureDetector(
            onTap: (){
              FocusScope.of(context).unfocus();
              areaController.editReview(reviewId: reviewId, msg: msg);
            },
            child: Container(
              decoration: BoxDecoration(color: Colors.green, borderRadius: BorderRadius.circular(10), boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.16),
                  spreadRadius: 1,
                  blurRadius: 1,
                  offset: const Offset(2, 2),
                ),
              ]),
              child: const Text(
                'Edit',
                style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.w500),
              ).paddingSymmetric(horizontal: 30,vertical: 10),
            ),
          )
        ],
      ),
    );
  }
}
