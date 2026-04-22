import 'package:flutter/material.dart';

class GmailScreen extends StatelessWidget {
  const GmailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Gmail')),
      body: const Center(child: Text('Messagerie Gmail (Phase 3)')),
    );
  }
}
