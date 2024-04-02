import 'package:flutter/material.dart';
import 'package:mboacare/model/chat_model/message.dart';
import 'package:mboacare/services/chat_provider/chat_provider.dart';
import 'package:mboacare/widgets/chat/assistant_message_widget.dart';
import 'package:mboacare/widgets/chat/my_message_widget.dart';


class ChatMessages extends StatelessWidget {
  const ChatMessages({
    Key? key,
    required this.scrollController,
    required this.chatProvider,
  }) : super(key: key);

  final ScrollController scrollController;
  final ChatProvider chatProvider;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      controller: scrollController,
      itemCount: chatProvider.inChatMessages.length,
      itemBuilder: (context, index) {
        // compare with timeSent bewfore showing the list
        final message = chatProvider.inChatMessages[index];
        return message.role == Role.user
            ? MyMessageWidget(message: message)
            : AssistantMessageWidget(
                message: message.message.toString(),
              );
      },
    );
  }
}
