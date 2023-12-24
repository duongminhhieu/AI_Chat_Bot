import 'package:boilerplate/constants/assets.dart';
import 'package:boilerplate/domain/usecase/chat/send_message_usecase.dart';
import 'package:mobx/mobx.dart';

import '../../../../constants/secrets.dart';
import '../../../../core/stores/error/error_store.dart';
import '../../../../domain/entity/chat/chat.dart';
import '../../../../utils/dio/dio_error_util.dart';

part 'chat_store.g.dart';

class ChatStore = _ChatStore with _$ChatStore;

abstract class _ChatStore with Store {
  static const String TAG = "ChatStore";
  // constructor:---------------------------------------------------------------
  _ChatStore(this._sendMessageUseCase, this.errorStore) {
    init();
  }

  // use cases:-----------------------------------------------------------------
  final SendMessageUseCase _sendMessageUseCase;

  // stores:--------------------------------------------------------------------
  // store for handling errors
  final ErrorStore errorStore;

  // store variables:-----------------------------------------------------------
  static ObservableFuture<Message?> emptyMessageResponse =
      ObservableFuture.value(null);

  @observable
  ObservableFuture<Message?> fetchMessageFuture =
      ObservableFuture<Message?>(emptyMessageResponse);

  @observable
  List<Conversation> conversations = [];

  @observable
  int currentConversationIndex = 0;

  @observable
  bool success = false;

  @observable
  late String apiKey = SecretsString.apiKey;

  @observable
  late String proxy = SecretsString.proxy;

  @computed
  bool get loading => fetchMessageFuture.status == FutureStatus.pending;

  @computed
  String get currentConversationTitle =>
      conversations[currentConversationIndex].title;

  @computed
  int get currentConversationLength =>
      conversations[currentConversationIndex].messages.length;

  @computed
  Conversation get currentConversation =>
      conversations[currentConversationIndex];

  @computed
  List<Map<String, String>> get currentConversationMessages {
    List<Map<String, String>> messages = [
      {
        'role': "system",
        'content': "",
      }
    ];
    for (Message message in conversations[currentConversationIndex].messages) {
      messages.add({
        'role': message.senderId == 'User' ? 'user' : 'system',
        'content': message.content
      });
    }
    return messages;
  }

  @observable
  Sender _systemSender =
      Sender(name: 'System', avatarAssetPath: Assets.chatGPTLogo);

  @computed
  Sender get systemSender => _systemSender;

  @observable
  Sender _userSender =
      Sender(name: 'User', avatarAssetPath: Assets.personIcon);

  @computed
  Sender get userSender => _userSender;

  // actions:-------------------------------------------------------------------
  @action
  void setSystemSender(Sender value) {
    _systemSender = value;
  }

  @action
  void setUserSender(Sender value) {
    _userSender = value;
  }

  // change conversations
  @action
  void changeConversation(List<Conversation> value) {
    conversations = value;
  }

  // change current conversation
  @action
  void changeCurrentConversationIndex(int value) {
    currentConversationIndex = value;
  }

  // change api key
  @action
  void changeApiKey(String value) {
    apiKey = value;
  }

  // change proxy
  @action
  void changeProxy(String value) {
    proxy = value;
  }

  // add to current conversation
  @action
  void addMessage(Message value) {
    conversations[currentConversationIndex].messages.add(value);
  }

  // add a new empty conversation
  // default title is 'new conversation ${_conversations.length}'
  @action
  void addEmptyConversation(String title) {
    if (title == '') {
      title = 'New conversation ${conversations.length}';
    }
    conversations.add(Conversation(messages: [], title: title));
    currentConversationIndex = conversations.length - 1;
  }

  // add new conversation
  @action
  void addConversation(Conversation value) {
    conversations.add(value);
    currentConversationIndex = conversations.length - 1;
  }

  // remove conversation by index
  @action
  void removeConversation(int index) {
    conversations.removeAt(index);
    currentConversationIndex = conversations.length - 1;
  }

  // remove current conversation
  @action
  void removeCurrentConversation() {
    conversations.removeAt(currentConversationIndex);
    currentConversationIndex = conversations.length - 1;
    if (conversations.isEmpty) {
      addEmptyConversation('');
    }
  }

  //rename conversation
  @action
  void renameConversation(String title) {
    if (title == "") {
      // no title, use default title
      title = 'New conversation $currentConversationIndex';
    }
    conversations[currentConversationIndex].title = title;
  }

  // clear all conversations
  @action
  void clearConversations() {
    conversations.clear();
    addEmptyConversation('');
  }

  // clear current conversation
  @action
  void clearCurrentConversation() {
    conversations[currentConversationIndex].messages.clear();
  }

  @action
  Future<void> sendMessage() async {

    List<Map<String, String>> messages = [
      {
        'role': "system",
        'content': "",
      }
    ];
    for (Message message in conversations[currentConversationIndex].messages) {
      messages.add({
        'role': message.senderId == 'User' ? 'user' : 'system',
        'content': message.content
      });
    }

    final future = _sendMessageUseCase.call(params: messages);
    fetchMessageFuture = ObservableFuture(future);

    future.then((assistantMessage) {
      if (assistantMessage != null) {
        addMessage(assistantMessage);
      }
    }).catchError((error) {
      errorStore.errorMessage = DioErrorUtil.handleError(error);
    });
  }

  // general methods:-----------------------------------------------------------
  void init() async {
    // getting current language from shared preference
    conversations.add(Conversation(messages: [], title: 'New conversation'));
  }

  // dispose:-------------------------------------------------------------------
  @override
  dispose() {}
}
