// main.dart
// App completo listo para ejecutar.
// Importa 'vital_widget.dart' (está en el mismo directorio).

import 'package:flutter/material.dart';
import 'vital_widget.dart';

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
              appBar: AppBar(title: Text('Detector - Frecuencia Vital')),
              body: Center(child: VitalWidget()),
            ),
      },
    );
  }
}

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Frecuencia Vital'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(18.0),
        child: Column(
          children: [
            Expanded(
              child: Center(
                child: Text(
                  'Bienvenido a Frecuencia Vital',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.w600),
                  textAlign: TextAlign.center,
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
                ),
              ),
            ),
            SizedBox(height: 12),
            Text(
              'Hecho para integrarse o ejecutarse como app completa.',
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 18),
          ],
        ),
      ),
    );
  }
}
