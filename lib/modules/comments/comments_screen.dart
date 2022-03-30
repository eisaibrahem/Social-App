import 'package:bloc/bloc.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:social_app/layout/cubit/cubit.dart';
import 'package:social_app/layout/cubit/states.dart';
import 'package:social_app/models/comments_model.dart';
import 'package:social_app/models/post_model.dart';
import 'package:social_app/modules/feeds/feeds_screen.dart';
import 'package:social_app/shared/components.dart';
import 'package:social_app/shared/constants.dart';
import 'package:social_app/shared/styles/Iconly-Broken_icons.dart';

class CommentsScreen extends StatelessWidget {
  CommentsScreen(this.postIndex);

  var textCommentController = TextEditingController();

  int? postIndex;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit, SocialStates>(
      listener: (context, state) {
        if(state is SocialGetCommentLoadingState){

        }

        if(state is SocialCreateCommentSuccessState){
          textCommentController.text='';

        }
      },
      builder: (context, state) {
        PostModel postModel=SocialCubit.get(context).posts[postIndex!];
        return Scaffold(
          appBar: defaultAppBar(
            context: context,
            title: 'Comments',
          ),
          body: Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  physics: BouncingScrollPhysics(),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Card(
                        elevation: 2,
                        clipBehavior: Clip.antiAliasWithSaveLayer,
                        child: Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  CircleAvatar(
                                    radius: 25,
                                    backgroundImage: NetworkImage(
                                        '${SocialCubit.get(context).userModel!.image}'),
                                  ),
                                  SizedBox(
                                    width: 15,
                                  ),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          children: [
                                            Text(
                                              '${postModel.name}',
                                              style: TextStyle(height: 1.4),
                                            ),
                                            SizedBox(
                                              width: 5,
                                            ),
                                            Icon(
                                              Icons.check_circle,
                                              color: Colors.blue,
                                              size: 16,
                                            )
                                          ],
                                        ),
                                        Text('${postModel.dateTime}',
                                            style: Theme.of(context)
                                                .textTheme
                                                .caption!
                                                .copyWith(height: 1.4)),
                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                    width: 15,
                                  ),
                                  IconButton(
                                      iconSize: 16,
                                      onPressed: () {},
                                      icon: Icon(Icons.more_horiz)),
                                ],
                              ),
                              SizedBox(
                                height: 10,
                              ),

