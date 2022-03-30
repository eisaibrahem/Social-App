import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:social_app/layout/cubit/states.dart';
import 'package:social_app/models/comments_model.dart';
import 'package:social_app/models/message_model.dart';
import 'package:social_app/models/notification_model.dart';
import 'package:social_app/models/post_model.dart';
import 'package:social_app/models/social_user_model.dart';
import 'package:social_app/modules/chats/chats_screen.dart';
import 'package:social_app/modules/feeds/feeds_screen.dart';
import 'package:social_app/modules/new_post/new_post_screen.dart';
import 'package:social_app/modules/settings/settings_screen.dart';
import 'package:social_app/modules/users/users_screen.dart';
import 'package:social_app/shared/constants.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:social_app/shared/network/end_points.dart';
import 'package:social_app/shared/network/local/cache_helper.dart';
import 'package:social_app/shared/network/remote/dio_helper.dart';

class SocialCubit extends Cubit<SocialStates> {
  SocialCubit() : super(SocialGetUserInitialState());

  static SocialCubit get(context) => BlocProvider.of(context);

  SocialUserModel? userModel;
  void getUserData() {
    emit(SocialGetUserLoadingState());
    FirebaseFirestore.instance
        .collection('users')
        .doc(CacheHelper.getData(key: "uId"))
        .get()
        .then((value) {
      userModel = SocialUserModel.fromJson(value.data()!);

      print('vvvvvvvvvvvvvvvvvvvvvvvvvvvvv');
      print(value.data());
      print('vvvvvvvvvvvvvvvvvvvvvvvvvvvvv');
      emit(SocialGetUserSuccessState());
    }).catchError((error) {
      print('ffffffffffffffffffffggffffffff');
      print(error.toString());
      print('fffffffffffffffffffffffffffffff');
      emit(SocialGetUserErrorState(error.toString()));
    });
  }

  int currentIndex = 0;

  List<Widget> screens = [
    FeedsScreen(),
    ChatsScreen(),
    NewPostScreen(),
    UsersScreen(),
    SettingScreen(),
  ];
  List<String> titles = [
    'Home',
    'Chats',
    'New Post',
    'Users',
    'Settings',
  ];

  void changeBottomNav(int index) {
    if (index == 1) {
      getUsers();
    }
    if (index == 4) {
      emit(SocialSettingState());
    } else {
      currentIndex = index;
      emit(SocialChangeBottomNavState());
    }
  }

  final imagePicker = ImagePicker();

