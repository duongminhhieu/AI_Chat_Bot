import 'package:boilerplate/constants/secrets.dart';
import 'package:boilerplate/presentation/chat/store/chat/chat_store.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:material_dialog/material_dialog.dart';

import '../../core/widgets/progress_indicator_widget.dart';
import '../../di/service_locator.dart';
import '../../domain/entity/chat/chat.dart';
import '../../utils/locale/app_localization.dart';
import 'dialogs/secrets_dialog.dart';
import 'store/language/language_store.dart';
import 'store/theme/theme_store.dart';

class ChatView extends StatefulWidget {
  const ChatView({Key? key}) : super(key: key);

  @override
  State<ChatView> createState() => _ChatViewState();
}

class _ChatViewState extends State<ChatView> {
  //controllers:-----------------------------------------------------------
  final TextEditingController _textController = TextEditingController();
  final ScrollController _scrollController = ScrollController();

  //focus node:-----------------------------------------------------------------
  final FocusNode _focusNode = FocusNode();

  //stores:---------------------------------------------------------------------
  final ThemeStore _themeStore = getIt<ThemeStore>();
  final ChatStore _chatStore = getIt<ChatStore>();

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
  }

  //scroll to last message
  void _scrollToLastMessage() {
    final double height = _scrollController.position.maxScrollExtent;
    final double lastMessageHeight =
        _scrollController.position.viewportDimension;
    _scrollController.animateTo(
      height,
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeOut,
    );
  }

  void _sendMessageAndAddToChat() async {
    final text = _textController.text.trim();
    if (text.isNotEmpty) {
      _textController.clear();
      final userMessage =
          Message(senderId: _chatStore.userSender.id, content: text);

      _chatStore.addMessage(userMessage);

      _scrollToLastMessage();

      _chatStore.sendMessage();

      _scrollToLastMessage();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      drawer: _buildDrawer(),
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        onVerticalDragDown: (_) => FocusScope.of(context).unfocus(),
        child: Scaffold(
          // resizeToAvoidBottomInset: true,
          body: Observer(
            builder: (context) {
              return Column(
                children: [
                  Expanded(
                      child: _chatStore.loading
                          ? CustomProgressIndicatorWidget()
                          : ListView.builder(
                              controller: _scrollController,
                              itemCount: _chatStore.currentConversationLength,
                              key: UniqueKey(),
                              itemBuilder: (BuildContext context, int index) {

                                Message message = _chatStore
                                    .currentConversation.messages[index];
                                return Padding(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 8.0, horizontal: 16.0),
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      if (message.senderId !=
                                          _chatStore.userSender.id)
                                        CircleAvatar(
                                          backgroundImage: AssetImage(_chatStore
                                              .systemSender.avatarAssetPath),
                                          radius: 16.0,
                                        )
                                      else
                                        const SizedBox(width: 24.0),
                                      const SizedBox(width: 8.0),
                                      Expanded(
                                        child: Align(
                                          alignment: message.senderId ==
                                                  _chatStore.userSender.id
                                              ? Alignment.centerRight
                                              : Alignment.centerLeft,
                                          child: Container(
                                            padding: const EdgeInsets.symmetric(
                                                vertical: 8.0,
                                                horizontal: 16.0),
                                            decoration: BoxDecoration(
                                              color: message.senderId ==
                                                      _chatStore.userSender.id
                                                  ? const Color(0xff55bb8e)
                                                  : Colors.grey[200],
                                              borderRadius:
                                                  BorderRadius.circular(16.0),
                                              boxShadow: [
                                                BoxShadow(
                                                  color: Colors.black
                                                      .withOpacity(0.05),
                                                  blurRadius: 5,
                                                  offset: const Offset(0, 2),
                                                ),
                                              ],
                                            ),
                                            child: Text(
                                              message.content,
                                              style: TextStyle(
                                                color: message.senderId ==
                                                        _chatStore.userSender.id
                                                    ? Colors.white
                                                    : Colors.black,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                      const SizedBox(width: 8.0),
                                      if (message.senderId ==
                                          _chatStore.userSender.id)
                                        CircleAvatar(
                                          backgroundImage: AssetImage(_chatStore
                                              .userSender.avatarAssetPath),
                                          radius: 16.0,
                                        )
                                      else
                                        const SizedBox(width: 24.0),
                                    ],
                                  ),
                                );
                              },
                            )),

                  // input box
                  Container(
                    decoration: BoxDecoration(
                      color: _themeStore.darkMode
                          ? Colors.grey[850]
                          : Colors.grey[300],
                      borderRadius: BorderRadius.circular(32.0),
                    ),
                    margin: const EdgeInsets.symmetric(
                        vertical: 16.0, horizontal: 16.0),
                    padding: const EdgeInsets.symmetric(
                        vertical: 0.0, horizontal: 16.0),
                    child: Row(
                      children: [
                        Expanded(
                          child: TextField(
                            controller: _textController,
                            style: _themeStore.darkMode
                                ? const TextStyle(color: Colors.white)
                                : const TextStyle(color: Colors.black),
                            decoration: const InputDecoration.collapsed(
                                hintText: 'Type your message...'),
                          ),
                        ),
                        (_chatStore.apiKey == SecretsString.apiKey)
                            ? IconButton(
                                icon: const Icon(Icons.send),
                                onPressed: () {
                                  showRenameDialog(context);
                                },
                              )
                            : IconButton(
                                icon: const Icon(Icons.send),
                                onPressed: () {
                                  _sendMessageAndAddToChat();
                                },
                              )
                      ],
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }

  // app bar methods:-----------------------------------------------------------
  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      title: Text(_chatStore.currentConversationTitle),
      actions: _buildActions(context),
    );
  }

  List<Widget> _buildActions(BuildContext context) {
    return <Widget>[
      _buildThemeButton(),
      _buildCustomPopupMenuButton(),
    ];
  }

  Widget _buildCustomPopupMenuButton() {
    return PopupMenuButton(
      icon: const Icon(Icons.more_vert),
      itemBuilder: (BuildContext context) => <PopupMenuEntry>[
        const PopupMenuItem(
          value: "rename",
          child: ListTile(
            leading: Icon(Icons.edit),
            title: Text('Rename'),
          ),
        ),
        const PopupMenuItem(
          value: "refresh",
          child: ListTile(
            leading: Icon(Icons.refresh),
            title: Text('Refresh'),
          ),
        ),
        const PopupMenuItem(
          value: "delete",
          child: ListTile(
            leading: Icon(Icons.delete),
            title: Text('Delete'),
          ),
        ),
      ],
      elevation: 2,
      padding: EdgeInsets.zero,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      onSelected: (value) {
        if (value == "rename") {
          // rename
          showDialog(
            context: context,
            builder: (BuildContext context) {
              String newName = '';
              return AlertDialog(
                title: const Text('Rename Conversation'),
                content: TextField(
                  // display the current name of the conversation
                  decoration: InputDecoration(
                    hintText: _chatStore.currentConversation.title,
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
                      'Rename',
                      style: TextStyle(
                        color: Color(0xff55bb8e),
                      ),
                    ),
                    onPressed: () {
                      // Call renameConversation method here with the new name
                      _chatStore.renameConversation(newName);
                      Navigator.pop(context);
                    },
                  ),
                ],
              );
            },
          );

          // Provider.of<ConversationProvider>(context, listen: false)
          //     .renameCurrentConversation();
        } else if (value == "delete") {
          // delete
          _chatStore.removeCurrentConversation();
        } else if (value == "refresh") {
          // refresh
          _chatStore.clearCurrentConversation();
        }
      },
    );
  }

  Widget _buildThemeButton() {
    return Observer(
      builder: (context) {
        return IconButton(
          onPressed: () {
            _themeStore.changeBrightnessToDark(!_themeStore.darkMode);
          },
          icon: Icon(
            _themeStore.darkMode
                ? Icons.brightness_6_outlined
                : Icons.brightness_3,
          ),
        );
      },
    );
  }

  _showDialog<T>({required BuildContext context, required Widget child}) {
    showDialog<T>(
      context: context,
      builder: (BuildContext context) => child,
    ).then<void>((T? value) {
      // The value passed to Navigator.pop() or null.
    });
  }

  Widget _buildDrawer() {
    return Drawer(
      child: SafeArea(
        child: Column(
          children: [
            Container(
              margin: const EdgeInsets.all(16.0),
              child: GestureDetector(
                onTap: () {
                  _chatStore.addEmptyConversation('');
                  Navigator.pop(context);
                },
                child: Container(
                  padding: const EdgeInsets.all(16.0),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    // border: Border.all(color: Color(Colors.grey[300]?.value ?? 0)),
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  child: Row(
                    // left align
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Icon(Icons.add, color: Colors.grey[800], size: 20.0),
                      const SizedBox(width: 15.0),
                      Text(
                        'New Chat',
                        style: TextStyle(
                          fontSize: 18.0,
                          fontFamily: 'din-regular',
                          color: Colors.grey[800],
                          // fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Expanded(
                child: ListView.builder(
                        itemCount: _chatStore.conversations.length,
                        itemBuilder: (BuildContext context, int index) {
                          Conversation conversation =
                              _chatStore.conversations[index];
                          return Dismissible(
                            key: UniqueKey(),
                            child: GestureDetector(
                              onTap: () {
                                _chatStore.currentConversationIndex = index;
                                Navigator.pop(context);
                              },
                              child: Container(
                                padding: const EdgeInsets.all(10.0),
                                margin: const EdgeInsets.symmetric(
                                    horizontal: 20.0, vertical: 4.0),
                                decoration: BoxDecoration(
                                  color: _chatStore.currentConversationIndex ==
                                          index
                                      ? const Color(0xff55bb8e)
                                      : Colors.white,
                                  // border: Border.all(color: Color(Colors.grey[200]?.value ?? 0)),
                                  borderRadius: BorderRadius.circular(8.0),
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    // conversation icon
                                    Icon(
                                      Icons.person,
                                      color:
                                          _chatStore.currentConversationIndex ==
                                                  index
                                              ? Colors.white
                                              : Colors.grey[700],
                                      size: 20.0,
                                    ),
                                    const SizedBox(width: 15.0),
                                    Text(
                                      conversation.title,
                                      style: TextStyle(
                                        // fontWeight: FontWeight.bold,
                                        color: _chatStore
                                                    .currentConversationIndex ==
                                                index
                                            ? Colors.white
                                            : Colors.grey[700],
                                        fontFamily: 'din-regular',
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                      )),
            // add a setting button at the end of the drawer
            Container(
              padding:
                  const EdgeInsets.symmetric(vertical: 14.0, horizontal: 30),
              child: GestureDetector(
                onTap: () {
                  showRenameDialog(context);
                },
                child: Row(
                  children: [
                    Icon(Icons.settings, color: Colors.grey[700], size: 20.0),
                    const SizedBox(width: 15.0),
                    Text(
                      'API Setting',
                      style: TextStyle(
                        fontFamily: 'din-regular',
                        color: Colors.grey[700],
                        fontSize: 18.0,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Container(
              padding:
                  const EdgeInsets.symmetric(vertical: 14.0, horizontal: 30),
              child: GestureDetector(
                onTap: () {
                  showProxyDialog(context);
                },
                child: Row(
                  children: [
                    Icon(Icons.settings, color: Colors.grey[700], size: 20.0),
                    const SizedBox(width: 15.0),
                    Text(
                      'Proxy Setting',
                      style: TextStyle(
                        fontFamily: 'din-regular',
                        color: Colors.grey[700],
                        fontSize: 18.0,
                      ),
                    ),
                    const SizedBox(
                      height: 50,
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
