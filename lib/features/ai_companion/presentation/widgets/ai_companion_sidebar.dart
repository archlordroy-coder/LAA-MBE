import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/theme/app_theme.dart';
import '../providers/ai_provider.dart';

class AICompanionSidebar extends ConsumerWidget {
  const AICompanionSidebar({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      decoration: const BoxDecoration(
        color: AppColors.sidebarBackground,
        border: Border(
          left: BorderSide(color: Color(0x1AC6C6CD), width: 1),
        ),
      ),
      child: Column(
        children: [
          const WaveformVisualizer(),
          const Expanded(
            child: ChatHistoryList(),
          ),
          AIInputArea(),
        ],
      ),
    );
  }
}

class WaveformVisualizer extends StatelessWidget {
  const WaveformVisualizer({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      padding: const EdgeInsets.all(20),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.5),
          borderRadius: BorderRadius.circular(16),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(15, (index) => Container(
            width: 4,
            height: (index % 5 + 2) * 5.0,
            margin: const EdgeInsets.symmetric(horizontal: 2),
            decoration: BoxDecoration(
              color: AppColors.accent.withOpacity(0.6),
              borderRadius: BorderRadius.circular(2),
            ),
          )),
        ),
      ),
    );
  }
}

class ChatHistoryList extends ConsumerWidget {
  const ChatHistoryList({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final messages = ref.watch(chatProvider);

    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: messages.length,
      itemBuilder: (context, index) {
        final msg = messages[index];
        return ChatBubble(
          message: msg.text,
          isAI: msg.isAI,
        );
      },
    );
  }
}

class ChatBubble extends StatelessWidget {
  final String message;
  final bool isAI;
  const ChatBubble({super.key, required this.message, required this.isAI});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: Column(
        crossAxisAlignment: isAI ? CrossAxisAlignment.start : CrossAxisAlignment.end,
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            constraints: const BoxConstraints(maxWidth: 280),
            decoration: BoxDecoration(
              color: isAI ? AppColors.secondaryContainer : AppColors.surface,
              borderRadius: BorderRadius.only(
                topLeft: const Radius.circular(16),
                topRight: const Radius.circular(16),
                bottomLeft: Radius.circular(isAI ? 0 : 16),
                bottomRight: Radius.circular(isAI ? 16 : 0),
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 4,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: MarkdownBody(
              data: message,
              styleSheet: MarkdownStyleSheet(
                p: TextStyle(color: AppColors.textPrimary, fontSize: 14),
              ),
            ),
          ),
          const SizedBox(height: 4),
          Text(
            isAI ? "LAA-MBÈ" : "Vous",
            style: const TextStyle(fontSize: 10, color: AppColors.textSecondary),
          ),
        ],
      ),
    );
  }
}

class AIInputArea extends ConsumerWidget {
  AIInputArea({super.key});

  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.surface,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, -5),
          ),
        ],
      ),
      child: Column(
        children: [
          TextField(
            controller: _controller,
            onSubmitted: (value) {
              if (value.isNotEmpty) {
                ref.read(chatProvider.notifier).sendMessage(value);
                _controller.clear();
              }
            },
            decoration: InputDecoration(
              hintText: "Demandez-moi n'importe quoi...",
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(24),
                borderSide: BorderSide.none,
              ),
              filled: true,
              fillColor: AppColors.background,
              contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
            ),
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              IconButton(
                onPressed: () {},
                icon: const Icon(Icons.mic_none, color: AppColors.textSecondary),
              ),
              const Spacer(),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                decoration: BoxDecoration(
                  color: AppColors.background,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: DropdownButton<String>(
                  value: "Gemma 2b",
                  items: ["Gemma 2b", "Gemma 9b"].map((s) => DropdownMenuItem(
                    value: s,
                    child: Text(s, style: const TextStyle(fontSize: 12)),
                  )).toList(),
                  onChanged: (v) {},
                  underline: const SizedBox(),
                ),
              ),
              const SizedBox(width: 8),
              IconButton(
                onPressed: () {
                   if (_controller.text.isNotEmpty) {
                    ref.read(chatProvider.notifier).sendMessage(_controller.text);
                    _controller.clear();
                  }
                },
                icon: const Icon(Icons.send, color: AppColors.accent),
              ),
            ],
          )
        ],
      ),
    );
  }
}
