import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:nachsorgecompass/providers/EmailFormProvider.dart';
import 'package:provider/provider.dart';

import 'app.dart';

Future<void> main() async {
  await dotenv.load(fileName: 'assets/.env');
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => EmailStepperProvider()),
      ],
      child: const StepperApp(),
    ),
  );
}
