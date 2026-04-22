import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:laa_mbe/core/theme/app_theme.dart';
import 'package:laa_mbe/features/ai/presentation/providers/chat_provider.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:animate_do/animate_do.dart';

class AIPane extends ConsumerStatefulWidget {
  const AIPane({super.key});

  @override
  ConsumerState<AIPane> createState() => _AIPaneState();
}

class _AIPaneState extends ConsumerState<AIPane> {
  final TextEditingController _controller = TextEditingController();
  final ScrollController _scrollController = ScrollController();

  void _sendMessage() {
    if (_controller.text.isNotEmpty) {
      ref.read(chatProvider.notifier).sendMessage(_controller.text);
      _controller.clear();
      _scrollToBottom();
    }
  }

  void _scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final chatState = ref.watch(chatProvider);

    return Container(
      width: 340,
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        border: Border(left: BorderSide(color: AppTheme.indigoNdop.withOpacity(0.1), width: 1)),
      ),
      child: Column(
        children: [
          // Header with Visualizer
          _buildHeader(chatState.isGenerating),
          const Divider(height: 1),
          // Chat area
          Expanded(
            child: ListView.builder(
              controller: _scrollController,
              padding: const EdgeInsets.all(16),
              itemCount: chatState.messages.length,
              itemBuilder: (context, index) {
                final message = chatState.messages[index];
                return _buildMessageBubble(message);
              },
            ),
          ),
          if (chatState.isGenerating)
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: LinearProgressIndicator(minHeight: 2),
            ),
          const Divider(height: 1),
          // Input area
          _buildInputArea(chatState),
        ],
      ),
    );
  }

  Widget _buildHeader(bool isGenerating) {
    return Container(
      height: 120,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppTheme.indigoNdop.withOpacity(0.03),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(Icons.auto_awesome, color: AppTheme.indigoNdop, size: 18),
              const SizedBox(width: 8),
              Text(
                'LAA-MBÈ Assistant',
                style: Theme.of(context).textTheme.titleSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: AppTheme.indigoNdop,
                ),
              ),
            ],
          ),
          const Spacer(),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(15, (index) {
              return FadeInUp(
                animate: isGenerating,
                duration: Duration(milliseconds: 500 + (index * 100)),
                child: Container(
                  margin: const EdgeInsets.symmetric(horizontal: 2),
                  width: 4,
                  height: isGenerating ? 20 + (index % 5) * 10 : 8,
                  decoration: BoxDecoration(
                    color: AppTheme.indigoNdop.withOpacity(isGenerating ? 0.8 : 0.2),
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
              );
            }),
          )
        ],
      ),
    );
  }

  Widget _buildMessageBubble(ChatMessage message) {
    final isUser = message.role == MessageRole.user;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Column(
        crossAxisAlignment: isUser ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            constraints: const BoxConstraints(maxWidth: 280),
            decoration: BoxDecoration(
              color: isUser ? AppTheme.indigoNdop : AppTheme.indigoNdop.withOpacity(0.05),
              borderRadius: BorderRadius.circular(16).copyWith(
                bottomRight: isUser ? const Radius.circular(0) : const Radius.circular(16),
                bottomLeft: isUser ? const Radius.circular(16) : const Radius.circular(0),
              ),
            ),
            child: MarkdownBody(
              data: message.text,
              styleSheet: MarkdownStyleSheet(
                p: TextStyle(
                  color: isUser ? Colors.white : Colors.black87,
                  fontSize: 14,
                  height: 1.4,
                ),
              ),
            ),
          ),
          const SizedBox(height: 4),
          Text(
            '${message.timestamp.hour}:${message.timestamp.minute.toString().padLeft(2, '0')}',
            style: const TextStyle(fontSize: 10, color: Colors.grey),
          ),
        ],
      ),
    );
  }

  Widget _buildInputArea(ChatState chatState) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: TextField(
                  controller: _controller,
                  onSubmitted: (_) => _sendMessage(),
                  decoration: InputDecoration(
                    hintText: 'Posez une question...',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                      borderSide: BorderSide.none,
                    ),
                    filled: true,
                    fillColor: AppTheme.indigoNdop.withOpacity(0.05),
                    contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  ),
                ),
              ),
              const SizedBox(width: 8),
              IconButton(
                icon: const Icon(Icons.mic, color: AppTheme.indigoNdop),
                onPressed: () {},
              ),
            ],
          ),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                decoration: BoxDecoration(
                  color: AppTheme.indigoNdop.withOpacity(0.05),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: DropdownButton<String>(
                  value: chatState.selectedModel,
                  items: const [
                    DropdownMenuItem(value: 'Gemma 2b', child: Text('Gemma 2b', style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold))),
                    DropdownMenuItem(value: 'Gemma 9b', child: Text('Gemma 9b', style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold))),
                  ],
                  onChanged: (val) {
                    if (val != null) ref.read(chatProvider.notifier).setModel(val);
                  },
                  underline: const SizedBox(),
                  iconSize: 18,
                ),
              ),
              IconButton(
                icon: const Icon(Icons.send_rounded, color: AppTheme.indigoNdop),
                onPressed: _sendMessage,
              ),
            ],
          )
        ],
      ),
    );
  }
}
