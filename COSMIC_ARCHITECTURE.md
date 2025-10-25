# Cosmic Background Architecture

## Layer Stack (Bottom to Top)

```
┌─────────────────────────────────────────────────┐
│                                                 │
│  📱 UI Content Layer (Your App Content)        │
│     - Widgets overlay on background             │
│     - Semi-transparent containers               │
│     - Text, buttons, interactive elements       │
│                                                 │
├─────────────────────────────────────────────────┤
│                                                 │
│  🌊 Quantum Wave Effects Layer                 │
│     - Sine wave patterns                        │
│     - Energy field lines                        │
│     - 3 overlapping waves                       │
│     - Animation: 3s cycle                       │
│                                                 │
├─────────────────────────────────────────────────┤
│                                                 │
│  ✨ Particle Effects Layer                     │
│     - 50 quantum particles                      │
│     - Moving in random directions               │
│     - Trail effects                             │
│     - Animation: 5s cycle                       │
│                                                 │
├─────────────────────────────────────────────────┤
│                                                 │
│  🪐 Planets Layer                               │
│     - 5 orbiting planets                        │
│     - Elliptical orbit paths                    │
│     - Glow effects                              │
│     - Animation: 60s cycle                      │
│                                                 │
├─────────────────────────────────────────────────┤
│                                                 │
│  ⭐ Starfield Layer                            │
│     - 150 stars                                 │
│     - Twinkling animation                       │
│     - Varying brightness                        │
│     - Animation: 3s cycle (individual)          │
│                                                 │
├─────────────────────────────────────────────────┤
│                                                 │
│  🌌 Deep Space Gradient (Static Base)          │
│     - 4-color gradient                          │
│     - Dark blue/purple tones                    │
│     - No animation (performance)                │
│                                                 │
└─────────────────────────────────────────────────┘
```

## Animation Controllers

```
Main Controller (60s)
    ↓
  Planets orbit around center

Particle Controller (5s)
    ↓
  Particles drift and wrap

Quantum Controller (3s)
    ↓
  Waves animate + Stars twinkle
```

## Performance Profile

```
Component          | Elements | Update Freq | Impact
-------------------|----------|-------------|--------
Gradient           | 1        | Never       | None
Starfield          | 150      | 60 FPS      | Low
Planets            | 5        | 60 FPS      | Low
Particles          | 50       | 60 FPS      | Low
Quantum Waves      | 8        | 60 FPS      | Low
Total              | 214      | 60 FPS      | Low
```

## Color Scheme

```
Background Gradient:
  #0A0E27 (Dark Blue) ────┐
  #1A1F3A (Navy Blue)     ├─→ Creates depth
  #0F1628 (Deep Blue)     │
  #1E0B3D (Purple)    ────┘

Celestial Bodies:
  🟠 Orange Planet
  🟣 Purple Planet
  🔵 Blue Planet
  🟢 Teal Planet
  🔴 Pink Planet

Effects:
  🌊 Cyan Waves
  ✨ Cyan Particles
  💜 Purple Energy Lines
  ⭐ White Stars
```

## Component Communication

```
CosmicBackground (StatefulWidget)
        |
        ├─→ initState()
        |     ├─→ Initialize Controllers
        |     ├─→ Generate Stars
        |     ├─→ Generate Planets
        |     └─→ Generate Particles
        |
        ├─→ build()
        |     └─→ Stack of Layers
        |           ├─→ Gradient Container
        |           ├─→ AnimatedBuilder (Stars)
        |           ├─→ AnimatedBuilder (Planets)
        |           ├─→ AnimatedBuilder (Particles)
        |           ├─→ AnimatedBuilder (Waves)
        |           └─→ Child Widget
        |
        └─→ dispose()
              └─→ Dispose Controllers
```

## Data Models

```dart
Star {
  double x, y          // Position (0.0 - 1.0)
  double size          // Radius (0.5 - 2.5)
  double brightness    // Opacity (0.0 - 1.0)
  double twinkleSpeed  // Animation speed multiplier
}

Planet {
  double orbitRadius   // Distance from center (0.0 - 0.5)
  double size          // Diameter (25 - 50)
  Color color          // RGBA color
  double speed         // Orbit speed multiplier
  double angle         // Starting angle (radians)
}

Particle {
  double x, y          // Position (0.0 - 1.0)
  double size          // Radius (1 - 4)
  double speedX, speedY // Velocity (-0.001 - 0.001)
  Color color          // RGBA color
}
```

## Rendering Pipeline

```
Frame Update (60 FPS)
    ↓
Animation Controllers Update
    ↓
CustomPainters Paint
    ├─→ StarfieldPainter
    ├─→ PlanetsPainter
    ├─→ ParticlesPainter
    └─→ QuantumWavesPainter
    ↓
Composite Layers
    ↓
Display Frame
```

## Memory Footprint

```
Stars:    150 × ~56 bytes  = ~8.4 KB
Planets:    5 × ~48 bytes  = ~0.24 KB
Particles: 50 × ~48 bytes  = ~2.4 KB
Controllers: 3 × ~200 bytes = ~0.6 KB
--------------------------------------
Total:                       ~11.64 KB
```

## Integration Example

```dart
// Basic Integration
Scaffold(
  extendBodyBehindAppBar: true,
  appBar: AppBar(
    backgroundColor: Colors.transparent,
    elevation: 0,
  ),
  body: CosmicBackground(
    child: YourContent(),
  ),
)

// With Performance Control
CosmicBackground(
  enableAnimations: shouldAnimate,
  child: YourContent(),
)

// Styling Content for Visibility
Container(
  decoration: BoxDecoration(
    color: Colors.black.withOpacity(0.3),
    borderRadius: BorderRadius.circular(16),
    border: Border.all(
      color: Colors.tealAccent.withOpacity(0.3),
    ),
  ),
  child: YourContent(),
)
```

## Customization Points

```
┌────────────────────────────────┐
│ Easy to Customize              │
├────────────────────────────────┤
│ ✓ Element counts               │
│ ✓ Colors (planets, effects)    │
│ ✓ Animation speeds             │
│ ✓ Orbit radii                  │
│ ✓ Particle behaviors           │
│ ✓ Wave patterns                │
│ ✓ Star properties              │
└────────────────────────────────┘

┌────────────────────────────────┐
│ Advanced Customization         │
├────────────────────────────────┤
│ ⚙ Add new effect layers        │
│ ⚙ Custom painters              │
│ ⚙ Interactive elements         │
│ ⚙ Dynamic quality scaling      │
│ ⚙ Custom animation curves      │
└────────────────────────────────┘
```
