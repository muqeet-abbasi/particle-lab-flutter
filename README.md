# 🧪 Particle Lab — Flutter Web

A real-time quantum particle simulator running entirely in the browser.
Built with **pure Dart** — zero JavaScript, zero CSS frameworks.

![Flutter](https://img.shields.io/badge/Flutter-Web-02569B?style=for-the-badge&logo=flutter&logoColor=white)
![Dart](https://img.shields.io/badge/Dart-3.0-0175C2?style=for-the-badge&logo=dart&logoColor=white)
![License](https://img.shields.io/badge/License-MIT-green?style=for-the-badge)
![Live](https://img.shields.io/badge/Live-Demo-00BFA0?style=for-the-badge&logo=netlify&logoColor=white)

## 🌐 [Live Demo → particle-lab-flutter.netlify.app](https://particle-lab-flutter.netlify.app)

---

## 📽️ Demo

> 🌐 Visit the live demo above — move your mouse around, click anywhere to detonate 💥
> No install. No download. Just open and play.

---

## ✨ Features

- ⚛️ 200+ physics-simulated particles with real mass, charge & velocity
- 🌀 5 Force Modes — Attract, Repel, Orbit, Vortex, Magnetic
- 🔬 4 Formation Presets — DNA Helix, Galaxy Spiral, Atom Orbits, Torus Ring
- 🔷 5 Particle Shapes — Circle, Square, Triangle, Hexagon, Star
- 🎨 6 Color Palettes — switchable in real time
- 💫 Particle trails, bond lines, glow aura & collision detection
- 💥 Shockwave detonation on tap/click
- 📊 Live HUD — Energy, Speed, Temperature, Cluster stats
- 🎨 Deep 3D Neumorphic UI built entirely with CustomPainter
- ⚡ 60fps canvas rendering using Flutter's Skia engine

---

## 🛠️ How It Works

Flutter Web isn't just "Flutter but in a browser." It's a full rendering engine running on the web. Every particle, every shadow, every glow effect is drawn directly on an HTML Canvas using **Skia**. No DOM manipulation. No CSS tricks. Flutter just takes over the screen and paints whatever it wants, pixel by pixel — the same way it does on iOS and Android.

The `CustomPainter` API handles everything:
- Bezier curves & radial gradients
- Sweep shaders & blur masks
- Real-time path rendering
- All at **60fps** in a browser tab — no libraries, just math and Dart

---

## 📁 Project Structure
```
lib/
├── main.dart                        # Entry point
├── theme/
│   └── tokens.dart                  # Colors, shadows & decorations
├── models/
│   ├── enums.dart                   # Mode, Shape, Palette, Formation
│   ├── particle.dart                # Particle data class
│   └── effects.dart                 # Shockwave, Sparkle, BoomText, GravityWell
├── core/
│   └── simulation.dart              # Physics engine
├── painters/
│   ├── aurora_painter.dart          # Background atmosphere
│   ├── sim_painter.dart             # Particle rendering
│   └── corner_painter.dart          # UI corner ornaments
└── ui/
    ├── particle_lab.dart            # Main screen — wires everything
    ├── widgets/
    │   ├── hud.dart                 # Live stats overlay
    │   ├── mode_pill.dart           # Active mode indicator
    │   ├── cursor_widget.dart       # Custom cursor ring
    │   └── neu_thumb.dart           # Neumorphic slider thumb
    ├── sections/
    │   ├── palette_section.dart
    │   ├── mode_section.dart
    │   ├── param_section.dart
    │   ├── shape_section.dart
    │   ├── formation_section.dart
    │   ├── effects_section.dart
    │   └── stats_section.dart
    └── panel/
        ├── brand_card.dart
        ├── panel_inner.dart
        └── panel_outer.dart
```

---

## 🚀 Getting Started

### Prerequisites
- Flutter SDK 3.0+
- Dart 3.0+
- Chrome browser

### Run Locally
```bash
# Clone the repo
git clone https://github.com/muqeet-abbasi/particle-lab-flutter.git

# Navigate into project
cd particle-lab-flutter

# Get dependencies
flutter pub get

# Run on Chrome
flutter run -d chrome
```

### Build for Web
```bash
flutter build web --release
```

---

## 📦 Dependencies
```yaml
dependencies:
  flutter:
    sdk: flutter
  google_fonts: ^6.1.0
```

---

## 🎮 How to Use

| Action | Result |
|--------|--------|
| 🖱️ Move mouse over canvas | Particles react based on active force mode |
| 👆 Click / Tap canvas | Shockwave detonation 💥 |
| 🎛️ Adjust sliders | Control particle count, force, speed & size live |
| 🔘 Select force mode | Switch between Attract, Repel, Orbit, Vortex, Magnetic |
| 🔷 Select shape | Change particle geometry in real time |
| 🧬 Select formation | Arrange particles into DNA, Galaxy, Atom or Torus |
| ⚡ Toggle effects | Enable trails, bond lines, glow aura & collisions |
| 🔄 Reset | Spawn fresh random particles |

---

## 🏗️ Built With

| Technology | Purpose |
|---|---|
| Flutter Web | Cross-platform UI framework |
| CustomPainter API | Direct canvas rendering |
| Skia Engine | Hardware-accelerated 60fps graphics |
| Google Fonts | Orbitron + Space Mono typography |
| Pure Dart | Zero JS, zero CSS dependencies |

---

## 💡 Key Technical Highlights

- **Physics Engine** — built from scratch in Dart. No game engine, no physics library
- **Neumorphic UI** — every shadow, highlight and surface crafted using `BoxDecoration` and `CustomPainter`
- **One Codebase** — same code runs on Chrome, Android, iOS and Desktop without changing a single line
- **Clean Architecture** — split into theme, models, core, painters and UI layers for maintainability

---

## 📄 License

MIT License — feel free to use, fork and build on top of this.

---

## 🙋‍♂️ Author

**Abdul Muqeet Hassan**

[![LinkedIn](https://img.shields.io/badge/LinkedIn-Connect-0077B5?style=for-the-badge&logo=linkedin&logoColor=white)](https://www.linkedin.com/in/abdul-muqeet-hassan-0702a9260/)
[![GitHub](https://img.shields.io/badge/GitHub-Follow-181717?style=for-the-badge&logo=github&logoColor=white)](https://github.com/muqeet-abbasi)
[![Instagram](https://img.shields.io/badge/Instagram-Follow-E4405F?style=for-the-badge&logo=instagram&logoColor=white)](https://www.instagram.com/muqeet_abbasi06/)

---

⭐ **Star this repo if you found it interesting!**