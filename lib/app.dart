import 'package:flutter/material.dart';
import 'package:nachsorgecompass/pages/stepperscreen.dart';

class StepperApp extends StatelessWidget {
  const StepperApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Termin-Stepper',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorSchemeSeed: Colors.teal,
        scaffoldBackgroundColor: Colors.white,
      ),
      home: const StepperScreen(),
    );
  }
}
