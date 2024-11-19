import 'package:flutter/material.dart';
import 'signup.dart'; // Importez la page SignUpScreen

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const LanguageSelectionScreen(),
    );
  }
}

class LanguageSelectionScreen extends StatefulWidget {
  const LanguageSelectionScreen({Key? key}) : super(key: key);

  @override
  _LanguageSelectionScreenState createState() =>
      _LanguageSelectionScreenState();
}

class _LanguageSelectionScreenState extends State<LanguageSelectionScreen> {
  String? _selectedLanguage = 'English'; // Langue sélectionnée par défaut

  void _onContinue() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const SignUpScreen()), // Redirection vers SignUpScreen
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 33, 58, 79), // Couleur de fond bleue
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Spacer(),
            const Text(
              'Set your language',
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 24),
            Container(
              decoration: BoxDecoration(
                color: const Color(0xFF5E8BB4),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
                children: [
                  // Option pour l'anglais
                  ListTile(
                    leading: Image.asset(
                      'assets/images/uk.png', // Chemin vers l'image du drapeau anglais
                      width: 32,
                      height: 32,
                    ),
                    title: const Text(
                      'English',
                      style: TextStyle(color: Colors.white),
                    ),
                    trailing: _selectedLanguage == 'English'
                        ? const Icon(Icons.check, color: Colors.white)
                        : null,
                    onTap: () {
                      setState(() {
                        _selectedLanguage = 'English';
                      });
                    },
                  ),
                  const Divider(color: Colors.white38, height: 1),
                  // Option pour le français
                  ListTile(
                    leading: Image.asset(
                      'assets/images/fr.png', // Chemin vers l'image du drapeau français
                      width: 32,
                      height: 32,
                    ),
                    title: const Text(
                      'Français',
                      style: TextStyle(color: Colors.white),
                    ),
                    trailing: _selectedLanguage == 'Français'
                        ? const Icon(Icons.check, color: Colors.white)
                        : null,
                    onTap: () {
                      setState(() {
                        _selectedLanguage = 'Français';
                      });
                    },
                  ),
                ],
              ),
            ),
            const SizedBox(height: 40),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF365A77), // Couleur du bouton
                padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 50),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              onPressed: _onContinue,
              child: const Text(
                'Continue',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const Spacer(),
          ],
        ),
      ),
    );
  }
}
