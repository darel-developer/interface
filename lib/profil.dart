import 'package:flutter/material.dart';

class ProfilScreen extends StatefulWidget {
  const ProfilScreen({Key? key}) : super(key: key);

  @override
  _ProfilScreenState createState() => _ProfilScreenState();
}

class _ProfilScreenState extends State<ProfilScreen> {
  int? _selectedAvatarIndex;
  
  void _onAvatarSelected(int index) {
    setState(() {
      _selectedAvatarIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xFFD4E2F9), Color(0xFFFFFFFF)],
          ),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 16),
            const Text(
              'Pick a profile picture',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.black87),
            ),
            const SizedBox(height: 24),
            GestureDetector(
              child: CircleAvatar(
                radius: 50,
                backgroundColor: Colors.grey[200],
                child: Icon(
                  Icons.camera_alt,
                  color: Colors.blue,
                  size: 30,
                ),
              ),
            ),
            const SizedBox(height: 16),
            const Text(
              'You can also use your own',
              style: TextStyle(fontSize: 16, color: Colors.black54),
            ),
            const SizedBox(height: 16),
            // Liste d'avatars
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(6, (index) {
                return GestureDetector(
                  onTap: () => _onAvatarSelected(index),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: CircleAvatar(
                      radius: 24,
                      backgroundColor: _selectedAvatarIndex == index ? Colors.blue : Colors.grey[200],
                      child: Icon(Icons.person, color: _selectedAvatarIndex == index ? Colors.white : Colors.grey),
                    ),
                  ),
                );
              }),
            ),
            const Spacer(),
            // Bouton "Next"
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _selectedAvatarIndex != null
                    ? () {
                        // naviguer vers la dernière page
                      }
                    : null,
                style: ElevatedButton.styleFrom(
                  backgroundColor: _selectedAvatarIndex != null ? Colors.blue : Colors.grey[300],
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  padding: const EdgeInsets.symmetric(vertical: 16),
                ),
                child: const Text(
                  'Next',
                  style: TextStyle(color: Colors.white, fontSize: 16),
                ),
              ),
            ),
            const SizedBox(height: 16),
            GestureDetector(
              onTap: () {
                // Action pour sauter cette étape
              },
              child: const Text(
                'Skip it for now',
                style: TextStyle(fontSize: 16, color: Colors.grey),
              ),
            ),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}
