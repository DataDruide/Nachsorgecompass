import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;

import '../config/env.dart';
import '../core/validators/email_validator.dart';

enum EmailStepperStatus {
  idle,
  loading,
  success,
  error,
}

class EmailStepperProvider with ChangeNotifier {
  final emailController = TextEditingController();

  EmailStepperStatus status = EmailStepperStatus.idle;
  String? errorMessage;

  Future<void> sendEmailRequest() async {
    final email = emailController.text.trim();

    if (!EmailValidator.isValid(email)) {
      errorMessage = 'Bitte gib eine gültige E-Mail-Adresse ein.';
      status = EmailStepperStatus.error;
      notifyListeners();
      return;
    }

    status = EmailStepperStatus.loading;
    errorMessage = null;
    notifyListeners();
    HapticFeedback.mediumImpact();

    try {
      final response = await http
          .post(
        Uri.parse('${Env.backendUrl}/mail/welcome'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'email': email}),
      )
          .timeout(const Duration(seconds: 10));

      if (response.statusCode >= 200 && response.statusCode < 300) {
        status = EmailStepperStatus.success;
        emailController.clear();
      } else if (response.statusCode == 400) {
        errorMessage = 'Ungültige Anfrage. Bitte überprüfe deine Eingabe.';
        status = EmailStepperStatus.error;
      } else if (response.statusCode == 409) {
        errorMessage = 'Diese E-Mail-Adresse ist bereits registriert.';
        status = EmailStepperStatus.error;
      } else {
        errorMessage = 'Serverfehler: ${response.statusCode}';
        status = EmailStepperStatus.error;
      }
    } catch (e) {
      debugPrint('Verbindungsfehler: $e');
      errorMessage = 'Keine Verbindung zum Server. Bitte versuche es später erneut.';
      status = EmailStepperStatus.error;
    }

    notifyListeners();
  }

  void reset() {
    emailController.clear();
    status = EmailStepperStatus.idle;
    errorMessage = null;
    notifyListeners();
  }

  @override
  void dispose() {
    emailController.dispose();
    super.dispose();
  }
}
