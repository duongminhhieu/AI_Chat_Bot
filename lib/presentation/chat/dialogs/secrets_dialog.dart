import 'package:boilerplate/presentation/chat/store/chat/chat_store.dart';
import 'package:flutter/material.dart';

import '../../../di/service_locator.dart';

final ChatStore _chatStore = getIt<ChatStore>();

void showProxyDialog(BuildContext context) async {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      String newProxy = 'your proxy';
      return AlertDialog(
        title: const Text('proxy Setting'),
        content: TextField(
          // display the current name of the conversation
          decoration: InputDecoration(
            hintText: _chatStore.proxy,
          ),
          onChanged: (value) {
            newProxy = value;
          },
        ),
        actions: <Widget>[
          TextButton(
            child: const Text('Cancel'),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          TextButton(
            child: const Text(
              'Save',
              style: TextStyle(
                color: Color(0xff55bb8e),
              ),
            ),
            onPressed: () {
              if (newProxy == '') {
                Navigator.pop(context);
                return;
              }
              _chatStore.changeProxy(newProxy);
              Navigator.pop(context);
            },
          ),
        ],
      );
    },
  );
}


void showRenameDialog(BuildContext context) async {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      String newName = 'YOUR_API_KEY';
      return AlertDialog(
        title: const Text('API Setting'),
        content: TextField(
          // display the current name of the conversation
          decoration: InputDecoration(
            hintText: _chatStore.apiKey,
          ),
          onChanged: (value) {
            newName = value;
          },
        ),
        actions: <Widget>[
          TextButton(
            child: const Text('Cancel'),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          TextButton(
            child: const Text(
              'Save',
              style: TextStyle(
                color: Color(0xff55bb8e),
              ),
            ),
            onPressed: () {
              if (newName == '') {
                Navigator.pop(context);
                return;
              }
            _chatStore.changeApiKey(newName);
              Navigator.pop(context);
            },
          ),
        ],
      );
    },
  );
}