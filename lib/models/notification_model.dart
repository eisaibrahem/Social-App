class NotificationModel {
  String? title;
  String? body;
  String? dateTime;


  NotificationModel({this.title,this.body,this.dateTime});

  NotificationModel.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    body = json['body'];
    dateTime = json['dateTime'];

  }

  Map<String, dynamic> toMap() {
    return
      {
        'title': title,
        'body': body,
        'dateTime': dateTime,

      };
  }
}




