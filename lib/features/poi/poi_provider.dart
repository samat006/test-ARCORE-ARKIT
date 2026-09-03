import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'poi.dart';

// Notifier : gère un état mutable (ici une liste de Poi) et expose des
// méthodes pour le modifier. Chaque modification de `state` notifie
// automatiquement tous les widgets qui écoutent ce provider.
class PoiListNotifier extends Notifier<List<Poi>> {
  int _nextId = 1;

  // build() définit l'état initial : liste vide au démarrage.
  @override
  List<Poi> build() => [];

  void addPoi({
    required String name,
    required double latitude,
    required double longitude,
    String description = '',
    String? modelUrl,
    String? panoramaUrl,
  }) {
    final poi = Poi(
      id: (_nextId++).toString(),
      name: name,
      description: description,
      latitude: latitude,
      longitude: longitude,
      modelUrl: modelUrl,
      panoramaUrl: panoramaUrl,
    );
    state = [...state, poi];
  }

  void removePoi(String id) {
    state = state.where((poi) => poi.id != id).toList();
  }
}

// Le provider lui-même, à utiliser dans les widgets via ref.watch/ref.read.
final poiListProvider = NotifierProvider<PoiListNotifier, List<Poi>>(
  PoiListNotifier.new,
);
