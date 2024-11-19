import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'components/custom_button.dart';
import 'components/loading.dart'; 
import 'verification.dart'; 

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Sign Up App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const SignUpScreen(), // L'écran de départ est défini ici.
    );
  }
}

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final TextEditingController _phoneController = TextEditingController();
  bool _isButtonEnabled = false;

  @override
  void initState() {
    super.initState();
    _phoneController.addListener(_updateButtonState);
  }

  void _updateButtonState() {
    setState(() {
      _isButtonEnabled = _phoneController.text.length == 9;
    });
  }

  @override
  void dispose() {
    _phoneController.dispose();
    super.dispose();
  }

  void _showLoadingDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return const LoadingIndicator(); // Utilisation du composant LoadingIndicator.
      },
    );
  }

  void _onContinuePressed() async {
    _showLoadingDialog();

    await Future.delayed(const Duration(seconds: 2));

    if (mounted) {
      Navigator.pop(context); // Ferme la boîte de dialogue.
    }

    // Redirige vers l'écran de vérification.
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const VerificationScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: 600, // Taille définie pour le dégradé.
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
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 16),
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
              'Sign up',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
            const SizedBox(height: 16),
            const Text(
              'Login with phone number',
              style: TextStyle(
                fontSize: 16,
                color: Colors.black87,
              ),
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: const Color(0xFFEDEDED),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Row(
                    children: [
                      Image.asset(
                        'assets/images/drapeau.png',
                        width: 24,
                        height: 24,
                      ),
                      const SizedBox(width: 8),
                      const Text(
                        '+237',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: TextField(
                    controller: _phoneController,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      hintText: '690 000 000',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: BorderSide.none,
                      ),
                      filled: true,
                      fillColor: const Color(0xFFEDEDED),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 50),
            CustomButton(
              isEnabled: _isButtonEnabled,
              text: 'Continue',
              onPressed: _isButtonEnabled ? _onContinuePressed : null,
            ),
            const SizedBox(height: 50),
            Center(
              child: Text.rich(
                TextSpan(
                  text: 'By signing up, you agree to the ',
                  style: const TextStyle(
                    fontSize: 12,
                    color: Colors.grey,
                  ),
                  children: [
                    TextSpan(
                      text: 'Terms of Service',
                      style: const TextStyle(
                        fontSize: 12,
                        color: Colors.black54,
                        fontWeight: FontWeight.bold,
                        decoration: TextDecoration.underline,
                      ),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          // Action pour "Terms of Service"
                          print('Terms of Service clicked');
                        },
                    ),
                    const TextSpan(
                      text: ' and ',
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.grey,
                      ),
                    ),
                    TextSpan(
                      text: 'Privacy Policy',
                      style: const TextStyle(
                        fontSize: 12,
                        color: Colors.black54,
                        fontWeight: FontWeight.bold,
                        decoration: TextDecoration.underline,
                      ),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          // Action pour "Privacy Policy"
                          print('Privacy Policy clicked');
                        },
                    ),
                    const TextSpan(
                      text: ', including Cookie Use.',
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }
}
