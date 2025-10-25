// cosmic_background.dart
// Dynamic cosmic background with moving planets, stars, quantum effects, and animations

import 'dart:math' as math;
import 'package:flutter/material.dart';

class CosmicBackground extends StatefulWidget {
  final Widget child;
  final bool enableAnimations;

  const CosmicBackground({
    Key? key,
    required this.child,
    this.enableAnimations = true,
  }) : super(key: key);

  @override
  _CosmicBackgroundState createState() => _CosmicBackgroundState();
}

class _CosmicBackgroundState extends State<CosmicBackground>
    with TickerProviderStateMixin {
  late AnimationController _controller;
  late AnimationController _particleController;
  late AnimationController _quantumController;
  final List<Star> _stars = [];
  final List<Planet> _planets = [];
  final List<Particle> _particles = [];
  final math.Random _random = math.Random();

  @override
  void initState() {
    super.initState();
    
    // Main animation controller for planets and overall movement
    _controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 60),
    )..repeat();

    // Particle effects controller
    _particleController = AnimationController(
      vsync: this,
      duration: Duration(seconds: 5),
    )..repeat();

    // Quantum effects controller
    _quantumController = AnimationController(
      vsync: this,
      duration: Duration(seconds: 3),
    )..repeat();

    _initializeStars();
    _initializePlanets();
    _initializeParticles();
  }

  void _initializeStars() {
    // Create 150 stars with random positions and sizes
    for (int i = 0; i < 150; i++) {
      _stars.add(Star(
        x: _random.nextDouble(),
        y: _random.nextDouble(),
        size: _random.nextDouble() * 2 + 0.5,
        brightness: _random.nextDouble(),
        twinkleSpeed: _random.nextDouble() * 2 + 1,
      ));
    }
  }

  void _initializePlanets() {
    // Create 5 planets with different properties
    _planets.addAll([
      Planet(
        orbitRadius: 0.15,
        size: 40,
        color: Colors.orange.withOpacity(0.7),
        speed: 1.0,
        angle: 0,
      ),
      Planet(
        orbitRadius: 0.25,
        size: 30,
        color: Colors.purple.withOpacity(0.6),
        speed: 0.7,
        angle: math.pi / 2,
      ),
      Planet(
        orbitRadius: 0.35,
        size: 50,
        color: Colors.blue.withOpacity(0.5),
        speed: 0.5,
        angle: math.pi,
      ),
      Planet(
        orbitRadius: 0.42,
        size: 25,
        color: Colors.tealAccent.withOpacity(0.6),
        speed: 0.3,
        angle: math.pi * 1.5,
      ),
      Planet(
        orbitRadius: 0.48,
        size: 35,
        color: Colors.pinkAccent.withOpacity(0.5),
        speed: 0.2,
        angle: math.pi / 4,
      ),
    ]);
  }

  void _initializeParticles() {
    // Create 50 particles for quantum effects
    for (int i = 0; i < 50; i++) {
      _particles.add(Particle(
        x: _random.nextDouble(),
        y: _random.nextDouble(),
        size: _random.nextDouble() * 3 + 1,
        speedX: (_random.nextDouble() - 0.5) * 0.002,
        speedY: (_random.nextDouble() - 0.5) * 0.002,
        color: Colors.cyan.withOpacity(_random.nextDouble() * 0.5 + 0.3),
      ));
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    _particleController.dispose();
    _quantumController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // Deep space gradient background
        Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Color(0xFF0A0E27),
                Color(0xFF1A1F3A),
                Color(0xFF0F1628),
                Color(0xFF1E0B3D),
              ],
              stops: [0.0, 0.3, 0.7, 1.0],
            ),
          ),
        ),
        
        // Animated cosmic effects
        if (widget.enableAnimations) ...[
          // Stars layer
          AnimatedBuilder(
            animation: _quantumController,
            builder: (context, child) {
              return CustomPaint(
                painter: StarfieldPainter(
                  stars: _stars,
                  animationValue: _quantumController.value,
                ),
                size: Size.infinite,
              );
            },
          ),

          // Planets layer
          AnimatedBuilder(
            animation: _controller,
            builder: (context, child) {
              return CustomPaint(
                painter: PlanetsPainter(
                  planets: _planets,
                  animationValue: _controller.value,
                ),
                size: Size.infinite,
              );
            },
          ),

          // Particle effects layer
          AnimatedBuilder(
            animation: _particleController,
            builder: (context, child) {
              return CustomPaint(
                painter: ParticlesPainter(
                  particles: _particles,
                  animationValue: _particleController.value,
                ),
                size: Size.infinite,
              );
            },
          ),

          // Quantum wave effects
          AnimatedBuilder(
            animation: _quantumController,
            builder: (context, child) {
              return CustomPaint(
                painter: QuantumWavesPainter(
                  animationValue: _quantumController.value,
                ),
                size: Size.infinite,
              );
            },
          ),
        ],

        // Content overlay
        widget.child,
      ],
    );
  }
}

// Star model
class Star {
  final double x;
  final double y;
  final double size;
  final double brightness;
  final double twinkleSpeed;

  Star({
    required this.x,
    required this.y,
    required this.size,
    required this.brightness,
    required this.twinkleSpeed,
  });
}

// Planet model
class Planet {
  final double orbitRadius;
  final double size;
  final Color color;
  final double speed;
  final double angle;

  Planet({
    required this.orbitRadius,
    required this.size,
    required this.color,
    required this.speed,
    required this.angle,
  });
}

// Particle model
class Particle {
  double x;
  double y;
  final double size;
  final double speedX;
  final double speedY;
  final Color color;

  Particle({
    required this.x,
    required this.y,
    required this.size,
    required this.speedX,
    required this.speedY,
    required this.color,
  });

