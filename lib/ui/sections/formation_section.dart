import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../models/enums.dart';
import '../../theme/tokens.dart';

class FormationSection extends StatelessWidget {
  final ValueChanged<FormationType> onSelect;

  const FormationSection({Key? key, required this.onSelect}) : super(key: key);

  static const _items = [
    (Icons.linear_scale_rounded, 'DNA', FormationType.dna),
    (Icons.blur_circular_rounded, 'Galaxy', FormationType.galaxy),
    (Icons.center_focus_strong_rounded, 'Atom', FormationType.atom),
    (Icons.donut_large_rounded, 'Torus', FormationType.torus),
  ];

  @override
  Widget build(BuildContext context) => Row(
    children: _items
        .map(
          (t) => Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 3),
              child: GestureDetector(
                onTap: () => onSelect(t.$3),
                child: Container(
                  height: 64,
                  decoration: neu(r: 14, surface: kS2, elevation: 1.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(t.$1, size: 19, color: kMid),
                      const SizedBox(height: 5),
                      Text(
                        t.$2,
                        style: GoogleFonts.spaceMono(fontSize: 12, color: kMid),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        )
        .toList(),
  );
}
