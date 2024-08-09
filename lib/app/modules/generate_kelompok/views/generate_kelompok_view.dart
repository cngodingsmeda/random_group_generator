// ignore_for_file: must_be_immutable, prefer_typing_uninitialized_variables

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:random_group_generator/app/routes/app_pages.dart';
import 'package:random_group_generator/constants/all_material.dart';
import 'package:share_plus/share_plus.dart';

import '../controllers/generate_kelompok_controller.dart';

class GenerateKelompokView extends GetView<GenerateKelompokController> {
  const GenerateKelompokView({super.key});

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(GenerateKelompokController());
    var scrollController = Get.put(ScrollController());
    return PopScope(
      canPop: false,
      child: Scaffold(
        // backgroundColor: Colors.white,
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                Expanded(
                  child: Obx(
                    () => SingleChildScrollView(
                      physics: (controller.currentStep.value == 4)
                          ? const NeverScrollableScrollPhysics()
                          : const AlwaysScrollableScrollPhysics(),
                      controller: scrollController,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Appbar
                          (controller.currentStep.value == 1)
                              ? const Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.all(8),
                                      child: Text(
                                        "Pilih Kelas",
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: AllMaterial.fontExtraBold,
                                          // color: AllMaterial.colorBlackPrimary,
                                        ),
                                      ),
                                    ),
                                  ],
                                )
                              : Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    (controller.currentStep.value == 1)
                                        ? const SizedBox.shrink()
                                        : Opacity(
                                            opacity:
                                                (controller.currentStep.value !=
                                                        4)
                                                    ? 1
                                                    : 0,
                                            child: InkWell(
                                              borderRadius:
                                                  BorderRadius.circular(15),
                                              onTap: () {
                                                if (controller
                                                        .currentStep.value !=
                                                    4) {
                                                  if (controller
                                                          .currentStep.value >
                                                      1) {
                                                    controller.setCurrentStep(
                                                        controller.currentStep
                                                                .value -
                                                            1);
                                                  } else {
                                                    Get.back();
                                                    GenerateKelompokController()
                                                        .dispose();
                                                  }
                                                } else {
                                                  null;
                                                }
                                              },
                                              child: const Padding(
                                                padding: EdgeInsets.all(8),
                                                child: Text(
                                                  "Batal",
                                                  style: TextStyle(
                                                    fontSize: 14,
                                                    fontWeight: AllMaterial
                                                        .fontExtraBold,
                                                    color: AllMaterial
                                                        .colorBluePrimary,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                    Obx(() => Text(
                                          _getTitle(
                                              controller.currentStep.value),
                                          style: TextStyle(
                                            fontSize: 16,
                                            fontWeight:
                                                AllMaterial.fontExtraBold,
                                            color: controller.isDarkMode.value
                                                ? AllMaterial.colorWhite
                                                : AllMaterial.colorBlackPrimary,
                                          ),
                                        )),
                                    Obx(
                                      () => Opacity(
                                        opacity:
                                            (controller.currentStep.value == 4)
                                                ? 1
                                                : 0,
                                        child: InkWell(
                                          borderRadius:
                                              BorderRadius.circular(15),
                                          onTap: () async {
                                            String whatsappMessage =
                                                generateWhatsappMessage();
                                            final result = await Share.share(
                                                whatsappMessage);
                                            if (result.status ==
                                                ShareResultStatus.success) {
                                              print(
                                                  'Berhasil berbagi pesan WhatsApp!');
                                              // Menyimpan ke data title dan kelas ke dalam variabel histori, ketika ditekan akan mengarahkan ke page review tanpa tombol batal yang dapat diakses kapan saja
                                            } else {
                                              print(
                                                'Gagal berbagi pesan WhatsApp.',
                                              );
                                            }
                                          },
                                          child: const Padding(
                                            padding: EdgeInsets.all(8),
                                            child: Text(
                                              "Share",
                                              style: TextStyle(
                                                fontSize: 14,
                                                fontWeight:
                                                    AllMaterial.fontExtraBold,
                                                color: AllMaterial
                                                    .colorBluePrimary,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),

                          // Stepper
                          Container(
                            margin: const EdgeInsets.symmetric(
                                vertical: 20, horizontal: 5),
                            width: Get.width,
                            child: Obx(() {
                              return Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  StepperWidget(
                                    number: "1",
                                    titleText: "Pilih Kelas",
                                    isActive: controller.currentStep.value >= 1,
                                    isCompleted:
                                        controller.currentStep.value > 1,
                                  ),
                                  StepperWidget(
                                    number: "2",
                                    titleText: "Filter",
                                    isActive: controller.currentStep.value >= 2,
                                    isCompleted:
                                        controller.currentStep.value > 2,
                                  ),
                                  StepperWidget(
                                    number: "3",
                                    titleText: "Generate",
                                    isActive: controller.currentStep.value >= 3,
                                    isCompleted:
                                        controller.currentStep.value > 3,
                                  ),
                                  StepperWidget(
                                    number: "4",
                                    titleText: "Review",
                                    isActive: controller.currentStep.value >= 4,
                                    isCompleted:
                                        controller.currentStep.value > 4,
                                  ),
                                ],
                              );
                            }),
                          ),

                          // Text & Title
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 13),
                            child: Obx(
                              () => Text(
                                _getSubTitle(controller.currentStep.value),
                                style: const TextStyle(
                                  // color: AllMaterial.colorBlackPrimary,
                                  fontSize: 16,
                                  fontWeight: AllMaterial.fontBlack,
                                ),
                              ),
                            ),
                          ),
                          Obx(
                            () => Text(
                              _getTitleSub(controller.currentStep.value),
                              style: const TextStyle(
                                  // color: AllMaterial.colorGreyPrimary,
                                  ),
                            ),
                          ),

                          Obx(() =>
                              _getPageWidget(controller.currentStep.value)),
                        ],
                      ),
                    ),
                  ),
                ),
                Obx(
                  () {
                    if (controller.currentStep.value == 2) {
                      return Container(
                        width: Get.width,
                        height: Get.height * 0.17,
                        // color: const Color.fromARGB(11, 255, 255, 255),
                        alignment: Alignment.bottomCenter,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Obx(
                              () => CheckboxListTile(
                                checkColor: AllMaterial.colorWhite,
                                fillColor: (controller.checkboxValue.isTrue)
                                    ? const WidgetStatePropertyAll(
                                        AllMaterial.colorBluePrimary)
                                    : const WidgetStatePropertyAll(
                                        AllMaterial.colorWhite,
                                      ),
                                value: controller.checkboxValue.value,
                                onChanged: (value) {
                                  controller.checkboxValue.value = value!;
                                },
                                title: const Text(
                                  "Gunakan filter default",
                                  style: TextStyle(
                                    fontSize: 16,
                                    // color: AllMaterial.colorBlackPrimary,
                                    fontWeight: AllMaterial.fontMedium,
                                  ),
                                ),
                                subtitle: const Text(
                                  "(matikan ceklis untuk mengatur filter)",
                                  style: TextStyle(
                                    fontSize: 13,
                                    // color: AllMaterial.colorGreyPrimary,
                                  ),
                                ),
                                controlAffinity:
                                    ListTileControlAffinity.leading,
                              ),
                            ),
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                shape: const RoundedRectangleBorder(
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(12),
                                  ),
                                ),
                                fixedSize: Size(Get.width, 48),
                                backgroundColor: AllMaterial.colorBluePrimary,
                              ),
                              onPressed: () {
                                if (controller.currentStep.value < 4) {
                                  controller.setCurrentStep(
                                    controller.currentStep.value + 1,
                                  );
                                  controller.jumlahSiswa();
                                }
                              },
                              child: const Text(
                                "Lanjutkan",
                                style: TextStyle(
                                  color: AllMaterial.colorWhite,
                                  fontWeight: AllMaterial.fontSemiBold,
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    } else if (controller.currentStep.value == 3) {
                      return Container(
                        width: Get.width,
                        alignment: Alignment.bottomCenter,
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text(
                                  "Banyak Siswa",
                                  style: TextStyle(
                                    fontSize: 18,
                                    color: AllMaterial.colorGreyPrimary,
                                  ),
                                ),
                                Text(
                                  "${controller.jumlahSiswaTerpilih.length}",
                                  style: const TextStyle(
                                    fontSize: 18,
                                    fontWeight: AllMaterial.fontBold,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 10),
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                shape: const RoundedRectangleBorder(
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(12),
                                  ),
                                ),
                                fixedSize: Size(Get.width, 48),
                                backgroundColor: AllMaterial.colorBluePrimary,
                              ),
                              onPressed: () {
                                if (controller.currentStep.value < 4) {
                                  controller.setCurrentStep(
                                    controller.currentStep.value + 1,
                                  );
                                  controller.setJumlahKelompok();
                                  controller.setJumlahAnggotaKelompok();
                                  controller.generateKelompok();
                                }
                              },
                              child: const Text(
                                "Lanjutkan",
                                style: TextStyle(
                                  color: AllMaterial.colorWhite,
                                  fontWeight: AllMaterial.fontSemiBold,
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    } else if (controller.currentStep.value == 4) {
                      return Container(
                        width: Get.width,
                        alignment: Alignment.bottomCenter,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            shape: const RoundedRectangleBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(12),
                              ),
                            ),
                            fixedSize: Size(Get.width, 48),
                            backgroundColor: AllMaterial.colorBluePrimary,
                          ),
                          onPressed: () {
                            Get.offAllNamed(Routes.HOME);
                          },
                          child: const Text(
                            "Selesai",
                            style: TextStyle(
                              color: AllMaterial.colorWhite,
                              fontWeight: AllMaterial.fontSemiBold,
                            ),
                          ),
                        ),
                      );
                    } else {
                      return Container(
                        width: Get.width,
                        alignment: Alignment.bottomCenter,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            shape: const RoundedRectangleBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(12),
                              ),
                            ),
                            fixedSize: Size(Get.width, 48),
                            backgroundColor: AllMaterial.colorBluePrimary,
                          ),
                          onPressed: () {
                            if (controller.currentStep.value < 4 &&
                                controller.selectedKelas.value != "") {
                              controller.setCurrentStep(
                                controller.currentStep.value + 1,
                              );
                              controller.setTitle();
                            } else {
                              Get.bottomSheet(BottomSheet(
                                onClosing: () {},
                                builder: (context) {
                                  return Container(
                                    decoration: BoxDecoration(
                                      color: controller.isDarkMode.value ? Colors.black : AllMaterial.colorWhite,
                                      borderRadius: BorderRadius.circular(25),
                                    ),
                                    width: Get.width,
                                    height: 120,
                                    padding: const EdgeInsets.all(20),
                                    child: const Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "Kesalahan!",
                                          style: TextStyle(
                                            fontSize: 17,
                                            fontWeight: AllMaterial.fontBold,
                                          ),
                                        ),
                                        SizedBox(height: 5),
                                        Text("Harap Pilih Kelas Anda!"),
                                      ],
                                    ),
                                  );
                                },
                              ));
                            }
                          },
                          child: const Text(
                            "Lanjutkan",
                            style: TextStyle(
                              color: AllMaterial.colorWhite,
                              fontWeight: AllMaterial.fontSemiBold,
                            ),
                          ),
                        ),
                      );
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  String _getTitle(int step) {
    switch (step) {
      case 1:
        return "Pilih Kelas";
      case 2:
        return "Filter";
      case 3:
        return "Generate";
      case 4:
        return "Review";
      default:
        return "Pilih Kelas";
    }
  }

  String _getSubTitle(int step) {
    switch (step) {
      case 1:
        return "Tentukan kelas Anda!";
      case 2:
        return "Atur kelompok Anda!";
      case 3:
        return "Tentukan kelompok Anda!";
      case 4:
        return "Kelompok Anda!";
      default:
        return "";
    }
  }

  String _getTitleSub(int step) {
    switch (step) {
      case 1:
        return "Pilih sesuai kebutuhan";
      case 2:
        return "Terkadang anggota kelompok memiliki kriteria masing-masing, atur filter sesuai kebutuhan";
      case 3:
        return "Lihat dulu, berapa kelompok yang kamu inginkan";
      case 4:
        return "Kurang puas? segala aksi sebelumnya tidak dapat diulang kembali, pilih Selesai kemudian ulangi";
      default:
        return "";
    }
  }

  Widget _getPageWidget(int step) {
    switch (step) {
      case 1:
        return PilihKelas(controller: controller);
      case 2:
        return FutureBuilder(
          future: Future.delayed(const Duration(milliseconds: 20)),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              return FilterPage(controller: controller);
            } else {
              return const SizedBox.shrink();
            }
          },
        );
      case 3:
        return GeneratePage(controller: controller);
      case 4:
        return FutureBuilder(
          future: Future.delayed(const Duration(seconds: 1)),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              return ReviewPage(controller: controller);
            } else {
              return const Padding(
                padding: EdgeInsets.only(top: 40),
                child: Center(
                  child: CircularProgressIndicator(
                    color: AllMaterial.colorBluePrimary,
                  ),
                ),
              );
            }
          },
        );
      default:
        return const Center(
          child: Text("Gheral Ganteng"),
        );
    }
  }

  String generateWhatsappMessage() {
    String message =
        "*${controller.titleKelompok.value} ${controller.selectedKelas.value}*\n\n";
    for (int i = 0; i < controller.kelompokList.length; i++) {
      message += "Kelompok ${i + 1}:\n";
      var group = controller.kelompokList[i];
      for (var siswa in group) {
        message += "${siswa["nama"]}\n";
      }
      message += "\n";
    }
    return message;
  }
}