  File? profileImage;
  Future<void> getProfileImage(ImageSource src) async {
    final pickedFile = await imagePicker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      profileImage = File(pickedFile.path);
      emit(SocialProfileImagePickedSuccessState());
    } else {
      print('image not select');
      emit(SocialProfileImagePickedErrorState());
    }
  }

  File? coverImage;
  Future<void> getCoverImage(ImageSource src) async {
    final pickedFile = await imagePicker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      coverImage = File(pickedFile.path);
      emit(SocialProfileImagePickedSuccessState());
    } else {
      print('image not select');
      emit(SocialProfileImagePickedErrorState());
    }
  }

  File? postImage;
  Future<void> getPostImage(ImageSource src) async {
    final pickedFile = await imagePicker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      postImage = File(pickedFile.path);
      emit(SocialPostImagePickedSuccessState());
    } else {
      print('image not select');
      emit(SocialPostImagePickedErrorState());
    }
  }

  void removePostImage() {
    postImage = null;
    emit(SocialRemovePostImageState());
  }

  void uploadProfileImage({
    required String? name,
    required String? phone,
    required String? bio,
  }) {
    emit(SocialUserUpdateLoadingState());
    print('${Uri.file(profileImage!.path).pathSegments.last}');
    firebase_storage.FirebaseStorage.instance
        .ref()
        .child('users/${Uri.file(profileImage!.path).pathSegments.last}')
        .putFile(profileImage!)
        .then((value) {
      value.ref.getDownloadURL().then((value) {
        //  emit(SocialUploadProfileImageSuccessState());
        print(value);
        updateUser(
          name: name,
          phone: phone,
          bio: bio,
          image: value,
        );
      }).catchError((error) {
        print('fffffffffffffffff2');
        print(error.toString());
        print('fffffffffffffffff2');
        emit(SocialUploadProfileImageErrorState());
      });
    }).catchError((error) {
      print('ffffffffffffffffffffffffffff1');
      print(error.toString());
      print('ffffffffffffffffffffffffffff1');
      emit(SocialUploadProfileImageErrorState());
    });
  }

  void uploadCoverImage({
    required String? name,
    required String? phone,
    required String? bio,
  }) {
    emit(SocialUserUpdateLoadingState());
    firebase_storage.FirebaseStorage.instance
        .ref()
        .child("users/${Uri.file(coverImage!.path).pathSegments.last}")
        .putFile(coverImage!)
        .then((value) {
      value.ref.getDownloadURL().then((value) {
        //   emit(SocialUploadCoverImageSuccessState());
        print(value);
        updateUser(name: name, phone: phone, bio: bio, cover: value);
      }).catchError((error) {
        print('fffffffffffffffff2');
        print(error.toString());
        print('fffffffffffffffff2');
        emit(SocialUploadCoverImageErrorState());
      });
    }).catchError((error) {
      print('ffffffffffffffffffffffffffff1');
      print(error.toString());
      print('ffffffffffffffffffffffffffff1');
      emit(SocialUploadCoverImageErrorState());
    });
  }

