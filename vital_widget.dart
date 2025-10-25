// vital_widget.dart
// Widget principal para el detector de frecuencia vital

import 'package:flutter/material.dart';

class VitalWidget extends StatefulWidget {
  @override
  _VitalWidgetState createState() => _VitalWidgetState();
}

class _VitalWidgetState extends State<VitalWidget> {
  double _frequency = 528.0; // Frecuencia base (Hz)
  bool _isActive = false;

  void _toggleActive() {
    setState(() {
      _isActive = !_isActive;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        padding: EdgeInsets.all(24),
        decoration: BoxDecoration(
          color: Colors.black.withOpacity(0.4),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: _isActive ? Colors.tealAccent.withOpacity(0.6) : Colors.white.withOpacity(0.2),
            width: 2,
          ),
          boxShadow: [
            BoxShadow(
              color: _isActive ? Colors.tealAccent.withOpacity(0.3) : Colors.transparent,
              blurRadius: 20,
              spreadRadius: 2,
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Frecuencia Actual',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w300),
            ),
            SizedBox(height: 20),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 32, vertical: 16),
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.5),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: _isActive ? Colors.tealAccent : Colors.white24,
                  width: 1,
                ),
              ),
              child: Text(
                '${_frequency.toStringAsFixed(0)} Hz',
                style: TextStyle(
                  fontSize: 48,
                  fontWeight: FontWeight.bold,
                  color: _isActive ? Colors.tealAccent : Colors.white70,
                  shadows: _isActive ? [
                    Shadow(
                      color: Colors.tealAccent,
                      blurRadius: 10,
                    ),
                  ] : null,
                ),
              ),
            ),
            SizedBox(height: 40),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 16),
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.3),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Slider(
                value: _frequency,
                min: 174.0,
                max: 963.0,
                divisions: 789,
                label: '${_frequency.toStringAsFixed(0)} Hz',
                activeColor: Colors.tealAccent,
                inactiveColor: Colors.white24,
                onChanged: (value) {
                  setState(() {
                    _frequency = value;
                  });
                },
              ),
            ),
            SizedBox(height: 40),
            ElevatedButton.icon(
              onPressed: _toggleActive,
              icon: Icon(_isActive ? Icons.stop : Icons.play_arrow),
              label: Text(_isActive ? 'Detener' : 'Iniciar'),
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(horizontal: 40, vertical: 16),
                backgroundColor: _isActive ? Colors.redAccent : Colors.tealAccent,
                foregroundColor: Colors.black,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
            ),
            if (_isActive) ...[
              SizedBox(height: 30),
              CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(Colors.tealAccent),
              ),
              SizedBox(height: 10),
              Text(
                'Analizando frecuencia...',
                style: TextStyle(
                  color: Colors.tealAccent,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
