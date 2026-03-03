import 'dart:math' as math;
import 'package:flutter/material.dart';
import '../models/particle.dart';
import '../models/effects.dart';
import '../models/enums.dart';

class Simulation {
  final List<Particle> particles = [];
  final List<Shockwave> shockwaves = [];
  final List<Sparkle> sparkles = [];
  final List<BoomText> boomTexts = [];
  final List<GravityWell> gravWells = [];

  // ── public settings ──────────────────────────────────────
  int count = 200;
  double force = 0.8;
  double speed = 1.2;
  double size = 1.0;
  ParticleMode mode = ParticleMode.attract;
  bool trails = true;
  bool collis = false;

  // ── live stats ───────────────────────────────────────────
  double energy = 0;
  double avgVel = 0;
  double temp = 0;
  int hits = 0;
  int clusters = 0;

  Offset? cursor;

  // ─────────────────────────────────────────────────────────
  void spawn({
    required Color Function(double) colorFn,
    required ParticleShape shape,
  }) {
    particles.clear();
    final rng = math.Random();
    for (int i = 0; i < count; i++) {
      particles.add(
        Particle(
          pos: Offset(rng.nextDouble() * 1600, rng.nextDouble() * 900),
          vel: Offset(
            (rng.nextDouble() * 2 - 1) * speed,
            (rng.nextDouble() * 2 - 1) * speed,
          ),
          r: (rng.nextDouble() * 3 + 2) * size,
          col: colorFn(rng.nextDouble()),
          mass: rng.nextDouble() * 1.5 + 0.5,
          charge: rng.nextBool() ? 1.0 : -1.0,
          energy: rng.nextDouble(),
          shape: shape,
        ),
      );
    }
  }

  // ─────────────────────────────────────────────────────────
  void applyFormation({
    required FormationType formation,
    required Color Function(double) colorFn,
    required ParticleShape shape,
  }) {
    particles.clear();
    final rng = math.Random();
    const c = Offset(800, 450);

    switch (formation) {
      case FormationType.dna:
        for (int i = 0; i < count; i++) {
          final t = (i / count) * math.pi * 6;
          final y = c.dy + (i / count) * 580 - 290;
          particles.add(
            Particle(
              pos: Offset(c.dx + math.cos(i.isEven ? t : t + math.pi) * 140, y),
              vel: Offset((rng.nextDouble() - 0.5) * speed * 0.3, speed * 0.18),
              r: (rng.nextDouble() * 2 + 2) * size,
              col: colorFn(i / count),
              mass: 1,
              charge: i.isEven ? 1.0 : -1.0,
              energy: i / count,
              shape: shape,
            ),
          );
        }

      case FormationType.galaxy:
        for (int i = 0; i < count; i++) {
          final a = (i / count) * math.pi * 2;
          final arm = a + (i / count) * math.pi * 6;
          final rad = 50 + (i / count) * 340;
          particles.add(
            Particle(
              pos: Offset(
                c.dx + math.cos(arm) * rad,
                c.dy + math.sin(arm) * rad,
              ),
              vel: Offset(
                math.cos(a + math.pi / 2) * speed * 0.4,
                math.sin(a + math.pi / 2) * speed * 0.4,
              ),
              r: (rng.nextDouble() * 2.5 + 1) * size,
              col: colorFn(rng.nextDouble()),
              mass: 1,
              charge: rng.nextBool() ? 1.0 : -1.0,
              energy: 1 - i / count,
              shape: shape,
            ),
          );
        }

      case FormationType.atom:
        for (int i = 0; i < count ~/ 4; i++) {
          final a = rng.nextDouble() * math.pi * 2;
          particles.add(
            Particle(
              pos: Offset(
                c.dx + math.cos(a) * rng.nextDouble() * 28,
                c.dy + math.sin(a) * rng.nextDouble() * 28,
              ),
              vel: Offset.zero,
              r: 3.5 * size,
              col: colorFn(0.1),
              mass: 3,
              charge: 1,
              energy: 1,
              shape: shape,
            ),
          );
        }
        for (int s = 0; s < 3; s++) {
          final sr = 110.0 + s * 85;
          final ec = (count * 0.25).toInt();
          for (int i = 0; i < ec; i++) {
            final a = (i / ec) * math.pi * 2;
            particles.add(
              Particle(
                pos: Offset(c.dx + math.cos(a) * sr, c.dy + math.sin(a) * sr),
                vel: Offset(
                  math.cos(a + math.pi / 2) * speed * (1.4 - s * 0.28),
                  math.sin(a + math.pi / 2) * speed * (1.4 - s * 0.28),
                ),
                r: 1.8 * size,
                col: colorFn(0.8),
                mass: 0.5,
                charge: -1,
                energy: 0.9,
                shape: shape,
              ),
            );
          }
        }

      case FormationType.torus:
        for (int i = 0; i < count; i++) {
          final th = (i / count) * math.pi * 2;
          final rad = 200 + math.cos((i / count) * math.pi * 8) * 80;
          particles.add(
            Particle(
              pos: Offset(c.dx + rad * math.cos(th), c.dy + rad * math.sin(th)),
              vel: Offset(
                math.cos(th + math.pi / 2) * speed * 0.5,
                math.sin(th + math.pi / 2) * speed * 0.5,
              ),
              r: (rng.nextDouble() * 2 + 2) * size,
              col: colorFn(i / count),
              mass: 1,
              charge: rng.nextBool() ? 1.0 : -1.0,
              energy: rng.nextDouble(),
              shape: shape,
            ),
          );
        }
    }
  }

