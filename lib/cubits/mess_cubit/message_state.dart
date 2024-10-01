import 'package:chat_app2/models/messages_model.dart';

sealed class MessageState {}

class MessageInitial extends MessageState {}

class MessageLoading extends MessageState {}

class MessageSucsses extends MessageState {
  final List<MessageModel> loadedMessages;

  MessageSucsses(this.loadedMessages);
}

class MessageFailure extends MessageState {}
