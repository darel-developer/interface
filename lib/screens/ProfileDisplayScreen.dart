import 'package:flutter/material.dart';

class ProfileDisplayScreen extends StatelessWidget {
  final int avatarIndex;
  final int colorIndex;
  final String userName; 

  ProfileDisplayScreen({
    Key? key,
    required this.avatarIndex,
    required this.colorIndex,
    required this.userName, 
  }) : super(key: key);

  // Liste des couleurs spécifiques pour le cercle d'arrière-plan de l'avatar
  final List<Color> _avatarBackgroundColors = [
    const Color(0xFF88C7E2),
    const Color(0xFFFFEBEB),
    const Color(0xFFEBFFE1),
    const Color(0xFFFFF1F0),
    const Color(0xFFF3EEFF),
    const Color(0xFFF4F4F4),
  ];

  // Liste des chemins des images locales pour les avatars
  final List<String> _avatars = [
    'assets/images/avatar1.png',
    'assets/images/avatar2.png',
    'assets/images/avatar3.png',
    'assets/images/avatar4.png',
    'assets/images/avatar5.png',
    'assets/images/avatar6.png',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFFD4E2F9), 
              Color(0xFFFFFFFF), 
            ],
          ),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 40),
            Align(
              alignment: Alignment.topLeft,
              child: IconButton(
                icon: const Icon(Icons.arrow_back, color: Colors.black),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ),
            const SizedBox(height: 30),
            // Cercle pour afficher l'avatar avec sa couleur d'arrière-plan
            CircleAvatar(
              radius: 80, 
              backgroundColor: _avatarBackgroundColors[colorIndex], 
              child: ClipOval(
                child: Image.asset(
                  _avatars[avatarIndex],
                  fit: BoxFit.cover,
                  width: 160, 
                  height: 160,
                ),
              ),
            ),
            const SizedBox(height: 20),
            // Titre
            Text(
              ' @ $userName', // Affiche le nom d'utilisateur
              style: const TextStyle(
                fontSize: 18,
                color: Colors.black54,
              ),
            ),
            const SizedBox(height: 50),
            const Text(
              'Onboarding', 
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
            const SizedBox(height: 10),
            const Text(
              'with', 
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w400,
                color: Colors.black54,
              ),
            ),
            const SizedBox(height: 25),
            const Text(
              'Med Prepa', 
              style: TextStyle(
                fontSize: 70,
                fontWeight: FontWeight.bold,
                color: Colors.blueAccent,
              ),
            ),
            const Spacer(),
          ],
        ),
      ),
    );
  }
}
