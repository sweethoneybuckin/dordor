import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

void main() {
  runApp(LBSTrackingApp());
}

class LBSTrackingApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: Colors.black, // Latar belakang hitam
        textTheme: TextTheme(
          bodyLarge: TextStyle(color: Colors.white), // Warna teks putih
          bodyMedium: TextStyle(color: Colors.white), // Warna teks putih
        ),
      ),
      home: LokasiPenggunaScreen(),
    );
  }
}

class LokasiPenggunaScreen extends StatefulWidget {
  const LokasiPenggunaScreen({Key? key}) : super(key: key);

  @override
  LokasiPenggunaScreenState createState() => LokasiPenggunaScreenState();
}

class LokasiPenggunaScreenState extends State<LokasiPenggunaScreen> {
  Position? _currentPosition;
  String _locationMessage = "Tekan tombol untuk mendapatkan lokasi Anda";

  String get _formattedLocation {
    if (_currentPosition == null) {
      return "Lokasi tidak tersedia";
    }
    return "Lintang: ${_currentPosition!.latitude}, Bujur: ${_currentPosition!.longitude}";
  }

  @override
  void initState() {
    super.initState();
    _checkPermission();
  }

  Future<void> _checkPermission() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Periksa apakah layanan lokasi diaktifkan
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      setState(() {
        _locationMessage = "Layanan lokasi tidak diaktifkan.";
      });
      return;
    }

    // Periksa izin lokasi
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        setState(() {
          _locationMessage = "Izin lokasi ditolak.";
        });
        return;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      setState(() {
        _locationMessage =
            "Izin lokasi ditolak secara permanen. Harap aktifkan di pengaturan.";
      });
      return;
    }
  }

  Future<void> _getCurrentLocation() async {
    try {
      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );
      setState(() {
        _currentPosition = position;
        _locationMessage = _formattedLocation;
      });
    } catch (e) {
      setState(() {
        _locationMessage = "Terjadi kesalahan saat mendapatkan lokasi: $e";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Sistem Pelacakan Lokasi"),
        backgroundColor: Colors.grey[900], // Warna AppBar gelap
      ),
      body: Center(
        // Membuat konten berada di tengah layar
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.location_on,
                size: 100,
                color: Colors.redAccent, // Ikon lokasi dengan warna menarik
              ),
              SizedBox(height: 20),
              Text(
                "Lokasi Anda Saat Ini",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              SizedBox(height: 10),
              Text(
                _locationMessage,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.white70,
                ), // Teks putih dengan transparansi
              ),
              SizedBox(height: 30),
              ElevatedButton.icon(
                onPressed: _getCurrentLocation,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.redAccent, // Warna tombol merah
                  foregroundColor: Colors.white, // Warna teks tombol putih
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(
                      30,
                    ), // Tombol dengan sudut melengkung
                  ),
                ),
                icon: Icon(Icons.my_location), // Ikon pada tombol
                label: Text(
                  "Dapatkan Lokasi",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
