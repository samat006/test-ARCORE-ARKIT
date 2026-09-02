import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:maplibre_gl/maplibre_gl.dart';

import '../poi/poi.dart';
import '../poi/poi_provider.dart';
import 'location_provider.dart';

// ConsumerStatefulWidget (pas juste ConsumerWidget) : on a besoin d'un State
// qui persiste, pour garder une référence au MapLibreMapController. Ce
// contrôleur n'existe qu'une fois la carte créée (onMapCreated), et c'est
// lui qu'on utilise pour ajouter/retirer des marqueurs à la main —
// contrairement à flutter_map où les marqueurs se redessinaient juste en
// relisant la liste de POI dans build().
class MapScreen extends ConsumerStatefulWidget {
  const MapScreen({super.key});

  @override
  ConsumerState<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends ConsumerState<MapScreen> {
  MapLibreMapController? _controller;
  // Associe l'id de chaque cercle affiché sur la carte au Poi correspondant,
  // pour retrouver quel POI a été tapé.
  final Map<String, Poi> _circleToPoi = {};

  @override
  Widget build(BuildContext context) {
    final positionAsync = ref.watch(positionStreamProvider);

    // ref.listen (différent de ref.watch) : exécute une fonction à chaque
    // changement du provider, SANS reconstruire le widget. Parfait ici pour
    // synchroniser les cercles de façon impérative sans redessiner la carte.
    ref.listen(poiListProvider, (previous, next) => _syncCircles(next));

    return Scaffold(
      appBar: AppBar(title: const Text('Carte')),
      body: positionAsync.when(
        data: (position) => MapLibreMap(
          styleString: 'https://tiles.openfreemap.org/styles/liberty',
          initialCameraPosition: CameraPosition(
            target: LatLng(position.latitude, position.longitude),
            zoom: 17,
            tilt: 45, // incline la caméra pour voir les bâtiments en relief
          ),
          myLocationEnabled: true, // point bleu natif pour la position GPS
          onMapCreated: (controller) {
            _controller = controller;
            // Écoute le tap sur un cercle existant : ouvre l'écran AR du POI.
            controller.onCircleTapped.add((circle) {
              final poi = _circleToPoi[circle.id];
              if (poi != null) context.push('/ar', extra: poi);
            });
          },
          onStyleLoadedCallback: () {
            // Synchronise les cercles une première fois une fois le style
            // chargé (utile après un hot reload par exemple).
            _syncCircles(ref.read(poiListProvider));
          },
          onMapClick: (point, coordinates) =>
              _showAddPoiDialog(context, ref, coordinates),
        ),
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stackTrace) => Center(
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Text('Erreur de localisation : $error'),
          ),
        ),
      ),
    );
  }

  // Ajoute un cercle pour chaque POI qui n'en a pas encore.
  // (Version simple : la suppression n'est pas encore gérée, on l'ajoutera
  // juste après si tout compile.)
  Future<void> _syncCircles(List<Poi> pois) async {
    final controller = _controller;
    if (controller == null) return;

    final existingIds = _circleToPoi.values.map((p) => p.id).toSet();
    for (final poi in pois) {
      if (existingIds.contains(poi.id)) continue;
      final circle = await controller.addCircle(
        CircleOptions(
          geometry: LatLng(poi.latitude, poi.longitude),
          circleColor: '#e53935',
          circleRadius: 8,
        ),
      );
      _circleToPoi[circle.id] = poi;
    }
  }

  Future<void> _showAddPoiDialog(
    BuildContext context,
    WidgetRef ref,
    LatLng point,
  ) async {
    final controller = TextEditingController();

    final name = await showDialog<String>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: const Text('Ajouter un point'),
        content: TextField(
          controller: controller,
          autofocus: true,
          decoration: const InputDecoration(hintText: 'Nom du point'),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(dialogContext).pop(),
            child: const Text('Annuler'),
          ),
          FilledButton(
            onPressed: () =>
                Navigator.of(dialogContext).pop(controller.text.trim()),
            child: const Text('Ajouter'),
          ),
        ],
      ),
    );

    if (name == null || name.isEmpty) return;

    ref
        .read(poiListProvider.notifier)
        .addPoi(
          name: name,
          latitude: point.latitude,
          longitude: point.longitude,
          modelUrl: 'assets/models/Stag.glb',
        );
  }
}
