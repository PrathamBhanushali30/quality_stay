import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:quality_stay/data/models/city_model.dart';
import 'package:quality_stay/presentation/area_list_page.dart';
import 'package:quality_stay/presentation/login_page.dart';
import 'package:quality_stay/presentation/widgets/title_text.dart';
import 'package:quality_stay/presentation/widgets/value_text.dart';

import '../constants/dbkeys.dart';

class CityDetails extends StatefulWidget {
  const CityDetails({
    super.key,
    required this.city,
  });

  final ListElement city;

  @override
  State<CityDetails> createState() => _CityDetailsState();
}

class _CityDetailsState extends State<CityDetails> {
  bool isLogin = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.city.name!,
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
            children: [
              Align(
                alignment: Alignment.center,
                child: Image.asset(
                  'assets/${widget.city.name!.trim()}.png',
                  height: 200,
                  width: 200,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Align(
                alignment: Alignment.center,
                child: TitleText(
                  text: widget.city.name!,
                ),
              ),
              const SizedBox(
                height: 30,
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
                text: widget.city.area!,
              ),
              Stack(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(
                        height: 20,
                      ),
                      const TitleText(text: 'Average Temperature'),
                      const SizedBox(
                        height: 5,
                      ),
                      ValueText(
                        text: '${widget.city.avgTemperature}°C',
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      const TitleText(text: 'Population Density'),
                      const SizedBox(
                        height: 5,
                      ),
                      ValueText(
                        text: widget.city.populationDensity.toString(),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      const TitleText(text: 'Water Quality| tds(mg/L)'),
                      const SizedBox(
                        height: 5,
                      ),
                      ValueText(
                        text: widget.city.tds.toString(),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      const TitleText(text: 'Air Quality(aqi)'),
                      const SizedBox(
                        height: 5,
                      ),
                      ValueText(
                        text: widget.city.aqi.toString(),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      const TitleText(text: 'Average Rent (1BHK Apartment)'),
                      const SizedBox(
                        height: 5,
                      ),
                      ValueText(
                        text: widget.city.averageRent.toString(),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      const TitleText(text: 'Cost of Living Index (100=New York)'),
                      const SizedBox(
                        height: 5,
                      ),
                      ValueText(
                        text: widget.city.costOfLivingIndex.toString(),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      const TitleText(text: 'Average Annual Rainfall (mm)'),
                      const SizedBox(
                        height: 5,
                      ),
                      ValueText(
                        text: widget.city.averageAnnualRainfall.toString(),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => AreaListPage(cityName: widget.city.name!, cityId: widget.city.id!),
                              ));
                        },
                        child: Container(
                          decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(10), boxShadow: [
                            BoxShadow(color: Colors.black.withOpacity(0.26), offset: const Offset(3, 3), spreadRadius: 2, blurRadius: 2)
                          ]),
                          child: const Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Get Area Wise',
                                style: TextStyle(color: Colors.black, fontSize: 18, fontWeight: FontWeight.w500),
                              ),
                              Icon(
                                Icons.arrow_forward_ios,
                                color: Colors.black,
                              )
                            ],
                          ).paddingSymmetric(horizontal: 15, vertical: 10),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      )
                    ],
                  ),
                  if (GetStorage().read(DBKeys.isSkipLogin))
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.7,
                      width: double.infinity,
                      child: ClipRRect(
                        child: BackdropFilter(
                          filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
                          child: Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                const Text(
                                  'Please Login to see more',
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 18,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                const SizedBox(height: 10,),
                                GestureDetector(
                                  onTap: ()async{
                                    await GetStorage().write(DBKeys.isLogin, false);
                                    await GetStorage().write(DBKeys.isSkipLogin, false);
                                    Get.offAll(()=>const LoginPage());
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
                                      'Login',
                                      style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.w500),
                                    ).paddingSymmetric(horizontal: 30,vertical: 10),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
