import 'dart:math' as math;
import 'package:flutter/material.dart';
import '../../theme/tokens.dart';

class NeuThumb extends SliderComponentShape {
  @override
  Size getPreferredSize(bool e, bool d) => const Size.fromRadius(10);

  @override
  void paint(
    PaintingContext ctx,
    Offset center, {
    required Animation<double> activationAnimation,
    required Animation<double> enableAnimation,
    required bool isDiscrete,
    required TextPainter labelPainter,
    required RenderBox parentBox,
    required SliderThemeData sliderTheme,
    required TextDirection textDirection,
    required double value,
    required double textScaleFactor,
    required Size sizeWithOverflow,
  }) {
    final c = ctx.canvas;
    const r = 10.0;

    c.drawCircle(
      center,
      r + 3,
      Paint()
        ..color = const Color(0xFF030308)
        ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 8),
    );

    c.drawCircle(center + const Offset(-2.5, -2.5), r, Paint()..color = kHl2);

    c.drawCircle(
      center,
      r,
      Paint()
        ..shader = RadialGradient(
          center: const Alignment(-0.4, -0.4),
          radius: 1.0,
          colors: const [kS5, kS4, kS2],
          stops: const [0.0, 0.5, 1.0],
        ).createShader(Rect.fromCircle(center: center, radius: r)),
    );

    c.drawCircle(
      center,
      r,
      Paint()
        ..shader = SweepGradient(
          startAngle: -math.pi * 0.75,
          endAngle: math.pi * 1.25,
          colors: const [kA4, kA1, kA3, kT1, kA4],
          stops: const [0.0, 0.25, 0.5, 0.75, 1.0],
        ).createShader(Rect.fromCircle(center: center, radius: r))
        ..style = PaintingStyle.stroke
        ..strokeWidth = 1.6,
    );

    c.drawCircle(
      center,
      r * 0.28,
      Paint()
        ..shader = RadialGradient(
          center: const Alignment(-0.3, -0.3),
          colors: const [kA4, kA1],
        ).createShader(Rect.fromCircle(center: center, radius: r * 0.28)),
    );

    c.drawCircle(
      center + Offset(-r * 0.24, -r * 0.24),
      r * 0.14,
      Paint()..color = Colors.white.withOpacity(0.6),
    );
  }
}
