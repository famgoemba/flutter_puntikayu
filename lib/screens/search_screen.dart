import 'package:flutter/material.dart';
import 'package:flutter_puntikayu/data/wisata_data.dart';
import 'package:flutter_puntikayu/models/wisata_model.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController _txtSearch = TextEditingController();
  List<WisataModel> _filteredWisataList = [];

  @override
  void initState() {
    _txtSearch.addListener(_filterWisataProcess);
  }

  @override
  void dispose() {
    _txtSearch.removeListener(_filterWisataProcess);
    _txtSearch.dispose();
  }

  void _filterWisataProcess() {
    String query = _txtSearch.text.toLowerCase();
    setState(() {
      if (query.isEmpty) {
        _filteredWisataList = [];
      } else {
        _filteredWisataList = wisataList.where((wisataModel) {
          return wisataModel.nama.toLowerCase().contains(query);
        }).toList();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(title: const Text('Search')));
  }
}
