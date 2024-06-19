import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:random_group_generator/constants/all_material.dart';

class SnapshotView extends StatelessWidget {
  const SnapshotView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AllMaterial.colorBluePrimary,
      body: Container(
        height: Get.height,
        width: Get.width,
        decoration: const BoxDecoration(
          image: DecorationImage(
            fit: BoxFit.cover,
            image: AssetImage("assets/images/snapshot.png"),
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              "Random Group",
              style: TextStyle(
                color: AllMaterial.colorWhite,
                fontSize: 30,
                fontWeight: AllMaterial.fontMedium,
              ),
            ),
            const Text(
              "Generator",
              style: TextStyle(
                color: AllMaterial.colorWhite,
                fontSize: 28,
                fontWeight: AllMaterial.fontExtraBold,
              ),
            ),
            const SizedBox(height: 8),
            Image.asset("assets/images/icon.png"),
          ],
        ),
      ),
    );
  }
}
