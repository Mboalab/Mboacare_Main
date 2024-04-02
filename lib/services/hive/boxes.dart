import 'package:hive/hive.dart';
import 'package:mboacare/services/hive/chat_history.dart';
import 'package:mboacare/services/hive/settings.dart';
import 'package:mboacare/services/hive/user_model.dart';
import 'package:mboacare/utils/constants.dart';

class Boxes {
//get chat history box
  static Box<ChatHistory> getChatHistory() =>
      Hive.box<ChatHistory>(AppStrings.chatHistoryBox);

//get user box
  static Box<UserModel> getUser() => Hive.box<UserModel>(AppStrings.userBox);

//get settings box
  static Box<Settings> getSettings() =>
      Hive.box<Settings>(AppStrings.settingsBox);
}
