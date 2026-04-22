import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uuid/uuid.dart';

enum MessageRole { user, assistant }

class ChatMessage {
  final String id;
  final String text;
  final MessageRole role;
  final DateTime timestamp;

  ChatMessage({
    required this.id,
    required this.text,
    required this.role,
    required this.timestamp,
  });
}

class ChatState {
  final List<ChatMessage> messages;
  final bool isGenerating;
  final String selectedModel;

  ChatState({
    required this.messages,
    required this.isGenerating,
    required this.selectedModel,
  });

  ChatState copyWith({
    List<ChatMessage>? messages,
    bool? isGenerating,
    String? selectedModel,
  }) {
    return ChatState(
      messages: messages ?? this.messages,
      isGenerating: isGenerating ?? this.isGenerating,
      selectedModel: selectedModel ?? this.selectedModel,
    );
  }
}

class ChatNotifier extends StateNotifier<ChatState> {
  ChatNotifier() : super(ChatState(messages: [], isGenerating: false, selectedModel: 'Gemma 2b'));

  void sendMessage(String text) {
    if (text.trim().isEmpty) return;

    final userMessage = ChatMessage(
      id: const Uuid().v4(),
      text: text,
      role: MessageRole.user,
      timestamp: DateTime.now(),
    );

    state = state.copyWith(
      messages: [...state.messages, userMessage],
      isGenerating: true,
    );

    // Mock AI response for Phase 1
    Future.delayed(const Duration(seconds: 1), () {
      final aiMessage = ChatMessage(
        id: const Uuid().v4(),
        text: 'Ceci est une réponse simulée de ${state.selectedModel}. Dans la Phase 2, llama.cpp traitera cette demande localement.',
        role: MessageRole.assistant,
        timestamp: DateTime.now(),
      );
      state = state.copyWith(
        messages: [...state.messages, aiMessage],
        isGenerating: false,
      );
    });
  }

  void setModel(String model) {
    state = state.copyWith(selectedModel: model);
  }
}

final chatProvider = StateNotifierProvider<ChatNotifier, ChatState>((ref) {
  return ChatNotifier();
});
