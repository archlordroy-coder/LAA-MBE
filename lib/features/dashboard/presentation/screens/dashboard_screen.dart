import 'package:flutter/material.dart';
import 'package:laa_mbe/core/theme/app_theme.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Padding(
        padding: const EdgeInsets.all(32.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Mbeu’n lɑ’ 👋', // "Good morning" in Ghomala (approximate)
                style: Theme.of(context).textTheme.displaySmall?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: AppTheme.indigoNdop,
                ),
              ),
              const SizedBox(height: 8),
              const Text(
                'L’intelligence locale au service du collectif.',
                style: TextStyle(color: Colors.grey, fontStyle: FontStyle.italic),
              ),
              const SizedBox(height: 32),

              // AI Summary (Ndop inspired card)
              _buildSectionCard(
                title: 'Résumé IA du matin',
                child: const Text(
                  'Vous avez 3 réunions aujourd\'hui. Votre document \"Stratégie 2025\" a été commenté par 2 collaborateurs. N\'oubliez pas de répondre au message urgent de Jean sur WhatsApp.',
                  style: TextStyle(height: 1.5, fontSize: 15),
                ),
                color: AppTheme.indigoNdop.withOpacity(0.05),
                borderColor: AppTheme.indigoNdop.withOpacity(0.2),
              ),

              const SizedBox(height: 24),

              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Agenda
                  Expanded(
                    flex: 2,
                    child: _buildSectionCard(
                      title: 'Agenda du jour',
                      child: Column(
                        children: [
                          _buildListItem(Icons.access_time, '09:00 - Daily Standup', 'Lien Meet joint'),
                          _buildListItem(Icons.access_time, '11:00 - Revue de Projet', 'Salle de conférence B'),
                          _buildListItem(Icons.access_time, '14:30 - Entretien Candidat', 'Lien Meet joint'),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(width: 24),
                  // Recent Files
                  Expanded(
                    flex: 2,
                    child: _buildSectionCard(
                      title: 'Fichiers récents',
                      child: Column(
                        children: [
                          _buildListItem(Icons.description_outlined, 'Cahier des charges v3.0', 'Modifié il y a 2h'),
                          _buildListItem(Icons.table_chart_outlined, 'Budget Q3', 'Modifié hier'),
                          _buildListItem(Icons.slideshow_outlined, 'Présentation Client', 'Modifié hier'),
                        ],
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 24),

              // Badges section
              Row(
                children: [
                  _buildCountBadge('WhatsApp', '5 messages', Colors.green),
                  const SizedBox(width: 16),
                  _buildCountBadge('Gmail', '12 nouveaux', AppTheme.redCola),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSectionCard({required String title, required Widget child, Color? color, Color? borderColor}) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: color ?? Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: borderColor ?? AppTheme.indigoNdop.withOpacity(0.05)),
        boxShadow: [
          BoxShadow(
            color: AppTheme.indigoNdop.withOpacity(0.02),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 4,
                height: 20,
                decoration: BoxDecoration(
                  color: AppTheme.redCola,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              const SizedBox(width: 12),
              Text(
                title,
                style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18, color: AppTheme.indigoNdop),
              ),
            ],
          ),
          const SizedBox(height: 20),
          child,
        ],
      ),
    );
  }

  Widget _buildListItem(IconData icon, String title, String subtitle) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: AppTheme.indigoNdop.withOpacity(0.05),
              shape: BoxShape.circle,
            ),
            child: Icon(icon, size: 18, color: AppTheme.indigoNdop),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 14)),
                Text(subtitle, style: const TextStyle(fontSize: 12, color: Colors.grey)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCountBadge(String label, String count, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: color.withOpacity(0.08),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: color.withOpacity(0.2)),
      ),
      child: Row(
        children: [
          Icon(Icons.circle, size: 8, color: color),
          const SizedBox(width: 10),
          Text(
            ' : ',
            style: TextStyle(color: color, fontWeight: FontWeight.bold, fontSize: 13),
          ),
          Text(count, style: TextStyle(color: color, fontSize: 13)),
        ],
      ),
    );
  }
}
