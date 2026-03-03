import 'package:flutter/material.dart' hide Simulation;
import 'package:google_fonts/google_fonts.dart';
import '../../theme/tokens.dart';
import '../../models/enums.dart';
import '../../core/simulation.dart';
import 'brand_card.dart';
import '../sections/palette_section.dart';
import '../sections/mode_section.dart';
import '../sections/param_section.dart';
import '../sections/shape_section.dart';
import '../sections/formation_section.dart';
import '../sections/effects_section.dart';
import '../sections/stats_section.dart';

class PanelInner extends StatelessWidget {
  final Simulation sim;
  final int count;
  final double force, speed, size;
  final PaletteType pal;
  final ParticleMode mode;
  final ParticleShape shape;
  final bool trails, bonds, glow, collis;
  final Animation<double> spin;
  final Map<PaletteType, List<Color>> palettes;

  final ValueChanged<PaletteType> onPalette;
  final ValueChanged<ParticleMode> onMode;
  final ValueChanged<double> onCount, onForce, onSpeed, onSize;
  final ValueChanged<ParticleShape> onShape;
  final ValueChanged<FormationType> onFormation;
  final ValueChanged<bool> onTrails, onBonds, onGlow, onCollis;
  final VoidCallback onReset;

  const PanelInner({
    Key? key,
    required this.sim,
    required this.count,
    required this.force,
    required this.speed,
    required this.size,
    required this.pal,
    required this.mode,
    required this.shape,
    required this.trails,
    required this.bonds,
    required this.glow,
    required this.collis,
    required this.spin,
    required this.palettes,
    required this.onPalette,
    required this.onMode,
    required this.onCount,
    required this.onForce,
    required this.onSpeed,
    required this.onSize,
    required this.onShape,
    required this.onFormation,
    required this.onTrails,
    required this.onBonds,
    required this.onGlow,
    required this.onCollis,
    required this.onReset,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => Container(
    decoration: const BoxDecoration(
      gradient: LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [Color(0xFF0F0F24), Color(0xFF080814), Color(0xFF0A0A1A)],
        stops: [0.0, 0.5, 1.0],
      ),
    ),
    padding: const EdgeInsets.fromLTRB(14, 18, 18, 18),
    child: Column(
      children: [
        BrandCard(count: count, spin: spin),
        const SizedBox(height: 14),
        Expanded(
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              children: [
                _section(
                  'Color Palette',
                  PaletteSection(
                    pal: pal,
                    palettes: palettes,
                    onSelect: onPalette,
                  ),
                ),
                const SizedBox(height: 11),
                _section(
                  'Force Mode',
                  ModeSection(mode: mode, onSelect: onMode),
                ),
                const SizedBox(height: 11),
                _section(
                  'Parameters',
                  ParamSection(
                    count: count.toDouble(),
                    force: force,
                    speed: speed,
                    size: size,
                    onCount: onCount,
                    onForce: onForce,
                    onSpeed: onSpeed,
                    onSize: onSize,
                  ),
                ),
                const SizedBox(height: 11),
                _section(
                  'Particle Shape',
                  ShapeSection(shape: shape, onSelect: onShape),
                ),
                const SizedBox(height: 11),
                _section('Formations', FormationSection(onSelect: onFormation)),
                const SizedBox(height: 11),
                _section(
                  'Effects',
                  EffectsSection(
                    trails: trails,
                    bonds: bonds,
                    glow: glow,
                    collis: collis,
                    onTrails: onTrails,
                    onBonds: onBonds,
                    onGlow: onGlow,
                    onCollis: onCollis,
                  ),
                ),
                const SizedBox(height: 11),
                _section('Live Stats', StatsSection(sim: sim)),
                const SizedBox(height: 14),
                _resetButton(),
                const SizedBox(height: 4),
              ],
            ),
          ),
        ),
      ],
    ),
  );

  Widget _section(String title, Widget body) => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Container(
        margin: const EdgeInsets.only(left: 2, bottom: 8),
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        decoration: neuSectionLabel(),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 3,
              height: 10,
              margin: const EdgeInsets.only(right: 7),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [kA3, kT0],
                ),
                borderRadius: BorderRadius.circular(2),
                boxShadow: [
                  BoxShadow(color: kA1.withOpacity(0.6), blurRadius: 6),
                ],
              ),
            ),
            Text(
              title.toUpperCase(),
              style: GoogleFonts.spaceMono(
                fontSize: 7.5,
                fontWeight: FontWeight.w700,
                color: kA3,
                letterSpacing: 2.4,
              ),
            ),
          ],
        ),
      ),
      Container(
        padding: const EdgeInsets.all(15),
        decoration: neuGroove(r: 18),
        child: body,
      ),
    ],
  );

  Widget _resetButton() => GestureDetector(
    onTap: onReset,
    child: Container(
      padding: const EdgeInsets.symmetric(vertical: 15),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [kS4, kS3, kS2],
          stops: [0.0, 0.4, 1.0],
        ),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: kEdgeH.withOpacity(0.50), width: 0.8),
        boxShadow: [
          const BoxShadow(
            color: kSh3,
            offset: Offset(8, 10),
            blurRadius: 26,
            spreadRadius: 1,
          ),
          const BoxShadow(color: kSh0, offset: Offset(5, 6), blurRadius: 16),
          const BoxShadow(
            color: kSh1,
            offset: Offset(14, 18),
            blurRadius: 44,
            spreadRadius: -4,
          ),
          const BoxShadow(color: kHl2, offset: Offset(-6, -6), blurRadius: 16),
          const BoxShadow(color: kHl3, offset: Offset(-2, -2), blurRadius: 5),
          BoxShadow(
            color: kA1.withOpacity(0.10),
            blurRadius: 28,
            spreadRadius: 4,
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 28,
            height: 28,
            decoration: neuInset(r: 9, surface: kS0),
            child: const Icon(Icons.refresh_rounded, color: kA3, size: 15),
          ),
          const SizedBox(width: 11),
          ShaderMask(
            shaderCallback: (b) =>
                const LinearGradient(colors: [kA4, kT1]).createShader(b),
            child: Text(
              'RESET SIMULATION',
              style: GoogleFonts.orbitron(
                fontSize: 10,
                fontWeight: FontWeight.w800,
                color: Colors.white,
                letterSpacing: 2.2,
              ),
            ),
          ),
        ],
      ),
    ),
  );
}
