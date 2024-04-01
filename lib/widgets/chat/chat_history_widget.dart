// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:mboacare/app_modules/user/screens/chat/chat_screen.dart';
import 'package:mboacare/global/styles/colors.dart';

import 'package:mboacare/services/chat_provider/chat_provider.dart';
import 'package:mboacare/services/hive/chat_history.dart';
import 'package:mboacare/utils/router.dart';
import 'package:mboacare/utils/show_dialogue.dart';
import 'package:provider/provider.dart';

class ChatHistoryWidget extends StatelessWidget {
  const ChatHistoryWidget({
    super.key,
    required this.chat,
  });

  final ChatHistory chat;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: AppColors.whiteColor,
      child: ListTile(
        contentPadding: const EdgeInsets.only(left: 10.0, right: 10.0),
        leading: const CircleAvatar(
          radius: 30,
          backgroundColor: AppColors.primaryColor,
          child: Icon(
            Icons.chat,
            color: AppColors.whiteColor,
          ),
        ),
        title: Text(
          chat.prompt,
          maxLines: 1,
        ),
        subtitle: Text(
          chat.response,
          maxLines: 2,
        ),
        trailing: const Icon(Icons.arrow_forward_ios),
        onTap: () async {
          // navigate to chat screen
          final chatProvider = context.read<ChatProvider>();
          // prepare chat room
          await chatProvider.prepareChatRoom(
            isNewChat: false,
            chatID: chat.chatID,
          );
          PageNavigator(ctx: context).nextPage(page: const ChatScreen());
          // chatProvider.setCurrentIndex(newIndex: 1);
          // chatProvider.pageController.jumpToPage(1);
        },
        onLongPress: () {
          // show my animated dialog to delete the chat
          showMyAnimatedDialog(
            context: context,
            title: 'Delete Chat',
            content: 'Are you sure you want to delete this chat?',
            actionText: 'Delete',
            onActionPressed: (value) async {
              if (value) {
                // delete the chat
                await context
                    .read<ChatProvider>()
                    .deletChatMessages(chatId: chat.chatID);

                // delete the chat history
                await chat.delete();
              }
            },
          );
        },
      ),
    );
  }
}
