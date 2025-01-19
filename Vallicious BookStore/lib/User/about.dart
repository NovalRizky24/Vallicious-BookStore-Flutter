import 'package:flutter/material.dart';

class AboutScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Aplikasi sederhana penjualan toko buku\n\n',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
              Text(
                'Versi 1.0.0\n\n',
                style: TextStyle(
                  fontSize: 16,
                  fontStyle: FontStyle.italic,
                ),
                textAlign: TextAlign.center,
              ),
              Text(
                'Vallicious BookStore adalah aplikasi mobile yang menyediakan layanan penjualan buku secara online. Dengan aplikasi ini, Anda dapat mencari, memilih, dan membeli berbagai jenis buku kapan saja dan di mana saja. Kami menawarkan pengalaman belanja yang mudah, aman, dan nyaman untuk memenuhi kebutuhan membaca Anda.\n\n'
                    'Kontak:\n'
                    'noval.rizky@mhs.itenas.ac.id\n'
                    'muhammad.zaki15@mhs.itenas.ac.id',
                style: TextStyle(
                  fontSize: 16,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
