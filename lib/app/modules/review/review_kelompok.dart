// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:random_group_generator/app/modules/generate_kelompok/controllers/generate_kelompok_controller.dart';
import 'package:random_group_generator/app/modules/home/views/home_view.dart';
import 'package:random_group_generator/constants/all_material.dart';
import 'package:share_plus/share_plus.dart';

class ReviewKelompokView extends StatelessWidget {
  final String title;
  final String kelas;
  final List<dynamic> kelompok;

  ReviewKelompokView({
    super.key,
    required this.title,
    required this.kelas,
    required this.kelompok,
  });

  var controller = Get.put(GenerateKelompokController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.white,
        title: Text(
          '$title $kelas',
          style: const TextStyle(fontWeight: AllMaterial.fontSemiBold),
        ),
        actions: [
          IconButton(
            onPressed: () async {
              var message = _generateWhatsappMessage();
              final result = await Share.share(message);
              if (result.status == ShareResultStatus.success) {
                print('Berhasil berbagi pesan WhatsApp!');
              } else {
                print('Gagal berbagi pesan WhatsApp.');
              }
            },
            icon: const Icon(Icons.share),
          )
        ],
      ),
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(top: 0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 16),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: List.generate(
                    kelompok.length,
                    (index) {
                      print("detail: ${kelompok[index]}");
                      List item = kelompok[index];
                      final itemName = item
                          .where((siswa) =>
                              siswa is Map<String, dynamic> &&
                              siswa.containsKey('nama'))
                          .map<String>((siswa) => siswa['nama'] as String)
                          .toList();
                      String itemNamedChar =
                          itemName.toString().replaceAll("[", " ");
                      String itemNamedCharacter =
                          itemNamedChar.replaceAll("]", "");
                      return Container(
                        margin: const EdgeInsets.all(14),
                        padding: const EdgeInsets.only(
                          top: 15,
                          left: 15,
                          right: 15,
                          bottom: 30,
                        ),
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
                            const SizedBox(height: 15),
                            Text(
                              "Kelompok ${index + 1}:",
                              style: const TextStyle(
                                color: AllMaterial.colorBlackPrimary,
                                fontWeight: AllMaterial.fontBlack,
                                fontSize: 16,
                              ),
                            ),
                            const SizedBox(height: 15),
                            Text(
                              itemNamedCharacter.toString().replaceAll(
                                    ",",
                                    "\n",
                                  ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
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
          Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => const HomeView(),
          ));
        },
        child: const Icon(
          Icons.home,
          color: AllMaterial.colorWhite,
        ),
      ),
    );
  }

  String _generateWhatsappMessage() {
    String message = "$title $kelas \n\n";
    for (int i = 0; i < kelompok.length; i++) {
      message += "Kelompok ${i + 1}:\n";
      var group = kelompok[i];
      for (var siswa in group) {
        message += "${siswa["nama"]}\n";
      }
      message += "\n";
    }
    return Uri.encodeComponent(message);
  }
}