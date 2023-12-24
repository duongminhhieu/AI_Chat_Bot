import 'dart:async';

import '../../../di/service_locator.dart';
import '../../repository/chat/chat_repository.dart';
import '../../usecase/chat/send_message_usecase.dart';

mixin UseCaseModule {
  static Future<void> configureUseCaseModuleInjection() async {


    // chat:--------------------------------------------------------------------
    getIt.registerSingleton<SendMessageUseCase>(
      SendMessageUseCase(getIt<ChatRepository>()),
    );

  }
}