class ReviewPage extends StatelessWidget {
  final GenerateKelompokController controller;

  const ReviewPage({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    print("Kelompok List: ${controller.kelompokList}");
    print("Panjang Kelompok List: ${controller.kelompokList.length}");

    return Container(
      margin: const EdgeInsets.all(14),
      padding: const EdgeInsets.only(top: 15, left: 15, right: 15, bottom: 30),
      width: Get.width,
      height: Get.height,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: const Color(0xffD4D6DD),
          width: 1,
        ),
      ),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Text(
                '${controller.titleKelompok.value} ${controller.selectedKelas.value}',
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                  // color: Colors.black,
                ),
              ),
            ),
            const SizedBox(height: 16),
            if (controller.kelompokList.isNotEmpty)
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: List.generate(
                  controller.kelompokList.length,
                  (index) {
                    var group = controller.kelompokList[index];
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Kelompok ${index + 1}:',
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                            // color: Colors.black,
                          ),
                        ),
                        const SizedBox(height: 8),
                        ...group.map(
                          (siswa) => Text(
                            '${siswa["nama"]}',
                          ),
                        ),
                        const SizedBox(height: 16),
                      ],
                    );
                  },
                ),
              ),
            SizedBox(height: Get.height * 0.45),
          ],
        ),
      ),
    );
  }
}

