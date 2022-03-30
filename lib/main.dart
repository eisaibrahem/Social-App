import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/layout/cubit/cubit.dart';
import 'package:social_app/layout/social_layout.dart';
import 'package:social_app/modules/login/login_Screen.dart';
import 'package:social_app/modules/register/cubit/cubit.dart';
import 'package:social_app/shared/components.dart';
import 'package:social_app/shared/constants.dart';
import 'package:social_app/shared/network/local/cache_helper.dart';
import 'package:social_app/shared/network/remote/dio_helper.dart';
import 'package:social_app/shared/observer.dart';
import 'package:social_app/shared/styles/themes.dart';
import 'package:bloc/bloc.dart';

Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  print('on Background  Message  notification');
    print(message.data.toString());

  showToast(text: 'on Background  Message  notification', state: ToastStates.SUCCESS);

}
late bool isSigned;
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  DioHelper.init();
  token= await FirebaseMessaging.instance.getToken();
  print("===================Device Token====================");
  print(token);
  print("===================Device Token====================");


  var currentUser= await FirebaseAuth.instance.currentUser;
  if(currentUser==null)
    isSigned = false;
  else
    isSigned = true;

  // foreground fcm
  FirebaseMessaging.onMessage.listen((event) {
    print(event.data.toString());
    showToast(text: 'on Message notification', state: ToastStates.SUCCESS);
  });
// when click on notification to open app
  FirebaseMessaging.onMessageOpenedApp.listen((event) {
    print(event.data.toString());
    showToast(text: 'on Message Opened App notification', state: ToastStates.SUCCESS);

  });

// background fcm
  FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);

  runApp(MyApp());

  await CacheHelper.init();



  BlocOverrides.runZoned(() {
    Widget widget;


      uId = CacheHelper.getData(key: "uId")??"";

    print('user id  =  ($uId)');

    if (uId != '') {
      widget = SocialLayout();
    } else {
      widget = LoginScreen();
    }

    runApp(MyApp(
      startWidget: widget,
    ));
    },
    blocObserver: MyBlocObserver(),

  );


}

class MyApp extends StatelessWidget {
  Widget? startWidget;
  MyApp({
    this.startWidget,
  });

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context)=>SocialCubit()..getUserData()..getPosts(),

      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'social app',
        theme: lightMode(),
        home: startWidget,
      ),
    );
  }
}
