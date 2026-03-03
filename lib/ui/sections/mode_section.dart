import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../models/enums.dart';
import '../../theme/tokens.dart';

class ModeSection extends StatelessWidget {
  final ParticleMode mode;
  final ValueChanged<ParticleMode> onSelect;

  const ModeSection({Key? key, required this.mode, required this.onSelect})
    : super(key: key);

  static const _icons = {
    ParticleMode.attract: Icons.compress_rounded,
    ParticleMode.repel: Icons.expand_rounded,
    ParticleMode.orbit: Icons.rotate_right_rounded,
    ParticleMode.vortex: Icons.cyclone_rounded,
    ParticleMode.magnetic: Icons.electric_bolt_rounded,
  };

  @override
  Widget build(BuildContext context) => Wrap(
    spacing: 7,
    runSpacing: 7,
    children: ParticleMode.values.map((m) {
      final sel = mode == m;
      return GestureDetector(
        onTap: () => onSelect(m),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          curve: Curves.easeOutCubic,
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
          decoration: sel ? neuSelected(r: 12) : neuPill(r: 12),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(_icons[m]!, size: 13, color: sel ? kA3 : kMid),
              const SizedBox(width: 6),
              Text(
                m.name[0].toUpperCase() + m.name.substring(1),
                style: GoogleFonts.spaceMono(
                  fontSize: 10,
                  color: sel ? kWhite : kMid,
                  fontWeight: sel ? FontWeight.w700 : FontWeight.w400,
                ),
              ),
            ],
          ),
        ),
      );
    }).toList(),
  );
}
