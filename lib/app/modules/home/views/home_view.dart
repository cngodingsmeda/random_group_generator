// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:random_group_generator/app/modules/generate_kelompok/views/generate_kelompok_view.dart';
import 'package:random_group_generator/constants/all_material.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  var histori = [];
  HomeView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24),
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
                      color: AllMaterial.colorBlackPrimary,
                      fontSize: 24,
                      fontWeight: AllMaterial.fontBlack,
                    ),
                  ),
                  Text(
                    "Auto-Generate untuk kebutuhan-mu",
                    style: TextStyle(
                      color: AllMaterial.colorGreyPrimary,
                      fontSize: 16,
                      fontWeight: AllMaterial.fontRegular,
                    ),
                  ),
                ],
              ),

              // SizedBox(height: 34),

              // Histori
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 34,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Histori",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: AllMaterial.fontExtraBold,
                      ),
                    ),
                    Center(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 20),
                        child: (histori.isEmpty)
                            ? const Text(
                                "Belum ada histori",
                                style: TextStyle(
                                  color: AllMaterial.colorGreyPrimary,
                                  fontWeight: AllMaterial.fontRegular,
                                ),
                              )
                            : Container(
                                margin: const EdgeInsets.only(top: 14),
                                width: Get.width,
                                height: 180,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(16),
                                  border: Border.all(
                                    color: const Color(0xffD4D6DD),
                                    width: 1,
                                  ),
                                ),
                                child: const Column(),
                              ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        elevation: 2,
        backgroundColor: AllMaterial.colorBluePrimary,
        onPressed: () {
          Navigator.of(context).push(MaterialPageRoute(
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
