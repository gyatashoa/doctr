import 'package:doctr/theme/colors.dart';
import 'package:doctr/views/signup/signup_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:lottie/lottie.dart';
import 'package:stacked/stacked.dart';

class SignUpView extends HookWidget {
  const SignUpView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final statusBarHeight = MediaQuery.of(context).viewPadding.top;
    var nameController = useTextEditingController(text: '');
    var emailController = useTextEditingController(text: '');
    var passwordController = useTextEditingController(text: '');
    var passwordController1 = useTextEditingController(text: '');
    final devSize = MediaQuery.of(context).size;
    return ViewModelBuilder<SignUpViewModel>.reactive(
        viewModelBuilder: () => SignUpViewModel(),
        builder: (_, viewModel, child) => Padding(
              padding: EdgeInsets.only(top: statusBarHeight),
              child: Scaffold(
                  body: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: devSize.width * .08),
                  child: SizedBox(
                    height: devSize.height,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            'Sign Up',
                            style: TextStyle(
                                fontSize: 30,
                                fontWeight: FontWeight.bold,
                                color: Colors.black),
                          ),
                        ),
                        Lottie.asset('assets/animations/signup.zip',
                            height: devSize.height * .4),
                        const Text(
                          'Fill the form to sign up',
                          style: TextStyle(color: Colors.black38),
                        ),
                        TextField(
                          controller: nameController,
                          decoration:
                              const InputDecoration(hintText: 'full name'),
                        ),
                        TextField(
                          controller: emailController,
                          decoration: const InputDecoration(hintText: 'email'),
                        ),
                        TextField(
                          controller: passwordController,
                          decoration:
                              const InputDecoration(hintText: 'password'),
                        ),
                        TextField(
                          controller: passwordController1,
                          decoration: const InputDecoration(
                              hintText: 'confirm password'),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Row(
                          children: [
                            Checkbox(
                                value: viewModel.agreed,
                                onChanged: viewModel.onAgreementChanged),
                            Expanded(
                              child: InkWell(
                                onTap: viewModel.onRead,
                                child: const Text(
                                  'I agree to the terms and conditions of the application',
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(color: primaryColor),
                                ),
                              ),
                            )
                          ],
                        ),
                        SizedBox(
                            width: double.infinity,
                            child: TextButton(
                                style: TextButton.styleFrom(
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(5)),
                                    backgroundColor: const Color(0xFF3A00FF)),
                                onPressed: viewModel.isBusy
                                    ? null
                                    : () => viewModel.signUp(
                                        nameController.text,
                                        emailController.text,
                                        passwordController.text,
                                        passwordController1.text),
                                child: viewModel.isBusy
                                    ? Transform.scale(
                                        scale: .3,
                                        child: const CircularProgressIndicator(
                                            color: Colors.white),
                                      )
                                    : const Text(
                                        'Sign Up',
                                        style: TextStyle(
                                            fontWeight: FontWeight.w600,
                                            fontSize: 18,
                                            color: Colors.white),
                                      )))
                      ],
                    ),
                  ),
                ),
              )),
            ));
  }
}
