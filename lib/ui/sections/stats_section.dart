import 'package:flutter/material.dart' hide Simulation;
import 'package:google_fonts/google_fonts.dart';
import '../../theme/tokens.dart';
import '../../core/simulation.dart';

class StatsSection extends StatelessWidget {
  final Simulation sim;

  const StatsSection({Key? key, required this.sim}) : super(key: key);

  @override
  Widget build(BuildContext context) => Column(
    children: [
      Row(
        children: [
          _tile('Energy', sim.energy.toStringAsFixed(2), 'J'),
          const SizedBox(width: 8),
          _tile('Speed', sim.avgVel.toStringAsFixed(2), 'm/s'),
        ],
      ),
      const SizedBox(height: 8),
      Row(
        children: [
          _tile('Temp', sim.temp.toStringAsFixed(0), 'K'),
          const SizedBox(width: 8),
          _tile('Clusters', '${sim.clusters}', ''),
        ],
      ),
    ],
  );

  Widget _tile(String label, String val, String unit) => Expanded(
    child: Container(
      padding: const EdgeInsets.fromLTRB(13, 11, 13, 12),
      decoration: neuStatTile(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: GoogleFonts.spaceMono(
              fontSize: 7.5,
              color: kMid,
              letterSpacing: 1.1,
            ),
          ),
          const SizedBox(height: 7),
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Flexible(
                child: ShaderMask(
                  shaderCallback: (b) =>
                      const LinearGradient(colors: [kA4, kT1]).createShader(b),
                  child: Text(
                    val,
                    style: GoogleFonts.orbitron(
                      fontSize: 17,
                      fontWeight: FontWeight.w800,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              if (unit.isNotEmpty)
                Padding(
                  padding: const EdgeInsets.only(left: 3, bottom: 1),
                  child: Text(
                    unit,
                    style: GoogleFonts.spaceMono(fontSize: 7.5, color: kMid),
                  ),
                ),
            ],
          ),
        ],
      ),
    ),
  );
}
