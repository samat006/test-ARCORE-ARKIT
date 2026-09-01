import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:geolocator/geolocator.dart';

// StreamProvider : expose un flux réactif de positions GPS. N'importe quel
// écran peut "l'écouter" (ref.watch) et se reconstruit automatiquement à
// chaque nouvelle position, sans gérer soi-même un StreamSubscription.
final positionStreamProvider = StreamProvider<Position>((ref) async* {
  // 1. Vérifie que le GPS est activé sur l'appareil.
  final serviceEnabled = await Geolocator.isLocationServiceEnabled();
  if (!serviceEnabled) {
    throw Exception('Le service de localisation est désactivé.');
  }

  // 2. Vérifie/demande la permission de localisation à l'utilisateur.
  var permission = await Geolocator.checkPermission();
  if (permission == LocationPermission.denied) {
    permission = await Geolocator.requestPermission();
  }
  if (permission == LocationPermission.denied ||
      permission == LocationPermission.deniedForever) {
    throw Exception('Permission de localisation refusée.');
  }

  // 3. Diffuse la position en continu, avec une mise à jour tous les 5 mètres.
  yield* Geolocator.getPositionStream(
    locationSettings: const LocationSettings(
      accuracy: LocationAccuracy.high,
      distanceFilter: 5,
    ),
  );
});
