import "package:flutter/material.dart";
import 'package:pigym/screens/challenge_form_screen.dart';

class ChallengeScreen extends StatelessWidget {
  const ChallengeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Challenge')),
      body: Center(child: const Text('Challenge')),
    );
  }
}
