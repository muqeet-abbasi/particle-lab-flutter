import 'package:flutter/material.dart';
import '../../theme/tokens.dart';
import '../../painters/corner_painter.dart';
import 'dart:math' as math;

class PanelOuter extends StatelessWidget {
  final Widget child;
  final Animation<double> pulse;
  final Animation<double> spin;

  const PanelOuter({
    Key? key,
    required this.child,
    required this.pulse,
    required this.spin,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.fromLTRB(0, 16, 16, 16),
    child: Stack(
      children: [
        Positioned.fill(
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30),
              boxShadow: [
                BoxShadow(
                  color: kA1.withOpacity(0.06),
                  blurRadius: 80,
                  spreadRadius: 18,
                ),
                BoxShadow(
                  color: kT0.withOpacity(0.03),
                  blurRadius: 60,
                  spreadRadius: 8,
                ),
              ],
            ),
          ),
        ),
        Container(
          width: 388,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(26),
            border: Border.all(color: kEdgeL.withOpacity(0.45), width: 0.7),
            boxShadow: const [
              BoxShadow(
                color: kSh3,
                offset: Offset(0, 28),
                blurRadius: 56,
                spreadRadius: 2,
              ),
              BoxShadow(color: kSh0, offset: Offset(0, 14), blurRadius: 28),
              BoxShadow(
                color: kSh1,
                offset: Offset(8, 40),
                blurRadius: 60,
                spreadRadius: -5,
              ),
              BoxShadow(color: kHl1, offset: Offset(-6, -6), blurRadius: 18),
              BoxShadow(color: kHl2, offset: Offset(-2, -2), blurRadius: 6),
            ],
          ),
          clipBehavior: Clip.hardEdge,
          child: child,
        ),
        Positioned(
          top: 0,
          left: 60,
          right: 60,
          child: Container(
            height: 1,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Colors.transparent,
                  kA3.withOpacity(0.30),
                  kT1.withOpacity(0.18),
                  Colors.transparent,
                ],
              ),
            ),
          ),
        ),
        Positioned(top: 16, left: 16, child: _corner(pulse)),
        Positioned(top: 16, right: 16, child: _corner(pulse, flip: true)),
        Positioned(bottom: 16, left: 16, child: _corner(pulse, flipV: true)),
        Positioned(
          bottom: 16,
          right: 16,
          child: _corner(pulse, flip: true, flipV: true),
        ),
      ],
    ),
  );

  Widget _corner(
    Animation<double> pulse, {
    bool flip = false,
    bool flipV = false,
  }) => Transform.scale(
    scaleX: flip ? -1 : 1,
    scaleY: flipV ? -1 : 1,
    child: AnimatedBuilder(
      animation: pulse,
      builder: (_, __) {
        final p = (math.sin(pulse.value * math.pi * 2) + 1) / 2;
        return SizedBox(
          width: 14,
          height: 14,
          child: CustomPaint(
            painter: CornerPainter(color: kA2.withOpacity(0.20 + 0.08 * p)),
          ),
        );
      },
    ),
  );
}
