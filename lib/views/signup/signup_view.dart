import 'package:doctr/views/signup/signup_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_hooks/stacked_hooks.dart';

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
                  child: Column(
                    children: [
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
                        decoration: const InputDecoration(hintText: 'password'),
                      ),
                      TextField(
                        controller: passwordController1,
                        decoration:
                            const InputDecoration(hintText: 'confirm password'),
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
                                      'Login',
                                      style: TextStyle(
                                          fontWeight: FontWeight.w600,
                                          fontSize: 18,
                                          color: Colors.white),
                                    )))
                    ],
                  ),
                ),
              )),
            ));
  }
}
