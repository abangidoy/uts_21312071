import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:project_get/app/routes/app_pages.dart';

import '../../../controllers/auth_controller.dart';
import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  final CAuth = Get.find<AuthController>();

  void showOption(id) async {
    var result = await Get.dialog(
      SimpleDialog(
        children: [
          ListTile(
            onTap: () {
              Get.back();
              Get.toNamed(
                Routes.UPDATE_PRODUCT,
                arguments: id,
              );
            },
            title: Text('Update'),
          ),
          ListTile(
            onTap: () {
              Get.back();
              controller.deleteProduct(id);
            },
            title: Text('Delete'),
          ),
          ListTile(
            onTap: () => Get.back(),
            title: Text('Closed'),
          ),
        ],
      ),
      barrierDismissible: false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('List Mahasiswa'),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: CAuth.logout,
            icon: Icon(Icons.logout),
          )
        ],
        // Tambahkan logo di sini
        leading: Image.asset(
          'logo.png', // Ganti dengan path logo Anda di assets
          width: 40, // Sesuaikan lebar logo
          height: 40, // Sesuaikan tinggi logo
        ),
      ),
      body: StreamBuilder<QuerySnapshot<Object?>>(
        stream: controller.streamData(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.active) {
            var listAllDocs = snapshot.data!.docs;
            return ListView.builder(
              itemCount: listAllDocs.length,
              itemBuilder: (context, index) {
                final data = listAllDocs[index].data() as Map<String, dynamic>;
                return ListTile(
                  leading: CircleAvatar(
                    child: Text('${index + 1}'),
                    backgroundColor: Colors.white,
                  ),
                  title: Text("NPM: ${data["npm"]}"),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Nama: ${data["nama"]}"),
                      Text("Alamat: ${data["alamat"]}"),
                      Text("Program Studi: ${data["program_studi"]}"),
                      Text("Jenis Kelamin: ${data["jk"]}"),
                      // Tambahkan field lain seperti program_studi dan jk jika diperlukan
                    ],
                  ),
                  trailing: IconButton(
                    onPressed: () => showOption(listAllDocs[index].id),
                    icon: Icon(Icons.more_vert),
                  ),
                );
              },
            );
          }
          return Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Get.toNamed(Routes.ADD_PRODUCT),
        child: Icon(Icons.add),
      ),
    );
  }
}
