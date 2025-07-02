import 'package:flutter/material.dart';
import 'package:pigym/dto/challenge_config.dart';

class ChallengeScreen extends StatelessWidget {
  final ChallengeConfig config;

  const ChallengeScreen({super.key, required this.config});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Challenge')),
      body: Center(child: const Text('Challenge')),
    );
  }
}