                              Text(
                                '${postModel.text}',
                                style: Theme.of(context).textTheme.subtitle1,
                              ),
//tags
                              Padding(
                                padding: const EdgeInsets.only(top: 5),
                                child: Wrap(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsetsDirectional.only(end: 5),
                                      child: Container(
                                        height: 25,
                                        child: MaterialButton(
                                            onPressed: () {},
                                            minWidth: 1,
                                            padding: EdgeInsets.zero,
                                            child: Text('#SoftWare',
                                                style:
                                                Theme.of(context).textTheme.caption!.copyWith(
                                                  color: Colors.blue,
                                                ))),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsetsDirectional.only(end: 6),
                                      child: Container(
                                        height: 25,
                                        child: MaterialButton(
                                            onPressed: () {},
                                            minWidth: 1,
                                            padding: EdgeInsets.zero,
                                            child: Text('#Flutter',
                                                style:
                                                Theme.of(context).textTheme.caption!.copyWith(
                                                  color: Colors.blue,
                                                ))),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsetsDirectional.only(end: 6),
                                      child: Container(
                                        height: 25,
                                        child: MaterialButton(
                                            onPressed: () {},
                                            minWidth: 1,
                                            padding: EdgeInsets.zero,
                                            child: Text('#Development',
                                                style:
                                                Theme.of(context).textTheme.caption!.copyWith(
                                                  color: Colors.blue,
                                                ))),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              if (postModel.postImage != '')
                                Padding(
                                  padding: const EdgeInsets.symmetric(vertical: 10),
                                  child: Container(
                                    height: MediaQuery.of(context).size.height,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(4),
                                        image: DecorationImage(
                                          image: NetworkImage('${postModel.postImage}'),
                                          fit: BoxFit.cover,
                                        )),
                                  ),
                                ),
                              Padding(
                                padding: const EdgeInsets.symmetric(vertical: 5.0),
                                child: Row(
                                  children: [
                                    InkWell(
                                      child: Padding(
                                        padding:
                                        const EdgeInsets.only(top: 5, bottom: 5.0, right: 60),
                                        child: Row(
                                          children: [
                                            Icon(
                                              Iconly_Broken.Heart,
                                              size: 16,
                                              color: Colors.red,
                                            ),
                                            SizedBox(
                                              width: 5,
                                            ),
                                            Text(
                                              '${SocialCubit.get(context).postLikes.length}',
                                              style: Theme.of(context).textTheme.caption,
                                            )
                                          ],
                                        ),
                                      ),
                                      onTap: () {},
                                    ),
                                    Spacer(),
                                    InkWell(
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(vertical: 5.0),
                                        child: Text(
                                          '0  comment',
                                          style: Theme.of(context).textTheme.caption,
                                        ),
                                      ),
                                      onTap: () {},
                                    ),
                                  ],
                                ),
                              ),
//divider
                              Container(
                                width: double.infinity,
                                height: 1,
                                color: Colors.grey[300],
                              ),
                              Row(
                                children: [
                                  Expanded(
                                    child: InkWell(
                                      child: Padding(
                                        padding: const EdgeInsets.all(10.0),
                                        child: Row(
                                          children: [
                                            Icon(
                                              Iconly_Broken.Heart,
                                              size: 18,
                                              color: Colors.red,
                                            ),
                                            SizedBox(
                                              width: 5,
                                            ),
                                            Text(
                                              'Like ',
                                              style: Theme.of(context).textTheme.caption,
                                            )
                                          ],
                                        ),
                                      ),
                                      onTap: () {
                                        SocialCubit.get(context)
                                            .likePost(SocialCubit.get(context).postsId[postIndex!]);
                                      },
                                    ),
                                  ),
                                  SizedBox(
                                    width: 100,
                                  ),
                                  Expanded(
                                    child: InkWell(
                                      child: Padding(
                                        padding: const EdgeInsets.all(10.0),
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.end,
                                          children: [
                                            Icon(
                                              Iconly_Broken.Chat,
                                              size: 18,
                                              color: Colors.amber,
                                            ),
                                            SizedBox(
                                              width: 5,
                                            ),
                                            Text(
                                              'comment',
                                              style: Theme.of(context).textTheme.caption,
                                            )
                                          ],
                                        ),
                                      ),
                                      onTap: () {},
                                    ),
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: Text('Comments',
                          style: Theme.of(context).textTheme.bodyText1,
                        ),
                      ),
                      ListView.separated(
                        physics: NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                         var comments =SocialCubit.get(context).comments[index];
                         return buildCommentsScreen(comments, context,);
                        },
                        itemCount: SocialCubit.get(context).comments.length ,
                        separatorBuilder: (context,index)=>SizedBox(height: 8,),
                      ),
                    ],
                  ),
                ),
              ),
              //buildCommentItem(SocialCubit.get(context).comments[index!],context,index),
              if(SocialCubit.get(context).commentImage !=null)
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Stack(
                  alignment: AlignmentDirectional.topEnd,
                  children: [
                    Container(
                      height: 140,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(4),
                          image: DecorationImage(
                            image: FileImage(SocialCubit.get(context).commentImage!) as ImageProvider,
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
                              SocialCubit.get(context).removeCommentImage();
                            },
                            icon: Icon(
                              Icons.close,
                              size: 18,
                            )),
                      ),
                    )
                  ],
                ),
              ),
              Container(
                height: 60,
                child: Row(
                  children: [
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 5.0),
                        child: Container(
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Row(
                              children: [
                                CircleAvatar(
                                  radius: 18,
                                  backgroundImage: NetworkImage(
                                      '${SocialCubit.get(context).userModel!.image}'),
                                ),
                                SizedBox(
                                  width: 15,
                                ),
                                Expanded(
                                  child: TextFormField(
                                    controller: textCommentController,
                                    decoration: InputDecoration(
                                        hintText: 'Type a Comment...',
                                        border: InputBorder.none),
                                  ),
                                ),
                                IconButton(
                                  onPressed: () {
                                    SocialCubit.get(context)
                                        .getCommentImage(ImageSource.gallery);
                                  },
                                  icon: Icon(Iconly_Broken.Image),
                                )
                              ],
                            ),
                          ),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                      ),
                    ),
                    Container(
                      child: MaterialButton(
                        onPressed: () {
                          var now = DateTime.now();
                          if (SocialCubit.get(context).commentImage == null) {
                            SocialCubit.get(context).createComment(
                              dateTime: now.toLocal().toString(),
                              text: textCommentController.text,
                              postId: SocialCubit.get(context).postsId[postIndex!],
                              commentImage: '',
                            );
                          } else if(textCommentController.text == ''){
                            SocialCubit.get(context).uploadCommentImage(
                                dateTime: now.toLocal().toString(),
                                text: '',
                                postId: SocialCubit.get(context).postsId[postIndex!]);
                          }else{
                            SocialCubit.get(context).uploadCommentImage(
                                dateTime: now.toLocal().toString(),
                                text: textCommentController.text,
                                postId: SocialCubit.get(context).postsId[postIndex!]);
                          }

                        },
                        child: Icon(Iconly_Broken.Send),
                        padding: EdgeInsets.all(2),
                      ),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50),
                        color: kPrimaryColor,
                      ),
                      width: 50,
                      height: 50,
                      margin: EdgeInsets.all(5),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