//   void updateUserImages({
//   required String? name,
//   required String? phone,
//   required String? bio,
//
// }) {
//     emit(SocialUserUpdateLoadingState());
//     if(coverImage != null){
//       uploadCoverImage(name: name, phone: phone, bio: bio,);
//     }else if(profileImage != null){
//       uploadProfileImage(name: name, phone: phone, bio: bio,);
//     }else if(profileImage != null&&coverImage != null){
//
//     }
//     else{
//       updateUser(name: name,phone: phone,bio: bio);
//     }
//     }

  void updateUser({
    required String? name,
    required String? phone,
    required String? bio,
    String? cover,
    String? image,
  }) {
    SocialUserModel model = SocialUserModel(
        image: image ?? userModel!.image,
        cover: cover ?? userModel!.cover,
        email: userModel!.email,
        phone: phone ?? 'null',
        name: name ?? 'null',
        uId: userModel!.uId,
        bio: bio ?? 'null',
        isEmailVerified: false,
        token: userModel!.token);
    FirebaseFirestore.instance
        .collection('users')
        .doc(userModel!.uId)
        .update(model.toMap())
        .then((value) {
      getUserData();
    }).catchError((error) {
      print(error.toString());
      emit(SocialUserUpdateErrorState());
    });
  }

  void uploadPostImage({
    required String? dateTime,
    required String? text,
  }) {
    emit(SocialCreatePostLoadingState());
    firebase_storage.FirebaseStorage.instance
        .ref()
        .child("posts/${Uri.file(postImage!.path).pathSegments.last}")
        .putFile(postImage!)
        .then((value) {
      value.ref.getDownloadURL().then((value) {
        text = '';
        postImage = null;
        emit(SocialUploadPostImageSuccessState());
        print(value);
        createPost(dateTime: dateTime, text: text, postImage: value);
      }).catchError((error) {
        print('fffffffffffffffff2');
        print(error.toString());
        print('fffffffffffffffff2');
        emit(SocialCreatePostErrorState());
      });
    }).catchError((error) {
      print('ffffffffffffffffffffffffffff1');
      print(error.toString());
      print('ffffffffffffffffffffffffffff1');
      emit(SocialCreatePostErrorState());
    });
  }

  void createPost({
    required String? dateTime,
    required String? text,
    String? postImage,
  }) {
    emit(SocialCreatePostLoadingState());
    PostModel model = PostModel(
      image: userModel!.image,
      name: userModel!.name,
      uId: userModel!.uId,
      dateTime: dateTime,
      text: text,
      postImage: postImage ?? "",
    );

    FirebaseFirestore.instance
        .collection('posts')
        .add(model.toMap())
        .then((value) {
      text = '';
      emit(SocialCreatePostSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(SocialCreatePostErrorState());
    });
  }

  List<PostModel> posts = [];
  List<String> postsId = [];
  List<int> postLikes = [];

  void getPosts() {
    FirebaseFirestore.instance.collection('posts').snapshots().listen((event) {
      posts = [];
      event.docs.forEach((element) {
        element.reference.collection('likes').get().then((value) {
          postLikes.add(value.docs.length);
          postsId.add(element.id);
          posts.insert(0, PostModel.fromJson(element.data()));
        }).catchError((error) {});
      });

      emit(SocialGetPostSuccessState());
    });
  }

  void likePost(String postId) {
    FirebaseFirestore.instance
        .collection('posts')
        .doc(postId)
        .collection('likes')
        .doc(userModel!.uId)
        .set({
      'like': true,
    }).then((value) {
      emit(SocialLikePostSuccessState());
    }).catchError((error) {
      emit(SocialLikePostErrorState(error.toString()));
    });
  }

  List<SocialUserModel> users = [];

  void getUsers() {
    if (users.length == 0) {
      FirebaseFirestore.instance.collection('users').get().then((value) {
        value.docs.forEach((element) {
          if (element.data()['uId'] != userModel!.uId) {
            users.add(SocialUserModel.fromJson(element.data()));
          }
        });

        emit(SocialGetAllUsersSuccessState());
      }).catchError((error) {
        emit(SocialGetAllUsersErrorState(error.toString()));
      });
    }
  }

//comments

  List<CommentsModel> comments = [];
  List<String> commentId = [];
  List<int> commentLikes = [];

  File? commentImage;
  Future<void> getCommentImage(ImageSource src) async {
    final pickedFile = await imagePicker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      commentImage = File(pickedFile.path);
      emit(SocialCommentImagePickedSuccessState());
    } else {
      print('image not select');
      emit(SocialCommentImagePickedErrorState());
    }
  }

  void removeCommentImage() {
    commentImage = null;
    emit(SocialRemoveCommentImageState());
  }

  void commentPost(String postId, int index) {
    FirebaseFirestore.instance
        .collection('posts')
        .doc(postId)
        .collection('comments')
        .doc(userModel!.uId)
        .set({
      '${userModel!.name}': '${comments[index].text}',
    }).then((value) {
      emit(SocialCommentPostSuccessState());
    }).catchError((error) {
      emit(SocialCommentPostErrorState(error.toString()));
    });
  }

  void uploadCommentImage({
    required String? dateTime,
    required String? postId,
    required String? text,
  }) {
    emit(SocialCreateCommentLoadingState());
    firebase_storage.FirebaseStorage.instance
        .ref()
        .child("comments/${Uri.file(commentImage!.path).pathSegments.last}")
        .putFile(commentImage!)
        .then((value) {
      value.ref.getDownloadURL().then((value) {
        text = '';
        commentImage = null;
        emit(SocialUploadCommentImageSuccessState());
        print(value);
        createComment(
            dateTime: dateTime,
            text: text,
            commentImage: value,
            postId: postId!);
      }).catchError((error) {
        print('fffffffffffffffff2');
        print(error.toString());
        print('fffffffffffffffff2');
        emit(SocialCreateCommentErrorState());
      });
    }).catchError((error) {
      print('ffffffffffffffffffffffffffff1');
      print(error.toString());
      print('ffffffffffffffffffffffffffff1');
      emit(SocialCreateCommentErrorState());
    });
  }

  void createComment({
    required String postId,
    required String? dateTime,
    required String? text,
    String? commentImage,
  }) {
    emit(SocialCreateCommentLoadingState());
    CommentsModel commentsModel = CommentsModel(
      image: userModel!.image,
      name: userModel!.name,
      uId: userModel!.uId,
      dateTime: dateTime,
      text: text,
      commentImage: commentImage ?? "",
    );

    FirebaseFirestore.instance
        .collection('posts')
        .doc(postId)
        .collection('comments')
        .doc(userModel!.uId)
        .collection('comment')
        .add(commentsModel.toMap())
        .then((value) {
      emit(SocialCreateCommentSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(SocialCreateCommentErrorState());
    });
  }

  void getComments(String postId) {
    emit(SocialGetCommentLoadingState());
    FirebaseFirestore.instance
        .collection('posts')
        .doc(postId)
        .collection('comments')
        .doc(userModel!.uId)
        .collection('comment')
        .orderBy('dateTime')
        .snapshots()
        .listen((event) {
      comments = [];
      event.docs.forEach((element) {
        comments.add(CommentsModel.fromJson(element.data()));
      });
      emit(SocialGetCommentSuccessState());
    });
  }

//Chats

  void sendMessage({
    required String? receiverId,
    required String? dateTime,
    required String? text,
    required String? messageImage,
  }) {
    MessageModel messageModel = MessageModel(
      receiverId: receiverId,
      senderId: userModel!.uId,
      text: text,
      dateTime: dateTime,
      chatImage: messageImage ?? '',
    );
//set my chat
    FirebaseFirestore.instance
        .collection("users")
        .doc(userModel!.uId)
        .collection('chats')
        .doc(receiverId)
        .collection('messages')
        .add(messageModel.toMap())
        .then((value) {
      emit(SocialSendMessageSuccessState());
    }).catchError((error) {
      emit(SocialSendMessageErrorState());
      print(error.toString());
    });
//set receiver chat
    FirebaseFirestore.instance
        .collection("users")
        .doc(receiverId)
        .collection('chats')
        .doc(userModel!.uId)
        .collection('messages')
        .add(messageModel.toMap())
        .then((value) {
      emit(SocialSendMessageSuccessState());
    }).catchError((error) {
      emit(SocialSendMessageErrorState());
      print(error.toString());
    });
  }

  File? messageImage;
  Future<void> getMessageImage(ImageSource src) async {
    final pickedFile = await imagePicker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      messageImage = File(pickedFile.path);
      emit(SocialPostImagePickedSuccessState());
    } else {
      print('image not select');
      emit(SocialPostImagePickedErrorState());
    }
  }

  void removeMessageImage() {
    messageImage = null;
    emit(SocialRemovePostImageState());
  }

  void uploadChatImage({
    required String? receiverId,
    required String? dateTime,
    required String? text,
  }) {
    emit(SocialUploadMessageImageLoadingState());
    firebase_storage.FirebaseStorage.instance
        .ref()
        .child("chats/${Uri.file(messageImage!.path).pathSegments.last}")
        .putFile(messageImage!)
        .then((value) {
      value.ref.getDownloadURL().then((value) {
        text = text;
        messageImage = null;
        emit(SocialUploadMessageImageSuccessState());
        print(value);
        sendMessage(
            dateTime: dateTime,
            text: text,
            messageImage: value,
            receiverId: receiverId);
      }).catchError((error) {
        print('fffffffffffffffff2');
        print(error.toString());
        print('fffffffffffffffff2');
        emit(SocialSendMessageErrorState());
      });
    }).catchError((error) {
      print('ffffffffffffffffffffffffffff1');
      print(error.toString());
      print('ffffffffffffffffffffffffffff1');
      emit(SocialUploadMessageImageErrorState());
    });
  }

  List<MessageModel> messages = [];

  void getMessages({
    required String? receiverId,
  }) {
    emit(SocialGetMessagesLoadingState());
    FirebaseFirestore.instance
        .collection('users')
        .doc(userModel!.uId)
        .collection('chats')
        .doc(receiverId)
        .collection('messages')
        .orderBy('dateTime')
        .snapshots()
        .listen((event) {
      messages = [];
      event.docs.forEach((element) {
        messages.add(MessageModel.fromJson(element.data()));
      });
      emit(SocialGetMessagesSuccessState());
    });
  }

  bool show = false;
  void changeIcon() {
    show = !show;
    emit(SocialChangeEmojeIconState());
  }

