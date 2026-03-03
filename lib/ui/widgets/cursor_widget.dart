import 'dart:math' as math;
import 'package:flutter/material.dart';
import '../../theme/tokens.dart';

class CursorWidget extends StatelessWidget {
  final Animation<double> pulse;

  const CursorWidget({Key? key, required this.pulse}) : super(key: key);

  @override
  Widget build(BuildContext context) => AnimatedBuilder(
    animation: pulse,
    builder: (_, __) {
      final p = (math.sin(pulse.value * math.pi * 2) + 1) / 2;
      return SizedBox(
        width: 60,
        height: 60,
        child: Stack(
          alignment: Alignment.center,
          children: [
            Container(
              width: 60 * (0.92 + 0.08 * p),
              height: 60 * (0.92 + 0.08 * p),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: kA2.withOpacity(0.45 + 0.15 * p),
                  width: 1.0,
                ),
                boxShadow: [
                  BoxShadow(
                    color: kA1.withOpacity(0.12 + 0.08 * p),
                    blurRadius: 18,
                    spreadRadius: 2,
                  ),
                ],
              ),
            ),
            Container(
              width: 4,
              height: 4,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: kA3,
                boxShadow: [
                  BoxShadow(color: kA2, blurRadius: 6, spreadRadius: 1),
                ],
              ),
            ),
          ],
        ),
      );
    },
  );
}