Widget buildCommentItem(CommentsModel model, context, index) {
  return Card(
    elevation: 5,
    clipBehavior: Clip.antiAliasWithSaveLayer,
    child: Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              CircleAvatar(
                radius: 25,
                backgroundImage: NetworkImage(
                    '${SocialCubit.get(context).userModel!.image}'),
              ),
              SizedBox(
                width: 15,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          '${model.name}',
                          style: TextStyle(height: 1.4),
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Icon(
                          Icons.check_circle,
                          color: Colors.blue,
                          size: 16,
                        )
                      ],
                    ),
                    Text('${model.dateTime}',
                        style: Theme.of(context)
                            .textTheme
                            .caption!
                            .copyWith(height: 1.4)),
                  ],
                ),
              ),
              SizedBox(
                width: 15,
              ),
              IconButton(
                  iconSize: 16, onPressed: () {}, icon: Icon(Icons.more_horiz)),
            ],
          ),
//divider
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 15.0),
            child: Container(
              width: double.infinity,
              height: 1,
              color: Colors.grey[300],
            ),
          ),
          Text(
            '${model.text}',
            style: Theme.of(context).textTheme.subtitle1,
          ),
          Padding(
            padding: const EdgeInsets.only(top: 5),
            child: Wrap(
              children: [
                Padding(
                  padding: const EdgeInsetsDirectional.only(end: 6),
                  child: Container(
                    height: 25,
                    child: MaterialButton(
                        onPressed: () {},
                        minWidth: 1,
                        padding: EdgeInsets.zero,
                        child: Text('#SoftWare',
                            style:
                                Theme.of(context).textTheme.caption!.copyWith(
                                      color: Colors.blue,
                                    ))),
                  ),
                ),
                Padding(
                  padding: const EdgeInsetsDirectional.only(end: 6),
                  child: Container(
                    height: 25,
                    child: MaterialButton(
                        onPressed: () {},
                        minWidth: 1,
                        padding: EdgeInsets.zero,
                        child: Text('#Flutter',
                            style:
                                Theme.of(context).textTheme.caption!.copyWith(
                                      color: Colors.blue,
                                    ))),
                  ),
                ),
                Padding(
                  padding: const EdgeInsetsDirectional.only(end: 6),
                  child: Container(
                    height: 25,
                    child: MaterialButton(
                        onPressed: () {},
                        minWidth: 1,
                        padding: EdgeInsets.zero,
                        child: Text('#Development',
                            style:
                                Theme.of(context).textTheme.caption!.copyWith(
                                      color: Colors.blue,
                                    ))),
                  ),
                ),
              ],
            ),
          ),
          if (model.commentImage != '')
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 15),
              child: Container(
                height: 140,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(4),
                    image: DecorationImage(
                      image: NetworkImage('${model.commentImage}'),
                      fit: BoxFit.cover,
                    )),
              ),
            ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 5.0),
            child: Row(
              children: [
                Expanded(
                  child: InkWell(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 5.0),
                      child: Row(
                        children: [
                          Icon(
                            Iconly_Broken.Heart,
                            size: 16,
                            color: Colors.red,
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Text(
                            '5',
                            style: Theme.of(context).textTheme.caption,
                          )
                        ],
                      ),
                    ),
                    onTap: () {},
                  ),
                ),
                Expanded(
                  child: InkWell(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 5.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Icon(
                            Iconly_Broken.Chat,
                            size: 16,
                            color: Colors.amber,
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Text(
                            '0  reply',
                            style: Theme.of(context).textTheme.caption,
                          )
                        ],
                      ),
                    ),
                    onTap: () {},
                  ),
                ),
              ],
            ),
          ),
