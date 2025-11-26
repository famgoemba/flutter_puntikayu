import 'package:flutter/material.dart';
import 'package:flutter_puntikayu/models/wisata_model.dart';

class DetailScreen extends StatefulWidget {
  final WisataModel wisataModel;
  
  const DetailScreen({super.key, required this.wisataModel});

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              // GAMBAR UTAMA DAN TOMBOL BACK (TUMPUKAN)
              Stack(
                children: [
                  // Gambar Utama
                  Image.asset(
                    widget.wisataModel.gambarUtama,
                    fit: BoxFit.cover,
                    width: double.infinity,
                    height: 300,
                  ),
                  // Tombol Back
                  Container(
                    margin: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.white70
                    ),
                    child: IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      }, 
                      icon: const Icon(Icons.arrow_back)
                    )
                  )
                ],
              ),
              // NAMA DAN TOMBOL LOVE
        
              // ALAMAT
          
              // JAM BUKA
          
              // INSTAGRAM
          
              // DESKRIPSI
          
              // GAMBAR GALERI
            ],
          ),
        ),
      )
    );
  }
}