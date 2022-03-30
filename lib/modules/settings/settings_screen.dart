import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/layout/cubit/cubit.dart';
import 'package:social_app/layout/cubit/states.dart';
import 'package:social_app/modules/edit_profile/edit_profile_screen.dart';
import 'package:social_app/modules/login/login_Screen.dart';
import 'package:social_app/shared/components.dart';
import 'package:social_app/shared/constants.dart';
import 'package:social_app/shared/network/local/cache_helper.dart';
import 'package:social_app/shared/styles/Iconly-Broken_icons.dart';

class SettingScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit, SocialStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var userModel = SocialCubit.get(context).userModel;
        return Scaffold(
          appBar: defaultAppBar(
              context: context,
              title: 'Setting Screen',
              actions: [
                IconButton(
                    icon: Icon(Icons.exit_to_app),
                    onPressed: () async {
                      await FirebaseAuth.instance.signOut();
                      navigateAndFinish(context, LoginScreen());
                      CacheHelper.removeData(key: "uId");
                      uId = '';
                    })
              ]),
          body: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Container(
                  height: 190,
                  child: Stack(
                    alignment: Alignment.bottomCenter,
                    children: [
                      Align(
                        child: Container(
                          height: 140,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(4),
                                topRight: Radius.circular(4),
                              ),
                              image: DecorationImage(
                                image: NetworkImage(
                                    ("${userModel!.cover ?? 'https://aeroclub-issoire.fr/wp-content/uploads/2020/05/image-not-found-300x225.jpg'}")),
                                fit: BoxFit.cover,
                              )),
                        ),
                        alignment: Alignment.topCenter,
                      ),
                      CircleAvatar(
                        radius: 64,
                        backgroundColor:
                            Theme.of(context).scaffoldBackgroundColor,
                        child: CircleAvatar(
                          radius: 60,
                          backgroundImage: NetworkImage(
                              ("${userModel.image ?? 'https://aeroclub-issoire.fr/wp-content/uploads/2020/05/image-not-found-300x225.jpg'}")),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
                Text(
                  ("${userModel.name ?? 'name not found yet'}"),
                  style: Theme.of(context).textTheme.bodyText1,
                ),
                Text(
                  ("${userModel.bio ?? 'bio not found yet'}"),
                  style: Theme.of(context).textTheme.caption,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20.0),
                  child: Row(
                    children: [
                      Expanded(
                        child: InkWell(
                          child: Column(
                            children: [
                              Text(
                                '100',
                                style:
                                    Theme.of(context).textTheme.subtitle2,
                              ),
                              Text(
                                'Post',
                                style: Theme.of(context).textTheme.caption,
                              ),
                            ],
                          ),
                          onTap: () {},
                        ),
                      ),
                      Expanded(
                        child: InkWell(
                          child: Column(
                            children: [
                              Text(
                                '45',
                                style:
                                    Theme.of(context).textTheme.subtitle2,
                              ),
                              Text(
                                'Photos',
                                style: Theme.of(context).textTheme.caption,
                              ),
                            ],
                          ),
                          onTap: () {},
                        ),
                      ),
                      Expanded(
                        child: InkWell(
                          child: Column(
                            children: [
                              Text(
                                '20K',
                                style:
                                    Theme.of(context).textTheme.subtitle2,
                              ),
                              Text(
                                'Followers',
                                style: Theme.of(context).textTheme.caption,
                              ),
                            ],
                          ),
                          onTap: () {},
                        ),
                      ),
                      Expanded(
                        child: InkWell(
                          child: Column(
                            children: [
                              Text(
                                '95',
                                style:
                                    Theme.of(context).textTheme.subtitle2,
                              ),
                              Text(
                                'Following',
                                style: Theme.of(context).textTheme.caption,
                              ),
                            ],
                          ),
                          onTap: () {},
                        ),
                      ),
                    ],
                  ),
                ),
                Row(
                  children: [
                    Expanded(
                      child: OutlinedButton(
                        onPressed: () {},
                        child: Text('Add Photo '),
                      ),
                    ),
                    OutlinedButton(
                      onPressed: () {
                        navigateTo(context, EditProfileScreen());
                      },
                      child: Icon(
                        Iconly_Broken.Edit,
                        size: 16,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 40,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    OutlinedButton(
                        onPressed: () {
                        FirebaseMessaging.instance.subscribeToTopic('announcement');
                        },
                        child: Row(
                          children: [
                            Icon(Icons.notifications_active),
                             SizedBox(width: 10,),
                             Text('Subscribe'),
                          ],
                        )),
                    SizedBox(
                      width: 20,
                    ),
                    OutlinedButton(
                        onPressed: () {
                          FirebaseMessaging.instance.unsubscribeFromTopic('announcement');
                        },
                        child:  Row(
                          children: [
                            Icon(Icons.notifications_off_sharp),
                            SizedBox(width: 10,),
                            Text('Un Subscribe'),
                          ],
                        )
                    ),
                  ],
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
