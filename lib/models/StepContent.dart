import 'package:flutter/cupertino.dart';

class StepContent {
  final IconData icon;
  final String title;
  final String introText;
  final String content;
  final List<String>? bulletPoints;

  StepContent({
    required this.icon,
    required this.title,
    required this.introText,
    required this.content,
    this.bulletPoints,
  });
}
