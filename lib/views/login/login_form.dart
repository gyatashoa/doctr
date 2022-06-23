import 'package:doctr/theme/colors.dart';
import 'package:doctr/views/login/login_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:ionicons/ionicons.dart';
import 'package:stacked_hooks/stacked_hooks.dart';

class LoginForm extends HookViewModelWidget<LoginViewModel> {
  const LoginForm({Key? key}) : super(key: key);

  @override
  Widget buildViewModelWidget(BuildContext context, LoginViewModel viewModel) {
    var emailController = useTextEditingController(text: '');
    var passwordController = useTextEditingController(text: '');
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 5),
          child: Row(
            children: [
              const Padding(
                padding: EdgeInsets.only(right: 8.0),
                child: Icon(
                  Ionicons.at,
                  size: 24,
                  color: ashColor,
                ),
              ),
              Expanded(
                child: TextField(
                  controller: emailController,
                  decoration: const InputDecoration(
                    isDense: true,
                    contentPadding: EdgeInsets.symmetric(vertical: 10),
                    prefixIconConstraints:
                        BoxConstraints(minWidth: 24, maxHeight: 24),
                    hintText: 'Email',
                  ),
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 5),
          child: Row(
            children: [
              const Padding(
                padding: EdgeInsets.only(right: 8.0),
                child: Icon(
                  Ionicons.lock_closed_outline,
                  size: 24,
                  color: ashColor,
                ),
              ),
              Expanded(
                child: TextField(
                  controller: passwordController,
                  obscureText: viewModel.viewPassword,
                  decoration: InputDecoration(
                      isDense: true,
                      contentPadding: const EdgeInsets.symmetric(vertical: 10),
                      prefixIconConstraints:
                          const BoxConstraints(minWidth: 24, maxHeight: 24),
                      suffixIconConstraints:
                          const BoxConstraints(minWidth: 24, maxHeight: 24),
                      hintText: 'Password',
                      suffixIcon: IconButton(
                        icon: Icon(
                          viewModel.viewPassword
                              ? Ionicons.eye_outline
                              : Ionicons.eye_off_outline,
                          color: const Color(0xffACB1C1),
                        ),
                        onPressed: () =>
                            viewModel.viewPassword = !viewModel.viewPassword,
                      )),
                ),
              ),
            ],
          ),
        ),
        InkWell(
          onTap: viewModel.navigateToForgotPassword,
          child: const Align(
              alignment: Alignment.centerRight,
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 10.0),
                child: Text(
                  'Forgot Password?',
                  style: TextStyle(
                      fontWeight: FontWeight.w600, color: Color(0xFF2D00CE)),
                ),
              )),
        ),
        Container(
            padding: const EdgeInsets.all(5),
            width: double.infinity,
            child: TextButton(
                style: TextButton.styleFrom(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5)),
                    backgroundColor: const Color(0xFF3A00FF)),
                onPressed: viewModel.isLoginLoading
                    ? null
                    : () => viewModel.loginPressed(
                        context: context,
                        email: emailController.text,
                        password: passwordController.text),
                child: viewModel.isLoginLoading
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
                      ))),
      ],
    );
  }
}