//divider
          Padding(
            padding: const EdgeInsets.only(bottom: 10.0),
            child: Container(
              width: double.infinity,
              height: 1,
              color: Colors.grey[300],
            ),
          ),
          Row(
            children: [
              Expanded(
                child: InkWell(
                  child: Row(
                    children: [
                      CircleAvatar(
                        radius: 18,
                        backgroundImage: NetworkImage(
                            '${SocialCubit.get(context).userModel!.image}'),
                      ),
                      SizedBox(
                        width: 15,
                      ),
                      Text('Write the reply....',
                          style: Theme.of(context)
                              .textTheme
                              .caption!
                              .copyWith(height: 1.4)),
                    ],
                  ),
                  onTap: () {},
                ),
              ),
              InkWell(
                child: Row(
                  children: [
                    Icon(
                      Iconly_Broken.Heart,
                      size: 16,
                      color: Colors.red,
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Text(
                      'Like ',
                      style: Theme.of(context).textTheme.caption,
                    )
                  ],
                ),
                onTap: () {},
              ),
            ],
          )
        ],
      ),
    ),
    margin: EdgeInsets.symmetric(
      horizontal: 8,
    ),
  );
}

Widget buildCommentsScreen(CommentsModel commentsModel, context ) {
  return Padding(
    padding: const EdgeInsets.all(2.0),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 10.0,left: 10),
          child: CircleAvatar(
            radius: 20,
            backgroundImage: NetworkImage(
                '${SocialCubit.get(context).userModel!.image}'),
          ),
        ),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Card(
                elevation: 1,
                clipBehavior: Clip.antiAliasWithSaveLayer,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  '${SocialCubit.get(context).userModel!.name}',
                                  style: TextStyle(height: 1.4),
                                ),
                                Text('${commentsModel.dateTime}',
                                    style: Theme.of(context)
                                        .textTheme
                                        .caption!
                                        .copyWith(height: 1.4)),
                              ],
                            ),
                          ),

                          Container(
                            width: 25,
                            child: IconButton(
                              iconSize: 18,
                              onPressed: () {},
                              icon: Icon(Icons.more_vert),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Text(
                        '${commentsModel.text}',
                        style: Theme.of(context).textTheme.subtitle1,
                      ),
                      if (commentsModel.commentImage != '')
                        InkWell(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 10),
                            child: Container(
                              height: 140,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(4),
                                  image: DecorationImage(
                                    image: NetworkImage('${commentsModel.commentImage}'),
                                    fit: BoxFit.cover,
                                  )),
                            ),
                          ),
                          onTap: (){
                            print("fffffffffffffffffffffffffffffffff");
                            print("${commentsModel.commentImage.toString()}");
                            print("fffffffffffffffffffffffffffffffff");
                          },
                        ),

                    ],
                  ),
                ),
              ),
              Row(
                children: [
                  Row(
                    children: [
                      InkWell(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            'Like ',
                            style: Theme.of(context).textTheme.caption,
                          ),
                        ),
                        onTap: (){},
                      ),
                      Text(':'),
                      InkWell(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            children: [
                              Icon(
                                Iconly_Broken.Heart,
                                size: 16,
                                color: Colors.red,
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              Text(
                                '0',
                                style: Theme.of(context).textTheme.caption,
                              )
                            ],
                          ),
                        ),
                        onTap: (){},

                      ),
                    ],
                  ),
                  Text("|"),
                  Row(
                    children: [
                      InkWell(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            'Reply',
                            style: Theme.of(context).textTheme.caption,
                          ),
                        ),
                        onTap: (){},
                      ),
                      InkWell(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Icon(
                                Iconly_Broken.Chat,
                                size: 18,
                                color: Colors.amber,
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left:  5.0),
                                child: Text(
                                  '0',
                                  style: Theme.of(context).textTheme.caption,
                                ),
                              ),
                            ],
                          ),
                        ),
                        onTap: (){},
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),

      ],
    ),
  );
}
