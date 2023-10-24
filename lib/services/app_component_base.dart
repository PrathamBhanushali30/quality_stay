import 'dart:async';

import 'package:get/get_rx/src/rx_types/rx_types.dart';

class AppBaseComponent {
  AppBaseComponent._privateConstructor();

  RxBool completed = true.obs;
  static final AppBaseComponent instance =
  AppBaseComponent._privateConstructor();

  final StreamController<bool> progressStreamController =
  StreamController<bool>.broadcast();

  Stream<bool> get progressStream => progressStreamController.stream;

  void startLoading() {
    completed(false);
    Future.delayed(
      const Duration(milliseconds: 100),
          () {
        progressStreamController.sink.add(true);
      },
    );
  }

  void stopLoading() {
    progressStreamController.sink.add(false);
    Future.delayed(
      const Duration(milliseconds: 200),
          () {
        completed(true);
      },
    );
  }
}