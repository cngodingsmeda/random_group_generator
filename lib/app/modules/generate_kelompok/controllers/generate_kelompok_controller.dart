import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:random_group_generator/app/routes/app_pages.dart';

class GenerateKelompokController extends GetxController {
  var checkboxValue = true.obs;
  var filterAgamaActive = false.obs;
  var filterJKActive = false.obs;
  var namaKelas = [
    "RPL 1",
    "RPL 2",
    "RPL 3",
    "TKJ 1",
    "TKJ 2",
    "TKJ 3",
    "AKL 1",
    "AKL 2",
    "BDG",
    "BRT 1",
    "BRT 2",
    "LPS",
  ].obs;
  var agamaSiswa = ["ISLAM", "HINDU", "KRISTEN", "BUDDHA", "KONGHUCU"].obs;
  var selectedKelas = ''.obs;
  var selectedAgamaFilter = ''.obs;
  var kelasTerpilih = <dynamic>[].obs;
  var agamaTerpilih = <dynamic>[].obs;
  var jumlahSiswaTerpilih = <dynamic>[].obs;
  var jenisKelaminTerpilih = <dynamic>[].obs;
  var jKSiswa = "".obs;
  var titleKelompok = "".obs;
  var jumlahKelompokSet = "";
  var jumlahAnggotaKelompokSet = "";

  final Map<String, String> kelasJsonMap = {
    "RPL 1": 'assets/json/rpl1.json',
    "RPL 2": 'assets/json/rpl2.json',
    "RPL 3": 'assets/json/rpl3.json',
    "TKJ 1": 'assets/json/tkj1.json',
    "TKJ 2": 'assets/json/tkj2.json',
    "TKJ 3": 'assets/json/tkj3.json',
    "AKL 1": 'assets/json/akl1.json',
    "AKL 2": 'assets/json/akl2.json',
    "BDG": 'assets/json/bdg.json',
    "BRT 1": 'assets/json/brt_1.json',
    "BRT 2": 'assets/json/brt_2.json',
    "LPS": 'assets/json/lps.json',
  };

  void kelasDipilih(String value) async {
    if (kelasJsonMap.containsKey(value)) {
      var data = await rootBundle.loadString(kelasJsonMap[value]!);
      List<dynamic> jsonResult = jsonDecode(data);
      kelasTerpilih.assignAll(jsonResult);
    } else {
      kelasTerpilih.clear();
    }
    update();
  }

  void toggleSelection(String value) {
    if (selectedKelas.value == value) {
      selectedKelas.value = '';
      kelasTerpilih.clear();
    } else {
      selectedKelas.value = value;
      kelasDipilih(value);
    }
    update();
  }

  void toggleAgama(String value) {
    if (selectedAgamaFilter.value == value) {
      selectedAgamaFilter.value = '';
      agamaTerpilih.clear();
    } else {
      selectedAgamaFilter.value = value;
      filterAgamaTerpilih();
    }
    update();
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
    update();
  }

  void toggleFilterAgama() {
    filterAgamaActive.value = !filterAgamaActive.value;
    if (!filterAgamaActive.value) {
      selectedAgamaFilter.value = '';
      agamaTerpilih.clear();
    }
    update();
  }

  void toggleFilterJK() {
    filterJKActive.value = !filterJKActive.value;
    if (!filterJKActive.value) {
      jenisKelaminTerpilih.clear();
    }
    update();
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
    update();
  }

  bool toggleFilterCheckBox() {
    checkboxValue.value = !checkboxValue.value;
    return checkboxValue.value;
  }

  void jumlahSiswa() {
    if (jenisKelaminTerpilih.isNotEmpty) {
      jumlahSiswaTerpilih.assignAll(jenisKelaminTerpilih);
    } else if (agamaTerpilih.isNotEmpty) {
      jumlahSiswaTerpilih.assignAll(agamaTerpilih);
    } else if (kelasTerpilih.isNotEmpty) {
      jumlahSiswaTerpilih.assignAll(kelasTerpilih);
    }
    update();
  }

  var kelompokList = <List<dynamic>>[].obs;

  void generateKelompok() {
    int jumlahKelompok = int.tryParse(jumlahKelompokSet) ?? 1;
    int.tryParse(jumlahAnggotaKelompokSet) ??
        (jumlahSiswaTerpilih.length / jumlahKelompok).ceil();

    List<dynamic> siswaTerpilih = List.from(jumlahSiswaTerpilih);
    siswaTerpilih.shuffle();

    kelompokList.clear();
    for (int i = 0; i < jumlahKelompok; i++) {
      kelompokList.add([]);
    }

    for (int i = 0; i < siswaTerpilih.length; i++) {
      kelompokList[i % jumlahKelompok].add(siswaTerpilih[i]);
    }

    print("Kelompok List: $kelompokList");
    print("Jumlah Kelompok: ${kelompokList.length}");

    update();
  }

  // Text Editing Controllers
  TextEditingController titleC = TextEditingController();
  TextEditingController jumlahKelompok = TextEditingController();
  TextEditingController jumlahAnggotaKelompok = TextEditingController();
  FocusNode focusNodeC = FocusNode();
  FocusNode focusNodeJ = FocusNode();
  FocusNode focusNodeA = FocusNode();

  void setJumlahKelompok() {
    if (jumlahKelompok.text.isNotEmpty) {
      jumlahKelompokSet = jumlahKelompok.text.toUpperCase();
    } else {
      jumlahKelompokSet = "6";
    }
    update();
  }

  void setJumlahAnggotaKelompok() {
    if (jumlahAnggotaKelompok.text.isNotEmpty) {
      jumlahAnggotaKelompokSet = jumlahAnggotaKelompok.text.toUpperCase();
    } else {
      jumlahAnggotaKelompokSet = "8";
    }
  }

  void setTitle() {
    if (titleC.text.isNotEmpty) {
      titleKelompok.value = titleC.text.toUpperCase();
    } else {
      titleKelompok.value = "KELOMPOK";
    }
    update();
  }

  var currentStep = 1.obs;

  void setCurrentStep(int step) {
    currentStep.value = step;
  }

  // Histori
  var histori = [].obs;

  void addToHistory(String title, String kelas, List kelompok) {
    histori.add({'title': title, 'kelas': kelas, 'kelompok': kelompok});
    Get.toNamed(Routes.HOME);
  }

  void clearHistory() {
    histori.clear();
  }

  void resetState() {
    currentStep.value = 1;
    kelasTerpilih.clear();
    agamaTerpilih.clear();
    titleC.clear();
    selectedKelas.value = "";
    kelasDipilih("Clear");
    filterAgamaActive.value = false;
    filterJKActive.value = false;
    selectedAgamaFilter.value = "";
    jenisKelaminTerpilih.clear();
    jumlahSiswaTerpilih.clear();
    jKSiswa.value = '';
    titleKelompok.value = 'KELOMPOK';
    jumlahKelompokSet = '';
    jumlahAnggotaKelompokSet = '';
    kelompokList.clear();
  }
}
