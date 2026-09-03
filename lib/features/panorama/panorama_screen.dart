import 'package:flutter/material.dart';
import 'package:panorama_viewer/panorama_viewer.dart';

import '../poi/poi.dart';

// Affiche la photo 360° d'un point, pilotable au gyroscope : bouger le
// téléphone fait regarder autour de soi comme si on était sur place.
class PanoramaScreen extends StatelessWidget {
  const PanoramaScreen({required this.poi, super.key});

  final Poi poi;

  @override
  Widget build(BuildContext context) {
    final panoramaUrl = poi.panoramaUrl;

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(title: Text(poi.name)),
      body: panoramaUrl == null
          ? const Center(
              child: Padding(
                padding: EdgeInsets.all(24),
                child: Text(
                  "Ce point n'a pas de panorama associé.",
                  style: TextStyle(color: Colors.white),
                  textAlign: TextAlign.center,
                ),
              ),
            )
          : PanoramaViewer(
              sensorControl: SensorControl.orientation, // pilotage gyroscope
              child: Image.asset(panoramaUrl, fit: BoxFit.cover),
            ),
    );
  }
}
