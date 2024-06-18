import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:random_group_generator/constants/all_material.dart';

import 'app/routes/app_pages.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
    GetMaterialApp(
      theme: ThemeData(
        fontFamily: AllMaterial.fontFamily,
        primaryColorLight: Colors.white,
      ),
      debugShowCheckedModeBanner: false,
      title: "Generate Kelompok",
      initialRoute: AppPages.INITIAL,
      getPages: AppPages.routes,
    ),
  );
}
