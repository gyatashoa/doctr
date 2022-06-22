import 'package:doctr/views/forgot_password/forgot_password_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:stacked/stacked.dart';

class ForgotPasswordView extends HookWidget {
  const ForgotPasswordView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final emailController = useTextEditingController(text: '');
    final devSize = MediaQuery.of(context).size;
    return ViewModelBuilder<ForgotPasswordViewModel>.reactive(
      builder: (_, model, __) {
        return Scaffold(
          appBar: AppBar(
            leading: IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: const Icon(
                  Icons.arrow_back,
                  color: Colors.black,
                )),
            elevation: 0,
            title: Text(
              'Forgot Password',
              style: GoogleFonts.ptSans(color: Colors.black),
            ),
            centerTitle: true,
            backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          ),
          body: GestureDetector(
            onTap: () {
              FocusScope.of(context).unfocus();
            },
            child: SizedBox(
              height: devSize.height,
              child: Center(
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: devSize.width * .07),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Lottie.asset('assets/animations/forgot_password.zip'),
                        Text(
                          'Enter your email to reset the your password',
                          style: GoogleFonts.ptSans(color: Colors.black45),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(
                              vertical: devSize.height * .05),
                          child: TextField(
                            controller: emailController,
                            keyboardType: TextInputType.emailAddress,
                            decoration: const InputDecoration(
                                hintText: 'Enter your email address',
                                icon: Icon(Icons.email)),
                          ),
                        ),
                        Container(
                            padding: const EdgeInsets.all(5),
                            width: double.infinity,
                            child: TextButton(
                                style: TextButton.styleFrom(
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(5)),
                                    backgroundColor: const Color(0xFF3A00FF)),
                                onPressed: model.isBusy
                                    ? null
                                    : () => model.onForgotPassword(
                                          emailController.text,
                                        ),
                                child: model.isBusy
                                    ? Transform.scale(
                                        scale: .3,
                                        child: const CircularProgressIndicator(
                                            color: Colors.white),
                                      )
                                    : const Text(
                                        'Submit',
                                        style: TextStyle(
                                            fontWeight: FontWeight.w600,
                                            fontSize: 18,
                                            color: Colors.white),
                                      ))),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      },
      viewModelBuilder: () => ForgotPasswordViewModel(),
    );
  }
}
