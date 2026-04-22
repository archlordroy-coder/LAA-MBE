import 'package:flutter_riverpod/flutter_riverpod.dart';

class ChatMessage {
  final String text;
  final bool isAI;
  ChatMessage(this.text, this.isAI);
}

class ChatNotifier extends StateNotifier<List<ChatMessage>> {
  ChatNotifier() : super([
    ChatMessage("Bonjour Alex ! Je suis LAA-MBÈ. Comment puis-je vous assister ?", true),
  ]);

  void sendMessage(String text) {
    state = [...state, ChatMessage(text, false)];

    // Mock AI response delay
    Future.delayed(const Duration(seconds: 1), () {
      state = [...state, ChatMessage("C'est noté. Je traite votre demande : '$text'.", true)];
    });
  }
}

final chatProvider = StateNotifierProvider<ChatNotifier, List<ChatMessage>>((ref) {
  return ChatNotifier();
});
