import 'dart:async';

import '../../entity/chat/chat.dart';


abstract class ChatRepository {

  Future<Message?> sendMessage(List<Map<String, String>> messages);
}
