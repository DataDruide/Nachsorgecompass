import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class LegalFooter extends StatelessWidget {
  const LegalFooter({super.key});

  void _showBottomSheet(BuildContext context, String title, String content) {
    showModalBottomSheet(
      context: context,
      showDragHandle: true,
      isScrollControlled: true,
      backgroundColor: Colors.white,
      useSafeArea: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
      ),
      builder: (context) => FractionallySizedBox(
        heightFactor: 0.85,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
          child: Column(
            children: [
              Text(
                title,
                style: GoogleFonts.nunito(
                  fontSize: 24,
                  fontWeight: FontWeight.w700,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 20),
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.only(bottom: 24),
                  child: Text(
                    content,
                    style: GoogleFonts.nunito(fontSize: 17, height: 1.5),
                    textAlign: TextAlign.justify,
                  ),
                ),
              ),
              FilledButton(
                style: FilledButton.styleFrom(
                  minimumSize: const Size.fromHeight(48),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                  textStyle: GoogleFonts.nunito(fontSize: 16),
                ),
                onPressed: () => Navigator.pop(context),
                child: const Text('Schließen'),
              ),
            ],
          ),
        ),
      ),
    );
  }
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 28),
      child: Wrap(
        alignment: WrapAlignment.center,
        spacing: 24,
        children: [
          TextButton(
            onPressed: () => _showBottomSheet(
              context,
              'Datenschutzerklärung',
              '''
Wir freuen uns über dein Interesse an Nachsorge Engel.

**1. Welche Daten werden verarbeitet?**
Wir erheben ausschließlich deine E-Mail-Adresse, um dir Terminvorschläge und Beratungsinformationen zukommen zu lassen.

**2. Zweck der Verarbeitung**
Die E-Mail dient ausschließlich der Kontaktaufnahme und Terminvereinbarung. Es erfolgt keine Weitergabe an Dritte.

**3. Rechtsgrundlage**
Rechtsgrundlage ist Art. 6 Abs. 1 lit. a DSGVO (Einwilligung).

**4. Speicherdauer**
Deine E-Mail-Adresse wird nur so lange gespeichert, wie es zur Kontaktaufnahme erforderlich ist. Danach wird sie gelöscht.

**5. Verantwortlicher**
Nachsorge Engel, Marcel Zimmermann  
E-Mail: kontakt@nachsorge-engel.de

**6. Deine Rechte**
Du hast das Recht auf Auskunft, Berichtigung, Löschung und Widerspruch (Art. 15–21 DSGVO). Wende dich dazu einfach per E-Mail an uns.

Mit der Nutzung dieser App stimmst du der beschriebenen Datenverarbeitung zu.
            ''',
            ),
            style: TextButton.styleFrom(
              textStyle: GoogleFonts.nunito(fontSize: 14, fontWeight: FontWeight.w500),
            ),
            child: const Text('Datenschutz'),
          ),
          TextButton(
            onPressed: () => _showBottomSheet(
              context,
              'Impressum',
              '''
Angaben gemäß § 5 TMG

Nachsorge Engel  
Marcel Zimmermann  
Musterstraße 1  
12345 Berlin  
Deutschland

E-Mail: kontakt@nachsorge-engel.de  
Tel: +49 123 4567890

Verantwortlich für den Inhalt nach § 55 Abs. 2 RStV:  
Marcel Zimmermann

Umsatzsteuer-ID: DE123456789 (falls vorhanden)

Hinweis: Wir übernehmen keine Haftung für externe Links. Für den Inhalt verlinkter Seiten sind ausschließlich deren Betreiber verantwortlich.
            ''',
            ),
            style: TextButton.styleFrom(
              textStyle: GoogleFonts.nunito(fontSize: 14, fontWeight: FontWeight.w500),
            ),
            child: const Text('Impressum'),
          ),
        ],
      ),
    );
  }

}
