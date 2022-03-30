import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/layout/cubit/cubit.dart';
import 'package:social_app/layout/cubit/states.dart';
import 'package:social_app/modules/new_post/new_post_screen.dart';
import 'package:social_app/modules/notifications/notifications_screen.dart';
import 'package:social_app/modules/search/search_screen.dart';
import 'package:social_app/modules/settings/settings_screen.dart';
import 'package:social_app/shared/components.dart';
import 'package:social_app/shared/styles/Iconly-Broken_icons.dart';

class SocialLayout extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit, SocialStates>(
      listener: (context, state) {
        if(state is SocialSettingState){
          navigateTo(context, SettingScreen());
        }

      },
      builder: (context, state) {
       var cubit=SocialCubit.get(context);
        return Scaffold(
          appBar: AppBar(
            title: Text( cubit.titles[cubit.currentIndex]),
            actions: [
              IconButton(
                  onPressed: (){
                    navigateTo(context, NotificationsScreen());
                  },
                  icon: Icon(Iconly_Broken.Notification)
              ),
              IconButton(
                  onPressed: (){
                    navigateTo(context, SearchScreen());
                  },
                  icon: Icon(Iconly_Broken.Search),
              ),
            ],
          ),
          body: cubit.screens[cubit.currentIndex],
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: cubit.currentIndex,
            onTap: (index){
              if( index != 2) {
                cubit.changeBottomNav(index);
              }else{
                navigateTo(context, NewPostScreen());
              }
            },
            items: const [
              BottomNavigationBarItem(
                  icon: Icon(
                    Iconly_Broken.Home,
                  ),
                label: 'Home'
              ),
              BottomNavigationBarItem(
                  icon: Icon(
                    Iconly_Broken.Chat,
                  ),
                label: 'Chats'
              ),
              BottomNavigationBarItem(
                  icon: Icon(
                    Iconly_Broken.Upload,
                  ),
                label: 'Post'
              ),
              BottomNavigationBarItem(
                  icon: Icon(
                    Iconly_Broken.Location,
                  ),
                label: 'Users'
              ),
              BottomNavigationBarItem(
                  icon: Icon(
                    Iconly_Broken.Setting,
                  ),
                label: 'Settings'
              ),
            ],
          ),
        );
      },
    );
  }
}
