import 'package:window_manager/window_manager.dart';
import 'package:random_group_generator/all_material.dart';

Future<void> initDesktopWindow() async {
  await windowManager.ensureInitialized();

  windowManager.waitUntilReadyToShow(
    AllMaterial.windowOptions,
    () async {
      await windowManager.maximize();
    },
  );
}