import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:social_app/layout/cubit/cubit.dart';
import 'package:social_app/layout/cubit/states.dart';
import 'package:social_app/shared/components.dart';
import 'package:social_app/shared/constants.dart';
import 'package:social_app/shared/styles/Iconly-Broken_icons.dart';

class EditProfileScreen extends StatelessWidget {
  var nameController = TextEditingController();
  var bioController = TextEditingController();
  var phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit, SocialStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var userModel = SocialCubit.get(context).userModel;
        var profileImage = SocialCubit.get(context).profileImage;
        var coverImage = SocialCubit.get(context).coverImage;

        nameController.text = userModel!.name!;
        bioController.text = userModel.bio!;
        phoneController.text = userModel.phone!;
        return Scaffold(
          appBar:
              defaultAppBar(context: context, title: 'Edit Profile', actions: [
            defaultTextButton(
              color: Colors.black,
              function: () {
                SocialCubit.get(context)
                    .updateUser(
                    name: nameController.text,
                    phone: phoneController.text,
                    bio: bioController.text);
              },
              text: 'Update',
            ),
            SizedBox(
              width: 15,
            )
          ]),
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  if(state is SocialUserUpdateLoadingState)
                  LinearProgressIndicator(),
                  if(state is SocialUserUpdateLoadingState)
                  SizedBox(
                    height: 10,
                  ),
                  Column(
                    children: [
                      Container(
                        height: 190,
                        child: Stack(
                          alignment: Alignment.bottomCenter,
                          children: [
                            Align(
                              alignment: Alignment.topCenter,
                              child: Stack(
                                alignment: AlignmentDirectional.topEnd,
                                children: [
                                  Container(
                                    height: 140,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(4),
                                          topRight: Radius.circular(4),
                                        ),
                                        image: DecorationImage(
                                          image: coverImage == null
                                              ? NetworkImage(
                                                  ("${userModel.cover}"))
                                              : FileImage(coverImage)
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
                                            SocialCubit.get(context).getCoverImage(ImageSource.gallery);
                                          },
                                          icon: Icon(
                                            Iconly_Broken.Camera,
                                            size: 18,
                                          )),
                                    ),
                                  )
                                ],
                              ),
                            ),
                            Stack(
                              alignment: AlignmentDirectional.bottomEnd,
                              children: [
                                CircleAvatar(
                                  radius: 64,
                                  backgroundColor:
                                      Theme.of(context).scaffoldBackgroundColor,
                                  child: CircleAvatar(
                                    radius: 60,
                                    backgroundImage: profileImage == null
                                        ? NetworkImage(("${userModel.image}"))
                                        : FileImage(profileImage)
                                            as ImageProvider,
                                  ),
                                ),
                                CircleAvatar(
                                  radius: 20,
                                  backgroundColor: kPrimaryColor,
                                  child: IconButton(
                                      onPressed: () {
                                        SocialCubit.get(context)
                                            .getProfileImage(ImageSource.gallery);
                                      },
                                      icon: Icon(
                                        Iconly_Broken.Camera,
                                        size: 18,
                                      )),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      if(SocialCubit.get(context).profileImage != null || SocialCubit.get(context).coverImage != null )
                      Row(
                        children:
                        [
                          if(SocialCubit.get(context).profileImage != null)
                      Expanded(
                          child: Column(
                            children: [
                              defaultButton(
                                  function: (){
                                    SocialCubit.get(context).uploadProfileImage(name: nameController.text, phone: phoneController.text, bio: bioController.text,);

                                  },
                                  text: 'upload profile'
                              ),
                              if(state is SocialUserUpdateLoadingState)
                              SizedBox(height: 5,),
                              if(state is SocialUserUpdateLoadingState)
                              LinearProgressIndicator(),
                            ],
                          ),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                          if(SocialCubit.get(context).coverImage != null)
                          Expanded(
                            child: Column(
                              children: [
                                defaultButton(
                                    function: (){
                                      SocialCubit.get(context).uploadCoverImage(name: nameController.text, phone: phoneController.text, bio: bioController.text);

                                    },
                                    text: 'upload cover'
                                ),
                                if(state is SocialUserUpdateLoadingState)
                                SizedBox(height: 5,),
                                if(state is SocialUserUpdateLoadingState)
                                LinearProgressIndicator(),
                              ],
                            ),
                          ),
                      ],
                      ),
                      if(SocialCubit.get(context).profileImage != null || SocialCubit.get(context).coverImage != null )
                      SizedBox(
                        height: 20,
                      ),
                      defaultFormField(
                          controller: nameController,
                          type: TextInputType.text,
                          validate: (value) {
                            if (value!.isEmpty) {
                              return 'Name Must Not be Empty';
                            }
                            return null;
                          },
                          label: "Name",
                          prefix: Iconly_Broken.User),
                      SizedBox(
                        height: 10,
                      ),
                      defaultFormField(
                        controller: bioController,
                        type: TextInputType.text,
                        validate: (value) {
                          if (value!.isEmpty) {
                            return 'Bio Must Not be Empty';
                          }
                          return null;
                        },
                        label: "Bio",
                        prefix: Iconly_Broken.Info_Circle,
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      defaultFormField(
                        controller: phoneController,
                        type: TextInputType.phone,
                        validate: (value) {
                          if (value!.isEmpty) {
                            return 'Phone Must Not be Empty';
                          }
                          return null;
                        },
                        label: "Phone",
                        prefix: Iconly_Broken.Call,
                      ),

                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
