// ignore_for_file: invalid_use_of_protected_member

import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class GenerateKelompokController extends GetxController {
  var checkboxValue = true.obs;
  var filterAgamaActive = false.obs;
  var filterJKActive = false.obs;
  var namaKelas = ["RPL 1", "RPL 2", "RPL 3", "TKJ 1", "TKJ 2"].obs;
  var agamaSiswa = ["ISLAM", "HINDU", "KRISTEN", "BUDDHA", "KONGHUCU"].obs;
  var selectedKelas = ''.obs;
  var selectedAgamaFilter = ''.obs;
  var kelasTerpilih = <dynamic>[].obs;
  var agamaTerpilih = <dynamic>[].obs;
  var jenisKelaminTerpilih = <dynamic>[].obs;
  var jKSiswa = "".obs;

  final Map<String, String> kelasJsonMap = {
    "RPL 1": 'assets/json/rpl1.json',
    "RPL 2": 'assets/json/rpl2.json',
    "RPL 3": 'assets/json/rpl3.json',
    "TKJ 1": 'assets/json/tkj1.json',
    "TKJ 2": 'assets/json/tkj2.json',
  };

  void kelasDipilih(String value) async {
    if (kelasJsonMap.containsKey(value)) {
      var data = await rootBundle.loadString(kelasJsonMap[value]!);
      List<dynamic> jsonResult = jsonDecode(data);
      kelasTerpilih.assignAll(jsonResult);
    } else {
      kelasTerpilih.clear();
    }
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

  void toggleAgama(String value) {
    if (selectedAgamaFilter.value == value) {
      selectedAgamaFilter.value = '';
      agamaTerpilih.clear();
    } else {
      selectedAgamaFilter.value = value;
      filterAgamaTerpilih();
    }
  }

  void filterAgamaTerpilih() {
    if (selectedAgamaFilter.value.isEmpty) {
      agamaTerpilih.clear();
    } else {
      var siswaDenganAgama = kelasTerpilih
          .where((siswa) => siswa["agama"] == selectedAgamaFilter.value)
          .toList();
      agamaTerpilih.assignAll(siswaDenganAgama);
      print(siswaDenganAgama);
    }
  }

  void toggleFilterAgama() {
    filterAgamaActive.value = !filterAgamaActive.value;
    if (!filterAgamaActive.value) {
      selectedAgamaFilter.value = '';
      agamaTerpilih.clear();
    }
  }

  void toggleFilterJK() {
    filterJKActive.value = !filterJKActive.value;
    if (!filterJKActive.value) {
      jenisKelaminTerpilih.clear();
    }
  }

  void toggleJK(String value) {
    jKSiswa.value = value; 
    if (value == "Laki-Laki" || value == "Perempuan") {
      String jk = value == "Laki-Laki" ? "L" : "P";
      var filteredList =
          filterAgamaActive.value ? agamaTerpilih : kelasTerpilih;
      var jenisKelaminSiswa =
          filteredList.where((siswa) => siswa["jenis_kelamin"] == jk).toList();
      jenisKelaminTerpilih.assignAll(jenisKelaminSiswa);
      print(jenisKelaminSiswa);
    }
  }

  bool toggleFilterCheckBox() {
    return checkboxValue.value = !checkboxValue.value;
  }

  // TEXT FIELD
  TextEditingController titleC = TextEditingController();
  TextEditingController jumlahKelompok = TextEditingController();
  TextEditingController jumlahAnggotaKelompok = TextEditingController();
  FocusNode focusNodeC = FocusNode();
  FocusNode focusNodeJ = FocusNode();
  FocusNode focusNodeA = FocusNode();
  var currentStep = 1.obs;

  void setCurrentStep(int step) {
    currentStep.value = step;
  }
}
