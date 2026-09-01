import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'core/router/app_router.dart';
import 'core/theme/app_theme.dart';

void main() {
  // ProviderScope stocke l'état de tous les providers Riverpod de l'app.
  // Obligatoire pour pouvoir utiliser ref.watch()/ref.read() n'importe où.
  runApp(const ProviderScope(child: MapArApp()));
}

class MapArApp extends StatelessWidget {
  const MapArApp({super.key});

  @override
  Widget build(BuildContext context) {
    // MaterialApp.router délègue toute la navigation à go_router
    // (au lieu du système de routes classique de MaterialApp).
    return MaterialApp.router(
      title: 'Map AR App',
      theme: appTheme,
      routerConfig: appRouter,
      debugShowCheckedModeBanner: false,
    );
  }
}
