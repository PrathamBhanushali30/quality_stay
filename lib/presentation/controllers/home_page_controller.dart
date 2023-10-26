import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:quality_stay/services/app_component_base.dart';

import '../../data/models/city_model.dart';

class HomePageController extends GetxController{

  var client = http.Client();

  CityModel? cityModel;
  List<ListElement>? cityList;
  ListElement? ahmedabad;

  RxBool isLoading = true.obs;

  TextEditingController searchController = TextEditingController();

  @override
  void onInit() {
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
          statusBarColor: Colors.lightGreen,
      ),
    );
    Future.delayed(Duration(milliseconds: 300),() async{
      AppBaseComponent.instance.startLoading();
      var uri = Uri.parse('https://city-mania-kole.onrender.com/city/list');
      final response = await client.get(uri,headers: {'Content-Type': 'application/json'},);
      print(response.statusCode);
      cityModel = cityModelFromJson(response.body);
      cityList = cityModel?.list;
      for(var element in cityList!){
        if(element.name == 'Ahmedabad'){
          ahmedabad = element;
        }
      }
      cityList?.removeWhere((element) => element.name == 'Ahmedabad');
      cityList?.insert(0, ahmedabad!);
      isLoading.value = false;
      AppBaseComponent.instance.stopLoading();
    });
    super.onInit();
  }

  void getSearchData({required String searchedCity}) async {
    AppBaseComponent.instance.startLoading();
    var uri = Uri.parse('https://city-mania-kole.onrender.com/city/list?search=$searchedCity');
    final response = await client.get(uri,headers: {'Content-Type': 'application/json'},);
    print(response.statusCode);
    cityModel = cityModelFromJson(response.body);
    cityList = cityModel?.list;
    isLoading.value = false;
    AppBaseComponent.instance.stopLoading();
  }

  void resetData()async{
    AppBaseComponent.instance.startLoading();
    var uri = Uri.parse('https://city-mania-kole.onrender.com/city/list');
    final response = await client.get(uri,headers: {'Content-Type': 'application/json'},);
    print(response.statusCode);
    cityModel = cityModelFromJson(response.body);
    cityList = cityModel?.list;
    for(var element in cityList!){
      if(element.name == 'Ahmedabad'){
        ahmedabad = element;
      }
    }
    cityList?.removeWhere((element) => element.name == 'Ahmedabad');
    cityList?.insert(0, ahmedabad!);
    isLoading.value = false;
    AppBaseComponent.instance.stopLoading();
  }

}