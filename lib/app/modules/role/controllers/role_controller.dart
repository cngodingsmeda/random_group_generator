import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:random_group_generator/all_material.dart';
import 'package:random_group_generator/app/routes/app_pages.dart';

class RoleController extends GetxController {
  final usernameController = TextEditingController();
  final selectedRole = 'Siswa'.obs;

  final roles = ['Siswa', 'Guru', 'Admin'];

  void lanjutkan() {
    if (usernameController.text.trim().isEmpty) {
      AllMaterial.messageScaffold(title: "Username tidak boleh kosong!");
      return;
    }
    
    // Simpan data role ke lokal menggunakan GetStorage
    final box = GetStorage();
    box.write('username', usernameController.text.trim());
    box.write('role', selectedRole.value);
    // Simpan token sementara sebagai penanda sudah login/isi role
    box.write('token', 'logged_in'); 
    
    Get.offAllNamed(Routes.HOME);
  }
  
  @override
  void onClose() {
    usernameController.dispose();
    super.onClose();
  }
}
