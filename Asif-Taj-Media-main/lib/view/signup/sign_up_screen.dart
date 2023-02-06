import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tech_media/ViewModel/Services/SignUp/SignUp_Controller.dart';
import 'package:tech_media/utils/routes/Utils.dart';

import '../../res/Components/Input_text_field.dart';
import '../../res/Components/RoundButton.dart';
import '../../utils/routes/route_name.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _formkey = GlobalKey<FormState>();
  final emailcontroller = TextEditingController();
  final passwordcontroller = TextEditingController();
  final username_controller = TextEditingController();

  final emailfocusnode = FocusNode();
  final passwordfocusnode = FocusNode();
  final username_focusnode = FocusNode();

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    emailcontroller.dispose();
    passwordcontroller.dispose();
    username_controller.dispose();

    emailfocusnode.dispose();
    passwordcontroller.dispose();
    username_focusnode.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height * 1;
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
      ),
      body: SafeArea(
        child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: ChangeNotifierProvider(
              create: (_) => SignUPController(),
              child: Consumer<SignUPController>(
                builder: (context, Provider, child) {
                  return SingleChildScrollView(
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SizedBox(
                            height: height * .01,
                          ),
                          Text(
                            'Welcome to the App',
                            style: Theme.of(context).textTheme.headline3,
                          ),
                          Text(
                            'Enter your email to register',
                            style: Theme.of(context).textTheme.subtitle1,
                          ),
                          SizedBox(
                            height: height * 0.01,
                          ),
                          Form(
                            key: _formkey,
                            child: Padding(
                              padding: EdgeInsets.only(
                                  top: height * .06, bottom: height * 0.01),
                              child: Column(
                                children: [
                                  SizedBox(
                                    height: height * 0.01,
                                  ),
                                  InputTextField(
                                    myController: emailcontroller,
                                    focusnode: emailfocusnode,
                                    onFiledSubmittedValue: (value) {
                                      Utils.fieldFocus(context, emailfocusnode,
                                          passwordfocusnode);
                                    },
                                    //enable: true,
                                    keyBoardType: TextInputType.emailAddress,
                                    obscureText: false,
                                    hint: 'email',
                                    onValidator: (value) {
                                      return value.isEmpty
                                          ? 'enter email'
                                          : null;
                                    },
                                  ),
                                  InputTextField(
                                    myController: username_controller,
                                    focusnode: username_focusnode,
                                    onFiledSubmittedValue: (value) {},
                                    //enable: true,
                                    keyBoardType: TextInputType.emailAddress,
                                    obscureText: false,
                                    hint: 'username',
                                    onValidator: (value) {
                                      return value.isEmpty
                                          ? 'enter username'
                                          : null;
                                    },
                                  ),
                                  SizedBox(
                                    height: height * 0.01,
                                  ),
                                  InputTextField(
                                    myController: passwordcontroller,
                                    focusnode: passwordfocusnode,

                                    onFiledSubmittedValue: (value) {},
                                    //enable: true,
                                    keyBoardType: TextInputType.emailAddress,
                                    obscureText: true,
                                    hint: 'password',
                                    onValidator: (value) {
                                      return value.isEmpty
                                          ? 'Enter your password'
                                          : null;
                                    },
                                  ),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 40,
                          ),
                          RoundButton(
                            title: 'Sign up',
                            onpress: () {
                              if (_formkey.currentState!.validate()) {
                                Provider.signup(
                                    context,
                                    username_controller.text.toString(),
                                    emailcontroller.text.toString(),
                                    passwordcontroller.text.toString());
                              }
                            },
                            loading: false,
                          ),
                          SizedBox(
                            height: height * 0.03,
                          ),
                          InkWell(
                            onTap: () => Navigator.pushNamed(
                                context, RouteName.loginView),
                            child: Text.rich(
                              TextSpan(
                                text: 'Already have an account?',
                                style: Theme.of(context)
                                    .textTheme
                                    .subtitle1!
                                    .copyWith(fontSize: 15),
                                children: [
                                  TextSpan(
                                    text: 'Login',
                                    style: Theme.of(context)
                                        .textTheme
                                        .headline2!
                                        .copyWith(
                                            fontSize: 15,
                                            decoration:
                                                TextDecoration.underline),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ]),
                  );
                },
              ),
            )),
      ),
    );
  }
}