class FilterPage extends StatefulWidget {
  final GenerateKelompokController controller;
  const FilterPage({super.key, required this.controller});

  @override
  State<FilterPage> createState() => _FilterPageState();
}

class _FilterPageState extends State<FilterPage> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback(
      (_) {
        _scrollController.animateTo(
          0.0,
          duration: const Duration(milliseconds: 0),
          curve: Curves.easeInOut,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Opacity(
        opacity: widget.controller.checkboxValue.isFalse ? 1 : 0,
        child: Container(
          margin: const EdgeInsets.only(top: 14),
          padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 8),
          width: Get.width,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: const Color(0xffD4D6DD),
              width: 1,
            ),
          ),
          child: SingleChildScrollView(
            controller: _scrollController,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Tentukan Agama
                Column(
                  children: [
                    GestureDetector(
                      onTap: () {
                        widget.controller.toggleFilterAgama();
                      },
                      child: Obx(
                        () => Row(
                          children: [
                            Container(
                              alignment: Alignment.center,
                              width: 22,
                              height: 22,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                                color: widget.controller.filterAgamaActive.value
                                    ? AllMaterial.colorBluePrimary
                                    : AllMaterial.colorGreySec,
                              ),
                              child: Container(
                                width: 8,
                                height: 8,
                                decoration: BoxDecoration(
                                  color:
                                      widget.controller.filterAgamaActive.value
                                          ? AllMaterial.colorWhite
                                          : Colors.white,
                                  borderRadius: BorderRadius.circular(15),
                                ),
                              ),
                            ),
                            const SizedBox(width: 8),
                            const Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Filter Berdasarkan Agama",
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                    // color: Color(0xff6C6C6C),
                                  ),
                                ),
                                Text(
                                  "(untuk kebutuhan Kelompok Agama)",
                                  style: TextStyle(
                                    fontSize: 14,
                                    // color: Color(0xffB0B0B0),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 15),
                    Obx(() {
                      return Wrap(
                        spacing: 10.0,
                        children:
                            widget.controller.agamaSiswa.map((String agama) {
                          return ChoiceChip(
                            checkmarkColor: AllMaterial.colorWhite,
                            label: Text(
                              agama,
                              style: TextStyle(
                                color: widget.controller.filterAgamaActive.value
                                    ? AllMaterial.colorWhite
                                    : AllMaterial.colorGreyPrimary,
                              ),
                            ),
                            elevation: 0,
                            side: const BorderSide(
                              width: 0,
                              color: Colors.transparent,
                            ),
                            selected:
                                widget.controller.selectedAgamaFilter.value ==
                                    agama,
                            onSelected:
                                widget.controller.filterAgamaActive.value
                                    ? (bool selected) {
                                        widget.controller.toggleAgama(agama);
                                      }
                                    : null,
                            selectedColor: AllMaterial.colorBluePrimary,
                            disabledColor:
                                AllMaterial.colorWhite.withOpacity(0.1),
                            backgroundColor: widget.controller.isDarkMode.value
                                ? AllMaterial.colorGreyPrimary.withOpacity(0.4)
                                : AllMaterial.colorBlueSec,
                          );
                        }).toList(),
                      );
                    }),
                  ],
                ),
                const SizedBox(height: 24),

                // Tentukan Jenis Kelamin
                Column(
                  children: [
                    GestureDetector(
                      onTap: () {
                        widget.controller.toggleFilterJK();
                      },
                      child: Obx(
                        () => Row(
                          children: [
                            Container(
                              alignment: Alignment.center,
                              width: 22,
                              height: 22,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                                color: widget.controller.filterJKActive.value
                                    ? AllMaterial.colorBluePrimary
                                    : AllMaterial.colorGreySec,
                              ),
                              child: Container(
                                width: 8,
                                height: 8,
                                decoration: BoxDecoration(
                                  color: widget.controller.filterJKActive.value
                                      ? AllMaterial.colorWhite
                                      : Colors.white,
                                  borderRadius: BorderRadius.circular(15),
                                ),
                              ),
                            ),
                            const SizedBox(width: 8),
                            const Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Filter Berdasarkan Jenis Kelamin",
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                    // color: Color(0xff6C6C6C),
                                  ),
                                ),
                                Text(
                                  "(jika tidak dipilih, nilai default acak)",
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Color(0xffB0B0B0),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 24),
                    InkWell(
                      borderRadius: BorderRadius.circular(12),
                      onTap: widget.controller.filterJKActive.value
                          ? () {
                              widget.controller.toggleJK("Laki-Laki");
                            }
                          : null,
                      child: Obx(
                        () => Container(
                          padding: const EdgeInsets.all(16),
                          alignment: Alignment.centerLeft,
                          width: Get.width,
                          height: 50,
                          decoration: BoxDecoration(
                            border: Border.all(
                              color:  widget.controller.isDarkMode.value ? Colors.transparent : const Color(0xffD4D6DD),
                              width:
                                  widget.controller.jKSiswa.value == "Laki-Laki"
                                      ? 0
                                      : .5,
                            ),
                            color:
                                widget.controller.jKSiswa.value == "Laki-Laki"
                                    ? AllMaterial.colorBluePrimary
                                    : widget.controller.isDarkMode.value ? AllMaterial.colorGreyPrimary.withOpacity(0.4) : Colors.transparent,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Text(
                            "Laki-Laki",
                            style: TextStyle(
                              color:
                                  widget.controller.jKSiswa.value == "Laki-Laki"
                                      ? AllMaterial.colorWhite
                                      : widget.controller.isDarkMode.value ? AllMaterial.colorGreyPrimary.withOpacity(0.4) : AllMaterial.colorBlackPrimary,
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 8),
                    InkWell(
                      borderRadius: BorderRadius.circular(12),
                      onTap: widget.controller.filterJKActive.value
                          ? () {
                              widget.controller.toggleJK("Perempuan");
                            }
                          : null,
                      child: Obx(
                        () => Container(
                          padding: const EdgeInsets.all(16),
                          alignment: Alignment.centerLeft,
                          width: Get.width,
                          height: 50,
                          decoration: BoxDecoration(
                            border: Border.all(
                              color:  widget.controller.isDarkMode.value ? Colors.transparent : const Color(0xffD4D6DD),
                              width:
                                  widget.controller.jKSiswa.value == "Perempuan"
                                      ? 0
                                      : .5,
                            ),
                            borderRadius: BorderRadius.circular(12),
                            color:
                                widget.controller.jKSiswa.value == "Perempuan"
                                    ? AllMaterial.colorBluePrimary
                                    : widget.controller.isDarkMode.value ? AllMaterial.colorGreyPrimary.withOpacity(0.4) : Colors.transparent,
                          ),
                          child: Text(
                            "Perempuan",
                            style: TextStyle(
                              color:
                                  widget.controller.jKSiswa.value == "Perempuan"
                                      ? AllMaterial.colorWhite
                                      : widget.controller.isDarkMode.value ? AllMaterial.colorGreyPrimary.withOpacity(0.4) : AllMaterial.colorBlackPrimary,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class PilihKelas extends StatelessWidget {
  const PilihKelas({
    super.key,
    required this.controller,
  });

  final GenerateKelompokController controller;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 14),
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 8),
      width: Get.width,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: const Color(0xffD4D6DD),
          width: 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Title
          const Text(
            "Mata Pelajaran",
            style: TextStyle(
              fontSize: 13,
              // color: AllMaterial.colorGreyPrimary,
              fontWeight: AllMaterial.fontBold,
            ),
          ),
          const SizedBox(height: 8),
          TextField(
            keyboardType: TextInputType.text,
            controller: controller.titleC,
            onTapOutside: (_) {
              controller.focusNodeC.unfocus();
            },
            focusNode: controller.focusNodeC,
            cursorColor: AllMaterial.colorBluePrimary,
            decoration: const InputDecoration(
              hintText: "PPKN",
              contentPadding: EdgeInsets.symmetric(horizontal: 15),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: AllMaterial.colorGreySec,
                ),
                borderRadius: BorderRadius.all(Radius.circular(12)),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(12)),
                borderSide: BorderSide(
                  color: AllMaterial.colorBluePrimary,
                ),
              ),
            ),
          ),
          const SizedBox(height: 25),

          // Pilih Kelas
          const Text(
            "Pilih Kelas",
            style: TextStyle(
              fontSize: 13,
              // color: AllMaterial.colorGreyPrimary,
              fontWeight: AllMaterial.fontBold,
            ),
          ),
          Obx(() {
            return Wrap(
              spacing: 10.0,
              children: controller.namaKelas.map((String kelas) {
                return ChoiceChip(
                  checkmarkColor: AllMaterial.colorWhite,
                  label: Text(
                    kelas,
                    style: const TextStyle(
                      color: AllMaterial.colorWhite,
                    ),
                  ),
                  elevation: 0,
                  side: const BorderSide(
                    width: 0,
                    color: Colors.transparent,
                  ),
                  selected: controller.selectedKelas.value == kelas,
                  onSelected: (bool selected) {
                    controller.toggleSelection(kelas);
                  },
                  selectedColor: AllMaterial.colorBluePrimary,
                  backgroundColor: controller.isDarkMode.value
                      ? AllMaterial.colorGreyPrimary.withOpacity(0.4)
                      : AllMaterial.colorBlueSec,
                );
              }).toList(),
            );
          }),
        ],
      ),
    );
  }
}

class StepperWidget extends StatelessWidget {
  final String number;
  final String titleText;
  final bool isActive;
  final bool isCompleted;

  const StepperWidget({
    super.key,
    required this.titleText,
    required this.number,
    this.isActive = false,
    this.isCompleted = false,
  });

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(GenerateKelompokController());
    return Column(
      children: [
        CircleAvatar(
          backgroundColor: isActive
              ? AllMaterial.colorBluePrimary
              : AllMaterial.colorGreyPattern,
          child: isCompleted
              ? const Icon(Icons.check, color: AllMaterial.colorWhite)
              : Text(
                  number,
                  style: TextStyle(
                    color: isActive
                        ? AllMaterial.colorWhite
                        : AllMaterial.colorGreyPrimary,
                    fontSize: 14,
                    fontWeight: AllMaterial.fontSemiBold,
                  ),
                ),
        ),
        const SizedBox(height: 10),
        Text(
          titleText,
          style: TextStyle(
            color: isActive
                ? controller.isDarkMode.value
                    ? AllMaterial.colorWhite
                    : AllMaterial.colorBlackPrimary
                : controller.isDarkMode.value
                    ? AllMaterial.colorGreyPrimary
                    : Colors.grey,
            fontSize: 14,
            fontWeight: AllMaterial.fontBold,
          ),
        ),
      ],
    );
  }
}

class GeneratePage extends StatelessWidget {
  final GenerateKelompokController controller;
  const GeneratePage({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 14),
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 8),
      width: Get.width,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: const Color(0xffD4D6DD),
          width: 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Jumlah Kelompok
          const Text(
            "Jumlah Kelompok ",
            style: TextStyle(
              fontSize: 13,
              // color: AllMaterial.colorGreyPrimary,
              fontWeight: AllMaterial.fontBold,
            ),
          ),
          const SizedBox(height: 8),
          TextField(
            keyboardType: TextInputType.number,
            controller: controller.jumlahKelompok,
            onTapOutside: (_) {
              controller.focusNodeJ.unfocus();
            },
            focusNode: controller.focusNodeJ,
            cursorColor: AllMaterial.colorBluePrimary,
            decoration: const InputDecoration(
              hintText: "6",
              contentPadding: EdgeInsets.symmetric(horizontal: 15),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: AllMaterial.colorGreySec,
                ),
                borderRadius: BorderRadius.all(Radius.circular(12)),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(12)),
                borderSide: BorderSide(
                  color: AllMaterial.colorBluePrimary,
                ),
              ),
            ),
          ),
          const SizedBox(height: 25),
          const Text(
            "*Saran pembagian kelompok (banyak siswa 36): \nJumlah Kelompok: 8 = 5 kelompok ada 5 orang & 3 kelompok ada 4 orang \nJumlah Kelompok: 6 = setiap kelompok ada 6 orang \nJumlah Kelompok: 4 = setiap kelompok ada 9 orang",
            style: TextStyle(
              // color: AllMaterial.colorGreyPrimary,
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }
}
