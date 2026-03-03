import 'package:flutter/material.dart';
import '../../models/enums.dart';
import '../../theme/tokens.dart';

class PaletteSection extends StatelessWidget {
  final PaletteType pal;
  final Map<PaletteType, List<Color>> palettes;
  final ValueChanged<PaletteType> onSelect;

  const PaletteSection({
    Key? key,
    required this.pal,
    required this.palettes,
    required this.onSelect,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: PaletteType.values.map((p) {
      final sel = pal == p;
      final pair = palettes[p]!;
      return GestureDetector(
        onTap: () => onSelect(p),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 280),
          curve: Curves.easeOutCubic,
          width: 42,
          height: 42,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            gradient: RadialGradient(
              center: const Alignment(-0.3, -0.3),
              radius: 0.95,
              colors: [
                Color.lerp(pair[0], Colors.white, 0.15)!,
                pair[0],
                pair[1],
              ],
              stops: const [0.0, 0.3, 1.0],
            ),
            border: sel
                ? Border.all(color: Colors.white.withOpacity(0.85), width: 2.2)
                : Border.all(color: pair[0].withOpacity(0.12), width: 0.6),
            boxShadow: [
              const BoxShadow(
                color: kSh3,
                offset: Offset(0, 6),
                blurRadius: 14,
              ),
              const BoxShadow(color: kSh0, offset: Offset(0, 3), blurRadius: 6),
              const BoxShadow(
                color: kHl1,
                offset: Offset(-2, -2),
                blurRadius: 6,
              ),
              if (sel)
                BoxShadow(
                  color: pair[0].withOpacity(0.65),
                  blurRadius: 22,
                  spreadRadius: 3,
                ),
            ],
          ),
          child: sel
              ? Center(
                  child: Container(
                    width: 7,
                    height: 7,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(color: Colors.white, blurRadius: 5),
                      ],
                    ),
                  ),
                )
              : null,
        ),
      );
    }).toList(),
  );
}