  void update() {
    x += speedX;
    y += speedY;

    // Wrap around screen edges
    if (x < 0) x = 1;
    if (x > 1) x = 0;
    if (y < 0) y = 1;
    if (y > 1) y = 0;
  }
}

// Starfield painter
class StarfieldPainter extends CustomPainter {
  final List<Star> stars;
  final double animationValue;

  StarfieldPainter({
    required this.stars,
    required this.animationValue,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..style = PaintingStyle.fill;

    for (final star in stars) {
      final x = star.x * size.width;
      final y = star.y * size.height;
      
      // Twinkling effect
      final twinkle = (math.sin(animationValue * math.pi * 2 * star.twinkleSpeed) + 1) / 2;
      final opacity = star.brightness * twinkle;
      
      paint.color = Colors.white.withOpacity(opacity);
      canvas.drawCircle(Offset(x, y), star.size, paint);
      
      // Glow effect for brighter stars
      if (star.brightness > 0.7) {
        paint.color = Colors.white.withOpacity(opacity * 0.3);
        canvas.drawCircle(Offset(x, y), star.size * 2, paint);
      }
    }
  }

  @override
  bool shouldRepaint(StarfieldPainter oldDelegate) => true;
}

// Planets painter
class PlanetsPainter extends CustomPainter {
  final List<Planet> planets;
  final double animationValue;

  PlanetsPainter({
    required this.planets,
    required this.animationValue,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final centerX = size.width / 2;
    final centerY = size.height / 2;

    for (final planet in planets) {
      // Calculate planet position in orbit
      final angle = planet.angle + (animationValue * math.pi * 2 * planet.speed);
      final orbitX = math.cos(angle) * planet.orbitRadius * size.width;
      final orbitY = math.sin(angle) * planet.orbitRadius * size.height * 0.7;
      
      final x = centerX + orbitX;
      final y = centerY + orbitY;

      // Draw planet with gradient
      final paint = Paint()..style = PaintingStyle.fill;
      final rect = Rect.fromCircle(center: Offset(x, y), radius: planet.size / 2);
      
      paint.shader = RadialGradient(
        colors: [
          planet.color.withOpacity(1.0),
          planet.color.withOpacity(0.3),
        ],
        stops: [0.0, 1.0],
      ).createShader(rect);
      
      canvas.drawCircle(Offset(x, y), planet.size / 2, paint);

      // Draw orbit path (faint)
      final orbitPaint = Paint()
        ..color = planet.color.withOpacity(0.1)
        ..style = PaintingStyle.stroke
        ..strokeWidth = 1;
      
      canvas.drawOval(
        Rect.fromCenter(
          center: Offset(centerX, centerY),
          width: planet.orbitRadius * size.width * 2,
          height: planet.orbitRadius * size.height * 0.7 * 2,
        ),
        orbitPaint,
      );

      // Draw planet glow
      final glowPaint = Paint()
        ..shader = RadialGradient(
          colors: [
            planet.color.withOpacity(0.3),
            planet.color.withOpacity(0.0),
          ],
          stops: [0.0, 1.0],
        ).createShader(Rect.fromCircle(center: Offset(x, y), radius: planet.size));
      
      canvas.drawCircle(Offset(x, y), planet.size, glowPaint);
    }
  }

  @override
  bool shouldRepaint(PlanetsPainter oldDelegate) => true;
}

// Particles painter for quantum effects
class ParticlesPainter extends CustomPainter {
  final List<Particle> particles;
  final double animationValue;

  ParticlesPainter({
    required this.particles,
    required this.animationValue,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..style = PaintingStyle.fill;

    // Update and draw particles
    for (final particle in particles) {
      particle.update();
      
      final x = particle.x * size.width;
      final y = particle.y * size.height;
      
      // Draw particle
      paint.color = particle.color;
      canvas.drawCircle(Offset(x, y), particle.size, paint);
      
      // Draw quantum trail effect
      final trailPaint = Paint()
        ..shader = RadialGradient(
          colors: [
            particle.color.withOpacity(0.5),
            particle.color.withOpacity(0.0),
          ],
        ).createShader(Rect.fromCircle(center: Offset(x, y), radius: particle.size * 3));
      
      canvas.drawCircle(Offset(x, y), particle.size * 3, trailPaint);
    }
  }

  @override
  bool shouldRepaint(ParticlesPainter oldDelegate) => true;
}

// Quantum waves painter for energy field effects
class QuantumWavesPainter extends CustomPainter {
  final double animationValue;

  QuantumWavesPainter({required this.animationValue});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2;

    // Draw multiple wave patterns
    for (int i = 0; i < 3; i++) {
      final path = Path();
      final waveOffset = animationValue * math.pi * 2 + (i * math.pi / 3);
      final amplitude = 30.0 + (i * 10);
      final frequency = 0.02 + (i * 0.01);
      final opacity = 0.15 - (i * 0.03);

      paint.color = Colors.cyanAccent.withOpacity(opacity);

      path.moveTo(0, size.height / 2);

      for (double x = 0; x <= size.width; x += 5) {
        final y = size.height / 2 +
            math.sin(x * frequency + waveOffset) * amplitude;
        path.lineTo(x, y);
      }

      canvas.drawPath(path, paint);
    }

    // Draw energy field lines
    paint.strokeWidth = 1;
    for (int i = 0; i < 5; i++) {
      final y = (size.height / 6) * (i + 1);
      final offset = math.sin(animationValue * math.pi * 2 + i) * 20;
      
      paint.color = Colors.purpleAccent.withOpacity(0.1);
      canvas.drawLine(
        Offset(0, y + offset),
        Offset(size.width, y + offset),
        paint,
      );
    }
  }

  @override
  bool shouldRepaint(QuantumWavesPainter oldDelegate) => true;
}
