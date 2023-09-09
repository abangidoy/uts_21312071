import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class UpdateProductController extends GetxController {
  late TextEditingController cNpm;
  late TextEditingController cNama;
  late TextEditingController cProgramStudi;
  late TextEditingController cAlamat;
  late TextEditingController cJenisKelamin;

  FirebaseFirestore firestore = FirebaseFirestore.instance;

  Future<DocumentSnapshot<Object?>> getData(String id) async {
    DocumentReference docRef = firestore.collection("mahasiswa").doc(id);
    return docRef.get();
  }

  void updateProduct(String id, String npm, String nama, String programStudi,
      String alamat, String jenisKelamin) async {
    DocumentReference productById = firestore.collection("mahasiswa").doc(id);

    try {
      await productById.update({
        "npm": npm,
        "nama": nama,
        "program_studi": programStudi,
        "alamat": alamat,
        "jenis_kelamin": jenisKelamin,
      });

      Get.defaultDialog(
        title: "Berhasil",
        middleText: "Berhasil Mengubah Data Mahasiswa.",
        onConfirm: () {
          cNpm.clear();
          cNama.clear();
          cProgramStudi.clear();
          cAlamat.clear();
          cJenisKelamin.clear();
          Get.back();
          Get.back();
        },
        textConfirm: "OK",
      );
    } catch (e) {
      print(e);
      Get.defaultDialog(
        title: "Terjadi Kesalahan",
        middleText: "Gagal Mengubah Data Mahasiswa.",
      );
    }
  }

  @override
  void onInit() {
    cNpm = TextEditingController();
    cNama = TextEditingController();
    cProgramStudi = TextEditingController();
    cAlamat = TextEditingController();
    cJenisKelamin = TextEditingController();
    super.onInit();
  }

  @override
  void onClosed() {
    cNpm.dispose();
    cNama.dispose();
    cProgramStudi.dispose();
    cAlamat.dispose();
    cJenisKelamin.dispose();
    super.onClose();
  }
}
