import 'package:flutter/material.dart';

class Shockwave {
  final Offset pos;
  double r = 0;
  double op = 1.0;
  bool done = false;

  Shockwave(this.pos);

  void step() {
    r += 10;
    op -= 0.022;
    if (r > 270 || op <= 0) done = true;
  }
}

class Sparkle {
  Offset pos;
  final Offset vel;
  final Color col;
  double r = 3.5;
  double op = 1.0;
  bool done = false;

  Sparkle(this.pos, this.vel, this.col);

  void step() {
    pos = Offset(pos.dx + vel.dx * 0.95, pos.dy + vel.dy * 0.95);
    r *= 0.94;
    op -= 0.033;
    if (op <= 0) done = true;
  }
}

class BoomText {
  final Offset pos;
  final String txt;
  double dy = 0;
  double sc = 0.3;
  double op = 1.0;
  double rot = 0;
  bool done = false;

  BoomText(this.pos, this.txt);

  void step() {
    dy -= 3.0;
    sc = (sc + 0.055).clamp(0.0, 1.4);
    op -= 0.014;
    rot += 0.03;
    if (dy < -160 || op <= 0) done = true;
  }
}

class GravityWell {
  final Offset pos;
  final double strength;
  double age = 0;
  bool done = false;

  GravityWell(this.pos, this.strength);

  void step() {
    age += 0.016;
    if (age >= 1.0) done = true;
  }
}
