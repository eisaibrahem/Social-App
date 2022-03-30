import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_tags/flutter_tags.dart';
import 'package:image_picker/image_picker.dart';
import 'package:social_app/layout/cubit/cubit.dart';
import 'package:social_app/layout/cubit/states.dart';
import 'package:social_app/shared/components.dart';
import 'package:social_app/shared/constants.dart';
import 'package:social_app/shared/styles/Iconly-Broken_icons.dart';

class NewPostScreen extends StatelessWidget {

  var textPostController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit,SocialStates>(
      listener: (context, state) {
        if(state is SocialCreatePostSuccessState){
          textPostController.text='';
          Navigator.pop(context);
        }
      },
      builder: (context, state) {

        return Scaffold(
          appBar: defaultAppBar(
            context: context,
            title: 'Create Post',
            actions: [
              defaultTextButton(
                function: () {
                var now = DateTime.now();
                  if(SocialCubit.get(context).postImage==null){
                    SocialCubit.get(context).createPost(dateTime: now.toLocal().toString(), text: textPostController.text,);
                  }else{
                    SocialCubit.get(context).uploadPostImage(dateTime: now.toLocal().toString(), text:textPostController.text );
                  }
                },
                text: 'Post',
                color: Colors.black,
              ),
            ],
          ),
          body: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                if(state is SocialCreatePostLoadingState)
                LinearProgressIndicator(),
                if(state is SocialCreatePostLoadingState)
                SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    CircleAvatar(
                      radius: 25,
                      backgroundImage: NetworkImage(
                          'https://img.freepik.com/free-photo/portrait-pretty-young-curly-boy-red-wear-yellow-studio-wall_155003-41478.jpg?t=st=1647645088~exp=1647645688~hmac=ca5a0084a22d807c46da0359e76df460e308217ef82d6b369cfe0a869edbff6e&w=740'),
                    ),
                    SizedBox(
                      width: 15,
                    ),
                    Expanded(
                      child: Text(
                        'Eisa Ibrahem',
                        style: TextStyle(height: 1.4),
                      ),
                    ),


                  ],
                ),
                Expanded(
                  child: TextFormField(
                    decoration: InputDecoration(
                        hintText: 'What is in your mind .....',
                      border: InputBorder.none
                    ),
                    controller: textPostController,
                  ),
                ),
                SizedBox(
                  height: 20,
                ),

                if(SocialCubit.get(context).postImage !=null)
                Stack(
                  alignment: AlignmentDirectional.topEnd,
                  children: [
                    Container(
                      height: 140,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(4),
                          image: DecorationImage(
                            image: FileImage(SocialCubit.get(context).postImage!) as ImageProvider,
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
                              SocialCubit.get(context).removePostImage();
                            },
                            icon: Icon(
                              Icons.close,
                              size: 18,
                            )),
                      ),
                    )
                  ],
                ),
                SizedBox(
                  height: 40,
                ),
                Row(
                  children: [
                    Expanded(
                      child: TextButton(
                          onPressed: (){
                            SocialCubit.get(context).getPostImage(ImageSource.gallery);
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Iconly_Broken.Image),
                              SizedBox(width: 5,),
                              Text('Add Photo')

                            ],
                          ),
                      ),
                    ),

                    Expanded(
                      child: TextButton(
                        onPressed: (){

                        },
                        child: Text('#tages'),
                      ),
                    ),
                  ],
                ),

              ],
            ),
          ),

        );
      },
    );
  }
}
