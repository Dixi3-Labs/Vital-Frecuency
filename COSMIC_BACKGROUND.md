# Cosmic Background System

## Overview

The **Cosmic Background System** provides a dynamic, animated space background for the Frecuencia Vital Flutter app. It creates an immersive experience that makes the app appear to be floating in space with moving planets, twinkling stars, particle effects, and quantum wave animations.

## Features

### 1. **Starfield Layer** (150 stars)
- Randomly positioned stars across the screen
- Dynamic twinkling effect with varying speeds
- Different brightness levels for visual depth
- Glow effects for brighter stars

### 2. **Orbiting Planets** (5 planets)
- Planets orbit around the screen center in elliptical paths
- Each planet has:
  - Unique orbit radius and speed
  - Gradient coloring (orange, purple, blue, teal, pink)
  - Subtle orbit path visualization
  - Glow effects for an ethereal appearance
- Smooth, continuous orbital motion

### 3. **Particle Effects** (50 particles)
- Quantum-style particles that drift across the screen
- Particles wrap around screen edges for continuous effect
- Each particle has:
  - Random starting position
  - Independent velocity and direction
  - Trailing glow effect
  - Cyan coloring with varying opacity

### 4. **Quantum Wave Effects**
- Multiple sine wave patterns that animate across the screen
- Energy field lines that pulse vertically
- Creates a sense of energy and frequency resonance
- Cyan and purple accent colors for quantum aesthetic

### 5. **Deep Space Gradient Background**
- Multi-color gradient background
- Dark blues and purples create a deep space atmosphere
- Static base layer for performance optimization

## Implementation

### File Structure

```
Vital-Frecuency/
├── main.dart                    # Main app entry with screen routing
├── vital_widget.dart            # Frequency detector widget
└── cosmic_background.dart       # Cosmic background system
```

### Usage

The `CosmicBackground` widget wraps any content and renders the animated space background behind it:

```dart
import 'cosmic_background.dart';

// Wrap your content with CosmicBackground
CosmicBackground(
  child: YourContentWidget(),
)
```

You can also disable animations if needed for performance:

```dart
CosmicBackground(
  enableAnimations: false,
  child: YourContentWidget(),
)
```

### Integration Points

The cosmic background is integrated in two places:

1. **HomeScreen** - Welcome screen with app introduction
2. **Detector Screen** - Main frequency detection interface

Both screens use:
- `extendBodyBehindAppBar: true` for transparent AppBar
- `backgroundColor: Colors.transparent` on AppBar
- Semi-transparent containers for content readability

## Performance Considerations

### Optimization Techniques

1. **Layered Rendering**
   - Static gradient background (no repaint needed)
   - Independent animation controllers for each layer
   - Separate painters for different effect types

2. **Efficient Animation**
   - Three animation controllers with different durations:
     - Main controller (60s) for planets
     - Particle controller (5s) for particles
     - Quantum controller (3s) for waves and twinkling
   - Reduces unnecessary repaints

3. **Canvas Optimization**
   - Direct canvas painting for all effects
   - Minimal widget tree overhead
   - Efficient Path and Paint reuse

4. **Particle Management**
   - Limited to 50 particles (adjustable)
   - Simple position updates
   - Edge wrapping instead of recreation

### Performance Impact

The cosmic background is designed to be performant on most devices:

- **CPU Usage**: Minimal - uses Flutter's hardware-accelerated canvas
- **Memory**: Low - only stores position/state data for elements
- **Frame Rate**: Should maintain 60 FPS on modern devices
- **Battery**: Comparable to any animated UI; animations can be disabled if needed

### Monitoring Performance

To check performance in your app:

1. Run with Flutter DevTools
2. Check the Performance tab
3. Monitor frame rendering times
4. Profile on target devices

If performance issues occur:
- Reduce particle count in `_initializeParticles()`
- Reduce star count in `_initializeStars()`
- Simplify wave calculations in `QuantumWavesPainter`
- Disable animations: `CosmicBackground(enableAnimations: false)`

## Customization

### Adjusting Element Counts

In `cosmic_background.dart`, modify these values:

```dart
// In _initializeStars()
for (int i = 0; i < 150; i++) {  // Change 150 to desired count

// In _initializeParticles()
for (int i = 0; i < 50; i++) {   // Change 50 to desired count
```

### Changing Colors

Modify planet colors in `_initializePlanets()`:

```dart
Planet(
  color: Colors.yourColor.withOpacity(0.7),
  // ...
)
```

Modify wave and particle colors in respective painters:

```dart
// In ParticlesPainter
color: Colors.cyan.withOpacity(...)  // Change cyan to your color

// In QuantumWavesPainter
paint.color = Colors.cyanAccent.withOpacity(...)  // Change colors
```

### Adjusting Animation Speeds

In the `initState()` method:

```dart
// Main animation (planets) - increase duration to slow down
_controller = AnimationController(
  duration: Duration(seconds: 60),  // Adjust this value
)

// Particles - increase duration to slow down
_particleController = AnimationController(
  duration: Duration(seconds: 5),   // Adjust this value
)
```

### Adding More Planets

In `_initializePlanets()`, add more Planet objects:

```dart
_planets.add(
  Planet(
    orbitRadius: 0.5,              // Distance from center (0.0 - 0.5)
    size: 40,                      // Planet diameter
    color: Colors.green.withOpacity(0.6),
    speed: 0.4,                    // Rotation speed multiplier
    angle: math.pi * 0.75,         // Starting angle
  ),
);
```

## Visual Design

### Color Palette

- **Background**: Deep space blues and purples (#0A0E27, #1A1F3A, #0F1628, #1E0B3D)
- **Planets**: Orange, purple, blue, teal, pink with transparency
- **Effects**: Cyan, teal accent, purple accent
- **UI Overlays**: Semi-transparent black (0.3-0.4 opacity)

### UI Component Styling

All UI components use:
- Semi-transparent backgrounds for "glass" effect
- Teal accent colors for active states
- Rounded corners for modern look
- Subtle glows and borders when active

## Future Enhancements

Potential improvements for future versions:

1. **Interactive Elements**
   - Planets respond to touch/hover
   - Particle trails follow cursor
   - Pinch to zoom cosmic view

2. **Dynamic Adjustments**
   - Adjust animation speed based on device performance
   - Adaptive quality settings
   - Battery-aware animation scaling

3. **Additional Effects**
   - Shooting stars/comets
   - Nebula clouds
   - Black hole effects
   - Aurora-like energy waves

4. **Theming Support**
   - Multiple cosmic themes (red giant, blue nebula, etc.)
   - Time-of-day variations
   - Seasonal variations

## Troubleshooting

### Issue: App feels sluggish

**Solution**: Reduce particle/star count or disable animations:
```dart
CosmicBackground(enableAnimations: false, child: ...)
```

### Issue: Background appears static

**Solution**: Check that animation controllers are initialized:
- Verify `initState()` is called
- Ensure controllers are not disposed prematurely

### Issue: Visual artifacts or clipping

**Solution**: 
- Ensure `extendBodyBehindAppBar: true` is set on Scaffold
- Check that AppBar has `backgroundColor: Colors.transparent`
- Verify `SafeArea` is used for content

## License

This cosmic background system is part of the Frecuencia Vital app project.

## Credits

Created for the Vital-Frecuency project by Dixi3-Labs.