// search

  List<SocialUserModel> searchesListUsers = [];

  void searchUser({
    required String text,
  }) {
    emit(SearchLoadingState());
    FirebaseFirestore.instance
        .collection('users')
        .where(
          'name',
          isGreaterThanOrEqualTo: text,
        )
        .snapshots()
        .listen((event) {
      searchesListUsers = [];
      event.docs.forEach((element) {
        searchesListUsers.add(SocialUserModel.fromJson(element.data()));
      });
      if (text == '') {
        searchesListUsers = [];
      }
    });
  }

  List<PostModel> searchesListPosts = [];
  void searchPost({
    required String text,
  }) {
    emit(SearchLoadingState());
    FirebaseFirestore.instance
        .collection('posts')
        .where(
      'text',
      isGreaterThanOrEqualTo: text,
    )
        .snapshots()
        .listen((event) {
      searchesListPosts = [];
      event.docs.forEach((element) {
        searchesListPosts.add(PostModel.fromJson(element.data()));
      });
      if (text == '') {
        searchesListPosts = [];
      }
    });
  }

  //tags


  List<PostModel> tags = [];

  void getTags({
    required String tage,
  }) {
    emit(SearchLoadingState());
    FirebaseFirestore.instance
        .collection('posts')
        .where(
      'text',
      isGreaterThanOrEqualTo: "#$tage",
    )
        .snapshots()
        .listen((event) {
      tags = [];
      event.docs.forEach((element) {
        tags.add(PostModel.fromJson(element.data()));
      });

    });
  }







