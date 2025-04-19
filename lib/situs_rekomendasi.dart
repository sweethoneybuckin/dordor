import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class SitusRekomendasiPage extends StatefulWidget {
  const SitusRekomendasiPage({super.key});

  @override
  State<SitusRekomendasiPage> createState() => _SitusRekomendasiPageState();
}

class _SitusRekomendasiPageState extends State<SitusRekomendasiPage> {
  final List<Map<String, dynamic>> situsList = [
    {
      'nama': 'Tanaman vs Mutan',
      'url':
          'https://play.google.com/store/apps/details?id=com.ea.game.pvzfree_row&hl=id',
      'gambar': 'assets/tanamangerak.jpg',
      'favorite': false,
    },
    {
      'nama': 'Sepakbola Elektronik',
      'url':
          'https://play.google.com/store/apps/details?id=jp.konami.pesam&hl=id',
      'gambar': 'assets/efootball.webp',
      'favorite': false,
    },
    {
      'nama': 'Iki Epep',
      'url':
          'https://play.google.com/store/apps/details?id=com.dts.freefireth&hl=id',
      'gambar': 'assets/epep.webp',
      'favorite': false,
    },
    {
      'nama': 'Epep versi HD Ada P',
      'url': 'https://play.google.com/store/apps/details?id=com.tencent.ig',
      'gambar': 'assets/pubg.webp',
      'favorite': false,
    },
    {
      'nama': 'Legenda Seluler',
      'url':
          'https://play.google.com/store/apps/details?id=com.mobile.legends&hl=id',
      'gambar': 'assets/legenda_seluler.jpg',
      'favorite': false,
    },
    {
      'nama': 'Ea Ea Ea FC',
      'url':
          'https://play.google.com/store/apps/details?id=com.ea.gp.fifamobile&hl=id',
      'gambar': 'assets/eafc.webp',
      'favorite': false,
    },
  ];

  void _toggleFavorite(int index) {
    setState(() {
      situsList[index]['favorite'] = !situsList[index]['favorite'];
    });
  }

  void _launchURL(String url) async {
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    } else {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Tidak bisa membuka $url')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Situs Rekomendasi'),
        backgroundColor: Colors.grey[900],
      ),
      backgroundColor: Colors.black,
      body: ListView.builder(
        itemCount: situsList.length,
        itemBuilder: (context, index) {
          final situs = situsList[index];
          return Card(
            color: Colors.grey[850],
            margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              children: [
                // Image section (full width)
                ClipRRect(
                  borderRadius: const BorderRadius.vertical(
                    top: Radius.circular(12),
                  ),
                  child: Container(
                    width: double.infinity,
                    height: 180,
                    child: Image.network(
                      situs['gambar'],
                      fit: BoxFit.cover, // Changed from contain to cover
                      width: double.infinity,
                      errorBuilder:
                          (context, error, stackTrace) => Container(
                            color: Colors.grey[700],
                            child: const Center(
                              child: Icon(
                                Icons.image_not_supported,
                                size: 50,
                                color: Colors.white,
                              ),
                            ),
                          ),
                      loadingBuilder: (context, child, loadingProgress) {
                        if (loadingProgress == null) return child;
                        return Container(
                          color: Colors.grey[800],
                          child: Center(
                            child: CircularProgressIndicator(
                              value:
                                  loadingProgress.expectedTotalBytes != null
                                      ? loadingProgress.cumulativeBytesLoaded /
                                          loadingProgress.expectedTotalBytes!
                                      : null,
                              color: Colors.white,
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),

                // Content section
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    children: [
                      // Title and URL
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              situs['nama'],
                              style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              situs['url'],
                              style: const TextStyle(color: Colors.white70),
                            ),
                          ],
                        ),
                      ),

                      // Favorite button
                      IconButton(
                        icon: Icon(
                          situs['favorite']
                              ? Icons.favorite
                              : Icons.favorite_border,
                          color: situs['favorite'] ? Colors.red : Colors.white,
                          size: 28, // Larger icon
                        ),
                        onPressed: () => _toggleFavorite(index),
                      ),

                      // Visit button
                      ElevatedButton.icon(
                        onPressed: () => _launchURL(situs['url']),
                        icon: const Icon(Icons.open_in_browser),
                        label: const Text('Visit'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue,
                          foregroundColor: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}