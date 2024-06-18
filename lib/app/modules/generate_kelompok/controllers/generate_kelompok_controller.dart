import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class GenerateKelompokController extends GetxController {
  var namaKelas = ["RPL 1", "RPL 2", "RPL 3", "TKJ 1", "TKJ 2"].obs;
  var selectedKelas = ''.obs;
  var kelasTerpilih = <dynamic>[].obs;

  void kelasDipilih(String value) async {
    var data = "".obs;
    if (value == "RPL 1") {
      data.value = await rootBundle.loadString('assets/json/rpl1.json');
    } else if (value == "RPL 2") {
      data.value = await rootBundle.loadString('assets/json/rpl2.json');
    } else if (value == "RPL 3") {
      data.value = await rootBundle.loadString('assets/json/rpl3.json');
    } else if (value == "TKJ 1") {
      data.value = await rootBundle.loadString('assets/json/tkj1.json');
    } else if (value == "TKJ 2") {
      data.value = await rootBundle.loadString('assets/json/tkj2.json');
    } else {
      return;
    }

    List<dynamic> jsonResult = jsonDecode(data.value);
    kelasTerpilih.assignAll(jsonResult);
  }

  void toggleSelection(String value) {
    if (selectedKelas.value == value) {
      selectedKelas.value = '';
      kelasTerpilih.clear();
    } else {
      selectedKelas.value = value;
      kelasDipilih(value);
    }
  }

  TextEditingController titleC = TextEditingController();
  FocusNode focusNodeC = FocusNode();
  var currentStep = 1.obs;

  void setCurrentStep(int step) {
    currentStep.value = step;
  }
}
