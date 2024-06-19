// ignore_for_file: must_be_immutable, prefer_typing_uninitialized_variables

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:random_group_generator/constants/all_material.dart';
import '../controllers/generate_kelompok_controller.dart';
import 'package:share_plus/share_plus.dart';

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
                child: Obx(
                  () => SingleChildScrollView(
                    physics: (controller.checkboxValue.isTrue)
                        ? const NeverScrollableScrollPhysics()
                        : const ScrollPhysics(),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Appbar
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Opacity(
                              opacity:
                                  (controller.currentStep.value != 4) ? 1 : 0,
                              child: InkWell(
                                borderRadius: BorderRadius.circular(15),
                                onTap: () {
                                  if (controller.currentStep.value != 4) {
                                    if (controller.currentStep.value > 1) {
                                      controller.setCurrentStep(
                                          controller.currentStep.value - 1);
                                    } else {
                                      Get.back();
                                      GenerateKelompokController().dispose();
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
                                      fontWeight: AllMaterial.fontExtraBold,
                                      color: AllMaterial.colorBluePrimary,
                                    ),
                                  ),
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
                            Obx(
                              () => Opacity(
                                opacity:
                                    (controller.currentStep.value == 4) ? 1 : 0,
                                child: InkWell(
                                  borderRadius: BorderRadius.circular(15),
                                  onTap: () async {
                                    String whatsappMessage =
                                        generateWhatsappMessage();
                                    final result =
                                        await Share.share(whatsappMessage);
                                    if (result.status ==
                                        ShareResultStatus.success) {
                                      print('Berhasil berbagi pesan WhatsApp!');
                                      // Menyimpan ke data title dan kelas ke dalam variabel histori, ketika ditekan akan mengarahkan ke page review tanpa tombol batal yang dapat diakses kapan saja
                                    } else {
                                      print('Gagal berbagi pesan WhatsApp.');
                                    }
                                  },
                                  child: const Padding(
                                    padding: EdgeInsets.all(8),
                                    child: Text(
                                      "Share",
                                      style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: AllMaterial.fontExtraBold,
                                        color: AllMaterial.colorBluePrimary,
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

                        Obx(() => _getPageWidget(controller.currentStep.value)),
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
                      height: controller.checkboxValue.isFalse
                          ? Get.height * 0.17
                          : Get.height * 0.63,
                      color: const Color.fromARGB(11, 255, 255, 255),
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
                                  color: AllMaterial.colorBlackPrimary,
                                  fontWeight: AllMaterial.fontMedium,
                                ),
                              ),
                              subtitle: const Text(
                                "(matikan ceklis untuk mengatur filter)",
                                style: TextStyle(
                                  fontSize: 13,
                                  color: AllMaterial.colorGreyPrimary,
                                ),
                              ),
                              controlAffinity: ListTileControlAffinity.leading,
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
                          controller.addToHistory(
                            controller.titleKelompok.value,
                            controller.selectedKelas.value,
                            controller.kelompokList,
                          );
                        },
                        child: const Text(
                          "Kembali Ke Beranda",
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
                                    color: AllMaterial.colorWhite,
                                    borderRadius: BorderRadius.circular(25),
                                  ),
                                  width: Get.width,
                                  height: 120,
                                  padding: const EdgeInsets.all(20),
                                  child: const Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
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
        return FilterPage(controller: controller);
      case 3:
        return GeneratePage(controller: controller);
      case 4:
        return ReviewPage(controller: controller);
      default:
        return const Center(
          child: Text("Gheral Ganteng"),
        );
    }
  }

  String generateWhatsappMessage() {
    String message =
        "${controller.titleKelompok.value} ${controller.selectedKelas.value}\n\n";
    for (int i = 0; i < controller.kelompokList.length; i++) {
      message += "Kelompok ${i + 1}:\n";
      var group = controller.kelompokList[i];
      for (var siswa in group) {
        message += "${siswa["nama"]}\n";
      }
      message += "\n";
    }
    return Uri.encodeComponent(message);
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
                  color: Colors.black,
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
                            color: Colors.black,
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

class FilterPage extends StatelessWidget {
  final GenerateKelompokController controller;
  const FilterPage({super.key, required this.controller});

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
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Tentukan Agama
          Column(
            children: [
              GestureDetector(
                onTap: () {
                  controller.toggleFilterAgama();
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
                          color: controller.filterAgamaActive.value
                              ? AllMaterial.colorBluePrimary
                              : AllMaterial.colorGreySec,
                        ),
                        child: Container(
                          width: 8,
                          height: 8,
                          decoration: BoxDecoration(
                            color: controller.filterAgamaActive.value
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
                              fontWeight: AllMaterial.fontBold,
                              color: AllMaterial.colorGreyPrimary,
                            ),
                          ),
                          Text(
                            "(untuk kebutuhan Kelompok Agama)",
                            style: TextStyle(
                              fontSize: 14,
                              color: AllMaterial.colorGreySec,
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
                  children: controller.agamaSiswa.map((String agama) {
                    return ChoiceChip(
                      checkmarkColor: AllMaterial.colorWhite,
                      label: Text(
                        agama,
                        style: TextStyle(
                          color: controller.filterAgamaActive.value
                              ? AllMaterial.colorWhite
                              : AllMaterial.colorGreyPrimary,
                        ),
                      ),
                      elevation: 0,
                      side: const BorderSide(
                        width: 0,
                        color: Colors.transparent,
                      ),
                      selected: controller.selectedAgamaFilter.value == agama,
                      onSelected: controller.filterAgamaActive.value
                          ? (bool selected) {
                              controller.toggleAgama(agama);
                            }
                          : null,
                      selectedColor: AllMaterial.colorBluePrimary,
                      disabledColor: AllMaterial.colorWhite,
                      backgroundColor: AllMaterial.colorBlueSec,
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
                  controller.toggleFilterJK();
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
                          color: controller.filterJKActive.value
                              ? AllMaterial.colorBluePrimary
                              : AllMaterial.colorGreySec,
                        ),
                        child: Container(
                          width: 8,
                          height: 8,
                          decoration: BoxDecoration(
                            color: controller.filterJKActive.value
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
                              fontWeight: AllMaterial.fontBold,
                              color: AllMaterial.colorGreyPrimary,
                            ),
                          ),
                          Text(
                            "(jika tidak dipilih, nilai default acak)",
                            style: TextStyle(
                              fontSize: 14,
                              color: AllMaterial.colorGreySec,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 24),
              GestureDetector(
                onTap: () {
                  controller.toggleJK("Laki-Laki");
                },
                child: Obx(() => Container(
                      padding: const EdgeInsets.all(16),
                      alignment: Alignment.centerLeft,
                      width: Get.width,
                      height: 50,
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: const Color(0xffD4D6DD),
                          width:
                              controller.jKSiswa.value == "Laki-Laki" ? 0 : .5,
                        ),
                        color: controller.jKSiswa.value == "Laki-Laki"
                            ? AllMaterial.colorWhiteBlue
                            : Colors.white,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: const Text(
                        "Laki-Laki",
                        style: TextStyle(
                          color: AllMaterial.colorBlackPrimary,
                        ),
                      ),
                    )),
              ),
              const SizedBox(height: 8),
              GestureDetector(
                onTap: () {
                  controller.toggleJK("Perempuan");
                },
                child: Obx(
                  () => Container(
                    padding: const EdgeInsets.all(16),
                    alignment: Alignment.centerLeft,
                    width: Get.width,
                    height: 50,
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: const Color(0xffD4D6DD),
                        width: controller.jKSiswa.value == "Perempuan" ? 0 : .5,
                      ),
                      borderRadius: BorderRadius.circular(12),
                      color: controller.jKSiswa.value == "Perempuan"
                          ? AllMaterial.colorWhiteBlue
                          : Colors.white,
                    ),
                    child: const Text(
                      "Perempuan",
                      style: TextStyle(
                        color: AllMaterial.colorBlackPrimary,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
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
              color: AllMaterial.colorGreyPrimary,
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

          // Jumlah Anggota Kelompok
          const Text(
            "Jumlah Anggota Kelompok",
            style: TextStyle(
              fontSize: 13,
              color: AllMaterial.colorGreyPrimary,
              fontWeight: AllMaterial.fontBold,
            ),
          ),
          const SizedBox(height: 8),
          TextField(
            keyboardType: TextInputType.number,
            controller: controller.jumlahAnggotaKelompok,
            onTapOutside: (_) {
              controller.focusNodeA.unfocus();
            },
            focusNode: controller.focusNodeA,
            cursorColor: AllMaterial.colorBluePrimary,
            decoration: const InputDecoration(
              hintText: "8",
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
        ],
      ),
    );
  }
}
