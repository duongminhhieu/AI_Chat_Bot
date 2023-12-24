import 'dart:async';

import 'package:boilerplate/data/network/apis/chats/chat_api.dart';
import 'package:boilerplate/data/repository/setting/setting_repository_impl.dart';
import 'package:boilerplate/data/sharedpref/shared_preference_helper.dart';
import 'package:boilerplate/domain/repository/chat/chat_repository.dart';
import 'package:boilerplate/domain/repository/setting/setting_repository.dart';

import '../../../di/service_locator.dart';
import '../../repository/chat/chat_repository_impl.dart';

mixin RepositoryModule {
  static Future<void> configureRepositoryModuleInjection() async {
    // repository:--------------------------------------------------------------
    getIt.registerSingleton<SettingRepository>(SettingRepositoryImpl(
      getIt<SharedPreferenceHelper>(),
    ));


    getIt.registerSingleton<ChatRepository>(ChatRepositoryImpl(
      getIt<ChatApi>(),
    ));
  }
}
