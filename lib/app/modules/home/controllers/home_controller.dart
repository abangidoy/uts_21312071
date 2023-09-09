import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  Future<QuerySnapshot<Map<String, dynamic>>> getData() async {
    try {
      // Mengambil data dari koleksi 'mahasiswa'
      QuerySnapshot<Map<String, dynamic>> querySnapshot =
          await firestore.collection('mahasiswa').get();

      return querySnapshot;
    } catch (e) {
      print(e.toString());
      throw e; // Lebih baik melempar kembali kesalahan agar dapat ditangani di atasnya.
    }
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> streamData() {
    // Menggunakan stream untuk data real-time dari koleksi 'mahasiswa'
    return firestore.collection('mahasiswa').snapshots();
  }

  Future<void> deleteProduct(String id) async {
    try {
      // Menghapus dokumen berdasarkan ID
      await firestore.collection("mahasiswa").doc(id).delete();
    } catch (e) {
      print(e.toString());
    }
  }
}
