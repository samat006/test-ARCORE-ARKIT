import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:model_viewer_plus/model_viewer_plus.dart';

import '../poi/poi.dart';

// Écran affiché quand on tape sur un point de la carte : montre le modèle
// 3D associé, avec un bouton "Voir en AR" natif (Quick Look/Scene Viewer).
class ArScreen extends StatelessWidget {
  const ArScreen({required this.poi, super.key});

  final Poi poi;

  @override
  Widget build(BuildContext context) {
    final modelUrl = poi.modelUrl;

    return Scaffold(
      appBar: AppBar(
        title: Text(poi.name),
        actions: [
          // N'affiche le bouton que si ce point a un panorama associé.
          if (poi.panoramaUrl != null)
            IconButton(
              icon: const Icon(Icons.threesixty),
              tooltip: 'Vue panoramique',
              onPressed: () => context.push('/panorama', extra: poi),
            ),
        ],
      ),
      body: modelUrl == null
          ? const Center(child: Text("Ce point n'a pas de modèle 3D associé."))
          : ModelViewer(
              src: modelUrl,
              alt: poi.name,
              autoRotate: true, // rotation automatique quand on ne touche pas
              cameraControls: true, // glisser du doigt pour orbiter
              ar: true, // active le bouton "Voir en AR"
              arModes: const ['scene-viewer', 'quick-look', 'webxr'],
            ),
    );
  }
}
