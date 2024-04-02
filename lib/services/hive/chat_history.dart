// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:hive/hive.dart';
part 'chat_history.g.dart';

@HiveType(typeId: 0)
class ChatHistory extends HiveObject {
  @HiveField(0)
  final String chatID;

 @HiveField(1)
 final String prompt;

 @HiveField(2)
 final String response;

 @HiveField(3)
 final List<String> imageUrls;

 @HiveField(4)
 final DateTime timeStamp;


 //constructor

  ChatHistory({
    required this.chatID,
    required this.prompt,
    required this.response,
    required this.imageUrls,
    required this.timeStamp,
  });

 


}
