import 'package:flutter/material.dart';
import 'dart:math';

void main() {
  runApp(const MaterialApp(
    debugShowCheckedModeBanner: false,
    home: JenisBilanganPage(),
  ));
}

class JenisBilanganPage extends StatefulWidget {
  const JenisBilanganPage({super.key});

  @override
  State<JenisBilanganPage> createState() => _JenisBilanganPageState();
}

class _JenisBilanganPageState extends State<JenisBilanganPage> {
  final TextEditingController _controller = TextEditingController();
  bool isChecked = false;
  bool isCacah = false;
  bool isBulat = false;
  bool isPrima = false;
  bool isDesimal = false;
  num number = 0;
  String bulatLabel = "Bulat";

  void _cekBilangan() {
    final input = _controller.text;
    if (input.isEmpty) return;

    setState(() {
      number = num.tryParse(input) ?? 0;
      isChecked = true;

      isCacah = number is int && number >= 0;
      isBulat = number % 1 == 0;
      isDesimal = number % 1 != 0;
      isPrima = _isPrima(number);

      if (isBulat) {
        if (number > 0) {
          bulatLabel = "Bulat (positif)";
        } else if (number < 0) {
          bulatLabel = "Bulat (negatif)";
        } else {
          bulatLabel = "Bulat";
        }
      } else {
        bulatLabel = "Bulat";
      }
    });
  }

  bool _isPrima(num n) {
    if (n is! int || n < 2) return false;
    for (int i = 2; i <= sqrt(n).toInt(); i++) {
      if (n % i == 0) return false;
    }
    return true;
  }

  Widget _buildSimpleStatus(bool status, String label) {
    return Column(
      children: [
        Icon(
          status ? Icons.check_circle : Icons.cancel,
          color: status ? Colors.greenAccent : Colors.redAccent,
          size: 28,
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: TextStyle(
            fontSize: 14,
            color: Colors.grey[300],
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: ThemeData.dark(), // Apply dark theme
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Cek Jenis Bilangan'),
          backgroundColor: Colors.grey[900], // consistent dark
          foregroundColor: Colors.white,
          centerTitle: true,
        ),
        body: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextField(
                  controller: _controller,
                  keyboardType: TextInputType.number,
                  style: const TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                    labelText: 'Masukkan Angka',
                    labelStyle: const TextStyle(color: Colors.white70),
                    filled: true,
                    fillColor: Colors.grey[850],
                    enabledBorder: OutlineInputBorder(
                      borderSide: const BorderSide(color: Colors.white38),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: const BorderSide(color: Colors.white),
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                SizedBox(
                  width: double.infinity, // Full width button
                  child: ElevatedButton(
                    onPressed: _cekBilangan,
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      backgroundColor: const Color(0xFF0A84FF),
                      foregroundColor: Colors.white,
                      textStyle: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12)),
                    ),
                    child: const Text('Cek Bilangan'),
                  ),
                ),
                const SizedBox(height: 40),
                if (isChecked)
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      _buildSimpleStatus(isCacah, "Cacah"),
                      _buildSimpleStatus(isBulat, bulatLabel),
                      _buildSimpleStatus(isPrima, "Prima"),
                      _buildSimpleStatus(isDesimal, "Desimal"),
                    ],
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
