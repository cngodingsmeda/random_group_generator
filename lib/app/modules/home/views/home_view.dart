import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:random_group_generator/app/modules/generate_kelompok/controllers/generate_kelompok_controller.dart';
import 'package:random_group_generator/app/modules/generate_kelompok/views/generate_kelompok_view.dart';
import 'package:random_group_generator/app/modules/home/controllers/home_controller.dart';
import 'package:random_group_generator/app/modules/review/review_kelompok.dart';
import 'package:random_group_generator/constants/all_material.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    final generateController = Get.put(GenerateKelompokController());

    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 50, horizontal: 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Title
                const Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Keadilan ada di tangan-mu!",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      "Auto-Generate untuk kelompok kelas",
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 16,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                  ],
                ),

                // Histori
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 34,
                  ),
                  child: Obx(() {
                    if (generateController.histori.isEmpty) {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text(
                                "Histori :",
                                style: TextStyle(
                                  color: AllMaterial.colorBlackPrimary,
                                  fontWeight: AllMaterial.fontBlack,
                                ),
                              ),
                              Opacity(
                                opacity: 0,
                                child: InkWell(
                                  borderRadius: BorderRadius.circular(15),
                                  onTap: null,
                                  child: const Padding(
                                    padding: EdgeInsets.all(8),
                                    child: Text(
                                      "Hapus",
                                      style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: AllMaterial.fontBold,
                                        color: AllMaterial.colorGreySec,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const Center(
                            child: Text(
                              "Belum ada histori",
                              style: TextStyle(
                                color: Colors.grey,
                                fontWeight: FontWeight.normal,
                              ),
                            ),
                          ),
                        ],
                      );
                    } else {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text(
                                "Histori :",
                                style: TextStyle(
                                  color: AllMaterial.colorBlackPrimary,
                                  fontWeight: AllMaterial.fontBlack,
                                ),
                              ),
                              InkWell(
                                borderRadius: BorderRadius.circular(15),
                                onTap: () {
                                  Get.dialog(
                                    barrierDismissible: true,
                                    Dialog(
                                      child: Container(
                                        padding: const EdgeInsets.symmetric(
                                          vertical: 20,
                                          horizontal: 20,
                                        ),
                                        decoration: const BoxDecoration(
                                          color: AllMaterial.colorWhite,
                                          borderRadius: BorderRadius.all(
                                            Radius.circular(10),
                                          ),
                                        ),
                                        child: Column(
                                          mainAxisSize: MainAxisSize.min,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            const Icon(
                                              Icons.help_outline_outlined,
                                              color:
                                                  AllMaterial.colorBluePrimary,
                                              size: 70,
                                            ),
                                            const SizedBox(
                                              height: 10,
                                            ),
                                            const Padding(
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: 10),
                                              child: Text(
                                                "Ingin menghapus Histori?",
                                                style: TextStyle(
                                                  fontWeight:
                                                      AllMaterial.fontSemiBold,
                                                  fontSize: 17,
                                                  fontFamily:
                                                      AllMaterial.fontFamily,
                                                  color: AllMaterial
                                                      .colorBlackPrimary,
                                                ),
                                              ),
                                            ),
                                            const SizedBox(
                                              height: 15,
                                            ),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                InkWell(
                                                  onTap: () {
                                                    Get.back();
                                                  },
                                                  child: Container(
                                                    padding: const EdgeInsets
                                                        .symmetric(
                                                      vertical: 10,
                                                      horizontal: 15,
                                                    ),
                                                    alignment: Alignment.center,
                                                    decoration:
                                                        const BoxDecoration(
                                                      color: AllMaterial
                                                          .colorBluePrimary,
                                                      borderRadius:
                                                          BorderRadius.all(
                                                        Radius.circular(10),
                                                      ),
                                                    ),
                                                    child: const Text(
                                                      "Batal",
                                                      style: TextStyle(
                                                        color: AllMaterial
                                                            .colorWhite,
                                                        fontWeight: AllMaterial
                                                            .fontMedium,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                const SizedBox(width: 10),
                                                InkWell(
                                                  onTap: () {
                                                    generateController
                                                        .clearHistory();
                                                    Get.back();
                                                  },
                                                  child: Container(
                                                    padding: const EdgeInsets
                                                        .symmetric(
                                                      vertical: 10,
                                                      horizontal: 10,
                                                    ),
                                                    alignment: Alignment.center,
                                                    decoration: BoxDecoration(
                                                      border: Border.all(
                                                        color: AllMaterial
                                                            .colorBluePrimary,
                                                      ),
                                                      borderRadius:
                                                          const BorderRadius
                                                              .all(
                                                        Radius.circular(10),
                                                      ),
                                                    ),
                                                    child: const Text(
                                                      "Hapus",
                                                      style: TextStyle(
                                                        color: AllMaterial
                                                            .colorBluePrimary,
                                                        fontWeight: AllMaterial
                                                            .fontMedium,
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
                                  );
                                },
                                child: const Padding(
                                  padding: EdgeInsets.all(8),
                                  child: Text(
                                    "Hapus",
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: AllMaterial.fontBold,
                                      color: AllMaterial.colorBluePrimary,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Column(
                            children: generateController.histori.reversed
                                .toList()
                                .asMap()
                                .entries
                                .map((entry) {
                              var item = entry.value;
                              return Container(
                                margin: const EdgeInsets.only(top: 14),
                                width: Get.width,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(16),
                                  border: Border.all(
                                    color: const Color(0xffD4D6DD),
                                    width: 1,
                                  ),
                                ),
                                child: InkWell(
                                  borderRadius: BorderRadius.circular(16),
                                  onTap: () {
                                    Get.to(
                                      () => ReviewKelompokView(
                                        title: item['title'],
                                        kelas: item['kelas'],
                                        kelompok: item['kelompok'],
                                      ),
                                    );
                                  },
                                  child: ListTile(
                                    trailing: const Icon(
                                      Icons.keyboard_arrow_right_rounded,
                                      color: AllMaterial.colorGreyPrimary,
                                    ),
                                    leading: const CircleAvatar(
                                      backgroundColor: AllMaterial.colorGreySec,
                                      child: Image(
                                        image: AssetImage(
                                          "assets/images/check.png",
                                        ),
                                      ),
                                    ),
                                    title: Text(
                                      "${item['title']}",
                                      style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16,
                                        color: AllMaterial.colorBlackPrimary,
                                      ),
                                    ),
                                    subtitle: Text(
                                      "${item['kelas']}",
                                      style: const TextStyle(
                                        fontWeight: FontWeight.w500,
                                        fontSize: 16,
                                        color: AllMaterial.colorGreyPrimary,
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            }).toList(),
                          ),
                        ],
                      );
                    }
                  }),
                ),
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        elevation: 2,
        backgroundColor: AllMaterial.colorBluePrimary,
        onPressed: () {
          generateController.resetState();
          Get.offAll(() => const GenerateKelompokView());
        },
        child: const Icon(
          Icons.add,
          color: AllMaterial.colorWhite,
        ),
      ),
    );
  }
}
