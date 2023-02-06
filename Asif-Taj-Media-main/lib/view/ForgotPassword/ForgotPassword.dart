import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../ViewModel/ForgotPassword/ForgotPassword_Controller.dart';
import '../../ViewModel/Services/Login/Login_Controller.dart';
import '../../res/Components/Input_text_field.dart';
import '../../res/Components/RoundButton.dart';
import '../../utils/routes/route_name.dart';

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({super.key});

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  final _formkey = GlobalKey<FormState>();
  final emailcontroller = TextEditingController();

  final emailfocusnode = FocusNode();

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    emailcontroller.dispose();

    emailfocusnode.dispose();
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
          child: SingleChildScrollView(
            child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    height: height * .01,
                  ),
                  Text(
                    'Forgot Password',
                    style: Theme.of(context).textTheme.headline3,
                  ),
                  Text(
                    'Enter your Email Address\n to Recover your Password',
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
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                  ChangeNotifierProvider(
                    create: (_) => ForgotPassword_Controller(),
                    child: Consumer<ForgotPassword_Controller>(
                        builder: (context, provider, child) {
                      return RoundButton(
                          title: 'login',
                          loading: false,
                          onpress: () {
                            if (_formkey.currentState!.validate()) {
                              // provider.login(context, emailcontroller.text,
                              //     passwordcontroller.text.toString());
                            }
                          });
                    }),
                  ),
                  SizedBox(
                    height: height * 0.03,
                  ),
                ]),
          ),
        ),
      ),
    );
  }
}
