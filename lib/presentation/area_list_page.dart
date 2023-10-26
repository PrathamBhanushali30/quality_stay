import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:quality_stay/presentation/area_details_page.dart';
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
          () {
            return Column(
              mainAxisSize: MainAxisSize.min,
                      children: [
                        const SizedBox(height: 10,),
                        Container(
                          height: 50,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                            boxShadow: [
                              BoxShadow(color: Colors.black.withOpacity(0.26), offset: const Offset(3, 3), spreadRadius: 2, blurRadius: 2)
                            ],
                          ),
                          child: Center(
                            child: TextField(
                              decoration: const InputDecoration(
                                border: InputBorder.none,
                                hintText: 'Search',
                                suffixIcon: Icon(Icons.search,size: 20,color: Colors.black,),
                              ),
                              controller: controller.searchController,
                              cursorColor: Colors.green,
                              onChanged: (value){
                                if(controller.searchController.text.isEmpty || value == ""){
                                  controller.resetData(cityId: cityId);
                                }else{
                                  controller.getSearchData(cityId: cityId, searchedArea: value);
                                }
                              },
                            ).paddingSymmetric(horizontal: 10).paddingOnly(top: 3),
                          ),
                        ).paddingSymmetric(horizontal: 10),
                        controller.isLoading.value == true
                            ? const SizedBox.shrink()
                            : (controller.areaList?.isEmpty ?? true)
                            ? const SizedBox.shrink()
                            : ListView.builder(
                          itemCount: controller.areaList?.length,
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemBuilder: (context, index) {
                            return GestureDetector(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => AreaDetailsPage(area: controller.areaList![index],areaIndex: index),
                                    ));
                              },
                              child: Container(
                                decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(10), boxShadow: [
                                  BoxShadow(color: Colors.black.withOpacity(0.26), offset: const Offset(3, 3), spreadRadius: 2, blurRadius: 2)
                                ]),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      controller.areaList![index].name!,
                                      style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                                    ).paddingSymmetric(vertical: 15, horizontal: 20),
                                    const Icon(
                                      Icons.arrow_forward_ios,
                                      size: 25,
                                    ).paddingOnly(right: 20),
                                  ],
                                ),
                              ),
                            ).paddingSymmetric(vertical: 10);
                          },
                        ).paddingSymmetric(horizontal: 15,),
                      ],
                    );
          },
        ),
      ),
    );
  }
}
