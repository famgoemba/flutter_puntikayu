import 'package:flutter/material.dart';
import 'package:flutter_puntikayu/data/wisata_data.dart';
import 'package:flutter_puntikayu/models/wisata_model.dart';
import 'package:flutter_puntikayu/screens/detail_screen.dart';

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
    super.initState();
    _txtSearch.addListener(_filterWisataProcess);
  }

  @override
  void dispose() {
    _txtSearch.removeListener(_filterWisataProcess);
    _txtSearch.dispose();
    super.dispose();
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
    return Scaffold(
      backgroundColor: const Color(0xFF0E0E0E),
      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 0,
        title: const Text('Search Destination'),
      ),
      body: Column(
        children: [
          // SEARCH BOX
          Padding(
            padding: const EdgeInsets.all(16),
            child: Container(
              decoration: BoxDecoration(
                color: const Color(0xFF1A1A1A),
                borderRadius: BorderRadius.circular(14),
              ),
              child: TextField(
                controller: _txtSearch,
                style: const TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  hintText: 'Search travel destination...',
                  hintStyle: TextStyle(color: Colors.grey.shade500),
                  prefixIcon:
                      const Icon(Icons.search, color: Colors.grey),
                  border: InputBorder.none,
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 14,
                  ),
                ),
              ),
            ),
          ),

          // RESULT LIST
          Expanded(
            child: _filteredWisataList.isEmpty
                ? Center(
                    child: Text(
                      'No destination found',
                      style: TextStyle(color: Colors.grey.shade600),
                    ),
                  )
                : ListView.builder(
                    itemCount: _filteredWisataList.length,
                    itemBuilder: (context, index) {
                      WisataModel wisataModel =
                          _filteredWisataList[index];
                      return InkWell(
                        borderRadius: BorderRadius.circular(16),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  DetailScreen(
                                      wisataModel: wisataModel),
                            ),
                          );
                        },
                        child: Container(
                          margin: const EdgeInsets.symmetric(
                              horizontal: 16, vertical: 8),
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: const Color(0xFF1A1A1A),
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: Row(
                            children: [
                              // IMAGE
                              ClipRRect(
                                borderRadius: BorderRadius.circular(12),
                                child: Image.asset(
                                  wisataModel.gambarUtama,
                                  width: 70,
                                  height: 70,
                                  fit: BoxFit.cover,
                                ),
                              ),
                              const SizedBox(width: 12),

                              // INFO
                              Expanded(
                                child: Column(
                                  crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      wisataModel.nama,
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 15,
                                      ),
                                    ),
                                  ],
                                ),
                              ),

                              // ARROW
                              const Icon(
                                Icons.arrow_forward_ios,
                                size: 14,
                                color: Colors.grey,
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}
