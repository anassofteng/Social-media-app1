import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'package:tech_media/ViewModel/Services/Sessionmanager.dart';
import 'package:tech_media/view/DashBoard/chat/message_Screen.dart';

import '../../../res/color.dart';

class UserListScreen extends StatefulWidget {
  const UserListScreen({super.key});

  @override
  State<UserListScreen> createState() => _UserListScreenState();
}

class _UserListScreenState extends State<UserListScreen> {
  DatabaseReference ref = FirebaseDatabase.instance.ref().child('user');
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('user List'),
      ),
      body: SafeArea(
        child: FirebaseAnimatedList(
          query: ref
              .orderByChild('uid')
              .equalTo(SessionController().userId.toString()),
          itemBuilder: (context, snapshot, animation, index) {
            if (SessionController().userId.toString() ==
                snapshot.child('uid').value.toString()) {
              return Container();
            } else {
              return Card(
                child: ListTile(
                  onTap: () {
                    PersistentNavBarNavigator.pushNewScreen(
                      context,
                      screen: MessageScreen(
                        name: snapshot.child('username').value.toString(),
                        image: snapshot.child('email').value.toString(),
                        email: snapshot.child('profile').value.toString(),
                      ),
                      withNavBar: false,
                    );
                  },
                  leading: Container(
                    height: 40,
                    width: 40,
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border:
                            Border.all(color: AppColors.PrimaryButtonColor)),
                    child: snapshot.child('profile').toString() == ''
                        ? Icon(Icons.person_outline)
                        : ClipRRect(
                            borderRadius: BorderRadius.circular(50),
                            child: Image(
                                fit: BoxFit.cover,
                                image: NetworkImage(snapshot
                                    .child('profile')
                                    .value
                                    .toString())),
                          ),
                  ),
                  title: Text(
                    snapshot.child('username').value.toString(),
                  ),
                  subtitle: Text(snapshot.child('email').value.toString()),
                ),
              );
            }
          },
        ),
      ),
    );
  }
}
