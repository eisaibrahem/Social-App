import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/layout/cubit/cubit.dart';
import 'package:social_app/layout/cubit/states.dart';
import 'package:social_app/models/social_user_model.dart';
import 'package:social_app/modules/chat_detailes_screen/chat_details_screen.dart';
import 'package:social_app/shared/components.dart';

class ChatsScreen extends StatelessWidget {
  const ChatsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit,SocialStates>(
      listener: (context, state) {},
      builder:  (context, state) {
        return ConditionalBuilder(
          condition: SocialCubit.get(context).users.length>0,
          builder:(context)=>ListView.separated(
            physics: BouncingScrollPhysics(),
            itemBuilder: (context,index)=>buildChatItem(SocialCubit.get(context).users[index],context),
            separatorBuilder:(context,index)=> myDivider(),
            itemCount: SocialCubit.get(context).users.length,
          ) ,
          fallback:(context)=>Center(child: CircularProgressIndicator()) ,
        );
      },
    );
  }


}
Widget buildChatItem(SocialUserModel userModel,context){
  return  InkWell(
    child: Padding(
      padding: const EdgeInsets.all(20.0),
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
      navigateTo(context, ChatDetailsScreen(userModel));
    },
  );
}