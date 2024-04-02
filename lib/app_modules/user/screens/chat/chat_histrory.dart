import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:mboacare/services/hive/boxes.dart';
import 'package:mboacare/services/hive/chat_history.dart';
import 'package:mboacare/widgets/chat/chat_history_widget.dart';
import 'package:mboacare/widgets/chat/empty_history_widget.dart';

class ChatHistoryScreen extends StatefulWidget {
  const ChatHistoryScreen({Key? key}) : super(key: key);

  @override
  _ChatHistoryScreenState createState() => _ChatHistoryScreenState();
}

class _ChatHistoryScreenState extends State<ChatHistoryScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          titleSpacing: 0.0,
          title: Text(
            'Chat History!',
            style: GoogleFonts.quicksand(
              fontSize: 16.5,
            ),
          ),
        ),
        body: ValueListenableBuilder<Box<ChatHistory>>(
          valueListenable: Boxes.getChatHistory().listenable(),
          builder: (context, box, _) {
            final chatHistory =
                box.values.toList().cast<ChatHistory>().reversed.toList();
            return chatHistory.isEmpty
                ? const EmptyHistoryWidget()
                : Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ListView.builder(
                      itemCount: chatHistory.length,
                      itemBuilder: (context, index) {
                        final chat = chatHistory[index];
                        return ChatHistoryWidget(chat: chat);
                      },
                    ),
                  );
          },
        ));
  }
}
