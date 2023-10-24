import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:quality_stay/presentation/controllers/area_page_controller.dart';

class AreaListPage extends GetView<AreaPageController> {
  const AreaListPage({super.key, required this.cityName, required this.cityId});

  final String cityName;
  final String cityId;

  @override
  AreaPageController get controller => Get.put(AreaPageController(cityId: cityId));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          cityName,
          style: const TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        backgroundColor: Colors.lightGreen,
        elevation: 0,
        systemOverlayStyle: SystemUiOverlayStyle.light,
      ),
      body: SingleChildScrollView(
        child: Obx(
          () => controller.isLoading.value == true
              ? const SizedBox.shrink()
              : controller.areaList!.isEmpty ? const SizedBox.shrink() : ListView.builder(
                  itemCount: controller.areaList?.length,
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: (){

                      },
                      child: Container(
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                            boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.26), offset: const Offset(3, 3), spreadRadius: 2, blurRadius: 2)]),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              controller.areaList![index].name!,
                              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                            ).paddingSymmetric(vertical: 15,horizontal: 20),
                            const Icon(Icons.arrow_forward_ios,size: 25,).paddingOnly(right: 20),
                          ],
                        ),
                      ),
                    );
                  },
                ).paddingSymmetric(horizontal: 15, vertical: 20),
        ),
      ),
    );
  }
}
