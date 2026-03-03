import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../models/enums.dart';
import '../../theme/tokens.dart';

class ShapeSection extends StatelessWidget {
  final ParticleShape shape;
  final ValueChanged<ParticleShape> onSelect;

  const ShapeSection({Key? key, required this.shape, required this.onSelect})
    : super(key: key);

  static const _items = [
    (Icons.circle_outlined, 'Circle'),
    (Icons.crop_square_rounded, 'Square'),
    (Icons.change_history_rounded, 'Tri'),
    (Icons.hexagon_rounded, 'Hex'),
    (Icons.star_outline_rounded, 'Star'),
  ];

  @override
  Widget build(BuildContext context) => Wrap(
    spacing: 7,
    runSpacing: 7,
    children: ParticleShape.values.asMap().entries.map((e) {
      final sel = shape == e.value;
      return GestureDetector(
        onTap: () => onSelect(e.value),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          curve: Curves.easeOutCubic,
          width: 58,
          height: 56,
          decoration: sel ? neuSelected(r: 14) : neuPill(r: 14),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(_items[e.key].$1, size: 19, color: sel ? kA3 : kMid),
              const SizedBox(height: 3),
              Text(
                _items[e.key].$2,
                style: GoogleFonts.spaceMono(
                  fontSize: 10,
                  color: sel ? kWhite : kMid,
                ),
              ),
            ],
          ),
        ),
      );
    }).toList(),
  );
}
