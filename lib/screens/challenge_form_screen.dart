import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';

class ChallengeFormScreen extends StatelessWidget {
  const ChallengeFormScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('New challenge'),
        // backgroundColor: Colors.grey[850],
      ),
      // backgroundColor: Colors.grey[900],
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Hints Allowed Field
              _buildTextFormField(
                label: 'Hints allowed',
                hint: 'Leave blank to disallow any hints',
              ),
              const SizedBox(height: 20),

              // Starting Digit Field
              _buildTextFormField(
                label: 'Starting digit',
                hint: 'Leave blank to start at the beginning',
              ),
              const SizedBox(height: 20),

              // Mistakes Allowed Field
              _buildTextFormField(
                label: 'Mistakes allowed',
                hint: 'Leave blank to allow unlimited mistakes',
              ),
              const SizedBox(height: 20),

              // Digits to Guess Field
              _buildTextFormField(
                label: 'Digits to guess',
                hint: 'Leave blank for endless digits',
              ),
              const SizedBox(height: 40),

              // Action Buttons
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        // Handle start action
                        context.go('/challenge-form/challenge');
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green[700],
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        textStyle: const TextStyle(fontSize: 16),
                      ),
                      child: const Text('Start'),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () {
                        // Handle reset action
                      },
                      style: OutlinedButton.styleFrom(
                        foregroundColor: Colors.blue[300],
                        side: BorderSide(color: Colors.blue[300]!),
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        textStyle: const TextStyle(fontSize: 16),
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
    );
  }

  // Helper method to build a consistent TextFormField
  Widget _buildTextFormField({required String label, required String hint}) {
    return TextFormField(
      keyboardType: TextInputType.number,
      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
      style: const TextStyle(color: Colors.white, fontSize: 18),
      decoration: InputDecoration(
        labelText: label,
        labelStyle: TextStyle(color: Colors.grey[400]),
        hintText: hint,
        hintStyle: TextStyle(color: Colors.grey[600]),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.grey[700]!),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.blue[300]!),
        ),
      ),
    );
  }
}
