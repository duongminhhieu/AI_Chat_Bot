import 'package:boilerplate/constants/secrets.dart';
import 'package:boilerplate/presentation/chat/store/chat/chat_store.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:material_dialog/material_dialog.dart';

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
  final LanguageStore _languageStore = getIt<LanguageStore>();
  final ChatStore _chatStore = getIt<ChatStore>();

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
      final userMessage = Message(senderId: _chatStore.userSender.id, content: text);
      setState(() {
        // add to current conversation
        _chatStore.addMessage(userMessage);
      });

      // TODO:scroll to last message
      _scrollToLastMessage();

      _chatStore.sendMessage();

      // TODO:scroll to last message
      _scrollToLastMessage();
    }
  }


  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (BuildContext context) {
        return Scaffold(
          appBar: _buildAppBar(),
          body: GestureDetector(
            onTap: () => FocusScope.of(context).unfocus(),
            onVerticalDragDown: (_) => FocusScope.of(context).unfocus(),
            child: Scaffold(
              // resizeToAvoidBottomInset: true,
              body: Column(
                children: [
                  Expanded(
                      child: ListView.builder(
                        controller: _scrollController,
                        itemCount: _chatStore.currentConversationLength,
                        itemBuilder: (BuildContext context, int index) {
                          Message message = _chatStore.currentConversation.messages[index];
                          return Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 8.0, horizontal: 16.0),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                if (message.senderId != _chatStore.userSender.id)
                                  CircleAvatar(
                                    backgroundImage:
                                    AssetImage(_chatStore.systemSender.avatarAssetPath),
                                    radius: 16.0,
                                  )
                                else
                                  const SizedBox(width: 24.0),
                                const SizedBox(width: 8.0),
                                Expanded(
                                  child: Align(
                                    alignment: message.senderId == _chatStore.userSender.id
                                        ? Alignment.centerRight
                                        : Alignment.centerLeft,
                                    child: Container(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 8.0, horizontal: 16.0),
                                      decoration: BoxDecoration(
                                        color: message.senderId == _chatStore.userSender.id
                                            ? const Color(0xff55bb8e)
                                            : Colors.grey[200],
                                        borderRadius: BorderRadius.circular(16.0),
                                        boxShadow: [
                                          BoxShadow(
                                            color: Colors.black.withOpacity(0.05),
                                            blurRadius: 5,
                                            offset: const Offset(0, 2),
                                          ),
                                        ],
                                      ),
                                      child: Text(
                                        message.content,
                                        style: TextStyle(
                                          color: message.senderId == _chatStore.userSender.id
                                              ? Colors.white
                                              : Colors.black,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 8.0),
                                if (message.senderId == _chatStore.userSender.id)
                                  CircleAvatar(
                                    backgroundImage:
                                    AssetImage(_chatStore.userSender.avatarAssetPath),
                                    radius: 16.0,
                                  )
                                else
                                  const SizedBox(width: 24.0),
                              ],
                            ),
                          );
                        },
                      )
                  ),

                  // input box
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      borderRadius: BorderRadius.circular(32.0),
                    ),
                    margin:
                    const EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
                    padding:
                    const EdgeInsets.symmetric(vertical: 0.0, horizontal: 16.0),
                    child: Row(
                      children: [
                        Expanded(
                          child: TextField(
                            controller: _textController,
                            decoration: const InputDecoration.collapsed(
                                hintText: 'Type your message...'),
                          ),
                        ),
                        Observer(
                          builder: (BuildContext context) {
                            if(_chatStore.apiKey == SecretsString.apiKey){
                              return IconButton(
                                icon: const Icon(Icons.send),
                                onPressed:() { showRenameDialog(context);},
                              );
                            } else {
                              return IconButton(
                                icon: const Icon(Icons.send),
                                onPressed:() { _sendMessageAndAddToChat();},
                              );                        }
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
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
      _buildLanguageButton(),
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
                    hintText: _chatStore
                        .currentConversation
                        .title,
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
                      'Rename'
                      , style: TextStyle(
                      color: Color(0xff55bb8e),
                    ),
                    ),
                    onPressed: () {
                      // Call renameConversation method here with the new name
                      _chatStore
                          .renameConversation(newName);
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
         _chatStore
              .removeCurrentConversation();
        } else if (value == "refresh") {
          // refresh
          _chatStore
              .clearCurrentConversation();
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
            _themeStore.darkMode ? Icons.brightness_5 : Icons.brightness_3,
          ),
        );
      },
    );
  }


  Widget _buildLanguageButton() {
    return IconButton(
      onPressed: () {
        _buildLanguageDialog();
      },
      icon: Icon(
        Icons.language,
      ),
    );
  }

  _buildLanguageDialog() {
    _showDialog<String>(
      context: context,
      child: MaterialDialog(
        borderRadius: 5.0,
        enableFullWidth: true,
        title: Text(
          AppLocalizations.of(context).translate('home_tv_choose_language'),
          style: TextStyle(
            color: Colors.white,
            fontSize: 16.0,
          ),
        ),
        headerColor: Theme.of(context).primaryColor,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        closeButtonColor: Colors.white,
        enableCloseButton: true,
        enableBackButton: false,
        onCloseButtonClicked: () {
          Navigator.of(context).pop();
        },
        children: _languageStore.supportedLanguages
            .map(
              (object) => ListTile(
            dense: true,
            contentPadding: EdgeInsets.all(0.0),
            title: Text(
              object.language!,
              style: TextStyle(
                color: _languageStore.locale == object.locale
                    ? Theme.of(context).primaryColor
                    : _themeStore.darkMode
                    ? Colors.white
                    : Colors.black,
              ),
            ),
            onTap: () {
              Navigator.of(context).pop();
              // change user language based on selected locale
              _languageStore.changeLanguage(object.locale!);
            },
          ),
        )
            .toList(),
      ),
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

}
