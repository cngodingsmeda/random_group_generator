import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:random_group_generator/constants/all_material.dart';
import '../controllers/generate_kelompok_controller.dart';

class GenerateKelompokView extends GetView<GenerateKelompokController> {
  const GenerateKelompokView({super.key});

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(GenerateKelompokController());
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Appbar
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          GestureDetector(
                            onTap: () {
                              if (controller.currentStep.value > 1) {
                                controller.setCurrentStep(
                                    controller.currentStep.value - 1);
                              } else {
                                Get.back();
                              }
                            },
                            child: const Text(
                              "Batal",
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: AllMaterial.fontExtraBold,
                                color: AllMaterial.colorBluePrimary,
                              ),
                            ),
                          ),
                          Obx(() => Text(
                                _getTitle(controller.currentStep.value),
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: AllMaterial.fontExtraBold,
                                  color: AllMaterial.colorBlackPrimary,
                                ),
                              )),
                          Opacity(
                            opacity: 0,
                            child: GestureDetector(
                              onTap: () {},
                              child: const Text(
                                "Batal",
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: AllMaterial.fontExtraBold,
                                  color: AllMaterial.colorBluePrimary,
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
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              StepperWidget(
                                number: "1",
                                titleText: "Pilih Kelas",
                                isActive: controller.currentStep.value >= 1,
                                isCompleted: controller.currentStep.value > 1,
                              ),
                              StepperWidget(
                                number: "2",
                                titleText: "Filter",
                                isActive: controller.currentStep.value >= 2,
                                isCompleted: controller.currentStep.value > 2,
                              ),
                              StepperWidget(
                                number: "3",
                                titleText: "Generate",
                                isActive: controller.currentStep.value >= 3,
                                isCompleted: controller.currentStep.value > 3,
                              ),
                              StepperWidget(
                                number: "4",
                                titleText: "Review",
                                isActive: controller.currentStep.value >= 4,
                                isCompleted: controller.currentStep.value > 4,
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
                              color: AllMaterial.colorBlackPrimary,
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
                            color: AllMaterial.colorGreyPrimary,
                          ),
                        ),
                      ),

                      // TextField Title & Pilih Kelas
                      Obx(
                        () => _getPageWidget(controller.currentStep.value),
                      ),
                    ],
                  ),
                ),
              ),
              Container(
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
                    if (controller.currentStep.value < 4) {
                      controller.setCurrentStep(
                        controller.currentStep.value + 1,
                      );
                    } else {}
                  },
                  child: const Text(
                    "Lanjutkan",
                    style: TextStyle(
                      color: AllMaterial.colorWhite,
                      fontWeight: AllMaterial.fontSemiBold,
                    ),
                  ),
                ),
              )
            ],
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
        return const FilterPage();
      default:
        return const Center(
          child: Text("Gheral Ganteng"),
        );
    }
  }
}

class FilterPage extends StatelessWidget {
  const FilterPage({super.key});

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
      child: const Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Tentukan Ketua
        ],
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
            "Title",
            style: TextStyle(
              fontSize: 13,
              color: AllMaterial.colorGreyPrimary,
              fontWeight: AllMaterial.fontBold,
            ),
          ),
          const SizedBox(height: 8),
          TextField(
            controller: controller.titleC,
            onTapOutside: (_) {
              controller.focusNodeC.unfocus();
            },
            focusNode: controller.focusNodeC,
            cursorColor: AllMaterial.colorBluePrimary,
            decoration: const InputDecoration(
              hintText: "Kelompok IPAS",
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
              color: AllMaterial.colorGreyPrimary,
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
                  backgroundColor: AllMaterial.colorBlueSec,
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
            color: isActive ? AllMaterial.colorBlackPrimary : Colors.grey,
            fontSize: 14,
            fontWeight: AllMaterial.fontBold,
          ),
        ),
      ],
    );
  }
}