  // ─────────────────────────────────────────────────────────
  void tick(Size sz) {
    double tE = 0, tV = 0;
    hits = 0;

    for (var p in particles) {
      _applyCursorForce(p);
      _applyGravityWells(p);
      if (collis) _applyCollisions(p);
      _moveParticle(p, sz);

      final v = math.sqrt(p.vel.dx * p.vel.dx + p.vel.dy * p.vel.dy);
      tV += v;
      tE += 0.5 * p.mass * v * v;
    }

    clusters = _countClusters();
    avgVel = particles.isEmpty ? 0 : tV / particles.length;
    energy = particles.isEmpty ? 0 : tE / particles.length;
    temp = avgVel * 10;

    shockwaves.removeWhere((s) => s.done);
    for (var s in shockwaves) s.step();
    sparkles.removeWhere((s) => s.done);
    for (var s in sparkles) s.step();
    boomTexts.removeWhere((b) => b.done);
    for (var b in boomTexts) b.step();
    gravWells.removeWhere((w) => w.done);
    for (var w in gravWells) w.step();
  }

  // ─────────────────────────────────────────────────────────
  void detonate(Offset pos, Color primary) {
    final rng = math.Random();
    shockwaves.add(Shockwave(pos));
    gravWells.add(GravityWell(pos, 1.8));

    const words = ['BOOM!', 'POW!', 'BANG!', 'ZAP!', 'NOVA!'];
    boomTexts.add(BoomText(pos, words[rng.nextInt(words.length)]));

    for (int i = 0; i < 20; i++) {
      final a = rng.nextDouble() * math.pi * 2;
      final spd = rng.nextDouble() * 7 + 2;
      sparkles.add(
        Sparkle(pos, Offset(math.cos(a) * spd, math.sin(a) * spd), primary),
      );
    }

    for (var p in particles) {
      final dx = p.pos.dx - pos.dx;
      final dy = p.pos.dy - pos.dy;
      final d = math.sqrt(dx * dx + dy * dy);
      if (d > 0 && d < 220) {
        p.vel = Offset(
          p.vel.dx + dx * 20 * (220 - d) / d,
          p.vel.dy + dy * 20 * (220 - d) / d,
        );
        p.energy = 1.0;
      }
    }
  }

