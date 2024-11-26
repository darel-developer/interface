// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart'; 
import '../components/custom_button.dart';
import '../components/custum_text.dart';
import '../components/custum_list.dart';
import '../components/loading.dart';
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
      barrierDismissible: false,
      builder: (BuildContext context) {
        return const LoadingIndicator();
      },
    );
  }

  Future<void> _onContinuePressed() async {
    _showLoadingDialog();
    await Future.delayed(const Duration(seconds: 2));

    if (mounted) {
      Navigator.pop(context);
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const NomScreen()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context)!;

    return Scaffold(
      body: Container(
        width: double.infinity,
        height: 600,
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
              backgroundColor: Colors.transparent,
              child: IconButton(
                icon: const Icon(Icons.arrow_back, color: Colors.black),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ),
            const SizedBox(height: 16),
            Text(
              localizations.completeSignup,
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
            const SizedBox(height: 24),
            Text(
              localizations.nameLabel,
              style: const TextStyle(fontSize: 16, color: Colors.black87),
            ),
            const SizedBox(height: 8),
            CustomTextField(
              hintText: localizations.nameHint,
              controller: _nameController,
            ),
            const SizedBox(height: 24),
            Text(
              localizations.specialtyLabel,
              style: const TextStyle(fontSize: 16, color: Colors.black87),
            ),
            const SizedBox(height: 8),
            CustomDropdown(
              value: _specialty,
              items: [
                localizations.specialtyOption1,
                localizations.specialtyOption2,
                localizations.specialtyOption3
              ],
              onChanged: (value) {
                setState(() {
                  _specialty = value;
                  _updateButtonState();
                });
              },
            ),
            const SizedBox(height: 24),
            Text(
              localizations.passwordLabel,
              style: const TextStyle(fontSize: 16, color: Colors.black87),
            ),
            const SizedBox(height: 4),
            Text(
              localizations.passwordHint,
              style: TextStyle(fontSize: 14, color: Colors.grey[600]),
            ),
            const SizedBox(height: 8),
            CustomTextField(
              hintText: localizations.passwordFieldHint,
              controller: _passwordController,
              isPassword: true,
            ),
            const Spacer(),
            CustomButton(
              isEnabled: _isButtonEnabled,
              text: localizations.continueButton,
              onPressed: _isButtonEnabled ? _onContinuePressed : null,
            ),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}
