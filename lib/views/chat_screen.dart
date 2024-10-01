import 'package:chat_app2/cubits/aut_cubit/auth_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:chat_app2/cubits/mess_cubit/message_cubit.dart';
import 'package:chat_app2/cubits/mess_cubit/message_state.dart';
import 'package:chat_app2/models/messages_model.dart';
import 'package:chat_app2/widgets/custom_text_field.dart';
import 'package:chat_bubbles/chat_bubbles.dart';

class ChatScreen extends StatefulWidget {
  ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  TextEditingController textController = TextEditingController();
  final scrollController = ScrollController();

  String message = '';
  String messageId = '';
  String emailId = '';
  String password = '';
  @override
  void initState() {
    super.initState();
    // Fetch messages when the screen loads
    BlocProvider.of<MessageCubit>(context).FetchData();
  }

  // Function to scroll to the bottom of the list
  void _scrollToBottom() {
    if (scrollController.hasClients) {
      scrollController.animateTo(
        scrollController.position.maxScrollExtent, // Scroll to the bottom
        duration:
            const Duration(milliseconds: 300), // Set scroll animation duration
        curve: Curves.easeOut, // Set scroll curve for a smoother effect
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/images/scholar.png',
              scale: 2,
            ),
            const Text(
              'chat',
              style: TextStyle(color: Colors.white),
            )
          ],
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: BlocListener<MessageCubit, MessageState>(
                listener: (context, state) {
                  if (state is MessageSucsses) {
                    // Scroll to the bottom after the messages are loaded
                    WidgetsBinding.instance.addPostFrameCallback((_) {
                      _scrollToBottom();
                    });
                  }
                },
                child: BlocBuilder<MessageCubit, MessageState>(
                  builder: (context, state) {
                    if (state is MessageSucsses) {
                      List<MessageModel> messageList = state.loadedMessages;
                      return ListView.builder(
                        controller: scrollController,
                        itemCount: messageList.length,
                        itemBuilder: (context, index) {
                          return messageList[index].email ==
                                  BlocProvider.of<AuthCubit>(context)
                                      .login(emailId, password)
                              ? BubbleNormal(
                                  text: messageList[index].message,
                                  isSender: true,
                                  color: Colors.blue,
                                )
                              : BubbleNormal(
                                  text: messageList[index].message,
                                  isSender: false,
                                  color: Colors.indigo,
                                );
                        },
                      );
                    }

                    // Show loading indicator while waiting for data
                    return const Center(child: CircularProgressIndicator());
                  },
                ),
              ),
            ),
            CustomTextField(
              controller: textController,
              hint: 'Write message',
              onSubmitted: (value) {
                message = value;

                // Send the message

                BlocProvider.of<MessageCubit>(context)
                    .sendData(message, messageId);
                textController.clear();

                // Scroll to the bottom after sending the message
                WidgetsBinding.instance.addPostFrameCallback((_) {
                  _scrollToBottom();
                });
              },
            ),
          ],
        ),
      ),
    );
  }
}
