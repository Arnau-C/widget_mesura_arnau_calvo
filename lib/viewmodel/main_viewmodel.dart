import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:widget_mesura_arnau_calvo/model/mesurador_ui_state.dart';

// ViewModel principal de l'aplicació.
// Gestiona la lògica matemàtica i l'estat, completament desacoblat de la UI.
class MainViewModel extends ChangeNotifier {
  // Model: estat actual del widget
  MesuradorUIState _estatPanell;
  // Getter públic perquè la vista només pugui llegir (no sobreescriure directament)
  MesuradorUIState get estatPanell => _estatPanell;

  // Constructor: Rep l'estat inicial injectat des de fora (Desacoblament fort)
  MainViewModel(this._estatPanell);

  // Metodes de logica

  void processarClic(Offset puntClicat) {

    // Si no hi ha cap punt fixat, guardem el Punt A. O bé, si ja hi ha dos punts, reiniciem la mesura col·locant un nou Punt A.
    if (_estatPanell.puntA == null || (_estatPanell.puntA != null && _estatPanell.puntB != null)) {

      // Com volem "netejar" el punt B antic (si n'hi havia), en lloc d'usar copyWith
      // creem un estat completament nou conservant només la imatge de fons.
      _estatPanell = MesuradorUIState(
        rutaImatge: _estatPanell.rutaImatge,
        puntA: puntClicat,
        missatgeGest: "Punt A fixat. Ara clica per fixar el Punt B"
      );
    }

    // Tenim el Punt A, però ens falta el Punt B. Calculem la distància.
    else if (_estatPanell.puntB == null) {
      // La classe nativa Offset ja sap calcular distàncies espacials.
      double calculaDistancia = (_estatPanell.puntA! - puntClicat).distance;

      // Actualitzem l'estat utilitzant copyWith
      _estatPanell = _estatPanell.copyWith(
        puntB: puntClicat,
        distancia: calculaDistancia,
        missatgeGest: "Distancia: ${calculaDistancia.toStringAsFixed(2)} pixels."
      );

    }

    // Avisem a la vista que les dades han canviat.
    notifyListeners();
  }

  // Neteja completament la pantalla de punts (Callback de reset)
  void reiniciarMesura() {
    _estatPanell = _estatPanell.copyWith(
      resetPunts: true,
      missatgeGest: "Mesura reiniciada. Clica per fixar el punt A."
    );
    notifyListeners();
  }

  // Càrrega d'imatge de fons mitjançant el sistema de fitxers natiu de l'OS.
  Future<void> carregarImatgeFons() async {
    try {
      // Obrim el selector natiu del sistema operatiu (file_picker)
      FilePickerResult? resultat = await FilePicker.pickFiles(
        type: FileType.image,
        dialogTitle: "Selecciona una imatge per mesurar",
      );
      // Si l'usuari ha triat un fitxer i tenim la ruta
      if (resultat != null && resultat.files.single.path != null) {
        String rutaEscollida = resultat.files.single.path!;

        // Actualitzem l'estat amb la ruta nova i reiniciem els punts
        _estatPanell = _estatPanell.copyWith(
          rutaImatge: rutaEscollida,
          resetPunts: true,
          missatgeGest: "Imatge carregada. Clica per fixar el Punt A.",
        );
        notifyListeners();
      }

    } catch (e) {
      _estatPanell = _estatPanell.copyWith(
        missatgeGest: "Error carregant la imatge: $e",
      );
      notifyListeners();
    }
  }

  // Un simple callback per poder rebre missatges genèrics del widget
  void registrarAccio(String missatge) {
    _estatPanell = _estatPanell.copyWith(missatgeGest: missatge);
    notifyListeners();
  }


}