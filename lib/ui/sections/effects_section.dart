import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../theme/tokens.dart';

class EffectsSection extends StatelessWidget {
  final bool trails, bonds, glow, collis;
  final ValueChanged<bool> onTrails, onBonds, onGlow, onCollis;

  const EffectsSection({
    Key? key,
    required this.trails,
    required this.bonds,
    required this.glow,
    required this.collis,
    required this.onTrails,
    required this.onBonds,
    required this.onGlow,
    required this.onCollis,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => Column(
    children: [
      _toggle('Particle Trails', trails, Icons.show_chart_rounded, onTrails),
      const SizedBox(height: 8),
      _toggle('Bond Lines', bonds, Icons.device_hub_rounded, onBonds),
      const SizedBox(height: 8),
      _toggle('Glow Aura', glow, Icons.flare_rounded, onGlow),
      const SizedBox(height: 8),
      _toggle('Collisions', collis, Icons.merge_type_rounded, onCollis),
    ],
  );

  Widget _toggle(
    String label,
    bool val,
    IconData icon,
    ValueChanged<bool> cb,
  ) => GestureDetector(
    onTap: () => cb(!val),
    child: AnimatedContainer(
      duration: const Duration(milliseconds: 220),
      curve: Curves.easeOutCubic,
      padding: const EdgeInsets.symmetric(horizontal: 13, vertical: 11),
      decoration: val ? neuSelected(r: 13) : neuPill(r: 13),
      child: Row(
        children: [
          Container(
            width: 28,
            height: 28,
            decoration: neuInset(r: 9, surface: kS0),
            child: Icon(icon, size: 13, color: val ? kA3 : kMid),
          ),
          const SizedBox(width: 11),
          Expanded(
            child: Text(
              label,
              style: GoogleFonts.spaceMono(
                fontSize: 9.5,
                color: val ? kWhite : kMid,
                fontWeight: val ? FontWeight.w700 : FontWeight.w400,
              ),
            ),
          ),
          _switch(val),
        ],
      ),
    ),
  );

  Widget _switch(bool val) => Container(
    width: 40,
    height: 20,
    decoration: neuInset(r: 10, surface: kS0),
    child: AnimatedAlign(
      duration: const Duration(milliseconds: 220),
      curve: Curves.easeOutCubic,
      alignment: val ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        width: 16,
        height: 16,
        margin: const EdgeInsets.all(2),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          gradient: val
              ? const LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [kA3, kA1],
                )
              : null,
          color: val ? null : kMute,
          boxShadow: [
            const BoxShadow(color: kSh3, offset: Offset(1, 2), blurRadius: 5),
            if (val)
              BoxShadow(
                color: kA1.withOpacity(0.65),
                blurRadius: 10,
                spreadRadius: 1,
              ),
          ],
        ),
      ),
    ),
  );
}
