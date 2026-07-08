// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:random_group_generator/all_material.dart';
import 'package:random_group_generator/app/modules/generate_kelompok/controllers/generate_kelompok_controller.dart';
import 'package:random_group_generator/app/modules/generate_kelompok/views/generate_kelompok_view.dart';
import 'package:random_group_generator/app/modules/home/controllers/home_controller.dart';
import 'package:random_group_generator/app/modules/review_kelompok/views/review_kelompok_view.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    final generateController = Get.put(GenerateKelompokController());
    final isDark = generateController.isDarkMode;
    final RxSet<String> selectedIds = <String>{}.obs;

    return GestureDetector(
      onTap: () {
        selectedIds.clear();
        generateController.selectedKelasFilter.value = '';
        generateController.searchQuery.value = '';
      },
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Obx(() => Container(
              width: double.infinity,
              height: double.infinity,
              decoration: BoxDecoration(
                color: isDark.value ? const Color(0xff121212) : null,
                gradient: isDark.value
                    ? null
                    : const LinearGradient(
                        colors: [
                          Color(0xffF6F9FF),
                          Color(0xffEEF4FF),
                        ],
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                      ),
              ),
              child: SafeArea(
                child: Align(
                  alignment: Alignment.topCenter,
                  child: ConstrainedBox(
                    constraints: const BoxConstraints(maxWidth: 700),
                    child: LayoutBuilder(
                      builder: (context, constraints) {
                        final isWide = constraints.maxWidth > 600;
                        final isSemiWide = constraints.maxWidth > 815;

                        return SingleChildScrollView(
                          padding: EdgeInsets.symmetric(
                            vertical: isWide ? 50 : 30,
                            horizontal: isWide ? 48 : 24,
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // TITLE
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "Bagi Kelompok Tanpa Ribet!",
                                          style: TextStyle(
                                            fontSize: isWide ? 28 : 22,
                                            fontWeight: FontWeight.bold,
                                            color: isDark.value
                                                ? Colors.white
                                                : const Color(0xff1E293B),
                                          ),
                                        ),
                                        const SizedBox(height: 8),
                                        Text(
                                          "Biarkan sistem membagi kelompok dengan adil dan cepat.",
                                          style: TextStyle(
                                            fontSize: isWide ? 15 : 13,
                                            color: isDark.value
                                                ? Colors.grey.shade400
                                                : Colors.grey.shade600,
                                            height: 1.5,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  if (isWide)
                                    Row(
                                      children: [
                                        TextButton(
                                          style: TextButton.styleFrom(
                                            alignment: Alignment.center,
                                            elevation: 0,
                                            backgroundColor: isDark.value
                                                ? AllMaterial.colorBlackPrimary
                                                : Colors.white,
                                            padding: const EdgeInsets.all(18),
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(14),
                                              side: BorderSide(
                                                color: isDark.value
                                                    ? Colors.transparent
                                                    : Colors.grey.shade300,
                                              ),
                                            ),
                                          ),
                                          onPressed:
                                              generateController.toggleTheme,
                                          child: Row(
                                            children: [
                                              AnimatedSwitcher(
                                                duration: const Duration(
                                                    milliseconds: 300),
                                                transitionBuilder: (Widget child,
                                                    Animation<double> animation) {
                                                  return RotationTransition(
                                                    turns: Tween<double>(
                                                      begin: 0.75,
                                                      end: 1,
                                                    ).animate(animation),
                                                    child: FadeTransition(
                                                      opacity: animation,
                                                      child: child,
                                                    ),
                                                  );
                                                },
                                                child: Icon(
                                                  isDark.value
                                                      ? Icons.light_mode
                                                      : Icons.dark_mode,
                                                  key: ValueKey<bool>(
                                                      isDark.value),
                                                  color: isDark.value
                                                      ? Colors.white
                                                      : const Color(0xff1E293B),
                                                  size: 24,
                                                ),
                                              ),
                                              if (isSemiWide)
                                                const SizedBox(width: 8),
                                              if (isSemiWide)
                                                Text(
                                                  isDark.value
                                                      ? "Light Mode"
                                                      : "Dark Mode",
                                                  style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    color: isDark.value
                                                        ? Colors.white
                                                        : const Color(
                                                            0xff1E293B),
                                                  ),
                                                ),
                                            ],
                                          ),
                                        ),
                                        const SizedBox(width: 12),
                                        FilledButton.icon(
                                          onPressed: () {
                                            generateController.resetState();
                                            Get.to(() =>
                                                const GenerateKelompokView());
                                          },
                                          style: FilledButton.styleFrom(
                                            backgroundColor:
                                                const Color(0xff2563EB),
                                            foregroundColor: Colors.white,
                                            padding: const EdgeInsets.all(18),
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(14),
                                            ),
                                          ),
                                          icon: Icon(
                                            Icons.add,
                                            key: ValueKey<int>(DateTime.now()
                                                .millisecondsSinceEpoch),
                                            size: 24,
                                          ),
                                          label: isSemiWide
                                              ? const Text(
                                                  "Generate Kelompok",
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold),
                                                )
                                              : const SizedBox.shrink(),
                                        ),
                                      ],
                                    ),
                                ],
                              ),

                              // HISTORI
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 20),
                                child: HistorySection(
                                  selectedIds: selectedIds,
                                  isWide: isWide,
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ),
            )),
        floatingActionButton: LayoutBuilder(
          builder: (context, constraints) {
            final isWide = constraints.maxWidth > 600;
            if (isWide) return const SizedBox.shrink();

            return Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Obx(() => FloatingActionButton(
                      tooltip: "Ubah Tema",
                      heroTag: "darkModeToggle",
                      elevation: isDark.value ? 2 : 4,
                      backgroundColor: isDark.value
                          ? AllMaterial.colorBlackPrimary
                          : Colors.white,
                      onPressed: generateController.toggleTheme,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Obx(() {
                        return AnimatedSwitcher(
                          duration: const Duration(milliseconds: 300),
                          transitionBuilder:
                              (Widget child, Animation<double> animation) {
                            return RotationTransition(
                              turns: Tween<double>(
                                begin: 0.75,
                                end: 1,
                              ).animate(animation),
                              child: FadeTransition(
                                opacity: animation,
                                child: child,
                              ),
                            );
                          },
                          child: Icon(
                            isDark.value ? Icons.light_mode : Icons.dark_mode,
                            key: ValueKey<bool>(isDark.value),
                            color: isDark.value
                                ? Colors.white
                                : const Color(0xff1E293B),
                            size: 24,
                          ),
                        );
                      }),
                    )),
                const SizedBox(height: 16),
                FloatingActionButton(
                  tooltip: "Generate Kelompok",
                  heroTag: "generateKelompok",
                  backgroundColor: const Color(0xff2563EB),
                  elevation: 4,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  onPressed: () {
                    generateController.resetState();
                    Get.to(() => const GenerateKelompokView());
                  },
                  child: const Icon(Icons.add, color: Colors.white),
                ),
                const SizedBox(height: 25),
              ],
            );
          },
        ),
      ),
    );
  }
}

