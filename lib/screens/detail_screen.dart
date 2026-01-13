import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_puntikayu/models/wisata_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

class DetailScreen extends StatefulWidget {
  final WisataModel wisataModel;

  const DetailScreen({super.key, required this.wisataModel});

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  bool _isFavorite = false;

  @override
  void initState() {
    super.initState();
    _loadFavoriteStatus();
  }

  Future<void> _loadFavoriteStatus() async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    List<String> favorites = sp.getStringList('keyWisataFavorite') ?? [];
    setState(() {
      _isFavorite = favorites.contains(widget.wisataModel.nama);
    });
  }

  Future<void> _toggleFavorite() async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    List<String> favorites = sp.getStringList('keyWisataFavorite') ?? [];

    setState(() {
      if (_isFavorite) {
        favorites.remove(widget.wisataModel.nama);
        _isFavorite = false;
      } else {
        favorites.add(widget.wisataModel.nama);
        _isFavorite = true;
      }
    });

    await sp.setStringList('keyWisataFavorite', favorites);

    // ignore: use_build_context_synchronously
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          _isFavorite
              ? 'Ditambahkan ke favorit'
              : 'Dihapus dari favorit',
        ),
      ),
    );
  }

  Future<void> _launchGoogleMaps() async {
    final Uri uri = Uri.parse(
      'https://www.google.com/maps/search/?api=1&query=${widget.wisataModel.koordinat}',
    );

    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0E0E0E),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // HERO IMAGE
            Stack(
              children: [
                Image.asset(
                  widget.wisataModel.gambarUtama,
                  height: 320,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
                Container(
                  height: 320,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.bottomCenter,
                      end: Alignment.topCenter,
                      colors: [
                        // ignore: deprecated_member_use
                        Colors.black.withOpacity(0.8),
                        Colors.transparent,
                      ],
                    ),
                  ),
                ),

                // BACK BUTTON
                Positioned(
                  top: 40,
                  left: 16,
                  child: _circleButton(
                    icon: Icons.arrow_back,
                    onTap: () => Navigator.pop(context),
                  ),
                ),

                // FAVORITE BUTTON
                Positioned(
                  top: 40,
                  right: 16,
                  child: _circleButton(
                    icon:
                        _isFavorite ? Icons.favorite : Icons.favorite_border,
                    color: _isFavorite ? Colors.redAccent : Colors.white,
                    onTap: _toggleFavorite,
                  ),
                ),
              ],
            ),

            // TITLE
            Padding(
              padding: const EdgeInsets.all(16),
              child: Text(
                widget.wisataModel.nama,
                style: const TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),

            _infoTile(Icons.location_on, 'Alamat',
                widget.wisataModel.alamat),
            _infoTile(Icons.access_time, 'Jam Buka',
                widget.wisataModel.jamBuka),
            _infoTile(Icons.camera_alt, 'Instagram',
                widget.wisataModel.instagram),

            _sectionDivider(),

            // DESCRIPTION
            _sectionTitle('Deskripsi'),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                widget.wisataModel.deskripsi,
                style: TextStyle(
                  color: Colors.grey.shade300,
                  height: 1.5,
                ),
                textAlign: TextAlign.justify,
              ),
            ),

            _sectionDivider(),

            // GALLERY
            _sectionTitle('Galeri'),
            SizedBox(
              height: 160,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.only(left: 16),
                itemCount: widget.wisataModel.gambarGaleri.length,
                itemBuilder: (context, index) {
                  return Container(
                    margin: const EdgeInsets.only(right: 12),
                    width: 160,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(16),
                      child: CachedNetworkImage(
                        imageUrl:
                            widget.wisataModel.gambarGaleri[index],
                        fit: BoxFit.cover,
                        placeholder: (c, s) =>
                            const Center(child: CircularProgressIndicator()),
                        errorWidget: (c, s, e) =>
                            const Icon(Icons.error),
                      ),
                    ),
                  );
                },
              ),
            ),

            _sectionDivider(),

            // MAP BUTTON
            Padding(
              padding: const EdgeInsets.all(16),
              child: SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton.icon(
                  onPressed: _launchGoogleMaps,
                  icon: const Icon(Icons.map),
                  label: const Text('Lihat Lokasi'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.deepOrange,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ================== WIDGET HELPERS ==================

  Widget _circleButton({
    required IconData icon,
    Color color = Colors.white,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(50),
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          // ignore: deprecated_member_use
          color: Colors.black.withOpacity(0.5),
          shape: BoxShape.circle,
        ),
        child: Icon(icon, color: color),
      ),
    );
  }

  Widget _infoTile(IconData icon, String title, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
      child: Row(
        children: [
          Icon(icon, color: Colors.deepOrange, size: 20),
          const SizedBox(width: 8),
          Text(
            '$title:',
            style: const TextStyle(
                fontWeight: FontWeight.bold, color: Colors.white),
          ),
          const SizedBox(width: 6),
          Expanded(
            child: Text(
              value,
              style: TextStyle(color: Colors.grey.shade300),
            ),
          ),
        ],
      ),
    );
  }

  Widget _sectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      ),
    );
  }

  Widget _sectionDivider() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16),
      child: Divider(color: Colors.grey.shade800),
    );
  }
}
