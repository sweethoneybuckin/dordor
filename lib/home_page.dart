import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Menu Utama')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _buildMenuButton(context, "Stopwatch", () {
              // TODO: Navigasi ke halaman Stopwatch
            }),
            _buildMenuButton(context, "Jenis Bilangan", () {
              // TODO: Navigasi ke halaman Jenis Bilangan
            }),
            _buildMenuButton(context, "Tracking LBS", () {
              // TODO: Navigasi ke halaman Tracking LBS
            }),
            _buildMenuButton(context, "Konversi Waktu", () {
              // TODO: Navigasi ke halaman Konversi Waktu
            }),
            _buildMenuButton(context, "Situs Rekomendasi", () {
              // TODO: Navigasi ke halaman Daftar Situs Rekomendasi
            }),
          ],
        ),
      ),
    );
  }

  Widget _buildMenuButton(
      BuildContext context, String title, VoidCallback onPressed) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: ElevatedButton(
        onPressed: onPressed,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Text(title, style: TextStyle(fontSize: 16)),
        ),
      ),
    );
  }
}
