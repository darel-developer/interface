import 'package:flutter/material.dart';

class ConfirmationDialog extends StatelessWidget {
  final String phoneNumber;
  final VoidCallback onConfirm;

  const ConfirmationDialog({
    super.key,
    required this.phoneNumber,
    required this.onConfirm,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      title: const Text(
        'Is your phone number correct?',
        style: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
          color: Colors.black,
        ),
        textAlign: TextAlign.center,
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            '(+237) $phoneNumber',
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 8),
          const Text(
            'We will send a verification code to your phone number.',
            style: TextStyle(
              fontSize: 14,
              color: Colors.black54,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
      actionsAlignment: MainAxisAlignment.center,
      actions: [
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.blue,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
          onPressed: onConfirm,
          child: const Text(
            'Confirm',
            style: TextStyle(color: Colors.white),
          ),
        ),
      ],
    );
  }
}

// Exemple d'utilisation
void _showConfirmationDialog(BuildContext context, String phoneNumber) {
  showDialog(
    context: context,
    barrierDismissible: false, // Empêche de fermer en cliquant en dehors.
    builder: (BuildContext context) {
      return ConfirmationDialog(
        phoneNumber: phoneNumber,
        onConfirm: () {
          Navigator.pop(context); // Ferme le dialogue.
          // Ajoutez ici l'action à effectuer après confirmation.
          print('Numéro confirmé : $phoneNumber');
        },
      );
    },
  );
}
