import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class UpdateProductController extends GetxController {
  late TextEditingController cNama;
  late TextEditingController cHarga;

  FirebaseFirestore firestore = FirebaseFirestore.instance;

  Future<DocumentSnapshot<Object?>> getData(String id) async {
    DocumentReference docRef = firestore.collection("products").doc(id);

    return docRef.get();
  }

  void updateProduct(String nama, String harga, String id) async {
    DocumentReference productById = firestore.collection("products").doc(id);

    try {
      await productById.update({
        "nama": nama,
        "price": harga,
      });

      Get.defaultDialog(
        title: "Berhasil",
        middleText: "Berhasil Mengubah Data Product.",
        onConfirm: () {
          cNama.clear();
          cHarga.clear();
          Get.back();
          Get.back();
        },
        textConfirm: "OK",
      );
    } catch (e) {
      print(e);
      Get.defaultDialog(
        title: "Terjadi Kesalahan",
        middleText: "Gagal Menambahkan Product.",
      );
    }
    ;
  }

  @override
  void onInit() {
    cNama = TextEditingController();
    cHarga = TextEditingController();
    super.onInit();
  }

  @override
  void onClosed() {
    cNama.dispose();
    cHarga.dispose();
    super.onClose();
  }
}
