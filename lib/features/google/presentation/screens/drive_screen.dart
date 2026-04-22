import 'package:flutter/material.dart';
import 'package:laa_mbe/core/theme/app_theme.dart';

class DriveScreen extends StatelessWidget {
  const DriveScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Google Drive')),
      body: const Center(child: Text('Explorateur de fichiers Google Drive (Phase 3)')),
    );
  }
}
