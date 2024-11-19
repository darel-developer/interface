import 'package:flutter/material.dart';
import 'components/custom_button.dart';
import 'components/custum_text.dart';
import 'components/custum_list.dart';
import 'components/loading.dart'; // Assurez-vous que ce fichier est bien référencé.
import 'name.dart';

class FormulaireScreen extends StatefulWidget {
  const FormulaireScreen({super.key});

  @override
  _FormulaireScreenState createState() => _FormulaireScreenState();
}

class _FormulaireScreenState extends State<FormulaireScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  String? _specialty = 'Odontostomatologie';
  bool _isButtonEnabled = false;

  @override
  void initState() {
    super.initState();
    _nameController.addListener(_updateButtonState);
    _passwordController.addListener(_updateButtonState);
  }

  void _updateButtonState() {
    setState(() {
      _isButtonEnabled = _nameController.text.isNotEmpty &&
          _passwordController.text.length >= 8 &&
          _specialty != null;
    });
  }

  @override
  void dispose() {
    _nameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _showLoadingDialog() {
    showDialog(
      context: context,
      barrierDismissible: false, // Empêche la fermeture en cliquant à l'extérieur.
      builder: (BuildContext context) {
        return const LoadingIndicator();
      },
    );
  }

  Future<void> _onContinuePressed() async {
    _showLoadingDialog(); // Affiche le composant de chargement.

    // Simule une opération (par exemple, un appel réseau).
    await Future.delayed(const Duration(seconds: 2));

    if (mounted) {
      Navigator.pop(context); // Ferme le dialogue de chargement.
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const NomScreen()),
      ); // Navigue vers l'écran suivant.
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
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
              'Complete your signup',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
            const SizedBox(height: 24),
            const Text(
              'Name',
              style: TextStyle(fontSize: 16, color: Colors.black87),
            ),
            const SizedBox(height: 8),
            CustomTextField(
              hintText: 'Murielle',
              controller: _nameController,
            ),
            const SizedBox(height: 24),
            const Text(
              'Specialty',
              style: TextStyle(fontSize: 16, color: Colors.black87),
            ),
            const SizedBox(height: 8),
            CustomDropdown(
              value: _specialty,
              items: const ['Odontostomatologie', 'Cardiologie', 'Dermatologie'],
              onChanged: (value) {
                setState(() {
                  _specialty = value;
                  _updateButtonState();
                });
              },
            ),
            const SizedBox(height: 24),
            const Text(
              'You’ll need a password',
              style: TextStyle(fontSize: 16, color: Colors.black87),
            ),
            const SizedBox(height: 4),
            Text(
              'Make sure it’s 8 characters or more',
              style: TextStyle(fontSize: 14, color: Colors.grey[600]),
            ),
            const SizedBox(height: 8),
            CustomTextField(
              hintText: 'Enter your password',
              controller: _passwordController,
              isPassword: true,
            ),
            const Spacer(),
            CustomButton(
              isEnabled: _isButtonEnabled,
              text: 'Continue',
              onPressed: _isButtonEnabled ? _onContinuePressed : null,
            ),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}
