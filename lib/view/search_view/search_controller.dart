import 'dart:async';

import 'package:get/get.dart';

class SearchViewController extends GetxController {
  Timer? timer;
  String searchText = "";
  void handleSearch(String value) {
    if (timer != null) timer?.cancel();
    timer = Timer(const Duration(milliseconds: 300), () {
      searchText = value.toLowerCase();

      update();
    });
  }
}
