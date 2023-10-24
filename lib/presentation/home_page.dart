import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:quality_stay/presentation/widgets/home_page_card_widget.dart';

import 'city_details.dart';
import 'controllers/home_page_controller.dart';

class HomePage extends GetView<HomePageController> {
  const HomePage({super.key});

  @override
  // TODO: implement controller
  HomePageController get controller => Get.put(HomePageController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Quality Stay',
          style: TextStyle(color: Colors.white),
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
            children: [
              const SizedBox(
                height: 20,
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.9,
                child: Obx(
                  () => GridView.builder(
                    physics: const BouncingScrollPhysics(),
                    itemCount: controller.cityList?.length,
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () {
                          if (index == 0) {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => CityDetails(
                                    city: controller.cityList![index],
                                  ),
                                ));
                          }
                        },
                        child: controller.isLoading.value == true
                            ? const SizedBox.shrink()
                            : !(controller.cityList?[index].isComingSoon ?? false)
                                ? HomePageCard(
                                    text: controller.cityList?[index].name ?? '',
                                    image: 'assets/${controller.cityList?[index].name}.png',
                                  )
                                : Stack(
                                    children: [
                                      HomePageCard(
                                        text: controller.cityList?[index].name ?? '',
                                        image: 'assets/${controller.cityList?[index].name?.trim()}.png',
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(10.0),
                                        child: Container(
                                          height: 150,
                                          width: 150,
                                          decoration: BoxDecoration(
                                            color: Colors.black.withOpacity(0.30),
                                            borderRadius: BorderRadius.circular(10),
                                          ),
                                          child: const Center(
                                            child: Text(
                                              'Coming Soon',
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 20,
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                      );
                    },
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
