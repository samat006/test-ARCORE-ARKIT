
import 'package:flutter/material.dart';

import 'package:ar_flutter_plugin_2/ar_flutter_plugin.dart';
import 'package:ar_flutter_plugin_2/managers/ar_session_manager.dart';
import 'package:ar_flutter_plugin_2/managers/ar_object_manager.dart';
import 'package:ar_flutter_plugin_2/managers/ar_anchor_manager.dart';
import 'package:ar_flutter_plugin_2/managers/ar_location_manager.dart';

import 'package:ar_flutter_plugin_2/datatypes/config_planedetection.dart';
import 'package:ar_flutter_plugin_2/datatypes/anchor_types.dart';
import 'package:ar_flutter_plugin_2/datatypes/node_types.dart';

import 'package:ar_flutter_plugin_2/models/ar_anchor.dart';
import 'package:ar_flutter_plugin_2/models/ar_hittest_result.dart';
import 'package:ar_flutter_plugin_2/models/ar_node.dart';

import 'package:vector_math/vector_math_64.dart';

class ArPage extends StatefulWidget {
  const ArPage({super.key});

  @override
  State<ArPage> createState() => _ArPageState();
}

class _ArPageState extends State<ArPage> {
  ARSessionManager? arSessionManager;
  ARObjectManager? arObjectManager;
  ARAnchorManager? arAnchorManager;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Village AR'),
      ),
      body: ARView(
        onARViewCreated: onARViewCreated,
        planeDetectionConfig:
            PlaneDetectionConfig.horizontalAndVertical,
      ),
    );
  }

  void onARViewCreated(
    ARSessionManager sessionManager,
    ARObjectManager objectManager,
    ARAnchorManager anchorManager,
    ARLocationManager locationManager,
  ) {
    arSessionManager = sessionManager;
    arObjectManager = objectManager;
    arAnchorManager = anchorManager;

    arSessionManager!.onInitialize(
      showFeaturePoints: true,
      showPlanes: true,
      showWorldOrigin: true,
      handleTaps: true,
    );

    arObjectManager!.onInitialize();

    arSessionManager!.onPlaneOrPointTap = onPlaneOrPointTapped;
  }

  Future<void> onPlaneOrPointTapped(
    List<ARHitTestResult> hits,
  ) async {
    if (hits.isEmpty) {
      return;
    }

    final hit = hits.first;

    // Création d'un ancrage sur le plan touché
    final anchor = ARPlaneAnchor(
      transformation: hit.worldTransform,
    );

    final didAddAnchor =
        await arAnchorManager!.addAnchor(anchor);

    if (didAddAnchor != true) {
      return;
    }

    // Création du village 3D
    final node = ARNode(
      type: NodeType.localGLTF2,
      uri: 'assets/village.glb',
      scale: Vector3(
        0.2,
        0.2,
        0.2,
      ),
      position: Vector3(
        0.0,
        0.0,
        0.0,
      ),
      rotation: Vector4(
        1.0,
        0.0,
        0.0,
        0.0,
      ),
    );

    final didAddNode =
        await arObjectManager!.addNode(
      node,
      planeAnchor: anchor,
    );

    if (didAddNode != true) {
      await arAnchorManager!.removeAnchor(anchor);
    }
  }

  @override
  void dispose() {
    arSessionManager?.dispose();
    super.dispose();
  }
}
