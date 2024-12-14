class MessageModel {
  final String message , id;
  MessageModel(this.message , this.id);

  factory MessageModel.fromJson(jsondata) {
    return MessageModel(jsondata['message'] , jsondata['id']);
  }
}
