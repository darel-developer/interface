import 'package:flutter/material.dart';

class LoadingIndicator extends StatelessWidget {
  const LoadingIndicator({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // Couche semi-transparente en arrière-plan
        Container(
          color: Colors.black.withOpacity(0.3),
        ),
        // Conteneur blanc avec le spinner
        Center(
          child: Container(
            width: 80,
            height: 80,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Padding(
              padding: EdgeInsets.all(16),
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(Color(0xFF4B97E2)),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
