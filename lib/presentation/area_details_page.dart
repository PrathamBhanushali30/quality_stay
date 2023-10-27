import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:quality_stay/constants/dbkeys.dart';
import 'package:quality_stay/data/models/area_model.dart';
import 'package:quality_stay/presentation/controllers/area_details_page_controller.dart';
import 'package:quality_stay/presentation/widgets/title_text.dart';
import 'package:quality_stay/presentation/widgets/value_text.dart';

class AreaDetailsPage extends GetView<AreaDetailsPageController> {
  const AreaDetailsPage({super.key, required this.area, required this.areaIndex});

  final ListElement area;
  final int areaIndex;

  @override
  AreaDetailsPageController get controller => Get.put(AreaDetailsPageController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          area.name!,
          style: const TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        backgroundColor: Colors.lightGreen,
        elevation: 0,
        systemOverlayStyle: SystemUiOverlayStyle.light,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(
                height: 20,
              ),
              const TitleText(text: 'OverAll Ratings'),
              const SizedBox(
                height: 5,
              ),
              const Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Icon(
                    Icons.star,
                    size: 30,
                    color: Colors.yellow,
                  ),
                  Icon(
                    Icons.star,
                    size: 30,
                    color: Colors.yellow,
                  ),
                  Icon(
                    Icons.star,
                    size: 30,
                    color: Colors.yellow,
                  ),
                  Icon(
                    Icons.star,
                    size: 30,
                    color: Colors.yellow,
                  ),
                  Icon(
                    Icons.star,
                    size: 30,
                    color: Colors.grey,
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              const TitleText(text: 'Area of Land'),
              const SizedBox(
                height: 5,
              ),
              ValueText(
                text: area.area!,
              ),
              const SizedBox(
                height: 20,
              ),
              const TitleText(text: 'Average Temperature'),
              const SizedBox(
                height: 5,
              ),
              ValueText(
                text: '${area.avgTemperature}°C',
              ),
              const SizedBox(
                height: 20,
              ),
              const TitleText(text: 'Population Density'),
              const SizedBox(
                height: 5,
              ),
              ValueText(
                text: area.populationDensity.toString(),
              ),
              const SizedBox(
                height: 20,
              ),
              const TitleText(text: 'Water Quality| tds(mg/L)'),
              const SizedBox(
                height: 5,
              ),
              ValueText(
                text: area.tds.toString(),
              ),
              const SizedBox(
                height: 20,
              ),
              const TitleText(text: 'Air Quality(aqi)'),
              const SizedBox(
                height: 5,
              ),
              ValueText(
                text: area.aqi.toString(),
              ),
              const SizedBox(
                height: 20,
              ),
              const TitleText(text: 'Average Rent (1BHK Apartment)'),
              const SizedBox(
                height: 5,
              ),
              ValueText(
                text: area.averageRent.toString(),
              ),
              const SizedBox(
                height: 20,
              ),
              const TitleText(text: 'Cost of Living Index (100=New York)'),
              const SizedBox(
                height: 5,
              ),
              ValueText(
                text: area.costOfLivingIndex.toString(),
              ),
              const SizedBox(
                height: 20,
              ),
              const TitleText(text: 'Average Annual Rainfall (mm)'),
              const SizedBox(
                height: 5,
              ),
              ValueText(
                text: area.averageAnnualRainfall.toString(),
              ),
              const SizedBox(
                height: 20,
              ),
              const Text(
                'Reviews',
                style: TextStyle(fontSize: 20, color: Colors.black, fontWeight: FontWeight.w700),
              ),
              const SizedBox(
                height: 10,
              ),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(
                    color: Colors.grey,
                  ),
                ),
                child: ListView.builder(
                  itemCount: area.reviews?.length,
                  controller: controller.scrollController,
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    return Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                                '${area.reviews?[index].createdAt?.day}/${area.reviews?[index].createdAt?.month}/${area.reviews?[index].createdAt?.year}' ??
                                    ""),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            TitleText(
                              text: area.reviews?[index].text ?? "",
                            ),
                            if(JwtDecoder.decode(GetStorage().read(DBKeys.token))['userId'] == area.reviews?[index].user)
                            Row(
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    controller.deleteReview(reviewId: area.reviews?[index].id ?? "0");
                                  },
                                  child: const Icon(Icons.delete),
                                ),
                                GestureDetector(
                                  onTap: (){
                                    controller.showBottomSheet(area.reviews?[index].text ?? "",controller,area.reviews?[index].id ?? "");
                                  },
                                  child: const Icon(Icons.edit),
                                ),
                              ],
                            )
                          ],
                        ),
                      ],
                    ).paddingSymmetric(vertical: 10, horizontal: 10);
                  },
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.black),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: TextField(
                        decoration: const InputDecoration(
                          hintText: 'Add Review',
                          border: InputBorder.none,
                        ),
                        controller: controller.reviewController,
                        cursorColor: Colors.green,
                      ).paddingSymmetric(horizontal: 10),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      if (controller.reviewController.text.isNotEmpty) {
                        FocusScope.of(context).unfocus();
                        controller.addReview(text: controller.reviewController.text, areaId: area.id!);
                        controller.reviewController.clear();
                      }
                    },
                    child: Container(
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.green,
                      ),
                      child: const Icon(
                        Icons.send,
                        color: Colors.white,
                      ).paddingSymmetric(horizontal: 10, vertical: 10),
                    ).paddingSymmetric(horizontal: 10),
                  )
                ],
              ),
              const SizedBox(
                height: 20,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
