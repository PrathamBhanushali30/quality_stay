import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:get_storage/get_storage.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:quality_stay/presentation/login_page.dart';
import 'package:quality_stay/presentation/home_page.dart';
import 'package:quality_stay/presentation/widgets/custom_scroll_behaviour.dart';
import 'package:quality_stay/services/app_component_base.dart';

import 'constants/dbkeys.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await GetStorage.init();
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.black,
      statusBarBrightness: Brightness.light
    ),
  );
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: GetStorage().read(DBKeys.isLogin) == true || GetStorage().read(DBKeys.isSkipLogin) == true ? const HomePage() : const LoginPage(),
      // home: HomePage(),
      debugShowCheckedModeBanner: false,
      builder: (context, child) {
        return Stack(
          children: [
            ScrollConfiguration(
              behavior: CustomScrollBehaviour(),
              child: child!,
            ),
            StreamBuilder<bool>(
              initialData: false,
              stream: AppBaseComponent.instance.progressStream,
              builder: (context, snapshot) {
                return Obx(
                  () => AppBaseComponent.instance.completed.value
                      ? const Offstage()
                      : Positioned.fill(
                          child: AnimatedOpacity(
                            opacity: snapshot.data! ? 1 : 0,
                            duration: const Duration(milliseconds: 200),
                            child: Container(
                              color: Colors.black.withOpacity(0.3),
                              child: Center(
                                child: LoadingAnimationWidget.staggeredDotsWave(color: Colors.green, size: 60),
                              ),
                            ),
                          ),
                        ),
                );
              },
            ),
          ],
        );
      },
    );
  }
}
