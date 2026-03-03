import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../models/particle.dart';
import '../models/effects.dart';
import '../models/enums.dart';

class SimPainter extends CustomPainter {
  final List<Particle> ps;
  final List<Shockwave> sw;
  final List<Sparkle> sk;
  final List<BoomText> bt;
  final Offset? cursor;
  final bool trails, bonds, glow;
  final Color p1, p2;
  final double pulseT;

  const SimPainter({
    required this.ps,
    required this.sw,
    required this.sk,
    required this.bt,
    required this.cursor,
    required this.trails,
    required this.bonds,
    required this.glow,
    required this.p1,
    required this.p2,
    required this.pulseT,
  });

  @override
  void paint(Canvas canvas, Size size) {
    _drawShockwaves(canvas);
    _drawSparkles(canvas);
    _drawBoomTexts(canvas);
    if (bonds) _drawBonds(canvas);
    if (trails) _drawTrails(canvas);
    _drawParticles(canvas);
  }

  void _drawShockwaves(Canvas canvas) {
    for (var s in sw) {
      for (int i = 0; i < 5; i++) {
        final r = s.r * (1 - i * 0.16);
        final op = s.op * (0.6 - i * 0.12);
        final w = (2.2 - i * 0.38).clamp(0.3, 3.0);
        if (r > 0 && op > 0.01)
          canvas.drawCircle(
            s.pos,
            r,
            Paint()
              ..color = p1.withOpacity(op)
              ..style = PaintingStyle.stroke
              ..strokeWidth = w,
          );
      }
    }
  }

  void _drawSparkles(Canvas canvas) {
    for (var s in sk) {
      canvas.drawCircle(
        s.pos,
        s.r * 0.45,
        Paint()..color = Colors.white.withOpacity(s.op * 0.65),
      );
      canvas.drawCircle(
        s.pos,
        s.r,
        Paint()
          ..color = s.col.withOpacity(s.op * 0.8)
          ..maskFilter = MaskFilter.blur(BlurStyle.normal, s.r * 1.2),
      );
    }
  }

  void _drawBoomTexts(Canvas canvas) {
    for (var b in bt) {
      canvas.save();
      canvas.translate(b.pos.dx, b.pos.dy + b.dy);
      canvas.rotate(b.rot);
      canvas.scale(b.sc);
      for (final outline in [true, false]) {
        final tp = TextPainter(
          text: TextSpan(
            text: b.txt,
            style: GoogleFonts.orbitron(
              fontSize: 28,
              fontWeight: FontWeight.w900,
              foreground: outline
                  ? (Paint()
                      ..style = PaintingStyle.stroke
                      ..strokeWidth = 5
                      ..color = p1.withOpacity(b.op * 0.65))
                  : null,
              color: outline ? null : Colors.white.withOpacity(b.op),
            ),
          ),
          textDirection: TextDirection.ltr,
        )..layout();
        tp.paint(canvas, Offset(-tp.width / 2, -tp.height / 2));
      }
      canvas.restore();
    }
  }

  void _drawBonds(Canvas canvas) {
    for (int i = 0; i < ps.length; i++) {
      for (int j = i + 1; j < math.min(i + 6, ps.length); j++) {
        final dx = ps[i].pos.dx - ps[j].pos.dx;
        final dy = ps[i].pos.dy - ps[j].pos.dy;
        final dSq = dx * dx + dy * dy;
        if (dSq < 38000) {
          final t = dSq / 38000;
          final op = ((1 - t) * (1 - t) * 0.22).clamp(0.0, 1.0);
          canvas.drawLine(
            ps[i].pos,
            ps[j].pos,
            Paint()
              ..shader = LinearGradient(
                colors: [ps[i].col.withOpacity(op), ps[j].col.withOpacity(op)],
              ).createShader(Rect.fromPoints(ps[i].pos, ps[j].pos))
              ..strokeWidth = 1.0,
          );
        }
      }
    }
  }

