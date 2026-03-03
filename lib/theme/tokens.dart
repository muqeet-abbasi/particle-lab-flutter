import 'package:flutter/material.dart';

// ─── SURFACES ───────────────────────────────────────────────
const kBase = Color(0xFF080810);
const kS0 = Color(0xFF0C0C18);
const kS1 = Color(0xFF101020);
const kS2 = Color(0xFF141428);
const kS3 = Color(0xFF191930);
const kS4 = Color(0xFF1E1E38);
const kS5 = Color(0xFF242448);

// ─── SHADOWS ────────────────────────────────────────────────
const kSh0 = Color(0xFF030308);
const kSh1 = Color(0xFF05050D);
const kSh2 = Color(0xFF070714);
const kSh3 = Color(0xFF020205);

// ─── HIGHLIGHTS ─────────────────────────────────────────────
const kHl0 = Color(0xFF1A1A35);
const kHl1 = Color(0xFF22223E);
const kHl2 = Color(0xFF2C2C52);
const kHl3 = Color(0xFF383870);

// ─── ACCENT (PURPLE) ────────────────────────────────────────
const kA0 = Color(0xFF4C2FD4);
const kA1 = Color(0xFF6648FF);
const kA2 = Color(0xFF8870FF);
const kA3 = Color(0xFFAA99FF);
const kA4 = Color(0xFFCCC0FF);

// ─── TEAL ───────────────────────────────────────────────────
const kT0 = Color(0xFF00BFA0);
const kT1 = Color(0xFF00E5C0);
const kT2 = Color(0xFF80FFE8);

// ─── TEXT / MISC ────────────────────────────────────────────
const kWhite = Color(0xFFECECFF);
const kMid = Color(0xFF4E4E82);
const kMute = Color(0xFF2E2E52);
const kEdge = Color(0xFF1C1C34);
const kEdgeL = Color(0xFF252548);
const kEdgeH = Color(0xFF2E2E5A);

// ─── DECORATIONS ────────────────────────────────────────────

BoxDecoration neu({
  double r = 20,
  Color surface = kS2,
  double elevation = 1.0,
  bool glowAccent = false,
}) => BoxDecoration(
  color: surface,
  borderRadius: BorderRadius.circular(r),
  border: Border.all(color: kEdgeL.withOpacity(0.45), width: 0.6),
  boxShadow: [
    BoxShadow(
      color: kSh3,
      offset: Offset(8 * elevation, 12 * elevation),
      blurRadius: 28 * elevation,
      spreadRadius: elevation.toInt().toDouble(),
    ),
    BoxShadow(
      color: kSh0,
      offset: Offset(5 * elevation, 7 * elevation),
      blurRadius: 16 * elevation,
    ),
    BoxShadow(
      color: kSh1,
      offset: Offset(14 * elevation, 20 * elevation),
      blurRadius: 48 * elevation,
      spreadRadius: -3,
    ),
    BoxShadow(
      color: kHl2,
      offset: Offset(-6 * elevation, -6 * elevation),
      blurRadius: 16 * elevation,
    ),
    BoxShadow(
      color: kHl3.withOpacity(0.4),
      offset: Offset(-2 * elevation, -2 * elevation),
      blurRadius: 5 * elevation,
    ),
    BoxShadow(
      color: kEdgeH.withOpacity(0.25),
      offset: Offset(-1 * elevation, -1 * elevation),
      blurRadius: 2 * elevation,
    ),
    if (glowAccent) ...[
      BoxShadow(color: kA1.withOpacity(0.10), blurRadius: 32, spreadRadius: 5),
      BoxShadow(color: kA0.withOpacity(0.06), blurRadius: 56, spreadRadius: 10),
    ],
  ],
);

BoxDecoration neuInset({double r = 12, Color surface = kS0}) => BoxDecoration(
  color: surface,
  borderRadius: BorderRadius.circular(r),
  border: Border.all(color: kSh0.withOpacity(0.95), width: 0.6),
  boxShadow: const [
    BoxShadow(
      color: kSh3,
      offset: Offset(4, 5),
      blurRadius: 14,
      spreadRadius: 1,
    ),
    BoxShadow(color: kSh0, offset: Offset(2, 3), blurRadius: 8),
    BoxShadow(color: kSh1, offset: Offset(1, 2), blurRadius: 4),
    BoxShadow(color: kHl0, offset: Offset(-3, -3), blurRadius: 9),
    BoxShadow(color: kHl1, offset: Offset(-1, -1), blurRadius: 3),
  ],
);

BoxDecoration neuSelected({
  double r = 20,
  Color surface = kS3,
}) => BoxDecoration(
  color: surface,
  borderRadius: BorderRadius.circular(r),
  border: Border.all(color: kA2.withOpacity(0.60), width: 1.0),
  boxShadow: [
    const BoxShadow(
      color: kSh3,
      offset: Offset(9, 12),
      blurRadius: 28,
      spreadRadius: 1,
    ),
    const BoxShadow(color: kSh0, offset: Offset(5, 7), blurRadius: 16),
    const BoxShadow(
      color: kSh1,
      offset: Offset(16, 22),
      blurRadius: 44,
      spreadRadius: -4,
    ),
    const BoxShadow(color: kHl2, offset: Offset(-6, -6), blurRadius: 16),
    const BoxShadow(color: kHl1, offset: Offset(-2, -2), blurRadius: 5),
    BoxShadow(color: kA1.withOpacity(0.18), blurRadius: 24, spreadRadius: 4),
    BoxShadow(color: kA0.withOpacity(0.08), blurRadius: 44, spreadRadius: 8),
    BoxShadow(color: kT0.withOpacity(0.04), blurRadius: 60, spreadRadius: 12),
  ],
);

