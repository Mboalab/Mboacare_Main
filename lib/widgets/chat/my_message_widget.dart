import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:mboacare/model/chat_model/message.dart';
import 'package:mboacare/widgets/chat/preview_images_widgets.dart';

class MyMessageWidget extends StatelessWidget {
  const MyMessageWidget({Key? key, required this.message}) : super(key: key);
  final Message message;
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: Container(
        constraints:
            BoxConstraints(maxWidth: MediaQuery.of(context).size.width * 0.7),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.primaryContainer,
          borderRadius: BorderRadius.circular(18),
        ),
        padding: const EdgeInsets.all(14),
        margin: const EdgeInsets.only(bottom: 8.0),
        child: Column(
          children: [
            if (message.imageUrl.isNotEmpty)
              PreviewImagesWidget(
                message: message,
              ),
            MarkdownBody(
              selectable: true,
              data: message.message.toString(),
            ),
          ],
        ),
      ),
    );
  }
}
