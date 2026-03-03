import 'dart:math' as math;
import 'package:flutter/material.dart';

class AuroraPainter extends CustomPainter {
  final double t, pulse, scan;
  final Offset? cursor;
  final Color p1, p2;

  const AuroraPainter({
    required this.t,
    required this.pulse,
    required this.scan,
    required this.cursor,
    required this.p1,
    required this.p2,
  });

  @override
  void paint(Canvas canvas, Size size) {
    // Background
    canvas.drawRect(
      Offset.zero & size,
      Paint()
        ..shader = const RadialGradient(
          center: Alignment(-0.5, -0.6),
          radius: 1.5,
          colors: [Color(0xFF0C0C1E), Color(0xFF050508)],
        ).createShader(Offset.zero & size),
    );

    _drawBlobs(canvas, size);
    _drawDotGrid(canvas, size);
    _drawScanLine(canvas, size);
    if (cursor != null) _drawCursorFx(canvas);
  }

  void _drawBlobs(Canvas canvas, Size size) {
    void blob(double cx, double cy, double r, Color c, double op) {
      canvas.drawCircle(
        Offset(cx, cy),
        r,
        Paint()
          ..shader = RadialGradient(
            colors: [
              c.withOpacity(op),
              c.withOpacity(op * 0.25),
              Colors.transparent,
            ],
            stops: const [0.0, 0.45, 1.0],
          ).createShader(Rect.fromCircle(center: Offset(cx, cy), radius: r)),
      );
    }

    final a1 = t * math.pi * 2;
    final a2 = t * math.pi * 2 * 0.71 + 1.1;
    final a3 = t * math.pi * 2 * 0.47 + 2.4;
    final a4 = t * math.pi * 2 * 0.33 + 0.7;

    blob(
      size.width * 0.18 + math.sin(a1) * size.width * 0.06,
      size.height * 0.25 + math.cos(a1) * size.height * 0.06,
      size.width * 0.42,
      p1,
      0.06,
    );
    blob(
      size.width * 0.78 + math.cos(a2) * size.width * 0.08,
      size.height * 0.70 + math.sin(a2) * size.height * 0.07,
      size.width * 0.36,
      p2,
      0.052,
    );
    blob(
      size.width * 0.52 + math.sin(a3) * size.width * 0.05,
      size.height * 0.46 + math.cos(a4) * size.height * 0.05,
      size.width * 0.28,
      p1,
      0.028,
    );
    blob(
      size.width * 0.50 + math.cos(a4) * size.width * 0.04,
      size.height * 0.50 + math.sin(a3) * size.height * 0.04,
      size.width * 0.62,
      const Color(0xFF2010A0),
      0.020,
    );
    blob(
      size.width * 0.30 + math.sin(a2) * size.width * 0.04,
      size.height * 0.65 + math.cos(a1) * size.height * 0.04,
      size.width * 0.22,
      const Color(0xFF00BFA0),
      0.022,
    );
  }

  void _drawDotGrid(Canvas canvas, Size size) {
    final dp = Paint()..color = const Color(0xFF0F0F20);
    const step = 40.0;
    for (double x = step; x < size.width; x += step)
      for (double y = step; y < size.height; y += step)
        canvas.drawCircle(Offset(x, y), 0.7, dp);
  }

  void _drawScanLine(Canvas canvas, Size size) {
    canvas.drawRect(
      Rect.fromLTWH(0, scan * size.height - 1.5, size.width, 2),
      Paint()..color = const Color(0xFF5050C0).withOpacity(0.014),
    );
  }

  void _drawCursorFx(Canvas canvas) {
    for (int i = 0; i < 4; i++) {
      final prog = (pulse + i * 0.25) % 1.0;
      final eased = 1.0 - math.pow(1.0 - prog, 3).toDouble();
      final r = (90.0 + i * 35) * eased;
      final op = (1.0 - eased) * 0.20;
      if (r > 0 && op > 0.008)
        canvas.drawCircle(
          cursor!,
          r,
          Paint()
            ..color = p1.withOpacity(op)
            ..style = PaintingStyle.stroke
            ..strokeWidth = 0.9 + (1 - eased) * 0.5,
        );
    }
    final cp = Paint()
      ..color = p1.withOpacity(0.20)
      ..strokeWidth = 0.7;
    canvas.drawLine(
      Offset(cursor!.dx - 10, cursor!.dy),
      Offset(cursor!.dx + 10, cursor!.dy),
      cp,
    );
    canvas.drawLine(
      Offset(cursor!.dx, cursor!.dy - 10),
      Offset(cursor!.dx, cursor!.dy + 10),
      cp,
    );
    canvas.drawCircle(cursor!, 1.2, Paint()..color = p1.withOpacity(0.5));
  }

  @override
  bool shouldRepaint(AuroraPainter o) => true;
}
