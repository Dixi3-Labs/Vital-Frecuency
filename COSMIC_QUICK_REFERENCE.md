# Cosmic Background Quick Reference

## Quick Start

### 1. Import the background
```dart
import 'cosmic_background.dart';
```

### 2. Wrap your content
```dart
CosmicBackground(
  child: YourWidget(),
)
```

### 3. Make AppBar transparent (optional but recommended)
```dart
Scaffold(
  extendBodyBehindAppBar: true,
  appBar: AppBar(
    backgroundColor: Colors.transparent,
    elevation: 0,
  ),
  body: CosmicBackground(child: YourContent()),
)
```

## Configuration

### Enable/Disable Animations
```dart
CosmicBackground(
  enableAnimations: true,  // Set to false to disable for performance
  child: YourWidget(),
)
```

## Styling Content for Visibility

### Semi-transparent Container
```dart
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

### Glowing Active State
```dart
BoxDecoration(
  color: Colors.black.withOpacity(0.4),
  borderRadius: BorderRadius.circular(20),
  border: Border.all(
    color: isActive ? Colors.tealAccent.withOpacity(0.6) : Colors.white.withOpacity(0.2),
    width: 2,
  ),
  boxShadow: [
    BoxShadow(
      color: isActive ? Colors.tealAccent.withOpacity(0.3) : Colors.transparent,
      blurRadius: 20,
      spreadRadius: 2,
    ),
  ],
)
```

## Common Customizations

### Change Star Count
In `cosmic_background.dart`:
```dart
void _initializeStars() {
  for (int i = 0; i < 150; i++) {  // ← Change this number
    // ...
  }
}
```

### Change Particle Count
In `cosmic_background.dart`:
```dart
void _initializeParticles() {
  for (int i = 0; i < 50; i++) {  // ← Change this number
    // ...
  }
}
```

### Change Planet Colors
In `_initializePlanets()`:
```dart
Planet(
  color: Colors.yourColor.withOpacity(0.7),  // ← Change color here
  // ...
)
```

### Adjust Animation Speed
In `initState()`:
```dart
_controller = AnimationController(
  duration: Duration(seconds: 60),  // ← Higher = slower planets
)

_particleController = AnimationController(
  duration: Duration(seconds: 5),   // ← Higher = slower particles
)

_quantumController = AnimationController(
  duration: Duration(seconds: 3),   // ← Higher = slower waves/stars
)
```

### Add a New Planet
In `_initializePlanets()`:
```dart
_planets.add(
  Planet(
    orbitRadius: 0.4,        // Distance from center (0.0-0.5)
    size: 35,                // Diameter in pixels
    color: Colors.green.withOpacity(0.6),
    speed: 0.6,              // Orbit speed multiplier
    angle: 0,                // Starting angle in radians
  ),
);
```

## Performance Tips

### Low-End Devices
```dart
// Reduce elements
_initializeStars() { for (int i = 0; i < 75; i++) ... }    // Half stars
_initializeParticles() { for (int i = 0; i < 25; i++) ... } // Half particles

// Or disable animations entirely
CosmicBackground(enableAnimations: false, child: ...)
```

### Monitor Performance
```dart
// Use Flutter DevTools Performance tab
// Check frame rendering times
// Profile on actual devices
```

## Color Reference

### Background Gradient
```dart
[
  Color(0xFF0A0E27),  // Dark blue
  Color(0xFF1A1F3A),  // Navy
  Color(0xFF0F1628),  // Deep blue
  Color(0xFF1E0B3D),  // Purple
]
```

### Effect Colors
```dart
Colors.cyan           // Particles
Colors.cyanAccent     // Quantum waves
Colors.purpleAccent   // Energy lines
Colors.white          // Stars
Colors.tealAccent     // UI accents
```

### Planet Colors (as implemented)
```dart
Colors.orange.withOpacity(0.7)   // Planet 1
Colors.purple.withOpacity(0.6)   // Planet 2
Colors.blue.withOpacity(0.5)     // Planet 3
Colors.tealAccent.withOpacity(0.6)  // Planet 4
Colors.pinkAccent.withOpacity(0.5)  // Planet 5
```

## Troubleshooting

| Issue | Solution |
|-------|----------|
| App laggy | Reduce star/particle count or disable animations |
| Background static | Check animation controllers are initialized |
| Content hard to read | Increase container opacity or add more padding |
| Visual artifacts | Use `extendBodyBehindAppBar: true` and transparent AppBar |
| Too dark | Reduce gradient opacity or lighten colors |
| Too bright | Darken planet/effect colors |

## File Structure
```
cosmic_background.dart
├── CosmicBackground (StatefulWidget)
├── Star (data model)
├── Planet (data model)
├── Particle (data model)
├── StarfieldPainter (CustomPainter)
├── PlanetsPainter (CustomPainter)
├── ParticlesPainter (CustomPainter)
└── QuantumWavesPainter (CustomPainter)
```

## Layer Order (bottom to top)
1. Deep space gradient (static)
2. Starfield (animated)
3. Planets with orbits (animated)
4. Particles (animated)
5. Quantum waves (animated)
6. Your content (on top)

## Animation Cycles
- Planets: 60 seconds per full orbit
- Particles: 5 seconds per cycle
- Quantum waves: 3 seconds per cycle
- Star twinkle: 1-3 seconds (varies per star)

## Memory Usage
- Total: ~12 KB for all elements
- Stars: ~8.4 KB (150 stars)
- Particles: ~2.4 KB (50 particles)
- Planets: ~0.24 KB (5 planets)
- Controllers: ~0.6 KB (3 controllers)

## Best Practices

✅ **Do:**
- Use semi-transparent containers for content
- Add borders/glows for important elements
- Test on target devices
- Monitor performance with DevTools
- Adjust counts based on device capabilities

❌ **Don't:**
- Create too many particles/stars on low-end devices
- Use completely opaque backgrounds (defeats the purpose)
- Forget to dispose animation controllers
- Nest multiple cosmic backgrounds
- Block the main thread with heavy computations

## Support

For issues or questions:
1. Check COSMIC_BACKGROUND.md for detailed documentation
2. Review COSMIC_ARCHITECTURE.md for technical details
3. Profile performance using Flutter DevTools
4. Test on multiple devices

## Example Integration

See `main.dart` for complete examples:
- HomeScreen: Welcome screen with cosmic background
- Detector Screen: Main app screen with cosmic background

Both use the same background with appropriate content styling.
