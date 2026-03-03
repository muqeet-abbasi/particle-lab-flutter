import 'dart:math' as math;
import 'package:flutter/material.dart' hide Simulation;
import 'package:google_fonts/google_fonts.dart';
import '../core/simulation.dart';
import '../models/enums.dart';
import '../theme/tokens.dart';
import '../painters/aurora_painter.dart';
import '../painters/sim_painter.dart';
import '../painters/corner_painter.dart';
import 'widgets/hud.dart';
import 'widgets/mode_pill.dart';
import 'widgets/cursor_widget.dart';
import 'panel/panel_inner.dart';
import 'panel/panel_outer.dart';

class ParticleLab extends StatefulWidget {
  const ParticleLab({Key? key}) : super(key: key);

  @override
  State<ParticleLab> createState() => _ParticleLabState();
}

class _ParticleLabState extends State<ParticleLab>
    with TickerProviderStateMixin {
  // ── controllers ──────────────────────────────────────────
  late AnimationController _tick, _ambient, _pulse, _spin, _scan;

  // ── simulation ───────────────────────────────────────────
  final Simulation _sim = Simulation();

  // ── ui state ─────────────────────────────────────────────
  Offset? _cursor;
  PaletteType _pal = PaletteType.cyan;
  ParticleShape _shape = ParticleShape.circle;
  bool _trails = true, _bonds = true, _glow = true, _collis = false;

  static const _palettes = {
    PaletteType.cyan: [Color(0xFF00FFB2), Color(0xFF00CFFF)],
    PaletteType.sunset: [Color(0xFFFF5F7E), Color(0xFFFFCB47)],
    PaletteType.violet: [Color(0xFFB060FF), Color(0xFFFF50C8)],
    PaletteType.flame: [Color(0xFFFF2060), Color(0xFFFF8C00)],
    PaletteType.arctic: [Color(0xFF40BCFE), Color(0xFF90EEFF)],
    PaletteType.lime: [Color(0xFF30FF20), Color(0xFFBBFF00)],
  };

  Color _pColor(double t) =>
      Color.lerp(_palettes[_pal]![0], _palettes[_pal]![1], t)!;
  Color get _primary => _palettes[_pal]![0];
  Color get _secondary => _palettes[_pal]![1];

  // ─────────────────────────────────────────────────────────
  @override
  void initState() {
    super.initState();
    _tick = AnimationController(vsync: this, duration: const Duration(days: 1))
      ..repeat();
    _ambient = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 32),
    )..repeat();
    _pulse = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2800),
    )..repeat();
    _spin = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 10),
    )..repeat();
    _scan = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 5),
    )..repeat();
    _spawnParticles();
  }

  void _spawnParticles() => _sim.spawn(colorFn: _pColor, shape: _shape);

  void _applyFormation(FormationType f) =>
      _sim.applyFormation(formation: f, colorFn: _pColor, shape: _shape);

  // ─────────────────────────────────────────────────────────
  @override
  void dispose() {
    _tick.dispose();
    _ambient.dispose();
    _pulse.dispose();
    _spin.dispose();
    _scan.dispose();
    super.dispose();
  }

  // ─────────────────────────────────────────────────────────
  @override
  Widget build(BuildContext context) => Scaffold(
    backgroundColor: kBase,
    body: Container(
      decoration: const BoxDecoration(
        gradient: RadialGradient(
          center: Alignment(-0.6, -0.7),
          radius: 1.8,
          colors: [Color(0xFF0C0C1C), Color(0xFF050508)],
        ),
      ),
      child: Row(
        children: [
          Expanded(child: _buildCanvas()),
          PanelOuter(
            pulse: _pulse,
            spin: _spin,
            child: PanelInner(
              sim: _sim,
              count: _sim.count,
              force: _sim.force,
              speed: _sim.speed,
              size: _sim.size,
              pal: _pal,
              mode: _sim.mode,
              shape: _shape,
              trails: _trails,
              bonds: _bonds,
              glow: _glow,
              collis: _collis,
              spin: _spin,
              palettes: _palettes,
              onPalette: (p) => setState(() {
                _pal = p;
                for (int i = 0; i < _sim.particles.length; i++)
                  _sim.particles[i].col = _pColor(i / _sim.particles.length);
              }),
              onMode: (m) => setState(() => _sim.mode = m),
              onCount: (v) => setState(() {
                _sim.count = v.toInt();
                _spawnParticles();
              }),
              onForce: (v) => setState(() => _sim.force = v),
              onSpeed: (v) => setState(() => _sim.speed = v),
              onSize: (v) => setState(() => _sim.size = v),
              onShape: (s) => setState(() {
                _shape = s;
                for (var p in _sim.particles) p.shape = s;
              }),
              onFormation: (f) => setState(() => _applyFormation(f)),
              onTrails: (v) => setState(() {
                _trails = v;
                _sim.trails = v;
              }),
              onBonds: (v) => setState(() => _bonds = v),
              onGlow: (v) => setState(() => _glow = v),
              onCollis: (v) => setState(() {
                _collis = v;
                _sim.collis = v;
              }),
              onReset: () => setState(() => _spawnParticles()),
            ),
          ),
        ],
      ),
    ),
  );

  Widget _buildCanvas() => Padding(
    padding: const EdgeInsets.fromLTRB(16, 16, 0, 16),
    child: Stack(
      children: [
        Positioned.fill(
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30),
              boxShadow: [
                BoxShadow(
                  color: kA1.withOpacity(0.05),
                  blurRadius: 80,
                  spreadRadius: 20,
                ),
                BoxShadow(
                  color: kT0.withOpacity(0.03),
                  blurRadius: 60,
                  spreadRadius: 10,
                ),
              ],
            ),
          ),
        ),
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(26),
            border: Border.all(color: kEdgeL.withOpacity(0.4), width: 0.6),
            boxShadow: const [
              BoxShadow(color: kSh0, offset: Offset(0, 28), blurRadius: 56),
              BoxShadow(color: kSh1, offset: Offset(0, 12), blurRadius: 24),
              BoxShadow(color: kHl0, offset: Offset(-8, -8), blurRadius: 20),
              BoxShadow(color: kHl1, offset: Offset(-2, -2), blurRadius: 6),
            ],
          ),
          clipBehavior: Clip.hardEdge,
          child: GestureDetector(
            onTapDown: (d) =>
                setState(() => _sim.detonate(d.localPosition, _primary)),
            child: MouseRegion(
              onHover: (e) => setState(() {
                _cursor = e.localPosition;
                _sim.cursor = e.localPosition;
              }),
              onExit: (_) => setState(() {
                _cursor = null;
                _sim.cursor = null;
              }),
              child: AnimatedBuilder(
                animation: Listenable.merge([
                  _tick,
                  _ambient,
                  _pulse,
                  _spin,
                  _scan,
                ]),
                builder: (_, __) => LayoutBuilder(
                  builder: (_, c) {
                    _sim.tick(c.biggest);
                    return Stack(
                      children: [
                        CustomPaint(
                          size: c.biggest,
                          painter: AuroraPainter(
                            t: _ambient.value,
                            pulse: _pulse.value,
                            scan: _scan.value,
                            cursor: _cursor,
                            p1: _primary,
                            p2: _secondary,
                          ),
                        ),
                        CustomPaint(
                          size: c.biggest,
                          painter: SimPainter(
                            ps: _sim.particles,
                            sw: _sim.shockwaves,
                            sk: _sim.sparkles,
                            bt: _sim.boomTexts,
                            cursor: _cursor,
                            trails: _trails,
                            bonds: _bonds,
                            glow: _glow,
                            p1: _primary,
                            p2: _secondary,
                            pulseT: _pulse.value,
                          ),
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
                                  kA3.withOpacity(0.35),
                                  kT1.withOpacity(0.20),
                                  Colors.transparent,
                                ],
                              ),
                            ),
                          ),
                        ),
                        Positioned(top: 16, left: 16, child: _corner()),
                        Positioned(
                          top: 16,
                          right: 16,
                          child: _corner(flip: true),
                        ),
                        Positioned(
                          bottom: 16,
                          left: 16,
                          child: _corner(flipV: true),
                        ),
                        Positioned(
                          bottom: 16,
                          right: 16,
                          child: _corner(flip: true, flipV: true),
                        ),
                        Positioned(
                          top: 22,
                          left: 22,
                          child: HudOverlay(
                            energy: _sim.energy,
                            avgVel: _sim.avgVel,
                            temp: _sim.temp,
                            clusters: _sim.clusters,
                            hits: _sim.hits,
                          ),
                        ),
                        Positioned(
                          bottom: 22,
                          left: 22,
                          child: ModePill(mode: _sim.mode, pulse: _pulse),
                        ),
                        Positioned(bottom: 22, right: 22, child: _tapHint()),
                        if (_cursor != null)
                          Positioned(
                            left: _cursor!.dx - 30,
                            top: _cursor!.dy - 30,
                            child: IgnorePointer(
                              child: CursorWidget(pulse: _pulse),
                            ),
                          ),
                      ],
                    );
                  },
                ),
              ),
            ),
          ),
        ),
      ],
    ),
  );

  Widget _corner({bool flip = false, bool flipV = false}) => Transform.scale(
    scaleX: flip ? -1 : 1,
    scaleY: flipV ? -1 : 1,
    child: AnimatedBuilder(
      animation: _pulse,
      builder: (_, __) {
        final p = (math.sin(_pulse.value * math.pi * 2) + 1) / 2;
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

  Widget _tapHint() => ClipRRect(
    borderRadius: BorderRadius.circular(10),
    child: Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: kS1.withOpacity(0.7),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: kEdge.withOpacity(0.5), width: 0.6),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(Icons.touch_app_rounded, size: 11, color: kMid),
          const SizedBox(width: 6),
          Text(
            'Tap to detonate',
            style: GoogleFonts.spaceMono(fontSize: 8, color: kMid),
          ),
        ],
      ),
    ),
  );
}