// notifications
  void sendNotification({
    required String textBody,
    required String receiverToken,
    required String dateTime,
  }) {
    NotificationModel notificationModel = NotificationModel(
      title: userModel!.name,
      body: textBody,
      dateTime: dateTime,
    );
    DioHelper.postData(
      url: SEND_NOTIFICATION,
      data: {
        "to": receiverToken,
        "notification": {
          "title": userModel!.name,
          "body": textBody,
          "sound": "default"
        },
        "android": {
          "priority": "HIGH",
          "notification": {
            "notification_priority": "PRIORITY_MAX",
            "sound": "default",
            "default_sound": true,
            "default_vibrate_timing": true,
            "default_light_setting": true
          }
        },
        "data": {
          "type": "order",
          "id": userModel!.uId,
          "click_action": "FLUTTER_NOTIFICATION_CLICK"
        }
      },
    ).then((value) {
      FirebaseFirestore.instance
          .collection("users")
          .doc(userModel!.uId)
          .collection('notifications')
          .add(notificationModel.toMap())
          .then((value) {
        emit(SocialSendMessageNotificationSuccessState());
      }).catchError((error) {
        emit(SocialSendMessageNotificationErrorState());
        print(error.toString());
      });
    }).catchError((error) {
      emit(SocialSendMessageNotificationErrorState());
      print("ffffffffffffffSendMessageNotificationffffffffffff");
      print(error.toString());
      print('fffffffffffffffffffffffffffffffffffffffffffffffff');
    });
  }

  List<NotificationModel> notifications = [];
  void getNotifications(String postId) {
    emit(SocialGetNotificationsSuccessState());
    FirebaseFirestore.instance
        .collection("users")
        .doc(userModel!.uId)
        .collection('notifications')
        .orderBy('dateTime')
        .snapshots()
        .listen((event) {
      notifications = [];
      event.docs.forEach((element) {
        notifications.add(NotificationModel.fromJson(element.data()));
      });
      emit(SocialGetNotificationsErrorState());
    });
  }

}
