import 'package:flutter/material.dart';

class MesuradorConfig {
  final String titol;
  final Color colorMarcador;
  final double midaMarcador;

  const MesuradorConfig ({
    required this.titol,
    this.colorMarcador = Colors.redAccent,
    this.midaMarcador = 15.0,
  });
  

}