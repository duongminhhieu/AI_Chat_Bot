import 'dart:async';

import 'package:boilerplate/data/local/constants/db_constants.dart';
import 'package:boilerplate/data/local/datasources/post/post_datasource.dart';
import 'package:boilerplate/data/network/apis/chats/chat_api.dart';
import 'package:boilerplate/data/network/apis/posts/post_api.dart';
import 'package:boilerplate/domain/entity/chat/chat.dart';
import 'package:boilerplate/domain/entity/post/post.dart';
import 'package:boilerplate/domain/entity/post/post_list.dart';
import 'package:boilerplate/domain/repository/chat/chat_repository.dart';
import 'package:boilerplate/domain/repository/post/post_repository.dart';
import 'package:sembast/sembast.dart';

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
