class MessageModel {
  String? senderId;
  String? receiverId;
  String? dateTime;
  String? text;
  String? chatImage;


  MessageModel({
    this.receiverId,
    this.senderId,
    this.dateTime,
    this.text,
    this.chatImage,
  });

  MessageModel.fromJson(Map<String, dynamic> json) {
    senderId = json['senderId'];
    receiverId = json['receiverId'];
    dateTime = json['dateTime'];
    text = json['text'];
    chatImage = json['chatImage'];
  }

  Map<String, dynamic> toMap() {
    return
      {
        'senderId': senderId,
        'receiverId': receiverId,
        'dateTime': dateTime,
        'text': text,
        'chatImage': chatImage,
      };
  }
}
