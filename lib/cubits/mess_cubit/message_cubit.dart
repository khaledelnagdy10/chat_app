import 'package:chat_app2/cubits/mess_cubit/message_state.dart';
import 'package:chat_app2/models/messages_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MessageCubit extends Cubit<MessageState> {
  MessageCubit() : super(MessageInitial());
  String? email;
  final data = FirebaseFirestore.instance.collection('message');
  Future sendData(String message, String messageId) async {
    await data.doc().set({
      'id': email,
      'message': message,
      'messageId': messageId,
      'date': FieldValue.serverTimestamp()
    });
    FetchData();
  }

  Future FetchData() async {
    emit(MessageLoading());
    final result = await data.orderBy('date').get();
    List<MessageModel> loadedMessages =
        result.docs.map((e) => MessageModel.fromMap(e.data())).toList();
    emit(MessageSucsses(loadedMessages));
  }
}
