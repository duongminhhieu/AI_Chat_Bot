import 'dart:async';

import 'package:boilerplate/data/network/apis/chats/chat_api.dart';
import 'package:boilerplate/domain/entity/chat/chat.dart';
import 'package:boilerplate/domain/repository/chat/chat_repository.dart';

class ChatRepositoryImpl extends ChatRepository {

  // api objects
  final ChatApi _chatApi;


  // constructor
  ChatRepositoryImpl(this._chatApi);


  // Post: ---------------------------------------------------------------------
  @override
  Future<Message?> sendMessage(List<Map<String, String>> messages) {

    return _chatApi.sendMessage(messages).then((message) {
      return message;
    }).catchError((error) => throw error);
  }



}
