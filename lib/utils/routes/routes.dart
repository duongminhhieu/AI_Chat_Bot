import 'package:boilerplate/presentation/chat/chat_view.dart';
import 'package:flutter/material.dart';

class Routes {
  Routes._();

  //static variables
  static const String splash = '/splash';

  static const String chat = '/chat';

  static final routes = <String, WidgetBuilder>{
    chat: (BuildContext context) => ChatView(),
  };
}
