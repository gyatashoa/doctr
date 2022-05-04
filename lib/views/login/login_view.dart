import 'package:doctr/config/app_properties.dart';
import 'package:doctr/views/login/login_form.dart';
import 'package:doctr/views/login/login_view_model.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

class LoginView extends ViewModelBuilderWidget<LoginViewModel> {
  const LoginView({Key? key})
      : super(
          key: key,
        );

  @override
  bool get reactive => false;

  @override
  Widget builder(
      BuildContext context, LoginViewModel viewModel, Widget? child) {
    var statusViewHeight = MediaQuery.of(context).viewPadding.top;
    var devSize = MediaQuery.of(context).size;
    return Padding(
        padding: EdgeInsets.only(top: statusViewHeight),
        child: Scaffold(
          body: Padding(
            padding: EdgeInsets.symmetric(horizontal: devSize.width * .1),
            child: SingleChildScrollView(
                child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                //image part
                Container(
                  height: devSize.height * .35,
                ),
                Text('Login'),
                LoginForm(),
                
                Center(
                  child: InkWell(
                    onTap: () {},
                    child: RichText(
                      text: TextSpan(
                          style: TextStyle(color: Colors.black),
                          text: 'New to $appName?',
                          children: [
                            TextSpan(
                                style: TextStyle(color: Colors.blue),
                                text: 'Register')
                          ]),
                    ),
                  ),
                )
              ],
            )),
          ),
        ));
  }

  @override
  LoginViewModel viewModelBuilder(BuildContext context) => LoginViewModel();
}
