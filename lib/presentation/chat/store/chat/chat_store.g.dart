// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chat_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$ChatStore on _ChatStore, Store {
  Computed<bool>? _$loadingComputed;

  @override
  bool get loading => (_$loadingComputed ??=
          Computed<bool>(() => super.loading, name: '_ChatStore.loading'))
      .value;
  Computed<String>? _$currentConversationTitleComputed;

  @override
  String get currentConversationTitle => (_$currentConversationTitleComputed ??=
          Computed<String>(() => super.currentConversationTitle,
              name: '_ChatStore.currentConversationTitle'))
      .value;
  Computed<int>? _$currentConversationLengthComputed;

  @override
  int get currentConversationLength => (_$currentConversationLengthComputed ??=
          Computed<int>(() => super.currentConversationLength,
              name: '_ChatStore.currentConversationLength'))
      .value;
  Computed<Conversation>? _$currentConversationComputed;

  @override
  Conversation get currentConversation => (_$currentConversationComputed ??=
          Computed<Conversation>(() => super.currentConversation,
              name: '_ChatStore.currentConversation'))
      .value;
  Computed<List<Map<String, String>>>? _$currentConversationMessagesComputed;

  @override
  List<Map<String, String>> get currentConversationMessages =>
      (_$currentConversationMessagesComputed ??=
              Computed<List<Map<String, String>>>(
                  () => super.currentConversationMessages,
                  name: '_ChatStore.currentConversationMessages'))
          .value;
  Computed<Sender>? _$systemSenderComputed;

  @override
  Sender get systemSender =>
      (_$systemSenderComputed ??= Computed<Sender>(() => super.systemSender,
              name: '_ChatStore.systemSender'))
          .value;
  Computed<Sender>? _$userSenderComputed;

  @override
  Sender get userSender =>
      (_$userSenderComputed ??= Computed<Sender>(() => super.userSender,
              name: '_ChatStore.userSender'))
          .value;

  late final _$fetchMessageFutureAtom =
      Atom(name: '_ChatStore.fetchMessageFuture', context: context);

  @override
  ObservableFuture<Message?> get fetchMessageFuture {
    _$fetchMessageFutureAtom.reportRead();
    return super.fetchMessageFuture;
  }

  @override
  set fetchMessageFuture(ObservableFuture<Message?> value) {
    _$fetchMessageFutureAtom.reportWrite(value, super.fetchMessageFuture, () {
      super.fetchMessageFuture = value;
    });
  }

  late final _$conversationsAtom =
      Atom(name: '_ChatStore.conversations', context: context);

  @override
  List<Conversation> get conversations {
    _$conversationsAtom.reportRead();
    return super.conversations;
  }

  @override
  set conversations(List<Conversation> value) {
    _$conversationsAtom.reportWrite(value, super.conversations, () {
      super.conversations = value;
    });
  }

  late final _$currentConversationIndexAtom =
      Atom(name: '_ChatStore.currentConversationIndex', context: context);

  @override
  int get currentConversationIndex {
    _$currentConversationIndexAtom.reportRead();
    return super.currentConversationIndex;
  }

  @override
  set currentConversationIndex(int value) {
    _$currentConversationIndexAtom
        .reportWrite(value, super.currentConversationIndex, () {
      super.currentConversationIndex = value;
    });
  }

  late final _$successAtom = Atom(name: '_ChatStore.success', context: context);

  @override
  bool get success {
    _$successAtom.reportRead();
    return super.success;
  }

  @override
  set success(bool value) {
    _$successAtom.reportWrite(value, super.success, () {
      super.success = value;
    });
  }

  late final _$apiKeyAtom = Atom(name: '_ChatStore.apiKey', context: context);

  @override
  String get apiKey {
    _$apiKeyAtom.reportRead();
    return super.apiKey;
  }

  @override
  set apiKey(String value) {
    _$apiKeyAtom.reportWrite(value, super.apiKey, () {
      super.apiKey = value;
    });
  }

  late final _$proxyAtom = Atom(name: '_ChatStore.proxy', context: context);

  @override
  String get proxy {
    _$proxyAtom.reportRead();
    return super.proxy;
  }

  @override
  set proxy(String value) {
    _$proxyAtom.reportWrite(value, super.proxy, () {
      super.proxy = value;
    });
  }

  late final _$_systemSenderAtom =
      Atom(name: '_ChatStore._systemSender', context: context);

  @override
  Sender get _systemSender {
    _$_systemSenderAtom.reportRead();
    return super._systemSender;
  }

  @override
  set _systemSender(Sender value) {
    _$_systemSenderAtom.reportWrite(value, super._systemSender, () {
      super._systemSender = value;
    });
  }

  late final _$_userSenderAtom =
      Atom(name: '_ChatStore._userSender', context: context);

  @override
  Sender get _userSender {
    _$_userSenderAtom.reportRead();
    return super._userSender;
  }

  @override
  set _userSender(Sender value) {
    _$_userSenderAtom.reportWrite(value, super._userSender, () {
      super._userSender = value;
    });
  }

  late final _$sendMessageAsyncAction =
      AsyncAction('_ChatStore.sendMessage', context: context);

  @override
  Future<void> sendMessage() {
    return _$sendMessageAsyncAction.run(() => super.sendMessage());
  }

  late final _$_ChatStoreActionController =
      ActionController(name: '_ChatStore', context: context);

  @override
  void setSystemSender(Sender value) {
    final _$actionInfo = _$_ChatStoreActionController.startAction(
        name: '_ChatStore.setSystemSender');
    try {
      return super.setSystemSender(value);
    } finally {
      _$_ChatStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setUserSender(Sender value) {
    final _$actionInfo = _$_ChatStoreActionController.startAction(
        name: '_ChatStore.setUserSender');
    try {
      return super.setUserSender(value);
    } finally {
      _$_ChatStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void changeConversation(List<Conversation> value) {
    final _$actionInfo = _$_ChatStoreActionController.startAction(
        name: '_ChatStore.changeConversation');
    try {
      return super.changeConversation(value);
    } finally {
      _$_ChatStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void changeCurrentConversationIndex(int value) {
    final _$actionInfo = _$_ChatStoreActionController.startAction(
        name: '_ChatStore.changeCurrentConversationIndex');
    try {
      return super.changeCurrentConversationIndex(value);
    } finally {
      _$_ChatStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void changeApiKey(String value) {
    final _$actionInfo = _$_ChatStoreActionController.startAction(
        name: '_ChatStore.changeApiKey');
    try {
      return super.changeApiKey(value);
    } finally {
      _$_ChatStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void changeProxy(String value) {
    final _$actionInfo = _$_ChatStoreActionController.startAction(
        name: '_ChatStore.changeProxy');
    try {
      return super.changeProxy(value);
    } finally {
      _$_ChatStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void addMessage(Message value) {
    final _$actionInfo =
        _$_ChatStoreActionController.startAction(name: '_ChatStore.addMessage');
    try {
      return super.addMessage(value);
    } finally {
      _$_ChatStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void addEmptyConversation(String title) {
    final _$actionInfo = _$_ChatStoreActionController.startAction(
        name: '_ChatStore.addEmptyConversation');
    try {
      return super.addEmptyConversation(title);
    } finally {
      _$_ChatStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void addConversation(Conversation value) {
    final _$actionInfo = _$_ChatStoreActionController.startAction(
        name: '_ChatStore.addConversation');
    try {
      return super.addConversation(value);
    } finally {
      _$_ChatStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void removeConversation(int index) {
    final _$actionInfo = _$_ChatStoreActionController.startAction(
        name: '_ChatStore.removeConversation');
    try {
      return super.removeConversation(index);
    } finally {
      _$_ChatStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void removeCurrentConversation() {
    final _$actionInfo = _$_ChatStoreActionController.startAction(
        name: '_ChatStore.removeCurrentConversation');
    try {
      return super.removeCurrentConversation();
    } finally {
      _$_ChatStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void renameConversation(String title) {
    final _$actionInfo = _$_ChatStoreActionController.startAction(
        name: '_ChatStore.renameConversation');
    try {
      return super.renameConversation(title);
    } finally {
      _$_ChatStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void clearConversations() {
    final _$actionInfo = _$_ChatStoreActionController.startAction(
        name: '_ChatStore.clearConversations');
    try {
      return super.clearConversations();
    } finally {
      _$_ChatStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void clearCurrentConversation() {
    final _$actionInfo = _$_ChatStoreActionController.startAction(
        name: '_ChatStore.clearCurrentConversation');
    try {
      return super.clearCurrentConversation();
    } finally {
      _$_ChatStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
fetchMessageFuture: ${fetchMessageFuture},
conversations: ${conversations},
currentConversationIndex: ${currentConversationIndex},
success: ${success},
apiKey: ${apiKey},
proxy: ${proxy},
loading: ${loading},
currentConversationTitle: ${currentConversationTitle},
currentConversationLength: ${currentConversationLength},
currentConversation: ${currentConversation},
currentConversationMessages: ${currentConversationMessages},
systemSender: ${systemSender},
userSender: ${userSender}
    ''';
  }
}
