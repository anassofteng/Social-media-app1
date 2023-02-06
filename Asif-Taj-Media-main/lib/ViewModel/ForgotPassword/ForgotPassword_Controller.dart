import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:tech_media/ViewModel/Services/Sessionmanager.dart';

import '../../../utils/routes/Utils.dart';
import '../../../utils/routes/route_name.dart';

class ForgotPassword_Controller with ChangeNotifier {
  FirebaseAuth auth = FirebaseAuth.instance;

  bool _loading = false;
  bool get loading => _loading;
  setLoading(bool value) {
    _loading = value;
    notifyListeners();
  }

  void ForgotPassword(
    BuildContext context,
    String email,
  ) async {
    setLoading(true);
    try {
      final User = await auth
          .sendPasswordResetEmail(
        email: email,
      )
          .then((value) {
        Navigator.pushNamed(context, RouteName.loginView);
        Utils.toastMessage('Please check your email to recover your Password');
      }).onError((error, stackTrace) {
        Utils.toastMessage(error.toString());
      });
    } catch (e) {
      setLoading(false);
      Utils.toastMessage(e.toString());
    }
  }
}
