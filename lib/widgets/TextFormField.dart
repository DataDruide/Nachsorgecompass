import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../core/validators/email_validator.dart';
import '../providers/EmailFormProvider.dart';

class EmailTextField extends StatelessWidget {
  final String label;
  final String hint;

  const EmailTextField({
    super.key,
    this.label = 'E-Mail-Adresse',
    this.hint = 'z. B. max@example.com',
  });

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<EmailStepperProvider>(context);

    return TextFormField(
      controller: provider.emailController,
      keyboardType: TextInputType.emailAddress,
      autofillHints: const [AutofillHints.email],
      textInputAction: TextInputAction.done,
      maxLength: 100,
      decoration: InputDecoration(
        labelText: label,
        hintText: hint,
        border: const OutlineInputBorder(),
        counterText: '',
      ),
      validator: (value) {
        final email = value?.trim() ?? '';
        if (email.isEmpty) return 'E-Mail darf nicht leer sein';
        if (!EmailValidator.isValid(email)) return 'Bitte gültige E-Mail-Adresse eingeben';
        return null;
      },
    );
  }
}
