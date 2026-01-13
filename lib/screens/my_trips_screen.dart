import 'package:flutter/material.dart';

class MyTripsScreen extends StatelessWidget {
  const MyTripsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0E0E0E),
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text('My Trips'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: const [
          _TripItem(
            title: 'Bromo',
            location: 'Indonesia',
            image:
                'https://upload.wikimedia.org/wikipedia/commons/a/a4/Andhika_bayu_nugraha-taman_nasional_bromo_tengger_semeru.jpg',
          ),
          _TripItem(
            title: 'Paris',
            location: 'Prancis',
            image:
                'https://img1.wallspic.com/previews/4/7/0/2/7/172074/172074-eiffel_tower-les_invalides-arc_de_triomphe-montparnasse-tower-550x310.jpg',
          ),
          _TripItem(
            title: 'Seoul',
            location: 'Korea Selatan',
            image:
                'https://silversea-discover.imgix.net/2022/12/QCRUa0gV-2asunsetinSeoulskyline_1490190263.jpg?auto=compress%2Cformat&ixlib=php-3.3.1',
          ),
          _TripItem(
            title: 'Raja Ampat',
            location: 'Papua',
            image:
                'https://images.unsplash.com/photo-1507525428034-b723cf961d3e',
          ),
        ],
      ),
    );
  }
}

class _TripItem extends StatelessWidget {
  final String title;
  final String location;
  final String image;

  const _TripItem({
    required this.title,
    required this.location,
    required this.image,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      height: 180,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        image: DecorationImage(
          image: NetworkImage(image),
          fit: BoxFit.cover,
        ),
      ),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
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
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold),
            ),
            Text(
              location,
              style: const TextStyle(color: Colors.white70),
            ),
          ],
        ),
      ),
    );
  }
}
