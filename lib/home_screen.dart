import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

// Écran d'accueil : menu de navigation vers les fonctionnalités de l'app.
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Map AR App')),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min, // ne prend que la place nécessaire
          children: [
            FilledButton(
              // context.go() remplace l'écran actuel par celui de la route '/map'
              onPressed: () => context.go('/map'),
              child: const Text('Carte'),
            ),
          ],
        ),
      ),
    );
  }
}
