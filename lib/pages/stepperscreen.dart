import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

import '../models/StepContent.dart';
import '../providers/EmailFormProvider.dart';
import '../widgets/LegalFooter.dart';
import '../widgets/TextFormField.dart';

final List<StepContent> stepContents = [
  StepContent(
    icon: Icons.group_outlined,
    title: 'Wer wir sind',
    introText: 'Nachsorge Engel – Ihre individuelle Beratung',
    content: 'Wir sind ein Service zur Unterstützung Pflegender und Angehöriger.',
    bulletPoints: [
      'Medizin & Pflege – das Beste vereint',
      'Empathie – wir hören dir wirklich zu',
      'Anlaufstelle – dein persönlicher Dreh- und Angelpunkt'
    ],
  ),
  StepContent(
    icon: Icons.handshake_outlined,
    title: 'Was machen wir',
    introText: 'Wir helfen dir im Pflege-Dschungel',
    content: 'Von Pflegegrad bis Kur – wir begleiten dich persönlich durch alle Anträge.',
    bulletPoints: [
      'Beratung – individuell vor & nach der Reha',
      'Koordination – bestmögliche Versorgung',
      'Bürokratie – übernehmen wir für dich'
    ],
  ),
  StepContent(
    icon: Icons.email,
    title: 'E-Mail senden',
    introText: 'Trage deine E-Mail-Adresse ein',
    content: 'Wir senden dir mögliche Termine zur Auswahl.',
    bulletPoints: ['Schnell – Anfrage in 1 Minute', 'Einfach – ohne Registrierung'],
  ),
];

class StepperScreen extends StatefulWidget {
  const StepperScreen({super.key});

  @override
  State<StepperScreen> createState() => _StepperScreenState();
}

class _StepperScreenState extends State<StepperScreen> {
  int _currentStep = 0;
  final PageController _pageController = PageController();
  final List<GlobalKey<FormState>> _formKeys =
  List.generate(stepContents.length, (_) => GlobalKey<FormState>());

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<EmailStepperProvider>(context);
    final isLoading = provider.status == EmailStepperStatus.loading;
    final isError = provider.status == EmailStepperStatus.error;
    final isSuccess = provider.status == EmailStepperStatus.success;
    final isLast = _currentStep == stepContents.length - 1;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        minimum: const EdgeInsets.only(top: 32),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: LinearProgressIndicator(
                value: (_currentStep + 1) / stepContents.length,
                color: Colors.teal,
                backgroundColor: Colors.teal.shade50,
                minHeight: 4,
              ),
            ),
            const SizedBox(height: 12),
            Expanded(
              child: PageView.builder(
                controller: _pageController,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: stepContents.length,
                itemBuilder: (context, index) {
                  final step = stepContents[index];

                  return Stack(
                    fit: StackFit.expand,
                    children: [
                      if (isLast && isSuccess)
                        Lottie.asset('assets/animations/success.json', fit: BoxFit.cover, repeat: false),
                      Center(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 24),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(step.icon, size: 48, color: Colors.teal),
                              const SizedBox(height: 24),
                              Text(
                                step.title,
                                style: GoogleFonts.nunito(
                                  fontSize: 28,
                                  fontWeight: FontWeight.w700,
                                ),
                                textAlign: TextAlign.center,
                              ),
                              if (step.introText.isNotEmpty) ...[
                                const SizedBox(height: 16),
                                Text(
                                  step.introText,
                                  style: GoogleFonts.nunito(
                                    fontSize: 20,
                                    fontWeight: FontWeight.w600,
                                    height: 1.4,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ],
                              if (step.content.isNotEmpty) ...[
                                const SizedBox(height: 12),
                                Text(
                                  step.content,
                                  style: GoogleFonts.nunito(
                                    fontSize: 18,
                                    height: 1.5,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ],
                              if (step.bulletPoints != null)
                                ...step.bulletPoints!.map(
                                      (point) {
                                    final parts = point.split('–');
                                    final bold = parts[0].trim();
                                    final normal = parts.length > 1 ? parts[1].trim() : '';

                                    return Padding(
                                      padding: const EdgeInsets.only(top: 12),
                                      child: Row(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          const Icon(Icons.check_circle_rounded, size: 20, color: Colors.green),
                                          const SizedBox(width: 12),
                                          Expanded(
                                            child: RichText(
                                              text: TextSpan(
                                                style: GoogleFonts.nunito(
                                                  fontSize: 16,
                                                  color: Colors.black,
                                                  height: 1.6,
                                                ),
                                                children: [
                                                  TextSpan(
                                                    text: '$bold ',
                                                    style: const TextStyle(fontWeight: FontWeight.w600),
                                                  ),
                                                  if (normal.isNotEmpty)
                                                    TextSpan(
                                                      text: normal,
                                                      style: const TextStyle(fontWeight: FontWeight.w400),
                                                    ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    );
                                  },
                                ),
                              if (isLast && !isSuccess)
                                Form(
                                  key: _formKeys[index],
                                  child: Column(
                                    children: [
                                      const SizedBox(height: 24),
                                      const EmailTextField(),
                                      const SizedBox(height: 16),
                                      Text(
                                        'Wir melden uns umgehend bei dir.',
                                        style: GoogleFonts.nunito(fontSize: 16),
                                        textAlign: TextAlign.center,
                                      ),
                                      if (provider.errorMessage != null && isError)
                                        Padding(
                                          padding: const EdgeInsets.only(top: 16),
                                          child: Text(
                                            provider.errorMessage!,
                                            style: const TextStyle(color: Colors.red),
                                          ),
                                        ),
                                    ],
                                  ),
                                ),
                              const SizedBox(height: 40),
                              if (!(isLast && isSuccess))
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    if (_currentStep > 0)
                                      TextButton(
                                        onPressed: () {
                                          setState(() => _currentStep--);
                                          _pageController.previousPage(
                                            duration: const Duration(milliseconds: 300),
                                            curve: Curves.easeInOut,
                                          );
                                        },
                                        child: const Text('Zurück'),
                                      ),
                                    const SizedBox(width: 12),
                                    FilledButton(
                                      onPressed: isLoading
                                          ? null
                                          : () async {
                                        if (isLast) {
                                          if (_formKeys[index].currentState!.validate()) {
                                            await provider.sendEmailRequest();
                                            if (provider.status == EmailStepperStatus.success) {
                                              setState(() => _currentStep++);
                                              _pageController.nextPage(
                                                duration: const Duration(milliseconds: 300),
                                                curve: Curves.easeInOut,
                                              );
                                            }
                                          }
                                        } else {
                                          setState(() => _currentStep++);
                                          _pageController.nextPage(
                                            duration: const Duration(milliseconds: 300),
                                            curve: Curves.easeInOut,
                                          );
                                        }
                                      },
                                      child: isLoading
                                          ? const SizedBox(
                                        width: 20,
                                        height: 20,
                                        child: CircularProgressIndicator(strokeWidth: 2),
                                      )
                                          : Text(isLast ? 'Absenden' : 'Weiter'),
                                    ),
                                  ],
                                ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
            const LegalFooter(),
          ],
        ),
      ),
    );
  }
}
