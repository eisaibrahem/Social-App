class CommentsModel {
  String? name;
  String? uId;
  String? image;
  String? dateTime;
  String? text;
  String? commentImage;


  CommentsModel({
    this.uId,
    this.name,
    this.image,
    this.dateTime,
    this.text,
    this.commentImage,
  });

  CommentsModel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    uId = json['uId'];
    image = json['image'];
    dateTime = json['dateTime'];
    text = json['text'];
    commentImage = json['commentsImage'];
  }

  Map<String, dynamic> toMap() {
    return
      {
        'name': name,
        'uId': uId,
        'image': image,
        'dateTime': dateTime,
        'text': text,
        'commentsImage': commentImage,
      };
  }
}
