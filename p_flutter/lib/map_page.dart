
import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:maplibre_gl/maplibre_gl.dart';
import 'package:path_provider/path_provider.dart';

class MapPage extends StatefulWidget {
  const MapPage({super.key});

  @override
  State<MapPage> createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  String? _styleJson;
  bool _loading = true;
  String? _error;

  @override
  void initState() {
    super.initState();
    _prepareMap();
  }

  Future<void> _prepareMap() async {
    try {
      final appDir = await getApplicationDocumentsDirectory();

      final mapDir = Directory('${appDir.path}/map');
      final fontsDir =
          Directory('${mapDir.path}/fonts/Noto Sans Regular');

      await mapDir.create(recursive: true);
      await fontsDir.create(recursive: true);

      // ============================================================
      // 1. COPIE DU PMTILES
      // ============================================================

      final pmtilesBytes =
          await rootBundle.load('assets/map/corse.pmtiles');

      final pmtilesFile =
          File('${mapDir.path}/corse.pmtiles');

      await pmtilesFile.writeAsBytes(
        pmtilesBytes.buffer.asUint8List(),
        flush: true,
      );

      debugPrint('PMTiles OK');

      // ============================================================
      // 2. TEST DES GLYPHES
      // ============================================================

      final glyphManifest =
          await rootBundle.loadString('assets/map/glyphs.json');

      final List<dynamic> glyphFiles =
          jsonDecode(glyphManifest);

      debugPrint(
        'NOMBRE GLYPHES : ${glyphFiles.length}',
      );

      for (final fileName in glyphFiles.take(5)) {
        final assetPath =
            'assets/map/fonts/NotoSansRegular/$fileName';

        debugPrint(
          'TEST ASSET : $assetPath',
        );

        try {
          final data =
              await rootBundle.load(assetPath);

          debugPrint(
            'OK : $assetPath (${data.lengthInBytes} bytes)',
          );
        } catch (e) {
          debugPrint(
            'ERREUR ASSET : $assetPath',
          );
          debugPrint(e.toString());
          rethrow;
        }
      }

      // ============================================================
      // 3. CHARGEMENT DU STYLE
      // ============================================================

      String style =
          await rootBundle.loadString('assets/map/style.json');

      style = style.replaceAll(
        '{MAP_PATH}',
        mapDir.path,
      );

      // Vérification JSON
      final decoded = jsonDecode(style);

      style = jsonEncode(decoded);

      debugPrint('STYLE JSON OK');

      if (!mounted) return;

      setState(() {
        _styleJson = style;
        _loading = false;
      });
    } catch (e, stackTrace) {
      debugPrint('ERREUR MAP : $e');
      debugPrint('$stackTrace');

      if (!mounted) return;

      setState(() {
        _loading = false;
        _error = e.toString();
      });
    }
  }

  void _onMapCreated(
    MapLibreMapController controller,
  ) {
    debugPrint('MapLibre initialisée');
  }

  void _onStyleLoaded() {
    debugPrint('Style Corse chargé');
  }

  @override
  Widget build(BuildContext context) {
    if (_loading) {
      return const Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    if (_error != null) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Carte Corse'),
        ),
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: SingleChildScrollView(
              child: SelectableText(
                'Erreur :\n\n$_error',
              ),
            ),
          ),
        ),
      );
    }

    if (_styleJson == null) {
      return const Scaffold(
        body: Center(
          child: Text('Style non chargé'),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Carte Corse'),
      ),
      body: MapLibreMap(
        styleString: _styleJson!,
        initialCameraPosition: const CameraPosition(
          target: LatLng(
            42.238460,
            9.034562,
          ),
          zoom: 8,
        ),
        minMaxZoomPreference:
            const MinMaxZoomPreference(
          8,
          14,
        ),
        cameraTargetBounds:
            CameraTargetBounds(
          LatLngBounds(
            southwest: const LatLng(
              41.10,
              8.25,
            ),
            northeast: const LatLng(
              43.25,
              9.85,
            ),
          ),
        ),
        onMapCreated: _onMapCreated,
        onStyleLoadedCallback: _onStyleLoaded,
      ),
    );
  }
}
