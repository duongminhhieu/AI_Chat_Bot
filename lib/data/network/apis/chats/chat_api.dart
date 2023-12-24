import 'dart:async';
import 'dart:convert';
import 'dart:io';


import 'package:boilerplate/data/network/constants/endpoints.dart';
import 'package:boilerplate/presentation/chat/store/chat/chat_store.dart';

import '../../../../constants/secrets.dart';
import '../../../../di/service_locator.dart';
import '../../../../domain/entity/chat/chat.dart';

class ChatApi {

  final HttpClient _client;

  ChatApi(this._client);

  Future<Message?> sendMessage(List<Map<String, String>> messages) async {
    final converter = JsonUtf8Encoder();
    final url = Uri.parse(Endpoints.sendMessage);
    final ChatStore _chatStore = getIt<ChatStore>();


    // send all current conversation to OpenAI
    final body = {
      'model': SecretsString.model,
      'messages': messages,
    };
    // _client.findProxy = HttpClient.findProxyFromEnvironment;
    if (SecretsString.proxy != "") {
      _client.findProxy = (url) {
        return HttpClient.findProxyFromEnvironment(
            url, environment: {
          "http_proxy": SecretsString.proxy,
          "https_proxy": SecretsString.proxy
        });
      };
    }

    try {
      return await _client.postUrl(url).then(
              (HttpClientRequest request) {
            request.headers.set('Content-Type', 'application/json');
            request.headers.set('Authorization', "Bearer ${SecretsString.apiKey}");
            request.add(converter.convert(body));
            return request.close();
          }
      ).then((HttpClientResponse response) async {
        var retBody = await response.transform(utf8.decoder).join();
        if (response.statusCode == 200) {
          final data = json.decode(retBody);
          final completions = data['choices'] as List<dynamic>;
          if (completions.isNotEmpty) {
            final completion = completions[0];
            final content = completion['message']['content'] as String;
            // delete all the prefix '\n' in content
            final contentWithoutPrefix = content.replaceFirst(
                RegExp(r'^\n+'), '');
            return Message(
                senderId: _chatStore.systemSender.id, content: contentWithoutPrefix);
          }
        } else {
          // invalid api key
          // create a new dialog
          return Message(content: "API KEY is Invalid", senderId: _chatStore.systemSender.id);
        }
        return null;
      });
    } on Exception catch (_) {
      return Message(content: _.toString(), senderId: _chatStore.systemSender.id);
    }

  }

}
