class Rpl1 {
  String? nama;
  String? jenisKelamin;
  String? agama;

  Rpl1({this.nama, this.jenisKelamin, this.agama});

  Rpl1.fromJson(Map<String, dynamic> json) {
    nama = json['nama'];
    jenisKelamin = json['jenis_kelamin'];
    agama = json['agama'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['nama'] = nama;
    data['jenis_kelamin'] = jenisKelamin;
    data['agama'] = agama;
    return data;
  }
}
