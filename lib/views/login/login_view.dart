import 'package:doctr/config/app_properties.dart';
import 'package:doctr/theme/colors.dart';
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
                              height: devSize.height * .35),
                        ),
                      ),
                      Text(
                        'Login',
                        style: TextStyle(
                            fontSize: devSize.height * .06,
                            fontWeight: FontWeight.bold,
                            color: const Color(0xff131945)),
                      ),
                      const LoginForm(),
                      Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: Center(
                          child: InkWell(
                            onTap: () {},
                            child: RichText(
                              text: TextSpan(
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyText1!
                                      .copyWith(
                                        color: ashColor,
                                      ),
                                  text: 'New to $appName?\t',
                                  children: const [
                                    TextSpan(
                                        style:
                                            TextStyle(color: Color(0xFF2D00CE)),
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
