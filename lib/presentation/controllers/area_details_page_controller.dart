import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:quality_stay/constants/dbkeys.dart';
import 'package:quality_stay/data/models/area_model.dart';
import '../../services/app_component_base.dart';

class AreaDetailsPageController extends GetxController{
  AreaDetailsPageController({required this.cityId});

  final String cityId;
  var client = http.Client();

  AreaModel? areaModel;
  List<ListElement>? areaList;
  RxBool isLoading = true.obs;

  ScrollController scrollController = ScrollController();
  TextEditingController reviewController = TextEditingController();

  @override
  void onReady() {
    getReviews(cityId: cityId);
    super.onReady();
  }

  void getReviews({required String cityId}) async {
    AppBaseComponent.instance.startLoading();
    isLoading.value = true;
    var uri = Uri.parse(
      'https://city-mania-kole.onrender.com/area/list?cityId=$cityId',
    );
    print(uri);
    final response = await client.get(
      uri,
      headers: {'Content-Type': 'application/json'},
    );
    areaModel = areaModelFromJson(response.body);
    areaList = areaModel?.list;
    isLoading.value = false;
    AppBaseComponent.instance.stopLoading();
  }

  void addReview({required String text, required String areaId}) async {
    AppBaseComponent.instance.startLoading();
    isLoading.value = true;
    var uri = Uri.parse(
      'https://city-mania-kole.onrender.com/review/create',
    );
    Map<String,dynamic> body={
      "text" : text,
      "area" : areaId
    };
    final response = await client.post(
      uri,
      headers: {'Content-Type': 'application/json','auth-token' : GetStorage().read(DBKeys.token)},
      body: jsonEncode(body),
    );

  }

}