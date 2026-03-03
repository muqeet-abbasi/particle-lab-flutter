import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../theme/tokens.dart';

class HudOverlay extends StatelessWidget {
  final double energy, avgVel, temp;
  final int clusters, hits;

  const HudOverlay({
    Key? key,
    required this.energy,
    required this.avgVel,
    required this.temp,
    required this.clusters,
    required this.hits,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => ClipRRect(
    borderRadius: BorderRadius.circular(16),
    child: Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 11),
      decoration: BoxDecoration(
        color: kS2.withOpacity(0.88),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: kEdgeL.withOpacity(0.5), width: 0.6),
        boxShadow: const [
          BoxShadow(color: kSh0, offset: Offset(0, 10), blurRadius: 24),
          BoxShadow(color: kHl0, offset: Offset(-4, -4), blurRadius: 10),
        ],
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          _stat('Energy', energy.toStringAsFixed(1), 'J'),
          _divider(),
          _stat('Speed', avgVel.toStringAsFixed(2), 'm/s'),
          _divider(),
          _stat('Temp', temp.toStringAsFixed(0), 'K'),
          _divider(),
          _stat('Nodes', '$clusters', ''),
          _divider(),
          _stat('Hits', '$hits', ''),
        ],
      ),
    ),
  );

  Widget _stat(String label, String val, String unit) => Padding(
    padding: const EdgeInsets.symmetric(horizontal: 10),
    child: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          label,
          style: GoogleFonts.spaceMono(
            fontSize: 8,
            color: kMid,
            letterSpacing: 1.2,
            height: 1,
          ),
        ),
        const SizedBox(height: 4),
        RichText(
          text: TextSpan(
            children: [
              TextSpan(
                text: val,
                style: GoogleFonts.spaceMono(
                  fontSize: 13,
                  fontWeight: FontWeight.w700,
                  color: kWhite,
                ),
              ),
              if (unit.isNotEmpty)
                TextSpan(
                  text: ' $unit',
                  style: GoogleFonts.spaceMono(fontSize: 8, color: kMid),
                ),
            ],
          ),
        ),
      ],
    ),
  );

  Widget _divider() => Container(
    width: 0.6,
    height: 22,
    margin: const EdgeInsets.symmetric(horizontal: 2),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [
          Colors.transparent,
          kMute.withOpacity(0.8),
          Colors.transparent,
        ],
      ),
    ),
  );
}
