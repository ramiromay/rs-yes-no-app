
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:yes_no_app/domain/entities/message.dart';
import 'package:yes_no_app/presentation/providers/chat_provider.dart';
import 'package:yes_no_app/presentation/widgets/chat/her_message_bubble.dart';
import 'package:yes_no_app/presentation/widgets/chat/my_message_bubble.dart';
import 'package:yes_no_app/presentation/widgets/shared/message_field_box.dart';

class ChatScreen extends StatelessWidget {

  const ChatScreen({
    super.key
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const Padding(
          padding: EdgeInsets.all(10.0),
          child: CircleAvatar(
            backgroundImage: NetworkImage('https://user-images.githubusercontent.com/1561955/106762302-fda9de00-6635-11eb-99be-3ef744e60c0e.png'),
          ),
        ),
        title: const Text('Midu'),
      ),
      body: _ChatView(),
    );
  }
}

class _ChatView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    final chatProvider = context.watch<ChatProvider>();

    return SafeArea(
        child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    controller: chatProvider.chatScrollController,
                      itemCount: chatProvider.messagesList.length,
                      itemBuilder: (context, index) {
                        final message = chatProvider.messagesList[index];
                        return (message.fromWho == FromWho.hers)
                            ? HerMessageBubble(message: message,)
                            : MyMessageBubble(message: message,);
                      }),
                ),
                //caja de texto
                MessageFieldBox(onValue: chatProvider.sendMessage,),
            ],
          )
        ),
    );
  }
}