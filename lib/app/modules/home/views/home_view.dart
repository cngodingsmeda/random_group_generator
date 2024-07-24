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
    final controller = Get.put(GenerateKelompokController());

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
                      "Buat kelompok Anda!",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      "Auto-Generate untuk kebutuhan-mu",
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
                    if (controller.histori.isEmpty) {
                      return const Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Histori:",
                            style: TextStyle(
                                color: AllMaterial.colorBlackPrimary,
                                fontWeight: AllMaterial.fontBlack),
                          ),
                          Center(
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
                          const Text(
                            "Histori:",
                            style: TextStyle(
                              color: AllMaterial.colorBlackPrimary,
                              fontWeight: AllMaterial.fontBlack,
                            ),
                          ),
                          // const SizedBox(height: 5),
                          Column(
                            children: controller.histori.reversed
                                .toList()
                                .asMap()
                                .entries
                                .map((entry) {
                              AllMaterial.box.remove("itemKelompok");
                              // int index = entry.key;
                              var item = entry.value;
                              // var item
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
                                    Get.to(() => ReviewKelompokView(
                                          title: item['title'],
                                          kelas: item['kelas'],
                                          kelompok: item['kelompok'],
                                        ));
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
          controller.resetState();
          Navigator.of(context).pushReplacement(MaterialPageRoute(
            builder: (context) => const GenerateKelompokView(),
          ));
        },
        child: const Icon(
          Icons.add,
          color: AllMaterial.colorWhite,
        ),
      ),
    );
  }
}
