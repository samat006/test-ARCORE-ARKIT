import 'package:flutter/material.dart';
import 'place_api.dart';
import 'place.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: const HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final PlaceApi api = PlaceApi();

  List<Place> places = [];

  @override
  void initState() {
    super.initState();
    loadPlaces();
  }

  Future<void> loadPlaces() async {
    try {
      final places = await api.getPlaces();

      setState(() {
  this.places = places;
});
    } catch (e) {
      setState(() {
        var result = 'Erreur : $e';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Flutter → Spring Boot'),
      ),
   body: ListView.builder(
  itemCount: places.length,
  itemBuilder: (context, index) {
    final place = places[index];

    return ListTile(
      title: Text(place.name),
      subtitle: Text(
        '${place.latitude}, ${place.longitude}',
      ),
    );
  },
),
    );
  }
}