// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'ProfileDisplayScreen.dart';

class ProfilScreen extends StatefulWidget {
  final String username;
  const ProfilScreen({super.key, required this.username});

  @override
  _ProfilScreenState createState() => _ProfilScreenState();
}

class _ProfilScreenState extends State<ProfilScreen> {
  int? _selectedAvatarIndex;
  int? _selectedColorIndex;

  final List<Color> _backgroundColors = [
    const Color(0xFF88C7E2),
    const Color(0xFFFFEBEB),
    const Color(0xFFEBFFE1),
    const Color(0xFFFFF1F0),
    const Color(0xFFF3EEFF),
    const Color(0xFFF4F4F4),
  ];

  final List<String> _avatars = [
    'assets/images/avatar1.png',
    'assets/images/avatar2.png',
    'assets/images/avatar3.png',
    'assets/images/avatar4.png',
    'assets/images/avatar5.png',
    'assets/images/avatar6.png',
  ];

  void _onAvatarSelected(int index) {
    setState(() {
      _selectedAvatarIndex = index;
    });
  }

  void _onColorSelected(int index) {
    setState(() {
      _selectedColorIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context)!;

    return Scaffold(
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
            // Bouton de retour
            Align(
              alignment: Alignment.topLeft,
              child: IconButton(
                icon: const Icon(Icons.arrow_back, color: Colors.black),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ),
            const SizedBox(height: 16),
            Text(
              localizations.pickProfilePicture,
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.black87),
            ),
            const SizedBox(height: 24),

            // CircleAvatar avec l'avatar et la couleur sélectionnés
            GestureDetector(
              child: CircleAvatar(
                radius: 50,
                backgroundColor: _selectedColorIndex != null
                    ? _backgroundColors[_selectedColorIndex!]
                    : Colors.grey[200],
                backgroundImage: _selectedAvatarIndex != null
                    ? AssetImage(_avatars[_selectedAvatarIndex!])
                    : null,
                child: _selectedAvatarIndex == null
                    ? const Icon(
                        Icons.camera_alt,
                        color: Colors.blue,
                        size: 30,
                      )
                    : null,
              ),
            ),
            const SizedBox(height: 16),
            Text(
              localizations.youCanUseOwnAvatar,
              style: const TextStyle(fontSize: 16, color: Colors.black54),
            ),
            const SizedBox(height: 16),

            // Liste horizontale des avatars
            Text(
              localizations.chooseAvatar,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: List.generate(_avatars.length, (index) {
                  return GestureDetector(
                    onTap: () => _onAvatarSelected(index),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: CircleAvatar(
                        radius: 30,
                        backgroundColor: _selectedAvatarIndex == index ? Colors.blue : Colors.grey[200],
                        backgroundImage: AssetImage(_avatars[index]),
                      ),
                    ),
                  );
                }),
              ),
            ),
            const SizedBox(height: 24),

            // Liste horizontale des couleurs de fond
            Text(
              localizations.chooseBackgroundColor,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: List.generate(_backgroundColors.length, (index) {
                  return GestureDetector(
                    onTap: () => _onColorSelected(index),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: CircleAvatar(
                        radius: 30,
                        backgroundColor: _backgroundColors[index],
                        child: _selectedColorIndex == index
                            ? const Icon(Icons.check, color: Colors.white)
                            : null,
                      ),
                    ),
                  );
                }),
              ),
            ),
            const Spacer(),

            // Bouton "Next"
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _selectedAvatarIndex != null && _selectedColorIndex != null
                    ? () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ProfileDisplayScreen(
                              avatarIndex: _selectedAvatarIndex!,
                              colorIndex: _selectedColorIndex!,
                              userName: widget.username, // Transmet le nom d'utilisateur
                            ),
                          ),
                        );
                      }
                    : null,
                style: ElevatedButton.styleFrom(
                  backgroundColor: _selectedAvatarIndex != null && _selectedColorIndex != null
                      ? Colors.blue
                      : Colors.grey[300],
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  padding: const EdgeInsets.symmetric(vertical: 16),
                ),
                child: Text(
                  localizations.nextButton,
                  style: const TextStyle(color: Colors.white, fontSize: 16),
                ),
              ),
            ),
            const SizedBox(height: 16),
            GestureDetector(
              onTap: () {
                // Action pour sauter cette étape
              },
              child: Text(
                localizations.skipForNow,
                style: const TextStyle(fontSize: 16, color: Colors.grey),
              ),
            ),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}
