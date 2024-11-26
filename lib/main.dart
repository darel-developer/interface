// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'screens/signup.dart'; 

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // langue par défaut 'en'
  Locale _locale = const Locale('en');

  // Fonction pour changer la locale
  void _changeLocale(Locale locale) {
    setState(() {
      _locale = locale; // Mise à jour de la locale
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      locale: _locale, // Applique la langue sélectionnée
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        AppLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('en'),
        Locale('fr'),
      ],
      debugShowCheckedModeBanner: false,
      home: LanguageSelectionScreen(onLanguageChanged: _changeLocale),
    );
  }
}

class LanguageSelectionScreen extends StatefulWidget {
  final Function(Locale) onLanguageChanged; // Callback pour changer la langue

  const LanguageSelectionScreen({super.key, required this.onLanguageChanged});

  @override
  _LanguageSelectionScreenState createState() =>
      _LanguageSelectionScreenState();
}

class _LanguageSelectionScreenState extends State<LanguageSelectionScreen> {
  String _selectedLanguage = 'English'; // Langue par défaut

  void _onContinue() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const SignUpScreen(),
      ),
    );
  }

  void _changeLanguage(String language) {
    Locale newLocale;
    switch (language) {
      case 'Français':
        newLocale = const Locale('fr');
        break;
      case 'English':
      default:
        newLocale = const Locale('en');
        break;
    }

    widget.onLanguageChanged(newLocale); // Appel du callback pour changer la langue

    setState(() {
      _selectedLanguage = language; // Mise à jour de la langue sélectionnée
    });
  }

  @override
  Widget build(BuildContext context) {
    // Chargement des textes localisés
    final localizations = AppLocalizations.of(context)!;

    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 33, 58, 79),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Spacer(),
            Text(
              localizations.setYourLanguage, // Texte localisé
              style: const TextStyle(
                color: Colors.white,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 50),
            Container(
              decoration: BoxDecoration(
                color: const Color(0xFF5E8BB4),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
                children: [
                  //option pour l'anglais
                  ListTile(
                    leading: Image.asset(
                      'assets/images/uk.png',
                      width: 32,
                      height: 32,
                    ),
                    title: Text(
                      localizations.english, // Texte localisé
                      style: const TextStyle(color: Colors.white),
                    ),
                    trailing: _selectedLanguage == 'English'
                        ? const Icon(Icons.check, color: Colors.white)
                        : null,
                    onTap: () => _changeLanguage('English'), // Changer de langue
                  ),
                  const Divider(color: Colors.white38, height: 1),
                  // Option pour le français
                  ListTile(
                    leading: Image.asset(
                      'assets/images/fr.png',
                      width: 32,
                      height: 32,
                    ),
                    title: Text(
                      localizations.french, // Texte localisé
                      style: const TextStyle(color: Colors.white),
                    ),
                    trailing: _selectedLanguage == 'Français'
                        ? const Icon(Icons.check, color: Colors.white)
                        : null,
                    onTap: () => _changeLanguage('Français'), // Changer de langue
                  ),
                ],
              ),
            ),
            const SizedBox(height: 100),
            ElevatedButton(
              onPressed: _onContinue,
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF5E8BB4),
                padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 50),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: Text(
                localizations.continueText,
                style: const TextStyle(
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
