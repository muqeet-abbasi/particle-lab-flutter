import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../theme/tokens.dart';

class BrandCard extends StatelessWidget {
  final int count;
  final Animation<double> spin;

  const BrandCard({Key? key, required this.count, required this.spin})
    : super(key: key);

  @override
  Widget build(BuildContext context) => Container(
    padding: const EdgeInsets.all(16),
    decoration: neuBrand(),
    child: Row(
      children: [
        _spinningOrb(),
        const SizedBox(width: 14),
        _title(),
        _counter(),
      ],
    ),
  );

  Widget _spinningOrb() => AnimatedBuilder(
    animation: spin,
    builder: (_, __) => Transform.rotate(
      angle: spin.value * math.pi * 2,
      child: Container(
        width: 50,
        height: 50,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          gradient: const RadialGradient(
            center: Alignment(-0.35, -0.35),
            radius: 0.9,
            colors: [kS5, kS4, kS2],
            stops: [0.0, 0.5, 1.0],
          ),
          border: Border.all(color: kEdgeH.withOpacity(0.6), width: 0.8),
          boxShadow: [
            const BoxShadow(color: kSh3, offset: Offset(5, 6), blurRadius: 16),
            const BoxShadow(color: kSh0, offset: Offset(3, 4), blurRadius: 8),
            const BoxShadow(
              color: kHl2,
              offset: Offset(-4, -4),
              blurRadius: 10,
            ),
            const BoxShadow(color: kHl3, offset: Offset(-1, -1), blurRadius: 3),
            BoxShadow(
              color: kA1.withOpacity(0.22),
              blurRadius: 18,
              spreadRadius: 3,
            ),
          ],
        ),
        child: const Icon(Icons.blur_on_rounded, color: kA2, size: 24),
      ),
    ),
  );

  Widget _title() => Expanded(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ShaderMask(
          shaderCallback: (b) => const LinearGradient(
            colors: [kA4, kT2],
            stops: [0.3, 1.0],
          ).createShader(b),
          child: Text(
            'Particle Lab',
            style: GoogleFonts.orbitron(
              fontSize: 16,
              fontWeight: FontWeight.w800,
              color: Colors.white,
              letterSpacing: 0.2,
            ),
          ),
        ),
        const SizedBox(height: 3),
        Text(
          'Quantum Simulator v3',
          style: GoogleFonts.spaceMono(
            fontSize: 7,
            color: kMid,
            letterSpacing: 0.6,
          ),
        ),
      ],
    ),
  );

  Widget _counter() => Container(
    padding: const EdgeInsets.symmetric(horizontal: 11, vertical: 8),
    decoration: neuInset(r: 12, surface: kS0),
    child: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        ShaderMask(
          shaderCallback: (b) =>
              const LinearGradient(colors: [kA4, kT1]).createShader(b),
          child: Text(
            '$count',
            style: GoogleFonts.orbitron(
              fontSize: 20,
              fontWeight: FontWeight.w900,
              color: Colors.white,
              height: 1.1,
            ),
          ),
        ),
        Text('ptcls', style: GoogleFonts.spaceMono(fontSize: 7, color: kMid)),
      ],
    ),
  );
}
