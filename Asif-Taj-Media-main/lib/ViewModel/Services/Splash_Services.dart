import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:tech_media/ViewModel/Services/Sessionmanager.dart';
import 'package:tech_media/utils/routes/route_name.dart';

class SplashServices {
  void isLogin(BuildContext context) {
    FirebaseAuth auth = FirebaseAuth.instance;

    final user = auth.currentUser;
    if (user != null) {
      SessionController().userId = user.uid.toString();
      Timer(Duration(seconds: 3),
          () => Navigator.pushNamed(context, RouteName.dashboard));
    } else {
      Timer(Duration(seconds: 3),
          () => Navigator.pushNamed(context, RouteName.loginView));
    }
  }
}
