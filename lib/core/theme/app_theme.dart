import 'package:flutter/material.dart';

// Thème Material 3 partagé par toute l'app. On le centralise ici pour ne pas
// dupliquer les couleurs/styles dans chaque écran.
final appTheme = ThemeData(
  useMaterial3: true,
  colorScheme: ColorScheme.fromSeed(seedColor: Colors.teal),
);
