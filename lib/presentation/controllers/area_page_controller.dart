import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import '../../data/models/area_model.dart';
import '../../services/app_component_base.dart';
import 'package:http/http.dart' as http;

class AreaPageController extends GetxController {
  AreaPageController({required this.cityId});

  final String cityId;
  var client = http.Client();

  AreaModel? areaModel;
  List<ListElement>? areaList;

  RxBool isLoading = true.obs;

  TextEditingController searchController = TextEditingController();

  @override
  void onInit() {
    Future.delayed(const Duration(milliseconds: 300), () async {
      AppBaseComponent.instance.startLoading();
      var uri = Uri.parse(
        'https://city-mania-kole.onrender.com/area/list?cityId=$cityId',
      );
      print(uri);
      final response = await client.get(
        uri,
        headers: {'Content-Type': 'application/json'},
      );
      print(response.statusCode);
      areaModel = areaModelFromJson(response.body);
      areaList = areaModel?.list;
      isLoading.value = false;
      AppBaseComponent.instance.stopLoading();
    });

    super.onInit();
  }

  void resetData({required String cityId})async{
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

  void getSearchData({required String cityId,required String searchedArea}) async {
    AppBaseComponent.instance.startLoading();
    isLoading.value = true;
    var uri = Uri.parse(
      'https://city-mania-kole.onrender.com/area/list?cityId=$cityId&search=$searchedArea',
    );
    print(uri);
    final response = await client.get(
      uri,
      headers: {'Content-Type': 'application/json'},
    );
    areaModel = areaModelFromJson(response.body);
    areaList = areaModel?.list;
    print(areaList?.length);
    isLoading.value = false;
    AppBaseComponent.instance.stopLoading();
  }

}
