import 'package:doctr/theme/colors.dart';
import 'package:doctr/views/login/login_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ionicons/ionicons.dart';
import 'package:stacked/stacked.dart';

class LoginForm extends ViewModelWidget<LoginViewModel> {
  const LoginForm({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, LoginViewModel viewModel) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: Row(
            children: const [
              Padding(
                padding: EdgeInsets.only(right: 8.0),
                child: Icon(
                  Ionicons.at,
                  size: 24,
                  color: ashColor,
                ),
              ),
              Expanded(
                child: TextField(
                  decoration: InputDecoration(
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
          padding: const EdgeInsets.symmetric(vertical: 8.0),
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
        const Align(
            alignment: Alignment.centerRight,
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 10.0),
              child: Text(
                'Forgot Password?',
                style: TextStyle(color: Color(0xFF2D00CE)),
              ),
            )),
        Container(
            padding: const EdgeInsets.all(5),
            width: double.infinity,
            child: TextButton(
                style: TextButton.styleFrom(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5)),
                    backgroundColor: const Color(0xFF3A00FF)),
                onPressed: viewModel.isLoginLoading ||
                        viewModel.isLoginwithGoogleLoading
                    ? null
                    : () => viewModel.loginPressed(),
                child: viewModel.isLoginLoading
                    ? Transform.scale(
                        scale: .3,
                        child: const CircularProgressIndicator(
                            color: Colors.white),
                      )
                    : const Text(
                        'Login',
                        style: TextStyle(fontSize: 16, color: Colors.white),
                      ))),
        Row(
          children: const [
            Expanded(
              child: Divider(
                thickness: .2,
                color: ashColor,
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 8.0),
              child: Text('OR'),
            ),
            Expanded(
                child: Divider(
              thickness: .2,
              color: ashColor,
            ))
          ],
        ),
        Container(
          padding: const EdgeInsets.all(5),
          width: double.infinity,
          child: TextButton.icon(
              style: TextButton.styleFrom(
                  backgroundColor: const Color(0xffF0F5F6)),
              onPressed:
                  viewModel.isLoginwithGoogleLoading || viewModel.isLoginLoading
                      ? null
                      : () => viewModel.loginWithGooglePressed(),
              icon: viewModel.isLoginwithGoogleLoading
                  ? const SizedBox()
                  : SvgPicture.asset('assets/icons/google_icon.svg',
                      height: 20, width: 20),
              label: viewModel.isLoginwithGoogleLoading
                  ? Transform.scale(
                      scale: .3,
                      child: const CircularProgressIndicator(),
                    )
                  : const Text(
                      'Login with Google',
                      style: TextStyle(fontSize: 16, color: Color(0xff374164)),
                    )),
        ),
      ],
    );
  }
}
