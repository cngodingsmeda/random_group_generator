import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class GenerateKelompokController extends GetxController {
  var isGenPiket = false.obs;
  var checkboxValue = true.obs;
  var filterAgamaActive = false.obs;
  var filterJKActive = false.obs;
  var namaHari = [
    "SENIN",
    "SELASA",
    "RABU",
    "KAMIS",
    "JUMAT",
    "SABTU",
  ];
  var namaKelas = [
    "X RPL 1",
    "X RPL 2",
    "X TKJ 1",
    "X TKJ 2",
    "X TKJ 3",
    "X AKL 1",
    "X AKL 2",
    "X AKL 3",
    "X MPK 1",
    "X MPK 2",
    "X BDG 1",
    "X BDG 2",
    "X BRT 1",
    "X BRT 2",
    "X ULW 1",
    "X ULW 2",
    "XI RPL 1",
    "XI RPL 2",
    "XI RPL 3",
    "XI TKJ 1",
    "XI TKJ 2",
    "XI TKJ 3",
    "XI AKL 1",
    "XI AKL 2",
    "XI MPK 1",
    "XI MPK 2",
    "XI BDG",
    "XI BRT 1",
    "XI BRT 2",
    "XI ULW",
    "XI LPS",
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
    "X RPL 1": 'assets/json/24/rpl1.json',
    "X RPL 2": 'assets/json/24/rpl2.json',
    "X TKJ 1": 'assets/json/24/tkj1.json',
    "X TKJ 2": 'assets/json/24/tkj2.json',
    "X TKJ 3": 'assets/json/24/tkj3.json',
    "X AKL 1": 'assets/json/24/akl1.json',
    "X AKL 2": 'assets/json/24/akl2.json',
    "X AKL 3": 'assets/json/24/akl3.json',
    "X MPK 1": 'assets/json/24/mpk1.json',
    "X MPK 2": 'assets/json/24/mpk2.json',
    "X BDG 1": 'assets/json/24/bdg1.json',
    "X BDG 2": 'assets/json/24/bdg2.json',
    "X BRT 1": 'assets/json/24/brt1.json',
    "X BRT 2": 'assets/json/24/brt2.json',
    "X ULW 1": 'assets/json/24/ulw1.json',
    "X ULW 2": 'assets/json/24/ulw2.json',
    "XI RPL 1": 'assets/json/23/rpl1.json',
    "XI RPL 2": 'assets/json/23/rpl2.json',
    "XI RPL 3": 'assets/json/23/rpl3.json',
    "XI TKJ 1": 'assets/json/23/tkj1.json',
    "XI TKJ 2": 'assets/json/23/tkj2.json',
    "XI TKJ 3": 'assets/json/23/tkj3.json',
    "XI AKL 1": 'assets/json/23/akl1.json',
    "XI AKL 2": 'assets/json/23/akl2.json',
    "XI MPK 1": 'assets/json/23/mpk1.json',
    "XI MPK 2": 'assets/json/23/mpk2.json',
    "XI BDG": 'assets/json/23/bdg.json',
    "XI BRT 1": 'assets/json/23/brt1.json',
    "XI BRT 2": 'assets/json/23/brt2.json',
    "XI ULW": 'assets/json/23/ulw.json',
    "XI LPS": 'assets/json/23/lps.json',
  };

  void kelasDipilih(String value) async {
    if (kelasJsonMap.containsKey(value)) {
      var data = await rootBundle.loadString(kelasJsonMap[value]!);
      List<dynamic> jsonResult = jsonDecode(data);
      kelasTerpilih.assignAll(jsonResult..shuffle());
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
      jumlahSiswaTerpilih.assignAll(agamaTerpilih.reversed);
    } else if (kelasTerpilih.isNotEmpty) {
      jumlahSiswaTerpilih.assignAll(kelasTerpilih.reversed);
    }
    update();
  }

  var kelompokList = <List<dynamic>>[].obs;

  void generateKelompok() {
    RxList<dynamic> kelompokAcak = jumlahSiswaTerpilih..shuffle();
    int jumlahKelompok = int.tryParse(jumlahKelompokSet) ?? 1;
    int.tryParse(jumlahAnggotaKelompokSet) ??
        (kelompokAcak.length / jumlahKelompok).ceil();

    List<dynamic> siswaTerpilih = List.from(kelompokAcak);
    siswaTerpilih.shuffle();

    kelompokList.clear();
    for (int i = 0; i < jumlahKelompok; i++) {
      kelompokList.add([]);
    }

    for (int i = 0; i < siswaTerpilih.length; i++) {
      kelompokList[i % jumlahKelompok].add(siswaTerpilih[i]);
    }

    update();
    addToHistory(
      titleKelompok.value,
      selectedKelas.value,
      kelompokList,
    );
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
      titleKelompok.value = "KELOMPOK ${titleC.text.toUpperCase()}";
    } else {
      titleKelompok.value = "KELOMPOK";
    }
    update();
  }

  var currentStep = 1.obs;

  void setCurrentStep(int step) {
    currentStep.value = step;
  }

  // Dark Mode
  RxBool isDarkMode = false.obs;
  void toggleTheme() {
    isDarkMode.value = !isDarkMode.value;
    _storage.write('isDarkMode', isDarkMode.value);
    Get.changeThemeMode(isDarkMode.value ? ThemeMode.dark : ThemeMode.light);
    print(_storage.read("isDarkMode"));
  }

  // Histori
  final GetStorage _storage = GetStorage();
  var histori = <Map<String, dynamic>>[].obs;

  @override
  void onInit() {
    super.onInit();
    loadHistory();
    isDarkMode.value = _storage.read('isDarkMode') ?? false;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Get.changeThemeMode(isDarkMode.value ? ThemeMode.dark : ThemeMode.light);
    });
  }

  void loadHistory() {
    var storedHistory = _storage
            .read<List<dynamic>>('histori')
            ?.map((e) => Map<String, dynamic>.from(e))
            .toList() ??
        [];
    histori.value = storedHistory;
  }

  void addToHistory(String title, String kelas, List kelompok) {
    if (histori.length >= 2) {
      histori.removeAt(0);
    }

    // Create a deep copy of the kelompok list
    List copiedKelompok = kelompok.map((group) => List.from(group)).toList();

    histori.add({'title': title, 'kelas': kelas, 'kelompok': copiedKelompok});
    _storage.write('histori', histori.toList());
    update();
  }

  void removeFromHistory(int index) {
    histori.removeAt(index);
    _storage.write('histori', histori.toList());
  }

  void clearHistory() {
    histori.clear();
    _storage.remove('histori');
  }

  void resetState() {
    currentStep.value = 1;
    kelasTerpilih.clear();
    agamaTerpilih.clear();
    titleC.clear();
    jumlahKelompok.clear();
    jumlahAnggotaKelompok.clear();
    selectedKelas.value = "";
    kelasDipilih("Clear");
    filterAgamaActive.value = false;
    filterJKActive.value = false;
    // focusNodeC.unfocus();
    // focusNodeA.unfocus();
    // focusNodeJ.unfocus();
    selectedAgamaFilter.value = "";
    jenisKelaminTerpilih.clear();
    checkboxValue.value = true;
    jumlahSiswaTerpilih.clear();
    jKSiswa.value = '';
    titleKelompok.value = 'KELOMPOK';
    isGenPiket.value = false;
    jumlahKelompokSet = '';
    jumlahAnggotaKelompokSet = '';
    kelompokList.clear();
    checkboxValue.value = true;
  }
}
