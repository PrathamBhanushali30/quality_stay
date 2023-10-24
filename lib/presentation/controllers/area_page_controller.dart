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
}
