import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:latlong2/latlong.dart' as ll;
import 'package:go_router/go_router.dart';
import '../poi/poi_provider.dart';
import 'location_provider.dart';

class MapScreen extends ConsumerWidget {
  const MapScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final positionAsync = ref.watch(positionStreamProvider);
    // On écoute aussi la liste des POI : dès qu'on en ajoute un, la carte
    // se redessine automatiquement avec le nouveau marqueur.
    final pois = ref.watch(poiListProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Carte')),
      body: positionAsync.when(
        data: (position) {
          final userLatLng = ll.LatLng(position.latitude, position.longitude);

          return FlutterMap(
            options: MapOptions(
              initialCenter: userLatLng,
              initialZoom: 16,
              // onTap donne directement les coordonnées GPS du point touché
              // sur la carte (converties depuis la position à l'écran).
              onTap: (tapPosition, point) =>
                  _showAddPoiDialog(context, ref, point),
            ),
            children: [
              TileLayer(
                urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                userAgentPackageName: 'com.touba7g.map_ar_app',
              ),
              MarkerLayer(
                markers: [
                  // Marqueur de la position actuelle.
                  Marker(
                    point: userLatLng,
                    width: 40,
                    height: 40,
                    child: const Icon(Icons.my_location, color: Colors.blue),
                  ),
                  // Un marqueur par POI ajouté. `for` dans une liste littérale
                  // Dart : génère un Marker pour chaque élément de `pois`.
                  for (final poi in pois)
                    Marker(
                      point: ll.LatLng(poi.latitude, poi.longitude),
                      width: 40,
                      height: 40,
                      child: GestureDetector(
                        onTap: () => context.push('/ar', extra: poi),
                        onLongPress: () => ref
                            .read(poiListProvider.notifier)
                            .removePoi(poi.id),
                        child: Tooltip(
                          message:
                              '${poi.name} (tap pour visiter, appui long pour supprimer)',
                          child: const Icon(
                            Icons.location_on,
                            color: Colors.red,
                          ),
                        ),
                      ),
                    ),
                ],
              ),
            ],
          );
        },
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

  // Boîte de dialogue affichée au tap sur la carte : demande un nom, puis
  // crée le POI aux coordonnées exactes du tap.
  Future<void> _showAddPoiDialog(
    BuildContext context,
    WidgetRef ref,
    ll.LatLng point,
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

    // Pour l'instant on attache toujours le même modèle 3D (le cerf) à
    // chaque nouveau point. On rendra ça choisissable plus tard si besoin.
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
