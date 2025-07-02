import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:pigym/dto/challenge_config.dart';

class ChallengeFormScreen extends StatefulWidget {
  const ChallengeFormScreen({super.key});

  @override
  State<ChallengeFormScreen> createState() => _ChallengeFormScreenState();
}

class _ChallengeFormScreenState extends State<ChallengeFormScreen> {
  final _formKey = GlobalKey<FormState>();

  final Map<String, TextEditingController> _controllers = {
    'hints': TextEditingController(),
    'startingDigit': TextEditingController(),
    'mistakes': TextEditingController(),
    'digits': TextEditingController(),
  };

  void _submitForm() {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    var config = ChallengeConfig();
    final hintsText = _controllers['hints']!.text;
    final startingDigitText = _controllers['startingDigit']!.text;
    final mistakesText = _controllers['mistakes']!.text;
    final digitsText = _controllers['digits']!.text;

    if (hintsText.isNotEmpty) {
      config = config.copyWith(hintsAllowed: int.tryParse(hintsText));
    }

    if (startingDigitText.isNotEmpty) {
      config = config.copyWith(startingDigit: int.tryParse(startingDigitText));
    }

    if (mistakesText.isNotEmpty) {
      config = config.copyWith(mistakesAllowed: int.tryParse(mistakesText));
    }

    if (digitsText.isNotEmpty) {
      config = config.copyWith(digitsToGuess: int.tryParse(digitsText));
    }

    context.go('/challenge-form/challenge', extra: config);
  }

  void _resetForm() {
    _controllers.forEach((key, controller) => controller.clear());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('New challenge'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                _buildTextFormField(
                  id: 'hints',
                  context: context,
                  label: 'Hints allowed',
                  hint: 'Leave blank to disallow any hints',
                ),
                const SizedBox(height: 20),
            
                _buildTextFormField(
                  id: 'startingDigit',
                  context: context,
                  label: 'Starting digit',
                  hint: 'Leave blank to start at the beginning',
                ),
                const SizedBox(height: 20),
            
                _buildTextFormField(
                  id: 'mistakes',
                  context: context,
                  label: 'Mistakes allowed',
                  hint: 'Leave blank to allow unlimited mistakes',
                ),
                const SizedBox(height: 20),
            
                _buildTextFormField(
                  id: 'digits',
                  context: context,
                  label: 'Digits to guess',
                  hint: 'Leave blank for endless digits',
                ),
                const SizedBox(height: 40),
            
                Row(
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () => _submitForm(),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Theme.of(context).colorScheme.primary,
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          textStyle: const TextStyle(fontSize: 20),
                        ),
                        child: const Text('Start'),
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: OutlinedButton(
                        onPressed: () => _resetForm(),
                        style: OutlinedButton.styleFrom(
                          foregroundColor: Theme.of(context).colorScheme.secondary,
                          side: BorderSide(
                            color: Theme.of(context).colorScheme.secondary,
                          ),
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          textStyle: const TextStyle(fontSize: 20),
                        ),
                        child: const Text('Reset'),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _controllers.forEach((key, controller) => controller.dispose());
    super.dispose();
  }

  Widget _buildTextFormField({
    required BuildContext context,
    required String label,
    required String hint,
    required String id,
  }) {
    final theme = Theme.of(context);
    final controller = _controllers[id];

    return TextFormField(
      controller: controller,
      keyboardType: TextInputType.number,
      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
      style: TextStyle(color: theme.colorScheme.onSurface, fontSize: 18),
      cursorColor: Theme.of(context).colorScheme.secondary,
      decoration: InputDecoration(
        labelText: label,
        labelStyle: TextStyle(color: Colors.grey[400]),
        hintText: hint,
        hintStyle: TextStyle(color: Colors.grey[400]),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: theme.colorScheme.outline),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: theme.colorScheme.secondary),
        ),
      ),
    );
  }
}