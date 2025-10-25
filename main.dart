// main.dart
// App completo listo para ejecutar.
// Importa 'vital_widget.dart' (está en el mismo directorio).

import 'package:flutter/material.dart';
import 'vital_widget.dart';
import 'cosmic_background.dart';

void main() {
  runApp(FrecuenciaVitalApp());
}

class FrecuenciaVitalApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Frecuencia Vital',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.dark,
        primarySwatch: Colors.teal,
        useMaterial3: true,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => HomeScreen(),
        '/detector': (context) => Scaffold(
              extendBodyBehindAppBar: true,
              appBar: AppBar(
                title: Text('Detector - Frecuencia Vital'),
                backgroundColor: Colors.transparent,
                elevation: 0,
              ),
              body: CosmicBackground(
                child: SafeArea(
                  child: Container(
                    padding: EdgeInsets.all(16),
                    child: VitalWidget(),
                  ),
                ),
              ),
            ),
      },
    );
  }
}

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: Text('Frecuencia Vital'),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: CosmicBackground(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(18.0),
            child: Column(
              children: [
                Expanded(
                  child: Center(
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                      decoration: BoxDecoration(
                        color: Colors.black.withOpacity(0.3),
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(
                          color: Colors.tealAccent.withOpacity(0.3),
                          width: 1,
                        ),
                      ),
                      child: Text(
                        'Bienvenido a Frecuencia Vital',
                        style: TextStyle(fontSize: 24, fontWeight: FontWeight.w600),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton.icon(
                    icon: Icon(Icons.play_circle_fill),
                    label: Text('Abrir Detector'),
                    onPressed: () => Navigator.pushNamed(context, '/detector'),
                    style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.symmetric(vertical: 14),
                      backgroundColor: Colors.tealAccent.withOpacity(0.8),
                      foregroundColor: Colors.black,
                    ),
                  ),
                ),
                SizedBox(height: 12),
                Container(
                  padding: EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.3),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    'Hecho para integrarse o ejecutarse como app completa.',
                    textAlign: TextAlign.center,
                  ),
                ),
                SizedBox(height: 18),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
