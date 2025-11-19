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
      appBar: AppBar(
        title: Text(widget.wisataModel.nama),
      ),
    );
  }
}