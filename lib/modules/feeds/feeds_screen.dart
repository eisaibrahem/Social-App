import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/layout/cubit/cubit.dart';
import 'package:social_app/layout/cubit/states.dart';
import 'package:social_app/models/post_model.dart';
import 'package:social_app/modules/comments/comments_screen.dart';
import 'package:social_app/shared/components.dart';
import 'package:social_app/shared/styles/Iconly-Broken_icons.dart';

class FeedsScreen extends StatelessWidget {
  const FeedsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit,SocialStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return ConditionalBuilder(
          condition:   SocialCubit.get(context).userModel!=null || SocialCubit.get(context).posts.length>0 ,
          builder: (context) => SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Column(
            children: [
              Card(
                clipBehavior: Clip.antiAliasWithSaveLayer,
                child: Stack(
                  alignment: AlignmentDirectional.bottomEnd,
                  children: [
                    Image(
                      width: double.infinity,
                      image: NetworkImage(
                          'https://img.freepik.com/free-photo/pointing-happy-boy-playing-having-fun-green-wall-caucasian-kid-bright-cloth-looks-playful-laughting-smiling-concept-education-childhood-emotions-facial-expression_155003-38712.jpg?w=740'),
                      fit: BoxFit.cover,
                      height: 200,
                    ),
                    Positioned(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          'communicat with frinds',
                          style: Theme.of(context).textTheme.subtitle1!.copyWith(
                            color: Colors.white,
                          ),
                        ),
                      ),
                    )
                  ],
                ),
                elevation: 5,
                margin: EdgeInsets.all(8.0),
              ),
              ListView.separated(
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemBuilder: (context, index) => buildPostItem(SocialCubit.get(context).posts[index],context,index),
                itemCount: SocialCubit.get(context).posts.length ,
                separatorBuilder: (context,index)=>SizedBox(height: 8,),

              ),
              SizedBox(height: 8,)
            ],
          ),
        ),
          fallback: (context)=>Center(child: CircularProgressIndicator()),
        );
      },
    );
  }

}
Widget buildPostItem(PostModel model, context,index) {
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
                          Text(
                            '${SocialCubit.get(context).postLikes[index]}',
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
                            '${SocialCubit.get(context).userModel!.image}'),
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