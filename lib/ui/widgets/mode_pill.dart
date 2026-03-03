import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../theme/tokens.dart';
import '../../models/enums.dart';

class ModePill extends StatelessWidget {
  final ParticleMode mode;
  final Animation<double> pulse;

  const ModePill({Key? key, required this.mode, required this.pulse})
    : super(key: key);

  @override
  Widget build(BuildContext context) => ClipRRect(
    borderRadius: BorderRadius.circular(12),
    child: Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 9),
      decoration: BoxDecoration(
        color: kS2.withOpacity(0.88),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: kEdgeL.withOpacity(0.5), width: 0.6),
        boxShadow: const [
          BoxShadow(color: kSh0, offset: Offset(0, 8), blurRadius: 18),
          BoxShadow(color: kHl0, offset: Offset(-3, -3), blurRadius: 8),
        ],
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          AnimatedBuilder(
            animation: pulse,
            builder: (_, __) {
              final p = (math.sin(pulse.value * math.pi * 2) + 1) / 2;
              return Container(
                width: 6,
                height: 6,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: const LinearGradient(colors: [kA3, kT1]),
                  boxShadow: [
                    BoxShadow(
                      color: kA1.withOpacity(0.4 + 0.4 * p),
                      blurRadius: 8 + 4 * p,
                    ),
                  ],
                ),
              );
            },
          ),
          const SizedBox(width: 9),
          Text(
            '${mode.name.toUpperCase()} MODE',
            style: GoogleFonts.spaceMono(
              fontSize: 9,
              fontWeight: FontWeight.w700,
              color: kA4,
              letterSpacing: 1.8,
            ),
          ),
        ],
      ),
    ),
  );
}
