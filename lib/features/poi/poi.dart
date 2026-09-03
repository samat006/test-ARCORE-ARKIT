class Poi {
  const Poi({
    required this.id,
    required this.name,
    required this.description,
    required this.latitude,
    required this.longitude,
    this.modelUrl,
    this.panoramaUrl, // nouveau : chemin vers une photo 360°
  });

  final String id;
  final String name;
  final String description;
  final double latitude;
  final double longitude;
  final String? modelUrl;
  final String? panoramaUrl;
}
