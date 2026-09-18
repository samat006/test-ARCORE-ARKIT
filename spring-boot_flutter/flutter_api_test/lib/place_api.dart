import 'dart:convert';
import 'package:http/http.dart' as http;
import 'place.dart';

class PlaceApi {
  final String baseUrl = 'http://10.0.2.2:8080';

  Future<List<Place>> getPlaces() async {
    final response = await http.get(
      Uri.parse('$baseUrl/places'),
    );

    if (response.statusCode != 200) {
      throw Exception('Erreur HTTP : ${response.statusCode}');
    }

    final List<dynamic> jsonList = jsonDecode(response.body);

    return jsonList
        .map((json) => Place.fromJson(json))
        .toList();
  }
}