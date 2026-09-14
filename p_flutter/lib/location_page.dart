import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

class LocationPage extends StatefulWidget {
  const LocationPage({super.key});

  @override
  State<LocationPage> createState() => _LocationPageState();
}

class _LocationPageState extends State<LocationPage> {
  String position = 'Position inconnue';

  Future<void> obtenirPosition() async {
    bool serviceActive = await Geolocator.isLocationServiceEnabled();

    if (!serviceActive) {
      setState(() {
        position = 'GPS désactivé';
      });
      return;
    }

    LocationPermission permission =
        await Geolocator.checkPermission();

    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
    }

    if (permission == LocationPermission.denied) {
      setState(() {
        position = 'Permission refusée';
      });
      return;
    }

    Position p = await Geolocator.getCurrentPosition();

    setState(() {
      position =
          'Latitude : ${p.latitude}\nLongitude : ${p.longitude}';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Ma position'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              position,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 20),
            ),

            const SizedBox(height: 30),

            ElevatedButton(
              onPressed: obtenirPosition,
              child: const Text('📍 Ma position'),
            ),
            
          ],
        ),
      ),
    );
  }
}