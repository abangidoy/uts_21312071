import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddProductController extends GetxController {
  late TextEditingController cNPM;
  late TextEditingController cNama;
  late TextEditingController cAlamat;
  late TextEditingController cProgramStudi;
  late TextEditingController cJK;

  FirebaseFirestore firestore = FirebaseFirestore.instance;

  void tambahProduk(String npm, String nama, String alamat, String programStudi,
      String jk) async {
    CollectionReference produk = firestore.collection("mahasiswa");

    try {
      await produk.add({
        "npm": npm,
        "nama": nama,
        "alamat": alamat,
        "program_studi": programStudi,
        "jk": jk,
      });
      Get.defaultDialog(
        title: "Berhasil",
        middleText: "Berhasil menyimpan data produk",
        onConfirm: () {
          cNPM.clear();
          cNama.clear();
          cAlamat.clear();
          cProgramStudi.clear();
          cJK.clear();
          Get.back();
          Get.back();
          textConfirm:
          "OK";
        },
      );
    } catch (e) {
      print(
          "Error: $e"); // Tambahkan ini untuk mencetak pesan kesalahan ke konsol.
    }
  }

  @override
  void onInit() {
    // Inisialisasi kontroler teks
    cNPM = TextEditingController();
    cNama = TextEditingController();
    cAlamat = TextEditingController();
    cProgramStudi = TextEditingController();
    cJK = TextEditingController();
    super.onInit();
  }

  @override
  void onClose() {
    // Hapus kontroler teks
    cNPM.dispose();
    cNama.dispose();
    cAlamat.dispose();
    cProgramStudi.dispose();
    cJK.dispose();
    super.onClose();
  }
}

class AddProductView extends GetView<AddProductController> {
  const AddProductView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tambah Produk'),
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.all(8),
        child: Column(
          children: [
            TextField(
              controller: controller.cNPM,
              autocorrect: false,
              textInputAction: TextInputAction.next,
              decoration: InputDecoration(labelText: "NPM"),
            ),
            TextField(
              controller: controller.cNama,
              textInputAction: TextInputAction.next,
              decoration: InputDecoration(labelText: "Nama"),
            ),
            TextField(
              controller: controller.cAlamat,
              textInputAction: TextInputAction.next,
              decoration: InputDecoration(labelText: "Alamat"),
            ),
            TextField(
              controller: controller.cProgramStudi,
              textInputAction: TextInputAction.next,
              decoration: InputDecoration(labelText: "Program Studi"),
            ),
            TextField(
              controller: controller.cJK,
              textInputAction: TextInputAction.done,
              decoration: InputDecoration(labelText: "Jenis Kelamin"),
            ),
            SizedBox(
              height: 30,
            ),
            ElevatedButton(
              onPressed: () => controller.tambahProduk(
                controller.cNPM.text,
                controller.cNama.text,
                controller.cAlamat.text,
                controller.cProgramStudi.text,
                controller.cJK.text,
              ),
              child: Text("Simpan"),
            ),
          ],
        ),
      ),
    );
  }
}
