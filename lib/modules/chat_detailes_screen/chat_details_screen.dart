import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:social_app/layout/cubit/cubit.dart';
import 'package:social_app/layout/cubit/states.dart';
import 'package:social_app/models/message_model.dart';
import 'package:social_app/models/social_user_model.dart';
import 'package:social_app/shared/components.dart';
import 'package:social_app/shared/constants.dart';
import 'package:social_app/shared/styles/Iconly-Broken_icons.dart';

class ChatDetailsScreen extends StatelessWidget {
  var textMessageController = TextEditingController();
  ScrollController _scrollController = ScrollController();
  FocusNode focusNode = FocusNode();
  SocialUserModel? receiverModel;
  ChatDetailsScreen(this.receiverModel);
  @override
  Widget build(BuildContext context) {

    return Builder(builder: (context) {
      SocialCubit.get(context).getMessages(receiverId: receiverModel!.uId);
      return BlocConsumer<SocialCubit, SocialStates>(
        listener: (context, state) {
          if (state is SocialSendMessageSuccessState) {
            textMessageController.text = '';
          }


          if (state is SocialGetMessagesSuccessState) {
            _scrollController.jumpTo(_scrollController.position.maxScrollExtent);
          }


        },
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
              title: Row(
                children: [
                  CircleAvatar(
                    radius: 20,
                    backgroundImage: NetworkImage('${receiverModel!.image}'),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Text('${receiverModel!.name}'),
                  Spacer(),
                  Container(
                      width: 20,
                      child: IconButton(
                          onPressed: () {},
                          icon: Icon(Icons.more_vert))),
                ],
              ),
            ),
            body: ConditionalBuilder(
              condition: SocialCubit.get(context).users.isNotEmpty,
              builder: (context) => Container(
                padding: EdgeInsets.all(5),
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                child: Column(
                  children: [
                    Expanded(
                     // height: MediaQuery.of(context).size.height,
                      child: ListView.separated(
                        keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
                        controller: _scrollController,
                        shrinkWrap: true,
                        physics: BouncingScrollPhysics(),
                        itemBuilder: (context, index) {
                          if(index==SocialCubit.get(context).messages.length) {
                            return const SizedBox(height: 40,);
                          }
                          var message =
                              SocialCubit.get(context).messages[index];

                          if (SocialCubit.get(context).userModel!.uId ==
                              message.senderId) {
                            return buildMyMessage(message, context, state);
                          } else {
                            return buildMessage(message, context, state);
                          }
                        },
                        separatorBuilder: (context, index) => SizedBox(
                          height: 15,
                        ),
                        itemCount: SocialCubit.get(context).messages.length+1,
                      ),
                    ),
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          if (state is SocialUploadMessageImageLoadingState)
                            LinearProgressIndicator(),
                          if (SocialCubit.get(context).messageImage != null)
                            Stack(
                              alignment: AlignmentDirectional.topEnd,
                              children: [
                                Container(
                                  height: 250,
                                  decoration: BoxDecoration(
                                      color: kPrimaryColor,
                                      borderRadius: BorderRadius.circular(4),
                                      image: DecorationImage(
                                        image: FileImage(
                                                SocialCubit.get(context)
                                                    .messageImage!)
                                            as ImageProvider,
                                        fit: BoxFit.cover,
                                      )),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: CircleAvatar(
                                    radius: 20,
                                    backgroundColor: kPrimaryColor,
                                    child: IconButton(
                                        onPressed: () {
                                          SocialCubit.get(context)
                                              .removeMessageImage();
                                        },
                                        icon: Icon(
                                          Icons.close,
                                          size: 18,
                                        )),
                                  ),
                                )
                              ],
                            ),
                          Row(
                            children: [
                              Container(
                                width: MediaQuery.of(context).size.width *.83,
                                child: Card(
                                  margin: EdgeInsets.only(
                                      left: 2, right: 2, bottom: 8),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(25),
                                  ),
                                  child: TextFormField(
                                    textInputAction: TextInputAction.send,
                                    onFieldSubmitted: (value){
                                      var now = DateTime.now();
                                      var formatter = new DateFormat('dd-MM-yyyy');
                                      String formattedTime = DateFormat('hh:mm a').format(now);
                                      String formattedDate = formatter.format(now);

                                      print(now.toString());
                                      if (SocialCubit.get(context)
                                          .messageImage !=
                                          null &&
                                          textMessageController.text != '') {
                                        SocialCubit.get(context)
                                            .uploadChatImage(
                                          dateTime: now.toString(),
                                          text: textMessageController.text,
                                          receiverId: receiverModel!.uId,
                                        );
                                      } else if (SocialCubit.get(context)
                                          .messageImage !=
                                          null) {
                                        SocialCubit.get(context)
                                            .uploadChatImage(
                                          dateTime: now.toString(),
                                          text: '',
                                          receiverId: receiverModel!.uId,
                                        );
                                      } else if (textMessageController.text !=
                                          '') {
                                        SocialCubit.get(context).sendMessage(
                                          dateTime: now.toString(),
                                          text: textMessageController.text,
                                          receiverId: receiverModel!.uId,
                                          messageImage: '',
                                        );
                                      }
                                      SocialCubit.get(context).sendNotification(
                                          textBody: textMessageController.text,
                                          receiverToken: '/topics/announcement' ,
                                          dateTime: now.toString()
                                      );
                                      print(receiverModel!.token!);

                                    },
                                    focusNode: focusNode,
                                    controller: textMessageController,
                                    textAlignVertical: TextAlignVertical.center,
                                    keyboardType: TextInputType.multiline,
                                    decoration: InputDecoration(
                                      hintText: 'Message ',
                                      hintStyle: TextStyle(color: Colors.grey),
                                      border: InputBorder.none,
                                      prefix: IconButton(
                                        icon: Icon(
                            SocialCubit.get(context).show? Icons.keyboard:Icons.emoji_emotions_outlined,
                                        ),
                                        onPressed: () {
                                          if (!SocialCubit.get(context).show) {
                                            focusNode.unfocus();
                                            focusNode.canRequestFocus = false;
                                          }
                                          SocialCubit.get(context).changeIcon();


                                        },
                                      ),
                                      suffix: IconButton(
                                        onPressed: () {
                                          SocialCubit.get(context)
                                              .getMessageImage(
                                                  ImageSource.gallery);
                                        },
                                        icon: Icon(Iconly_Broken.Image),
                                      ),
                                      contentPadding: EdgeInsets.all(5),
                                    ),
                                  ),
                                ),
                              ),
                              Padding(
                                  padding: const EdgeInsets.only(
                                    bottom: 8,
                                    right: 2,
                                    left: 2,
                                  ),
                                  child: CircleAvatar(
                                    radius: 25,
                                    backgroundColor: kPrimaryColor,
                                    child: IconButton(
                                      onPressed: () {
                                        _scrollController.animateTo(_scrollController.position.maxScrollExtent,
                                          duration: Duration(milliseconds: 300),
                                          curve: Curves.easeOut,
                                        );
                                        var now = DateTime.now();
                                        var formatter = new DateFormat('dd-MM-yyyy');
                                        String formattedTime = DateFormat('hh:mm a').format(now);
                                        String formattedDate = formatter.format(now);

                                        print(now.toString());
                                        if (SocialCubit.get(context)
                                                    .messageImage !=
                                                null &&
                                            textMessageController.text != '') {
                                          SocialCubit.get(context)
                                              .uploadChatImage(
                                            dateTime: now.toString(),
                                            text: textMessageController.text,
                                            receiverId: receiverModel!.uId,
                                          );
                                        } else if (SocialCubit.get(context)
                                                .messageImage !=
                                            null) {
                                          SocialCubit.get(context)
                                              .uploadChatImage(
                                            dateTime: now.toString(),
                                            text: '',
                                            receiverId: receiverModel!.uId,
                                          );
                                        } else if (textMessageController.text !=
                                            '') {
                                          SocialCubit.get(context).sendMessage(
                                            dateTime: now.toString(),
                                            text: textMessageController.text,
                                            receiverId: receiverModel!.uId,
                                            messageImage: '',
                                          );
                                        }
                                          SocialCubit.get(context).sendNotification(
                                            textBody: textMessageController.text,
                                            receiverToken: '/topics/announcement' ,
                                            dateTime: now.toString()
                                        );
                                        print(receiverModel!.token!);


                                      },
                                      icon: Icon(
                                        Iconly_Broken.Send,
                                        color: Colors.white,
                                      ),
                                    ),
                                  )),
                            ],
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
              fallback: (context) => Center(child: CircularProgressIndicator()),
            ),
          );

        },
      );
    }

    );

  }

  Widget buildMyMessage(MessageModel messageModel, context, SocialStates state) {
    return Align(
      alignment: AlignmentDirectional.centerEnd,
      child: Container(
        constraints: BoxConstraints(
          maxWidth: MediaQuery.of(context).size.width * 0.70,
        ),
        decoration: BoxDecoration(
          color: kPrimaryColor.withOpacity(.2),
          borderRadius: BorderRadiusDirectional.only(
            bottomStart: Radius.circular(10),
            topStart: Radius.circular(10),
            topEnd: Radius.circular(10),
          ),
        ),
        padding: EdgeInsets.symmetric(
          vertical: 2,
          horizontal: 2,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            if (messageModel.chatImage != '')
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadiusDirectional.only(
                    bottomStart: Radius.circular(10),
                    topStart: Radius.circular(10),
                    topEnd: Radius.circular(10),
                  ),
                ),
                child: Image(
                  image: NetworkImage(
                    '${messageModel.chatImage}',
                    scale: 4,
                  ),
                  fit: BoxFit.cover,
                ),
                clipBehavior: Clip.antiAliasWithSaveLayer,
              ),
            if (messageModel.text != '')
              Padding(
                padding: const EdgeInsets.only(right: 20, left: 5),
                child: Text(
                  '${messageModel.text}',
                  style: TextStyle(fontSize: 16),
                ),
              ),
            Padding(
              padding: const EdgeInsets.only(right: 2),
              child: Text(
                '${DateFormat('hh:mm a').format(DateFormat("yyyy-MM-dd hh:mm:ss").parse(messageModel.dateTime!))}',
                style: Theme.of(context).textTheme.caption!.copyWith(
                      fontSize: 10,
                    ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget buildMessage(MessageModel messageModel, context, SocialStates state) {
    return Align(
      alignment: AlignmentDirectional.centerStart,
      child: Container(
        constraints: BoxConstraints(
          maxWidth: MediaQuery.of(context).size.width * 0.70,
        ),
        decoration: BoxDecoration(
          color: kPrimaryColor.withOpacity(.2),
          borderRadius: BorderRadiusDirectional.only(
            bottomEnd: Radius.circular(10),
            topStart: Radius.circular(10),
            topEnd: Radius.circular(10),
          ),
        ),
        padding: EdgeInsets.symmetric(
          vertical: 2,
          horizontal: 2,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            if (messageModel.chatImage != '')
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadiusDirectional.only(
                    bottomEnd: Radius.circular(10),
                    topStart: Radius.circular(10),
                    topEnd: Radius.circular(10),
                  ),
                ),
                child: Image(
                  image: NetworkImage(
                    '${messageModel.chatImage}',
                    scale: 4,
                  ),
                  fit: BoxFit.cover,
                ),
                clipBehavior: Clip.antiAliasWithSaveLayer,
              ),
            if (messageModel.text != '')
              Padding(
                padding: const EdgeInsets.only(right: 15, left: 5),
                child: Text(
                  '${messageModel.text}',
                  style: TextStyle(fontSize: 16),
                ),
              ),
            Padding(
              padding: const EdgeInsets.only(right: 2),
              child: Text(
                '${DateFormat('hh:mm a').format(DateFormat("yyyy-MM-dd hh:mm:ss").parse(messageModel.dateTime!))}',
                style: Theme.of(context).textTheme.caption!.copyWith(
                      fontSize: 10,
                    ),
              ),
            )
          ],
        ),
      ),
    );
  }
}


