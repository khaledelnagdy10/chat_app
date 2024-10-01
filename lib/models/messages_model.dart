class MessageModel {
  final String message;
  final String messageId;
  final String email;

  MessageModel(
      {required this.message, required this.messageId, required this.email});

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'message': message,
      'messageId': messageId,
      'email': email
    };
  }

  factory MessageModel.fromMap(Map<String, dynamic> map) {
    return MessageModel(
      message: map['message'] as String,
      messageId: map['messageId'] as String,
      email: map['email'] as String,
    );
  }
}
