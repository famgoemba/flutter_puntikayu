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
          .where((wisataModel) => listWisataFavorite.contains(wisataModel.nama))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Favorite')),
      body: Padding(
        padding: const EdgeInsets.only(left: 16, right: 16, bottom: 16),
        child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 8.0,
            mainAxisSpacing: 8.0,
          ),
          itemCount: _listFavorite.length,
          itemBuilder: (context, index) {
            WisataModel wisataModel = _listFavorite[index];
            return InkWell(
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
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                elevation: 1,
                child: Column(
                  children: [
                    //Gambar Utama Tempat Wisata
                    Expanded(
                      child: ClipRRect(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(16),
                          topRight: Radius.circular(16),
                        ),
                        child: Image.asset(
                          wisataModel.gambarUtama,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    //Nama Tempat Wisata
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        wisataModel.nama,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
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
