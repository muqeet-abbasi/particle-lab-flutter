import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../theme/tokens.dart';
import '../widgets/neu_thumb.dart';

class ParamSection extends StatelessWidget {
  final double count, force, speed, size;
  final ValueChanged<double> onCount, onForce, onSpeed, onSize;

  const ParamSection({
    Key? key,
    required this.count,
    required this.force,
    required this.speed,
    required this.size,
    required this.onCount,
    required this.onForce,
    required this.onSpeed,
    required this.onSize,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => Column(
    children: [
      _row('Particles', count, 50, 400, onCount),
      const SizedBox(height: 16),
      _row('Force', force, 0.1, 2.0, onForce),
      const SizedBox(height: 16),
      _row('Speed', speed, 0.3, 2.5, onSpeed),
      const SizedBox(height: 16),
      _row('Size', size, 0.5, 2.0, onSize),
    ],
  );

  Widget _row(
    String label,
    double val,
    double min,
    double max,
    ValueChanged<double> cb,
  ) => Row(
    children: [
      SizedBox(
        width: 64,
        child: Text(
          label,
          style: GoogleFonts.spaceMono(fontSize: 9, color: kMid),
        ),
      ),
      Expanded(
        child: SliderTheme(
          data: SliderThemeData(
            trackHeight: 2.5,
            thumbShape: NeuThumb(),
            overlayShape: SliderComponentShape.noOverlay,
            activeTrackColor: kA1.withOpacity(0.8),
            inactiveTrackColor: kS0,
          ),
          child: Slider(value: val, min: min, max: max, onChanged: cb),
        ),
      ),
      Container(
        width: 46,
        height: 28,
        decoration: neuInset(r: 9),
        alignment: Alignment.center,
        child: Text(
          label == 'Particles'
              ? val.toInt().toString()
              : val.toStringAsFixed(1),
          style: GoogleFonts.spaceMono(
            fontSize: 9,
            fontWeight: FontWeight.w700,
            color: kWhite,
          ),
        ),
      ),
    ],
  );
}
