import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class AddUserPage extends StatefulWidget {
  const AddUserPage({super.key});

  @override
  State<AddUserPage> createState() => _AddUserPageState();
}

class _AddUserPageState extends State<AddUserPage> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _jobController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  Future<void> addUserData(String username, String job) async {
    var url = "https://reqres.in/api/users";
    final response =
        await http.post(Uri.parse(url), body: {"name": username, "job": job});
    // Menampilkan data di console, data-response dari server
    log(response.body);
    if (response.statusCode == 201) {
      // Pesan jika data berhasil ditambahkan
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Pengguna berhasil ditambahkan!'),
        ),
      );
      // Mengosongkan form setelah data berhasil ditambahkan
      _nameController.clear();
      _jobController.clear();
    } else {
      // Pesan jika terjadi kesalahan dalam menambahkan pengguna
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Gagal menambahkan pengguna. Silakan coba lagi.'),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tambah Pengguna'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                TextFormField(
                  controller: _nameController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Nama harus diisi';
                    }
                    return null;
                  },
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: "Nama",
                    hintText: "Masukkan nama pengguna",
                  ),
                ),
                const SizedBox(
                  height: 24,
                ),
                TextFormField(
                  controller: _jobController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Pekerjaan harus diisi';
                    }
                    return null;
                  },
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: "Pekerjaan",
                    hintText: "Masukkan pekerjaan",
                  ),
                ),
                const SizedBox(
                  height: 24,
                ),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        await addUserData(
                          _nameController.text,
                          _jobController.text,
                        );
                      }
                    },
                    child: const Text("Kirim"),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
