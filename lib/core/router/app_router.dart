import 'package:go_router/go_router.dart';

import '../../features/ar/ar_screen.dart';
import '../../features/map/map_screen.dart';
import '../../features/poi/poi.dart';
import '../../home_screen.dart';
import '../../features/panorama/panorama_screen.dart';

final appRouter = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(path: '/', builder: (context, state) => const HomeScreen()),
    GoRoute(path: '/map', builder: (context, state) => const MapScreen()),
    // state.extra transporte l'objet Poi complet d'un écran à l'autre,
    // sans avoir à l'encoder dans l'URL.
    GoRoute(
      path: '/ar',
      builder: (context, state) => ArScreen(poi: state.extra! as Poi),
    ),
    GoRoute(
      path: '/panorama',
      builder: (context, state) => PanoramaScreen(poi: state.extra! as Poi),
    ),
  ],
);
