import 'package:flutter/material.dart';
import 'package:flutter_puntikayu/data/wisata_data.dart';
import 'package:flutter_puntikayu/models/wisata_model.dart';
import 'package:flutter_puntikayu/screens/detail_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FavoriteScreen extends StatefulWidget {
  const FavoriteScreen({super.key});

  @override
  State<FavoriteScreen> createState() => _FavoriteScreenState();
}

class _FavoriteScreenState extends State<FavoriteScreen> {
  List<WisataModel> _listFavorite = [];

  @override
  void initState() {
    super.initState();
    _loadFavoriteWisata();
  }

  Future<void> _loadFavoriteWisata() async {
    SharedPreferences varSP = await SharedPreferences.getInstance();
    List<String> listWisataFavorite =
        varSP.getStringList('keyWisataFavorite') ?? [];

    setState(() {
      _listFavorite = wisataList
          .where((wisataModel) =>
              listWisataFavorite.contains(wisataModel.nama))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0E0E0E),
      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 0,
        title: const Text('Favorite Places'),
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 16, right: 16, bottom: 16),
        child: _listFavorite.isEmpty
            ? Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(Icons.favorite_border,
                        size: 64, color: Colors.grey),
                    const SizedBox(height: 12),
                    Text(
                      'No favorite places yet',
                      style: TextStyle(color: Colors.grey.shade500),
                    ),
                  ],
                ),
              )
            : GridView.builder(
                gridDelegate:
                    const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 12,
                  mainAxisSpacing: 12,
                  childAspectRatio: 0.75,
                ),
                itemCount: _listFavorite.length,
                itemBuilder: (context, index) {
                  WisataModel wisataModel = _listFavorite[index];
                  return InkWell(
                    borderRadius: BorderRadius.circular(20),
                    onTap: () async {
                      await Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              DetailScreen(wisataModel: wisataModel),
                        ),
                      );
                      _loadFavoriteWisata();
                    },
                    child: Card(
                      elevation: 6,
                      shadowColor: Colors.black87,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Image
                          Expanded(
                            child: ClipRRect(
                              borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(20),
                                topRight: Radius.circular(20),
                              ),
                              child: Stack(
                                fit: StackFit.expand,
                                children: [
                                  Image.asset(
                                    wisataModel.gambarUtama,
                                    fit: BoxFit.cover,
                                  ),
                                  Container(
                                    decoration: BoxDecoration(
                                      gradient: LinearGradient(
                                        begin: Alignment.bottomCenter,
                                        end: Alignment.topCenter,
                                        colors: [
                                          // ignore: deprecated_member_use
                                          Colors.black.withOpacity(0.7),
                                          Colors.transparent,
                                        ],
                                      ),
                                    ),
                                  ),
                                  // Favorite Badge
                                  Positioned(
                                    top: 10,
                                    right: 10,
                                    child: Container(
                                      padding: const EdgeInsets.all(6),
                                      decoration: BoxDecoration(
                                        // ignore: deprecated_member_use
                                        color: Colors.black.withOpacity(0.6),
                                        shape: BoxShape.circle,
                                      ),
                                      child: const Icon(
                                        Icons.favorite,
                                        color: Colors.redAccent,
                                        size: 16,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),

                          // Title
                          Padding(
                            padding: const EdgeInsets.all(12),
                            child: Text(
                              wisataModel.nama,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Color.fromARGB(255, 0, 0, 0),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
      ),
    );
  }
}
