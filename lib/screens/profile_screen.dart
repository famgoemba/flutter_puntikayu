import 'package:flutter/material.dart';
import 'edit_profile_screen.dart';
import 'my_trips_screen.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  String name = 'Username';
  String bio =
      'Exploring mountains, beaches, and hidden places.\nTraveling to collect memories.';
  String location = 'Indonesia';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0E0E0E),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Hero Banner
            Stack(
              children: [
                Container(
                  height: 240,
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: NetworkImage(
                        'https://images.unsplash.com/photo-1501785888041-af3ef285b470',
                      ),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Container(
                  height: 240,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.bottomCenter,
                      end: Alignment.topCenter,
                      colors: [
                        // ignore: deprecated_member_use
                        Colors.black.withOpacity(0.85),
                        Colors.transparent,
                      ],
                    ),
                  ),
                ),
                Positioned(
                  bottom: 20,
                  left: 16,
                  right: 16,
                  child: Row(
                    children: [
                      const CircleAvatar(
                        radius: 36,
                        backgroundImage:
                            NetworkImage('https://i.pravatar.cc/300'),
                      ),
                      const SizedBox(width: 16),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            name,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            location,
                            style: const TextStyle(color: Colors.white70),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),

            const SizedBox(height: 24),

            // Stats
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: const [
                _StatItem(title: 'Trips', value: '24'),
                _StatItem(title: 'Countries', value: '8'),
                _StatItem(title: 'Photos', value: '320'),
              ],
            ),

            const SizedBox(height: 20),

            // Bio
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                bio,
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.grey[400], height: 1.5),
              ),
            ),

            const SizedBox(height: 24),

            // Buttons
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () async {
                        final result = await Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => EditProfileScreen(
                              name: name,
                              bio: bio,
                              location: location,
                            ),
                          ),
                        );

                        if (result != null) {
                          setState(() {
                            name = result['name'];
                            bio = result['bio'];
                            location = result['location'];
                          });
                        }
                      },
                      style: OutlinedButton.styleFrom(
                        foregroundColor: Colors.white,
                        side: BorderSide(color: Colors.grey.shade700),
                      ),
                      child: const Text('Edit Profile'),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => const MyTripsScreen(),
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.teal,
                        foregroundColor: Colors.black,
                      ),
                      child: const Text('My Trips'),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }
}

class _StatItem extends StatelessWidget {
  final String title;
  final String value;

  const _StatItem({required this.title, required this.value});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          value,
          style: const TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 4),
        Text(title, style: TextStyle(color: Colors.grey[400])),
      ],
    );
  }
}
