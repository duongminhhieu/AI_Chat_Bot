

import 'dart:async';

import 'package:boilerplate/domain/repository/chat/chat_repository.dart';

import '../../../core/domain/usecase/use_case.dart';
import '../../entity/chat/chat.dart';

class SendMessageUseCase extends UseCase<Message?, List<Map<String, String>>> {

  final ChatRepository _chatRepository;

  SendMessageUseCase(this._chatRepository);

  @override
  Future<Message?> call({required List<Map<String, String>> params}) {
    return _chatRepository.sendMessage(params);
  }


}