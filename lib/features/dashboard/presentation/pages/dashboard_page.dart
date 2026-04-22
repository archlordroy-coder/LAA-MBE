import 'package:flutter/material.dart';
import '../../../../core/theme/app_theme.dart';

class DashboardPage extends StatelessWidget {
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(32),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Bonjour Alex,",
              style: Theme.of(context).textTheme.headlineLarge,
            ),
            const SizedBox(height: 8),
            const Text(
              "Voici votre briefing matinal généré par LAA-MBÈ.",
              style: TextStyle(color: AppColors.textSecondary, fontSize: 18),
            ),
            const SizedBox(height: 32),
            const MorningBriefingCard(),
            const SizedBox(height: 32),
            const DashboardGrid(),
          ],
        ),
      ),
    );
  }
}

class MorningBriefingCard extends StatelessWidget {
  const MorningBriefingCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.03),
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
              const Icon(Icons.auto_awesome, color: AppColors.accent, size: 24),
              const SizedBox(width: 12),
              Text(
                "Briefing IA",
                style: Theme.of(context).textTheme.headlineMedium?.copyWith(fontSize: 20),
              ),
            ],
          ),
          const SizedBox(height: 16),
          const Text(
            "Aujourd'hui, vous avez 3 réunions importantes, dont la revue de projet à 14h30. 2 documents Drive ont été modifiés récemment par votre équipe, et vous avez 5 messages non lus sur WhatsApp qui pourraient nécessiter votre attention.",
            style: TextStyle(height: 1.5, fontSize: 16),
          ),
        ],
      ),
    );
  }
}

class DashboardGrid extends StatelessWidget {
  const DashboardGrid({super.key});

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      crossAxisCount: 2,
      crossAxisSpacing: 24,
      mainAxisSpacing: 24,
      childAspectRatio: 1.5,
      children: const [
        DashboardWidget(
          title: "Agenda du jour",
          icon: Icons.calendar_today,
          content: "10:00 - Daily Standup\n14:30 - Project Review\n16:00 - Client Call",
        ),
        DashboardWidget(
          title: "Fichiers Récents",
          icon: Icons.description,
          content: "Q4_Planning_Final.pdf\nBudget_Draft_v2.xlsx\nSprint_Notes.docx",
        ),
        DashboardWidget(
          title: "WhatsApp",
          icon: Icons.chat,
          content: "5 nouveaux messages\n3 conversations actives",
          badgeCount: 5,
        ),
        DashboardWidget(
          title: "Gmail",
          icon: Icons.email,
          content: "12 non lus\n2 prioritaires",
          badgeCount: 2,
        ),
      ],
    );
  }
}

class DashboardWidget extends StatelessWidget {
  final String title;
  final IconData icon;
  final String content;
  final int? badgeCount;

  const DashboardWidget({
    super.key,
    required this.title,
    required this.icon,
    required this.content,
    this.badgeCount,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.03),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Icon(icon, color: AppColors.accent),
              if (badgeCount != null)
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: AppColors.accent,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    badgeCount.toString(),
                    style: const TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.bold),
                  ),
                ),
            ],
          ),
          const SizedBox(height: 16),
          Text(title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
          const SizedBox(height: 8),
          Expanded(
            child: Text(
              content,
              style: const TextStyle(color: AppColors.textSecondary, height: 1.4),
            ),
          ),
        ],
      ),
    );
  }
}