class HistorySection extends StatelessWidget {
  final generateController = Get.find<GenerateKelompokController>();
  final RxSet<String> selectedIds;
  final bool isWide;

  HistorySection({super.key, required this.selectedIds, required this.isWide});

  Color getRandomColor(String text) {
    final colors = [
      const Color(0xff2563EB),
      const Color(0xffE53935),
      const Color(0xff66BB6A),
      const Color(0xffFFA726),
      const Color(0xffAB47BC),
      const Color(0xff26A69A),
      const Color(0xffEC407A),
      const Color(0xff7E57C2),
      const Color(0xffF4511E),
      const Color(0xff00ACC1),
    ];
    // Menghasilkan warna yang acak namun tetap sama untuk string yang sama
    return colors[text.hashCode.abs() % colors.length];
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final isSmall = constraints.maxWidth < 500; // Breakpoint layar kecil

        return Obx(
          () {
            var isSelecting = selectedIds.isNotEmpty;
            final isDark = generateController.isDarkMode;
            final isHistoryEmpty = generateController.histori.isEmpty;

            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Histori :",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: isWide ? 18 : 16,
                        color: isDark.value
                            ? Colors.white
                            : const Color(0xff1E293B),
                      ),
                    ),
                    if (!isSelecting)
                      InkWell(
                        borderRadius: BorderRadius.circular(12),
                        onTap: isHistoryEmpty
                            ? null
                            : () {
                                AllMaterial.showDialogValidasi(
                                  title: "Hapus Semua Histori",
                                  subtitle:
                                      "Semua data akan dihapus. Lanjutkan?",
                                  onConfirm: () {
                                    generateController.histori.clear();
                                    generateController.histori.refresh();
                                    AllMaterial.messageScaffold(
                                        title: "Data berhasil dihapus!");
                                    Get.back();
                                  },
                                  onCancel: () {
                                    Get.back();
                                  },
                                );
                              },
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 12, vertical: 8),
                          child: Row(
                            children: [
                              Icon(
                                Icons.delete_outline,
                                size: isWide ? 20 : 18,
                                color: isHistoryEmpty
                                    ? (isDark.value
                                        ? Colors.grey.shade800
                                        : Colors.grey.shade400)
                                    : (isDark.value
                                        ? Colors.white
                                        : const Color(0xff1E293B)),
                              ),
                              const SizedBox(width: 4),
                              Text(
                                "Hapus Semua",
                                style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: isWide ? 14 : 12,
                                  color: isHistoryEmpty
                                      ? (isDark.value
                                          ? Colors.grey.shade800
                                          : Colors.grey.shade400)
                                      : (isDark.value
                                          ? Colors.white
                                          : const Color(0xff1E293B)),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    if (isSelecting)
                      InkWell(
                        borderRadius: BorderRadius.circular(12),
                        onTap: () {
                          AllMaterial.showDialogValidasi(
                            title: "Hapus Histori Terpilih",
                            subtitle:
                                "Data terpilih akan dihapus. Lanjutkan?",
                            onConfirm: () {
                              generateController
                                  .removeHistoryByIds(selectedIds.toList());
                              selectedIds.clear();
                              AllMaterial.messageScaffold(
                                  title: "Data berhasil dihapus!");
                              Get.back();
                            },
                            onCancel: () {
                              Get.back();
                              selectedIds.clear();
                            },
                          );
                        },
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 12, vertical: 8),
                          child: Row(
                            children: [
                              Icon(
                                Icons.delete,
                                color: Colors.red,
                                size: isWide ? 20 : 18,
                              ),
                              const SizedBox(width: 4),
                              Text(
                                "Hapus Terpilih",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: isWide ? 14 : 12,
                                  color: Colors.red,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                  ],
                ),
                const SizedBox(height: 20),
                Obx(() {
                  generateController.searchC.text =
                      generateController.searchQuery.isEmpty
                          ? ""
                          : generateController.searchQuery.value;
                  final histori = generateController.histori;

                  final query =
                      generateController.searchQuery.value.toLowerCase();
                  final selectedKelas =
                      generateController.selectedKelasFilter.value;
                  final filteredHistori = histori.where((item) {
                    final title = (item['title'] ?? '').toLowerCase();
                    final kelas = (item['kelas'] ?? '').toLowerCase();
                    final matchesQuery = query.isEmpty ||
                        title.contains(query) ||
                        kelas.contains(query);
                    final matchesKelas = selectedKelas.isEmpty ||
                        kelas == selectedKelas.toLowerCase();
                    return matchesQuery && matchesKelas;
                  }).toList();

                  Widget buildSearchField() {
                    return TextField(
                      controller: generateController.searchC,
                      focusNode: generateController.focusNodeS,
                      cursorColor: const Color(0xff2563EB),
                      style: TextStyle(fontSize: isWide ? 15 : 13),
                      onTapOutside: (_) =>
                          generateController.focusNodeS.unfocus(),
                      onChanged: (value) =>
                          generateController.searchQuery.value = value,
                      decoration: InputDecoration(
                        filled: true,
                        fillColor:
                            isDark.value ? Colors.grey[900] : Colors.white,
                        labelText: isSmall ? "Cari histori..." : "Cari berdasarkan judul atau kelas...",
                        labelStyle: TextStyle(
                          color: Colors.grey.shade500,
                          fontSize: isWide ? 15 : 13,
                        ),
                        alignLabelWithHint: true,
                        floatingLabelBehavior: FloatingLabelBehavior.never,
                        prefixIcon: IconButton(
                          onPressed: () {
                            generateController.searchQuery.value =
                                generateController.searchC.text;
                          },
                          icon: Icon(Icons.search,
                              color: Colors.grey.shade500,
                              size: isWide ? 24 : 20),
                        ),
                        contentPadding: EdgeInsets.symmetric(
                          horizontal: 15,
                          vertical: isWide ? 18 : 14,
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: isDark.value
                                  ? Colors.grey.shade800
                                  : Colors.grey.shade300),
                          borderRadius:
                              const BorderRadius.all(Radius.circular(14)),
                        ),
                        focusedBorder: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(14)),
                          borderSide: BorderSide(
                            color: Color(0xff2563EB),
                            width: 1.5,
                          ),
                        ),
                      ),
                    );
                  }

                  Widget buildFilterField() {
                    return DropdownButtonFormField<String>(
                      value: selectedKelas.isEmpty ? null : selectedKelas,
                      hint: Text(isSmall ? "Semua" : "Semua Kelas",
                          style: TextStyle(
                              color: Colors.grey.shade500,
                              fontSize: isWide ? 15 : 13)),
                      style: TextStyle(
                        color: isDark.value ? Colors.white : Colors.black,
                        fontSize: isWide ? 15 : 13,
                      ),
                      onChanged: (value) => generateController
                          .selectedKelasFilter.value = value ?? '',
                      isExpanded: true,
                      decoration: InputDecoration(
                        filled: true,
                        fillColor:
                            isDark.value ? Colors.grey[900] : Colors.white,
                        labelText: isSmall ? "Kelas" : "Filter Kelas",
                        labelStyle: TextStyle(
                            color: Colors.grey.shade500,
                            fontSize: isWide ? 15 : 13),
                        alignLabelWithHint: true,
                        floatingLabelBehavior: FloatingLabelBehavior.never,
                        contentPadding: EdgeInsets.symmetric(
                            horizontal: 15, vertical: isWide ? 18 : 14),
                        enabledBorder: OutlineInputBorder(
                          borderRadius:
                              const BorderRadius.all(Radius.circular(14)),
                          borderSide: BorderSide(
                              color: isDark.value
                                  ? Colors.grey.shade800
                                  : Colors.grey.shade300),
                        ),
                        focusedBorder: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(14)),
                          borderSide:
                              BorderSide(color: Color(0xff2563EB), width: 1.5),
                        ),
                      ),
                      items: [
                        DropdownMenuItem(
                          value: '',
                          child: Text(isSmall ? "Semua" : "Semua Kelas"),
                        ),
                        ...histori
                            .map((e) => e['kelas'])
                            .toSet()
                            .map((kelas) {
                          return DropdownMenuItem(
                            value: kelas,
                            child: Text(
                              kelas,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          );
                        }),
                      ],
                    );
                  }

                  Widget buildResponsiveHeader() {
                    return Row(
                      children: [
                        // Di layar kecil rasionya jadi 1:1, di layar besar 5:3
                        Expanded(flex: isSmall ? 1 : 5, child: buildSearchField()),
                        SizedBox(width: isSmall ? 8 : 12),
                        Expanded(flex: isSmall ? 1 : 3, child: buildFilterField()),
                      ],
                    );
                  }

                  if (filteredHistori.isEmpty) {
                    return Column(
                      children: [
                        buildResponsiveHeader(),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 40),
                          child: Center(
                            child: Text(
                              "Tidak ada histori ditemukan",
                              style: TextStyle(
                                  color: Colors.grey.shade500,
                                  fontSize: isWide ? 16 : 14),
                            ),
                          ),
                        ),
                      ],
                    );
                  }

                  final grouped = <String, List<Map<String, dynamic>>>{};
                  for (var item in filteredHistori.reversed) {
                    final dateStr = item['tanggalDibuat'];
                    grouped.putIfAbsent(dateStr, () => []).add(item);
                  }

                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      buildResponsiveHeader(),
                      const SizedBox(height: 32),

                      // List Histori
                      ...grouped.entries.map((entry) {
                        final tanggal = entry.key;
                        final dataList = entry.value;

                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding:
                                  const EdgeInsets.only(bottom: 12, left: 4),
                              child: Text(
                                tanggal,
                                style: TextStyle(
                                  fontSize: isWide ? 15 : 13,
                                  fontWeight: FontWeight.bold,
                                  color: isDark.value
                                      ? Colors.grey.shade300
                                      : const Color(0xff1E293B),
                                ),
                              ),
                            ),
                            ...dataList.map((item) {
                              final jumlahKelompok =
                                  (item['kelompok'] as List).length;
                              final id = item['id'];
                              final kelasText = item['kelas'] ?? '';

                              return Padding(
                                padding: const EdgeInsets.only(bottom: 12),
                                child: InkWell(
                                  borderRadius: BorderRadius.circular(20),
                                  onLongPress: () => selectedIds.add(id),
                                  onTap: () {
                                    if (isSelecting) {
                                      selectedIds.contains(id)
                                          ? selectedIds.remove(id)
                                          : selectedIds.add(id);
                                    } else {
                                      Get.to(
                                        () => ReviewKelompokView(
                                          title: item['title'],
                                          kelas: item['kelas'],
                                          kelompok: item['kelompok'],
                                          kompetensi: item['kompetensi'],
                                          tanggalDibuat:
                                              item['tanggalDibuat'],
                                          tugas: item['tugas'],
                                          lampiranURL: item['lampiranURL'],
                                          tanggalDeadline:
                                              item['tanggalDeadline'],
                                          tanggalPresentasi:
                                              item['tanggalPresentasi'],
                                        ),
                                      );
                                    }
                                  },
                                  child: Container(
                                    padding: EdgeInsets.all(isWide ? 16 : 14),
                                    decoration: BoxDecoration(
                                      color: isDark.value
                                          ? const Color(0xff1E1E1E)
                                          : Colors.white,
                                      borderRadius: BorderRadius.circular(20),
                                      boxShadow: isDark.value
                                          ? []
                                          : [
                                              BoxShadow(
                                                color: Colors.blue.withValues(
                                                    alpha: .10),
                                                blurRadius: 10,
                                                offset: const Offset(0, 4),
                                              )
                                            ],
                                      border: Border.all(
                                        color: isDark.value
                                            ? Colors.grey.shade800
                                            : Colors.transparent,
                                      ),
                                    ),
                                    child: Row(
                                      children: [
                                        if (isSelecting)
                                          CircleAvatar(
                                            radius: isWide ? 26 : 22,
                                            backgroundColor: Colors.transparent,
                                            child: Checkbox(
                                              activeColor:
                                                  const Color(0xff2563EB),
                                              shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(4)),
                                              value: selectedIds.contains(id),
                                              onChanged: (checked) {
                                                if (checked == true) {
                                                  selectedIds.add(id);
                                                } else {
                                                  selectedIds.remove(id);
                                                }
                                              },
                                            ),
                                          )
                                        else
                                          CircleAvatar(
                                            backgroundColor:
                                                getRandomColor(kelasText),
                                            radius: isWide ? 26 : 22,
                                            child: SvgPicture.asset(
                                              "assets/images/group.svg",
                                              color: Colors.white,
                                              width: isWide ? 26 : 22,
                                            ),
                                          ),
                                        const SizedBox(width: 16),
                                        Expanded(
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Expanded(
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      item['title'] ?? '',
                                                      style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontSize:
                                                            isWide ? 16 : 14,
                                                        color: isDark.value
                                                            ? Colors.white
                                                            : const Color(
                                                                0xff1E293B),
                                                      ),
                                                      maxLines: 1,
                                                      overflow: TextOverflow
                                                          .ellipsis,
                                                    ),
                                                    const SizedBox(height: 2),
                                                    Text(
                                                      kelasText,
                                                      style: TextStyle(
                                                        fontSize:
                                                            isWide ? 14 : 12,
                                                        color: Colors.grey
                                                            .shade600,
                                                      ),
                                                      maxLines: 1,
                                                      overflow: TextOverflow
                                                          .ellipsis,
                                                    ),
                                                    const SizedBox(height: 8),
                                                    Row(
                                                      children: [
                                                        Icon(
                                                          Icons.group,
                                                          size: isWide
                                                              ? 16
                                                              : 14,
                                                          color: Colors.grey
                                                              .shade500,
                                                        ),
                                                        const SizedBox(
                                                            width: 6),
                                                        Text(
                                                          '$jumlahKelompok kelompok',
                                                          style: TextStyle(
                                                            fontSize: isWide
                                                                ? 13
                                                                : 11,
                                                            color: Colors.grey
                                                                .shade600,
                                                          ),
                                                        ),
                                                        const SizedBox(
                                                            width: 16),
                                                        Icon(
                                                          Icons.access_time,
                                                          size: isWide
                                                              ? 16
                                                              : 14,
                                                          color: Colors.grey
                                                              .shade500,
                                                        ),
                                                        const SizedBox(
                                                            width: 6),
                                                        Text(
                                                          item['tanggalDibuat'],
                                                          style: TextStyle(
                                                            fontSize: isWide
                                                                ? 13
                                                                : 11,
                                                            color: Colors.grey
                                                                .shade600,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              const SizedBox(width: 12),
                                              Icon(
                                                Icons.arrow_forward_ios_outlined,
                                                size: isWide ? 18 : 16,
                                                color: Colors.grey.shade400,
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            }),
                            const SizedBox(height: 8),
                          ],
                        );
                      }),
                    ],
                  );
                }),
              ],
            );
          },
        );
      },
    );
  }
}