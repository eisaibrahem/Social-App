import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/modules/register/cubit/states.dart';
import 'package:social_app/shared/constants.dart';

import '../../../models/social_user_model.dart';

class SocialRegisterCubit extends Cubit<SocialRegisterStates> {
  SocialRegisterCubit() : super(SocialRegisterInitialState());

  static SocialRegisterCubit get(context) => BlocProvider.of(context);

  void userRegister({
    required String name,
    required String email,
    required String password,
    required String phone,
  }) {
    emit(SocialRegisterLoadingState());
    FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email, password: password)
        .then((value) {
      print(value.user?.email);
      print(value.user?.uid);
      userCreate(
          name: name,
          email: email,
          uId: value.user!.uid,
          phone: phone,
      );


    }).catchError((error) {
      emit(SocialRegisterErrorState(error));
    });
  }

  void userCreate({
    required String name,
    required String email,
    required String phone,
    required String uId,

  }) {
    SocialUserModel model = SocialUserModel(
      phone: phone,
      name: name,
      email: email,
      uId: uId,
      bio: 'Write your bio .....',
      image: 'https://img.freepik.com/free-photo/portrait-pretty-young-curly-boy-red-wear-yellow-studio-wall_155003-41478.jpg?t=st=1647645088~exp=1647645688~hmac=ca5a0084a22d807c46da0359e76df460e308217ef82d6b369cfe0a869edbff6e&w=740',
      cover: 'https://img.freepik.com/free-photo/portrait-pretty-young-curly-boy-red-wear-yellow-studio-wall_155003-41478.jpg?t=st=1647645088~exp=1647645688~hmac=ca5a0084a22d807c46da0359e76df460e308217ef82d6b369cfe0a869edbff6e&w=740',
      isEmailVerified: false,
      token: token
    );

    FirebaseFirestore.instance
        .collection('users')
        .doc(uId)
        .set(model.toMap())
        .then((value) {

      emit(SocialCreateUserSuccessState(uId));

    }).catchError((error) {
      print(error.toString());
      emit(SocialCreateUserErrorState(error.toString()));
    });
  }

  IconData suffix = Icons.visibility_outlined;
  bool isPassword = true;

  void changePasswordVisibility() {
    isPassword = !isPassword;
    suffix =
        isPassword ? Icons.visibility_outlined : Icons.visibility_off_outlined;

    emit(SocialRegisterChangePasswordVisibilityState());
  }
}
