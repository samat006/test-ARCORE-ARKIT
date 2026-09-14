import 'package:flutter/material.dart';
import 'package:maplibre_gl/maplibre_gl.dart';

class MapPage extends StatelessWidget {
  const MapPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Ma carte'),
      ),
      body: MapLibreMap(
        styleString:
      'https://tiles.openfreemap.org/styles/bright',

        initialCameraPosition: const CameraPosition(
          target: LatLng(42.635, 8.937),
          zoom: 7,
           tilt: 45,
        ),
      ),
    );
  }
}