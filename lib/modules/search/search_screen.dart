import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/layout/cubit/cubit.dart';
import 'package:social_app/layout/cubit/states.dart';
import 'package:social_app/models/post_model.dart';
import 'package:social_app/models/social_user_model.dart';
import 'package:social_app/modules/chats/chats_screen.dart';
import 'package:social_app/modules/comments/comments_screen.dart';
import 'package:social_app/shared/components.dart';
import 'package:social_app/shared/constants.dart';
import 'package:social_app/shared/styles/Iconly-Broken_icons.dart';

class SearchScreen extends StatelessWidget {
  var searchController = TextEditingController();
  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => SocialCubit(),
      child: BlocConsumer<SocialCubit, SocialStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(),
            body: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Form(
                key: formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    defaultFormField(
                      controller: searchController,
                      label: 'Search',
                      prefix: Icons.search,
                      type: TextInputType.text,
                      validate: (String? value) {
                        return null;
                      },
                      onChange: (value) {
                          SocialCubit.get(context)
                              .searchUser(text: value);

                          SocialCubit.get(context)
                              .searchPost(text: value);

                      },
                    ),
                    if (state is SearchLoadingState)
                      LinearProgressIndicator(),
                    SizedBox(height: 10,),
                    if(SocialCubit.get(context).searchesListUsers.isNotEmpty)
                    const SizedBox(
                      height: 15,
                      child: Text('Users',
                      style: TextStyle(
                        fontSize: 15
                      ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 5.0),
                      child: Container(
                        width: double.infinity,
                        height: 1,
                        color: Colors.grey[300],
                      ),
                    ),
                      Flexible(
                        child: ListView.separated(
                            physics: BouncingScrollPhysics(),
                            itemBuilder: (context, index) => buildSearchIUserItem(
                                SocialCubit.get(context).searchesListUsers[index], context),
                            separatorBuilder: (context, index) => Container(
                                  width: double.infinity,
                                  height: 10,
                                ),
                            itemCount:
                                SocialCubit.get(context).searchesListUsers.length),
                      ),
                    if(SocialCubit.get(context).searchesListPosts.isNotEmpty)
                    const SizedBox(
                      height: 15,
                      child: Text('Posts',
                        style: TextStyle(
                            fontSize: 15
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 5.0),
                      child: Container(
                        width: double.infinity,
                        height: 1,
                        color: Colors.grey[300],
                      ),
                    ),
                    Flexible(
                      child: ListView.separated(
                          physics: BouncingScrollPhysics(),
                          itemBuilder: (context, index) =>
                              buildSearchPostItem(
                              SocialCubit.get(context).searchesListPosts[index],
                                  context,
                                index
                              ),
                          separatorBuilder: (context, index) => const SizedBox(
                            width: double.infinity,
                            height: 10,
                          ),
                          itemCount:
                          SocialCubit.get(context).searchesListPosts.length),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

Widget buildSearchIUserItem(SocialUserModel userModel,context){
  return  InkWell(
    child: Container(
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        border: Border.all(color: kPrimaryColor,width: 1.5),
        borderRadius: BorderRadius.circular(10)
      ),

      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CircleAvatar(
            radius: 25,
            backgroundImage: NetworkImage(
                '${userModel.image}'),
          ),
          SizedBox(
            width: 5,
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Text(
              '${userModel.name}',
              style: TextStyle(height: 1.4),
            ),
          ),

        ],
      ),
    ),
    onTap: (){

    },
  );
}

Widget buildSearchPostItem(PostModel model, context,index) {
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
                    '${model.image}'),
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
                  iconSize: 16,
                  onPressed: () {},
                  icon: Icon(Icons.more_horiz)),
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
            padding: const EdgeInsets.only( top: 5),
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
          if(model.postImage!='')
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 15),
              child: Container(
                height: 140,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(4),
                    image: DecorationImage(
                      image: NetworkImage(
                          '${model.postImage}'),
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
                            '0  comment',
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
                            '${model.image}'),
                      ),
                      SizedBox(
                        width: 15,
                      ),
                      Text('Write the Comment  .....',
                          style: Theme.of(context)
                              .textTheme
                              .caption!
                              .copyWith(height: 1.4)),
                    ],
                  ),
                  onTap: () {
                    navigateTo(context, CommentsScreen(index));
                    SocialCubit.get(context).getComments(SocialCubit.get(context).postsId[index]);

                    //    buildCommentItem(SocialCubit.get(context).posts[index], context, index);

                  },
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
                onTap: () {
                  SocialCubit.get(context).likePost( SocialCubit.get(context).postsId[index]);
                },
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
