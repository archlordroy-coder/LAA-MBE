import 'package:flutter/material.dart';

class WhatsAppScreen extends StatelessWidget {
  const WhatsAppScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('WhatsApp')),
      body: const Center(child: Text('WhatsApp Web Integration (Phase 4)')),
    );
  }
}
