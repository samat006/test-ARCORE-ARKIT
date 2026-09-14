import 'package:flutter/material.dart';
import 'package:maplibre_gl/maplibre_gl.dart';
import 'package:geolocator/geolocator.dart';

class MapPage extends StatefulWidget {
  const MapPage({super.key});

  @override
  State<MapPage> createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  MapLibreMapController? mapController;

  Future<void> allerMaPosition() async {
    Position position = await Geolocator.getCurrentPosition();

    LatLng maPosition = LatLng(
      position.latitude,
      position.longitude,
    );

    // Déplacer la caméra
    await mapController?.animateCamera(
      CameraUpdate.newLatLngZoom(
        maPosition,
        16,
      ),
    );

    // Ajouter un cercle à ma position
    await mapController?.addCircle(
      CircleOptions(
        geometry: maPosition,
        circleRadius: 10,
        circleColor: '#FF0000',
        circleOpacity: 0.8,
        circleStrokeWidth: 3,
        circleStrokeColor: '#FFFFFF',
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Ma carte'),
      ),
      body: Column(
        children: [
          ElevatedButton(
            onPressed: allerMaPosition,
            child: const Text('📍 Ma position'),
          ),

          Expanded(
            child: MapLibreMap(
              styleString:
                  'https://tiles.openfreemap.org/styles/bright',

              initialCameraPosition: const CameraPosition(
                target: LatLng(42.635, 8.937),
                zoom: 7,
              ),

              onMapCreated: (controller) {
                mapController = controller;
              },
            ),
          ),
        ],
      ),
    );
  }
}