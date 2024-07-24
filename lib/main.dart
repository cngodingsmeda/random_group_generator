import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:random_group_generator/app/modules/home/views/home_view.dart';
import 'package:random_group_generator/app/modules/snapshot/snapshot_view.dart';
import 'package:random_group_generator/constants/all_material.dart';
import 'package:get_storage/get_storage.dart';
import 'app/routes/app_pages.dart';

void main() async {
  await GetStorage.init();
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
    GetMaterialApp(
      theme: ThemeData(
        fontFamily: AllMaterial.fontFamily,
        primaryColorLight: Colors.white,
      ),
      debugShowCheckedModeBanner: false,
      title: "Generate Kelompok",
      home: FutureBuilder(future: Future.delayed(const Duration(seconds: 2)), builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const SnapshotView();
        } else {
          return const HomeView();
        }
      },),
      getPages: AppPages.routes,
    ),
  );
}
