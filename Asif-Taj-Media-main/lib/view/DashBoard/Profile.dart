import 'dart:io';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:provider/provider.dart';
import 'package:tech_media/ViewModel/Profile/profile_Controller.dart';
import 'package:tech_media/ViewModel/Services/Sessionmanager.dart';
import 'package:tech_media/res/color.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final ref = FirebaseDatabase.instance.ref().child('user');
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: ChangeNotifierProvider(
        create: (_) => ProfileController(),
        child: Consumer<ProfileController>(builder: (context, provider, child) {
          return SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: StreamBuilder(
                stream:
                    ref.child(SessionController().userId.toString()).onValue,
                builder: (context, AsyncSnapshot snapshot) {
                  if (!snapshot.hasData) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasData) {
                    Map<dynamic, dynamic> map = snapshot.data.snapshot.value;
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        const SizedBox(
                          height: 20,
                        ),
                        Stack(alignment: Alignment.bottomCenter, children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 10),
                            child: Center(
                              child: Container(
                                height: 130,
                                width: 130,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                    color: AppColors.secondaryColor,
                                    width: 5,
                                  ),
                                ),
                                child: ClipRRect(
                                    borderRadius: BorderRadius.circular(100),
                                    child: provider.image == null
                                        ? map['profile'].toString() == ""
                                            ? const Icon(
                                                Icons.person,
                                                size: 35,
                                              )
                                            : Image(
                                                fit: BoxFit.cover,
                                                image: NetworkImage(
                                                    map['profile'].toString()),
                                                loadingBuilder: (context, child,
                                                    loadingProgress) {
                                                  if (loadingProgress == null)
                                                    return child;
                                                  return Center(
                                                      child:
                                                          CircularProgressIndicator());
                                                },
                                                errorBuilder:
                                                    (context, object, stack) {
                                                  return Container(
                                                    child: Icon(
                                                      Icons.error_outline,
                                                      color:
                                                          AppColors.alertColor,
                                                    ),
                                                  );
                                                },
                                              )
                                        : Stack(
                                            children: [
                                              Image.file(
                                                  File(provider.image!.path)
                                                      .absolute),
                                              Center(
                                                  child:
                                                      CircularProgressIndicator())
                                            ],
                                          )),
                              ),
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              provider.pickeImage(context);
                            },
                            child: const CircleAvatar(
                              radius: 14,
                              backgroundColor: AppColors.primaryIconColor,
                              child: Icon(
                                Icons.add,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ]),
                        const SizedBox(
                          height: 40,
                        ),
                        GestureDetector(
                          onTap: () {
                            provider.showUserNameDialogAlert(
                                context, map['username']);
                          },
                          child: ReusableRow(
                            title: 'Username',
                            value: map['username'],
                            icondata: Icons.person_outlined,
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            provider.showPhoneDialogAlert(
                                context, map['phone']);
                          },
                          child: ReusableRow(
                            title: 'Phone',
                            value: map['phone'] == ''
                                ? 'xxx-xxx-xxx'
                                : map['phone'],
                            icondata: Icons.phone_outlined,
                          ),
                        ),
                        ReusableRow(
                          title: 'Email',
                          value: map['email'],
                          icondata: Icons.email_outlined,
                        ),
                      ],
                    );
                  } else {
                    return Center(
                        child: Text(
                      'Some thing went wrong',
                      style: Theme.of(context).textTheme.subtitle1,
                    ));
                  }
                },
              ),
            ),
          );
        }),
      ),
    );
  }
}

class ReusableRow extends StatelessWidget {
  final String title, value;
  final IconData icondata;
  const ReusableRow(
      {super.key,
      required this.title,
      required this.value,
      required this.icondata});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          title: Text(
            title,
            style: Theme.of(context).textTheme.subtitle2,
          ),
          leading: Icon(
            icondata,
            color: AppColors.primaryIconColor,
          ),
          trailing: Text(
            value,
            style: Theme.of(context).textTheme.subtitle2,
          ),
        ),
        Divider(
          color: AppColors.dividedColor.withOpacity(0.4),
        ),
      ],
    );
  }
}
