import 'package:flutter/material.dart';
import 'enums.dart';

class Particle {
  Offset pos;
  Offset vel;
  double r;
  double mass;
  double charge;
  double energy;
  Color col;
  ParticleShape shape;
  final List<Offset> trail = [];

  Particle({
    required this.pos,
    required this.vel,
    required this.r,
    required this.col,
    required this.mass,
    required this.charge,
    required this.energy,
    required this.shape,
  });

  void addTrail() {
    trail.add(pos);
    if (trail.length > 28) trail.removeAt(0);
  }
}
