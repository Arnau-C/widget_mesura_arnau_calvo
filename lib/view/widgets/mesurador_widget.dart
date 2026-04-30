
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:widget_mesura_arnau_calvo/model/mesurador_config.dart';
import 'package:widget_mesura_arnau_calvo/model/mesurador_ui_state.dart';

class MesuradorWidget extends StatelessWidget {
  final MesuradorConfig config;
  final MesuradorUIState estat;

  final Function(Offset) onPuntoMarcado;
  final VoidCallback onReset;
  final Function(String) onAccioDetectada;

  const MesuradorWidget({
    super.key,
    required this.config,
    required this.estat,
    required this.onPuntoMarcado,
    required this.onReset,
    required this.onAccioDetectada,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (TapDownDetails details) {
        final RenderBox box = context.findRenderObject() as RenderBox;
        final Offset posicioLocal = box.globalToLocal(details.globalPosition);

        onAccioDetectada("Processant clic a: ${posicioLocal.dx.toInt()}, ${posicioLocal.dy.toInt()}");
        onPuntoMarcado(posicioLocal);
      },
      onSecondaryTap: onReset,
      onLongPress: onReset,

      child: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          color: Colors.grey[200],
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: config.colorMarcador, width: 2),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: Stack(
            fit: StackFit.expand,
            children: [
              if (estat.rutaImatge.isNotEmpty)
                Image.file(File(estat.rutaImatge), fit: BoxFit.contain)
              else
                const Center(child: Text("Fes clic al botó per carregar un plànol")),

              if (estat.puntA != null && estat.puntB != null)
                CustomPaint(
                  painter: _LiniaMesuraPainter(
                    p1: estat.puntA!,
                    p2: estat.puntB!,
                    color: config.colorMarcador,
                  ),
                ),
              if (estat.puntA != null) _buildMarcador(estat.puntA!),
              if (estat.puntB != null) _buildMarcador(estat.puntB!),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildMarcador(Offset punt) {
    return Positioned(
      left: punt.dx - (config.midaMarcador / 2),
      top: punt.dy - (config.midaMarcador / 2),
      child: Container(
        width: config.midaMarcador,
        height: config.midaMarcador,
        decoration: BoxDecoration(
          color: config.colorMarcador,
          shape: BoxShape.circle,
          border: Border.all(color: Colors.white, width: 2),
          boxShadow: const [
            BoxShadow(color: Colors.black45, blurRadius: 4, offset: Offset(0, 2))
          ]
        ),
      ),
    );
  }
}

// CLASSE AUXILIAR
// Permet traçar una línia recta vectorial entre dues coordenades
class _LiniaMesuraPainter extends CustomPainter {
  final Offset p1;
  final Offset p2;
  final Color color;

  _LiniaMesuraPainter({
    required this.p1,
    required this.p2,
    required this.color
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint();
    paint.color = color;
    paint.strokeWidth = 3.0;
    paint.style = PaintingStyle.stroke;

    // Aquesta es la funció nativa de flutter que permet unir dos punts
    canvas.drawLine(p1, p2, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}