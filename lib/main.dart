import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:random_group_generator/all_material.dart';

import 'package:random_group_generator/app/modules/generate_kelompok/controllers/generate_kelompok_controller.dart';
import 'package:random_group_generator/app/modules/home/views/home_view.dart';
import 'package:random_group_generator/app/modules/login/views/login_view.dart';
import 'package:random_group_generator/app_scroll.dart';
import 'package:random_group_generator/loading_splash_view.dart';
import 'package:random_group_generator/window_helper_desktop.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await initializeDateFormatting('id', null);
  await GetStorage.init();

  WidgetsBinding.instance.addPostFrameCallback((_) {
    final controller = Get.put(GenerateKelompokController());
    controller.loadHistory();
  });

  if (kIsWeb) {
    // Web
  } else {
    switch (defaultTargetPlatform) {
      case TargetPlatform.windows:
      case TargetPlatform.macOS:
      case TargetPlatform.linux:
        await initDesktopWindow();
        break;

      case TargetPlatform.android:
      case TargetPlatform.iOS:
        await SystemChrome.setPreferredOrientations([
          DeviceOrientation.portraitUp,
          DeviceOrientation.portraitDown,
        ]);
        break;

      default:
        break;
    }
  }

  final isDarkMode = AllMaterial.box.read("isDarkMode") ?? false;

  runApp(
    GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Random Group Generator",
      defaultTransition: Transition.cupertino,
      transitionDuration: const Duration(milliseconds: 350),
      builder: (context, child) {
        return ScrollConfiguration(
          behavior: const NoAlwaysScrollableBehavior(),
          child: child!,
        );
      },
      theme: ThemeData(
        useMaterial3: true,
        scaffoldBackgroundColor: AllMaterial.colorWhite,
        colorScheme: ColorScheme.fromSeed(
          seedColor: AllMaterial.colorBluePrimary,
          brightness: Brightness.light,
          primary: AllMaterial.colorBluePrimary,
          onPrimary: Colors.white,
          secondary: Colors.blueAccent,
          onSecondary: Colors.white,
          surface: AllMaterial.colorWhite,
          onSurface: Colors.black,
          error: Colors.grey,
          onError: Colors.white,
        ),
        appBarTheme: const AppBarTheme(
          backgroundColor: AllMaterial.colorWhite,
          surfaceTintColor: Colors.transparent,
        ),
        dropdownMenuTheme: DropdownMenuThemeData(
          menuStyle: MenuStyle(
            backgroundColor: WidgetStatePropertyAll(AllMaterial.colorWhite),
            surfaceTintColor: const WidgetStatePropertyAll(Colors.transparent),
          ),
        ),
      ),
      darkTheme: ThemeData(
        useMaterial3: true,
        scaffoldBackgroundColor: const Color(0xFF121212),
        colorScheme: ColorScheme.fromSeed(
          seedColor: AllMaterial.colorBluePrimary,
          brightness: Brightness.dark,
          primary: AllMaterial.colorBluePrimary,
          onPrimary: Colors.black,
          secondary: Colors.lightBlueAccent,
          onSecondary: Colors.black,
          surface: const Color(0xFF1E1E1E),
          onSurface: Colors.white,
          error: Colors.grey,
          onError: Colors.black,
        ),
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFF1E1E1E),
          surfaceTintColor: Colors.transparent,
        ),
        dropdownMenuTheme: DropdownMenuThemeData(
          menuStyle: MenuStyle(
            backgroundColor: WidgetStatePropertyAll(Color(0xFF1E1E1E)),
            surfaceTintColor: const WidgetStatePropertyAll(Colors.transparent),
          ),
        ),
      ),
      themeMode: isDarkMode ? ThemeMode.dark : ThemeMode.light,
      home: LoadingSplashView(
        title: 'Tunggu sebentar!',
        animationAsset: 'assets/images/loading.json',
        onCompleted: () {
          final token = AllMaterial.box.read('token');
          if (token != null && token.toString().isNotEmpty) {
            Get.offAll(() => HomeView());
          } else {
            Get.offAll(()=> LoginView());
          }
        },
      ),
      // getPages: AppPages.routes,
    ),
  );
}