BoxDecoration neuPill({double r = 50, bool active = false}) => BoxDecoration(
  gradient: LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: active ? [kS5, kS4, kS2] : [kS4, kS3, kS1],
    stops: const [0.0, 0.4, 1.0],
  ),
  borderRadius: BorderRadius.circular(r),
  border: Border.all(
    color: active ? kA2.withOpacity(0.50) : kEdgeL.withOpacity(0.40),
    width: 0.7,
  ),
  boxShadow: active
      ? [
          const BoxShadow(color: kSh3, offset: Offset(6, 8), blurRadius: 20),
          const BoxShadow(color: kSh0, offset: Offset(4, 5), blurRadius: 12),
          const BoxShadow(
            color: kSh1,
            offset: Offset(10, 14),
            blurRadius: 32,
            spreadRadius: -3,
          ),
          const BoxShadow(color: kHl2, offset: Offset(-5, -5), blurRadius: 12),
          const BoxShadow(color: kHl1, offset: Offset(-2, -2), blurRadius: 4),
          BoxShadow(
            color: kA1.withOpacity(0.20),
            blurRadius: 20,
            spreadRadius: 3,
          ),
        ]
      : [
          const BoxShadow(color: kSh3, offset: Offset(5, 7), blurRadius: 16),
          const BoxShadow(color: kSh0, offset: Offset(3, 4), blurRadius: 10),
          const BoxShadow(
            color: kSh1,
            offset: Offset(8, 12),
            blurRadius: 28,
            spreadRadius: -3,
          ),
          const BoxShadow(color: kHl1, offset: Offset(-4, -4), blurRadius: 11),
          const BoxShadow(color: kHl0, offset: Offset(-1, -1), blurRadius: 4),
        ],
);

BoxDecoration neuGroove({double r = 16}) => BoxDecoration(
  gradient: const LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [Color(0xFF08081A), Color(0xFF0D0D1E)],
  ),
  borderRadius: BorderRadius.circular(r),
  border: Border.all(color: kSh2.withOpacity(0.85), width: 0.7),
  boxShadow: const [
    BoxShadow(
      color: kSh3,
      offset: Offset(3, 4),
      blurRadius: 12,
      spreadRadius: 2,
    ),
    BoxShadow(color: kSh0, offset: Offset(2, 2), blurRadius: 6),
    BoxShadow(color: kHl0, offset: Offset(-2, -2), blurRadius: 7),
  ],
);

BoxDecoration neuStatTile() => const BoxDecoration(
  gradient: LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [Color(0xFF060610), Color(0xFF0B0B1C)],
  ),
  borderRadius: BorderRadius.all(Radius.circular(12)),
  boxShadow: [
    BoxShadow(
      color: kSh3,
      offset: Offset(4, 5),
      blurRadius: 16,
      spreadRadius: 2,
    ),
    BoxShadow(color: kSh0, offset: Offset(2, 3), blurRadius: 8),
    BoxShadow(color: kHl0, offset: Offset(-3, -3), blurRadius: 9),
    BoxShadow(color: kHl1, offset: Offset(-1, -1), blurRadius: 3),
  ],
);

BoxDecoration neuBrand() => BoxDecoration(
  gradient: const LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [kS4, kS3, kS2],
    stops: [0.0, 0.45, 1.0],
  ),
  borderRadius: BorderRadius.circular(22),
  border: Border.all(color: kEdgeH.withOpacity(0.55), width: 0.7),
  boxShadow: [
    const BoxShadow(
      color: kSh3,
      offset: Offset(10, 14),
      blurRadius: 32,
      spreadRadius: 2,
    ),
    const BoxShadow(color: kSh0, offset: Offset(6, 8), blurRadius: 20),
    const BoxShadow(
      color: kSh1,
      offset: Offset(18, 24),
      blurRadius: 56,
      spreadRadius: -4,
    ),
    const BoxShadow(color: kHl2, offset: Offset(-7, -7), blurRadius: 18),
    const BoxShadow(color: kHl3, offset: Offset(-2, -2), blurRadius: 6),
    BoxShadow(color: kA1.withOpacity(0.12), blurRadius: 36, spreadRadius: 6),
    BoxShadow(color: kT0.withOpacity(0.05), blurRadius: 56, spreadRadius: 10),
  ],
);

BoxDecoration neuSectionLabel() => BoxDecoration(
  gradient: const LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [kS3, kS2],
  ),
  borderRadius: BorderRadius.circular(8),
  border: Border.all(color: kEdgeL.withOpacity(0.35), width: 0.6),
  boxShadow: const [
    BoxShadow(color: kSh3, offset: Offset(3, 4), blurRadius: 10),
    BoxShadow(color: kHl1, offset: Offset(-2, -2), blurRadius: 6),
  ],
);
