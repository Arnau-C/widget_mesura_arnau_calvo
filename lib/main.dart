import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'model/mesurador_config.dart';
import 'model/mesurador_ui_state.dart';
import 'viewmodel/main_viewmodel.dart';
import 'view/widgets/mesurador_widget.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Eina de Mesura",
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.blue),
      home: ChangeNotifierProvider(
        create: (context) => MainViewModel(
          MesuradorUIState(rutaImatge: ""),
        ),
        child: const MesuradorScreen(),
      ),
    );
  }
}

// Aquesta és la pantalla principal
class MesuradorScreen extends StatelessWidget {
  const MesuradorScreen({super.key});

  @override
  Widget build(BuildContext context) {

    // Amb context.watch ens subscrivim. Cada cop que el ViewModel faci
    // notifyListeners(), només aquest mètode build es tornarà a executar.
    final vm = context.watch<MainViewModel>();

    return Scaffold(
      appBar: AppBar(
        title: const Text("Mesurador de Plànols"),
        actions: [
          IconButton(
            icon: const Icon(Icons.folder_open),
            tooltip: "Carregant Plànol",
            onPressed: () => vm.carregarImatgeFons(),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Text(
              vm.estatPanell.missatgeGest,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            
            Expanded(
              child: MesuradorWidget(

                // Li passem la configuració estàtica (Estils)
                config: MesuradorConfig(
                  titol: "Area de treball",
                  colorMarcador: Colors.redAccent,
                  midaMarcador: 14.0,
                ),

                // Li passem la "fotografia" actual de les dades
                estat: vm.estatPanell,

                // Quan el widget cridi "onPuntoMarcado" amb una coordenada...
                onPuntoMarcado: (coordenada) {
                  vm.processarClic(coordenada); // ...li passem al ViewModel
                },

                // Quan el widget cridi "onReset"...
                onReset: () {
                  vm.reiniciarMesura(); //...li diem al ViewModel que netegi
                },

                // Quan el widget vulgui avisar d'alguna acció extra...
                onAccioDetectada: (missatge) {
                  // ho imprimim per consola o ho passem al VM
                  debugPrint("Acció del Widget: $missatge");
                },
              ),
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => vm.reiniciarMesura(),
        tooltip: "Netejar Punts",
        child: const Icon(Icons.refresh),
      ),
    );
  }
}