  // ─── private helpers ─────────────────────────────────────
  void _applyCursorForce(Particle p) {
    if (cursor == null) return;
    final dx = cursor!.dx - p.pos.dx;
    final dy = cursor!.dy - p.pos.dy;
    final d = math.sqrt(dx * dx + dy * dy);
    if (d <= 0 || d >= 380) return;

    double f = 0;
    switch (mode) {
      case ParticleMode.attract:
        f = force * (380 - d) / 380;
      case ParticleMode.repel:
        f = -force * (380 - d) / 380;
      case ParticleMode.orbit:
        final a = math.atan2(dy, dx);
        p.vel = Offset(
          p.vel.dx + math.cos(a + math.pi / 2) * force * 0.7,
          p.vel.dy + math.sin(a + math.pi / 2) * force * 0.7,
        );
      case ParticleMode.vortex:
        final a = math.atan2(dy, dx);
        p.vel = Offset(
          p.vel.dx + math.cos(a + math.pi / 2) * force * (380 - d) / 380,
          p.vel.dy + math.sin(a + math.pi / 2) * force * (380 - d) / 380,
        );
      case ParticleMode.magnetic:
        f = p.charge * force * (380 - d) / d * 0.5;
    }

    if (f != 0)
      p.vel = Offset(p.vel.dx + (dx / d) * f, p.vel.dy + (dy / d) * f);
    p.energy = math.min(1.0, p.energy + 0.006);
  }

  void _applyGravityWells(Particle p) {
    for (var w in gravWells) {
      final dx = w.pos.dx - p.pos.dx;
      final dy = w.pos.dy - p.pos.dy;
      final d = math.sqrt(dx * dx + dy * dy);
      if (d > 8 && d < 320)
        p.vel = Offset(
          p.vel.dx + (dx / d) * w.strength * force / (d * d) * 900,
          p.vel.dy + (dy / d) * w.strength * force / (d * d) * 900,
        );
    }
  }

  void _applyCollisions(Particle p) {
    for (var o in particles) {
      if (o == p) continue;
      final dx = o.pos.dx - p.pos.dx;
      final dy = o.pos.dy - p.pos.dy;
      final dSq = dx * dx + dy * dy;
      final md = p.r + o.r;
      if (dSq >= md * md * 4) continue;

      final d = math.sqrt(dSq);
      if (d < md && d > 0) {
        hits++;
        final nx = dx / d, ny = dy / d;
        final van = (p.vel.dx - o.vel.dx) * nx + (p.vel.dy - o.vel.dy) * ny;
        if (van > 0) continue;
        final imp = -1.5 * van / (1 / p.mass + 1 / o.mass);
        p.vel = Offset(
          p.vel.dx - (imp / p.mass) * nx * 0.4,
          p.vel.dy - (imp / p.mass) * ny * 0.4,
        );
        p.energy = math.min(1.0, p.energy + 0.25);
        o.energy = math.min(1.0, o.energy + 0.25);
      }
    }
  }

  void _moveParticle(Particle p, Size sz) {
    p.pos = Offset(p.pos.dx + p.vel.dx, p.pos.dy + p.vel.dy);
    p.vel = Offset(p.vel.dx * 0.9975, p.vel.dy * 0.9975);

    if (p.pos.dx < 0 || p.pos.dx > sz.width) {
      p.vel = Offset(-p.vel.dx * 0.88, p.vel.dy);
      p.pos = Offset(p.pos.dx.clamp(0, sz.width), p.pos.dy);
    }
    if (p.pos.dy < 0 || p.pos.dy > sz.height) {
      p.vel = Offset(p.vel.dx, -p.vel.dy * 0.88);
      p.pos = Offset(p.pos.dx, p.pos.dy.clamp(0, sz.height));
    }

    p.energy = math.max(0.06, p.energy * 0.9988);
    if (trails)
      p.addTrail();
    else
      p.trail.clear();
  }

  int _countClusters() {
    if (particles.isEmpty) return 0;
    final visited = List.filled(particles.length, false);
    int c = 0;
    for (int i = 0; i < particles.length; i++) {
      if (!visited[i]) {
        _flood(i, visited);
        c++;
      }
    }
    return c;
  }

  void _flood(int i, List<bool> visited) {
    visited[i] = true;
    for (int j = 0; j < particles.length; j++) {
      if (!visited[j]) {
        final dx = particles[i].pos.dx - particles[j].pos.dx;
        final dy = particles[i].pos.dy - particles[j].pos.dy;
        if (math.sqrt(dx * dx + dy * dy) < 90) _flood(j, visited);
      }
    }
  }
}
