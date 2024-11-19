import 'package:flutter/material.dart';
import 'formulaire.dart';
import 'components/loading.dart'; // Assurez-vous que ce fichier est correctement importé

class VerificationScreen extends StatefulWidget {
  const VerificationScreen({super.key});

  @override
  _VerificationScreenState createState() => _VerificationScreenState();
}

class _VerificationScreenState extends State<VerificationScreen> {
  final List<TextEditingController> _controllers = List.generate(4, (_) => TextEditingController());
  bool _isButtonEnabled = false;
  bool _isLoading = false; // État pour gérer l'affichage du loading

  void _verificationchamp() {
    setState(() {
      _isButtonEnabled = _controllers.every((controller) => controller.text.isNotEmpty);
    });
  }

  @override
  void initState() {
    super.initState();
    for (var controller in _controllers) {
      controller.addListener(_verificationchamp);
    }
  }

  @override
  void dispose() {
    for (var controller in _controllers) {
      controller.dispose();
    }
    super.dispose();
  }

  Future<void> _navigation() async {
    if (_isButtonEnabled) {
      setState(() {
        _isLoading = true; // Affiche l'indicateur de chargement
      });

      // Simule un délai avant de naviguer
      await Future.delayed(const Duration(seconds: 2));

      setState(() {
        _isLoading = false; // Cache l'indicateur de chargement
      });

      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const FormulaireScreen()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            width: double.infinity,
            height: 600,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Color(0xFFD4E2F9), // Couleur du haut
                  Color(0xFFFFFFFF), // Couleur du bas
                ],
              ),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 16),
                // Bouton retour personnalisé
                CircleAvatar(
                  backgroundColor: Colors.transparent, // Couleur du cercle
                  child: IconButton(
                    icon: const Icon(Icons.arrow_back, color: Colors.black),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                ),
                const SizedBox(height: 16),
                const Text(
                  'Verification Code',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.black87),
                ),
                const SizedBox(height: 8),
                const Text(
                  'Enter the 4-digit code sent to +237 123456789',
                  style: TextStyle(fontSize: 16, color: Colors.black54),
                ),
                const SizedBox(height: 32),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: List.generate(
                    4,
                    (index) => Container(
                      width: 60,
                      height: 60,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: Colors.grey.shade300),
                      ),
                      child: TextField(
                        controller: _controllers[index],
                        textAlign: TextAlign.center,
                        style: const TextStyle(fontSize: 24),
                        keyboardType: TextInputType.number,
                        maxLength: 1,
                        decoration: const InputDecoration(
                          counterText: "",
                          border: InputBorder.none,
                        ),
                        onChanged: (value) {
                          if (value.isNotEmpty && index < 3) {
                            FocusScope.of(context).nextFocus();
                          }
                        },
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 24),
                Center(
                  child: ElevatedButton(
                    onPressed: _isButtonEnabled ? _navigation : null,
                    style: ElevatedButton.styleFrom(
                      minimumSize: const Size(double.infinity, 50),
                      backgroundColor: _isButtonEnabled ? Colors.blue : Colors.grey.shade300,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                    ),
                    child: const Text('Verify', style: TextStyle(color: Colors.white, fontSize: 18)),
                  ),
                ),
                const SizedBox(height: 16),
              ],
            ),
          ),
          // Affiche le composant de chargement si _isLoading est vrai
          if (_isLoading)
            const LoadingIndicator(),
        ],
      ),
    );
  }
}