  void _drawTrails(Canvas canvas) {
    for (var p in ps) {
      if (p.trail.length < 3) continue;
      for (int i = 1; i < p.trail.length; i++) {
        final t = i / p.trail.length;
        final op = t * 0.48 * p.energy;
        if (op < 0.01) continue;
        canvas.drawLine(
          p.trail[i - 1],
          p.trail[i],
          Paint()
            ..color = p.col.withOpacity(op)
            ..strokeWidth = 0.8 + t * 1.8
            ..strokeCap = StrokeCap.round,
        );
      }
    }
  }

  void _drawParticles(Canvas canvas) {
    for (var p in ps) {
      if (glow) _drawGlow(canvas, p);
      _drawShape(canvas, p);
      // specular highlight dot
      canvas.drawCircle(
        Offset(p.pos.dx - p.r * 0.32, p.pos.dy - p.r * 0.32),
        p.r * 0.28,
        Paint()..color = Colors.white.withOpacity(0.40 * p.energy),
      );
    }
  }

  void _drawGlow(Canvas canvas, Particle p) {
    canvas.drawCircle(
      p.pos,
      p.r * 5.5,
      Paint()
        ..color = p.col.withOpacity(0.05 * p.energy)
        ..maskFilter = MaskFilter.blur(BlurStyle.normal, 24 + p.energy * 10),
    );
    canvas.drawCircle(
      p.pos,
      p.r * 2.2,
      Paint()
        ..color = p.col.withOpacity(0.25 * p.energy)
        ..maskFilter = MaskFilter.blur(BlurStyle.normal, 5 + p.energy * 3),
    );
  }

  void _drawShape(Canvas canvas, Particle p) {
    final paint = Paint()..color = p.col;
    switch (p.shape) {
      case ParticleShape.circle:
        canvas.drawCircle(p.pos, p.r, paint);
      case ParticleShape.square:
        canvas.drawRRect(
          RRect.fromRectAndRadius(
            Rect.fromCenter(center: p.pos, width: p.r * 2, height: p.r * 2),
            Radius.circular(p.r * 0.3),
          ),
          paint,
        );
      case ParticleShape.triangle:
        canvas.drawPath(
          Path()
            ..moveTo(p.pos.dx, p.pos.dy - p.r)
            ..lineTo(p.pos.dx + p.r, p.pos.dy + p.r)
            ..lineTo(p.pos.dx - p.r, p.pos.dy + p.r)
            ..close(),
          paint,
        );
      case ParticleShape.hexagon:
        final path = Path();
        for (int i = 0; i < 6; i++) {
          final a = (i * 2 * math.pi / 6) - math.pi / 2;
          if (i == 0)
            path.moveTo(
              p.pos.dx + math.cos(a) * p.r,
              p.pos.dy + math.sin(a) * p.r,
            );
          else
            path.lineTo(
              p.pos.dx + math.cos(a) * p.r,
              p.pos.dy + math.sin(a) * p.r,
            );
        }
        canvas.drawPath(path..close(), paint);
      case ParticleShape.star:
        final path = Path();
        for (int i = 0; i < 5; i++) {
          final a = (i * 4 * math.pi / 5) - math.pi / 2;
          final ia = a + math.pi / 5;
          if (i == 0)
            path.moveTo(
              p.pos.dx + math.cos(a) * p.r,
              p.pos.dy + math.sin(a) * p.r,
            );
          else
            path.lineTo(
              p.pos.dx + math.cos(a) * p.r,
              p.pos.dy + math.sin(a) * p.r,
            );
          path.lineTo(
            p.pos.dx + math.cos(ia) * p.r * 0.42,
            p.pos.dy + math.sin(ia) * p.r * 0.42,
          );
        }
        canvas.drawPath(path..close(), paint);
    }
  }

  @override
  bool shouldRepaint(SimPainter o) => true;
}
