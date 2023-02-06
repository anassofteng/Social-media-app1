import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../ViewModel/Services/Login/Login_Controller.dart';
import '../../res/Components/Input_text_field.dart';
import '../../res/Components/RoundButton.dart';
import '../../utils/routes/route_name.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formkey = GlobalKey<FormState>();
  final emailcontroller = TextEditingController();
  final passwordcontroller = TextEditingController();

  final emailfocusnode = FocusNode();
  final passwordfocusnode = FocusNode();

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    emailcontroller.dispose();
    passwordcontroller.dispose();

    emailfocusnode.dispose();
    passwordfocusnode.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height * 1;
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: SingleChildScrollView(
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
                    'Enter your credentials',
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
                          InputTextField(
                            myController: emailcontroller,
                            focusnode: emailfocusnode,
                            onFiledSubmittedValue: (value) {},
                            //enable: true,
                            keyBoardType: TextInputType.emailAddress,
                            obscureText: false,
                            hint: 'email',
                            onValidator: (value) {
                              return value.isEmpty ? 'enter email' : null;
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
                            obscureText: false,
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
                  Align(
                    alignment: Alignment.centerRight,
                    child: GestureDetector(
                      onTap: () {
                        Navigator.popAndPushNamed(
                            context, RouteName.ForgotScreen);
                      },
                      child: Text(
                        'Forgot Password?',
                        style: Theme.of(context).textTheme.headline2!.copyWith(
                              fontSize: 15,
                              decoration: TextDecoration.underline,
                            ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 40,
                  ),
                  ChangeNotifierProvider(
                    create: (_) => LoginController(),
                    child: Consumer<LoginController>(
                        builder: (context, provider, child) {
                      return RoundButton(
                          title: 'login',
                          loading: false,
                          onpress: () {
                            if (_formkey.currentState!.validate()) {
                              provider.login(context, emailcontroller.text,
                                  passwordcontroller.text.toString());
                            }
                          });
                    }),
                  ),
                  SizedBox(
                    height: height * 0.03,
                  ),
                  InkWell(
                    onTap: () => Navigator.popAndPushNamed(
                        context, RouteName.signupview),
                    child: Text.rich(
                      TextSpan(
                        text: 'Dont have an account?',
                        style: Theme.of(context)
                            .textTheme
                            .subtitle1!
                            .copyWith(fontSize: 15),
                        children: [
                          TextSpan(
                            text: 'Sign Up',
                            style: Theme.of(context)
                                .textTheme
                                .headline2!
                                .copyWith(
                                    fontSize: 15,
                                    decoration: TextDecoration.underline),
                          ),
                        ],
                      ),
                    ),
                  ),
                ]),
          ),
        ),
      ),
    );
  }
}
