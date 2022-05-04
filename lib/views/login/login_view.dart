import 'package:doctr/config/app_properties.dart';
import 'package:doctr/views/login/login_form.dart';
import 'package:doctr/views/login/login_view_model.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
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
    return GestureDetector(
      onTap: FocusScope.of(context).unfocus,
      child: Padding(
          padding: EdgeInsets.only(top: statusViewHeight),
          child: Scaffold(
            backgroundColor: const Color(0xFFFBFCFD),
            body: Padding(
              padding: EdgeInsets.symmetric(horizontal: devSize.width * .1),
              child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(18.0),
                        child: Center(
                          child: Lottie.asset('assets/animations/login_1.zip',
                              fit: BoxFit.fill,
                              width: double.infinity,
                              height: devSize.height * .40),
                        ),
                      ),
                      Text(
                        'Login',
                        style: TextStyle(
                            fontSize: devSize.height * .04,
                            fontWeight: FontWeight.bold,
                            color: const Color(0xff1E2944)),
                      ),
                      const LoginForm(),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Center(
                          child: InkWell(
                            onTap: () {},
                            child: RichText(
                              text: const TextSpan(
                                  style: TextStyle(color: Colors.black),
                                  text: 'New to $appName?\t',
                                  children: [
                                    TextSpan(
                                        style: TextStyle(color: Colors.blue),
                                        text: 'Register')
                                  ]),
                            ),
                          ),
                        ),
                      )
                    ],
                  )),
            ),
          )),
    );
  }

  @override
  LoginViewModel viewModelBuilder(BuildContext context) => LoginViewModel();
}
