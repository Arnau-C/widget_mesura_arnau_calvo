import 'package:flutter/material.dart';

class MesuradorUIState {
  final Offset? puntA;
  final Offset? puntB;

  // Distancia entre els dos punts
  final double distancia;
  // Missatge feedback
  final String missatgeGest;
  // Ruta del fitxer de la imatge de fons
  final String rutaImatge;

  // Constructor constant amb l'estat inicial per defecte
  const MesuradorUIState({
    this.puntA,
    this.puntB,
    this.distancia = 0.0,
    this.missatgeGest = "Esperant interacció... Clica per fixar el Punt A.",
    this.rutaImatge = "",
  });

  // Crea una còpia de l'estat canviant només les propietats que ens interessin.
  MesuradorUIState copyWith({
    Offset? puntA,
    Offset? puntB,
    double? distancia,
    String? missatgeGest,
    String? rutaImatge,
    bool resetPunts = false,
  }) {
    return MesuradorUIState(
      // Us de ternaries, si ens demanen fer un reset, posem els punts a null
      // Si no, agafem el nou valor (si n'hi ha) o mantenim el que ja tenim (this.puntA)
      puntA: resetPunts ? null : (puntA ?? this.puntA),
      puntB: resetPunts ? null : (puntB ?? this.puntB),
      distancia: resetPunts ? 0.0 : (distancia ?? this.distancia),
      missatgeGest: missatgeGest ?? this.missatgeGest,
      rutaImatge: rutaImatge ?? this.rutaImatge,
    );
  }
}