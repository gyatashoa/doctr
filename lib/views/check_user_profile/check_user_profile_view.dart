import 'package:doctr/models/gender.dart';
import 'package:doctr/providers/user_additional_data_provider.dart';
import 'package:doctr/theme/colors.dart';
import 'package:doctr/views/check_user_profile/check_user_profile_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:provider/provider.dart';
import 'package:stacked/stacked.dart';

class CheckUserProfileView extends HookWidget {
  const CheckUserProfileView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final devSize = MediaQuery.of(context).size;
    final emailController = useTextEditingController();
    final nameController = useTextEditingController();
    final genderController = useTextEditingController();
    final dobController = useTextEditingController();
    final currentCondtionController = useTextEditingController();
    final createdAtController = useTextEditingController();
    final userTypeController = useTextEditingController();
    var user = Provider.of<UserAdditionalDataProvider>(context).getUserAddData;
    return ViewModelBuilder<CheckUserProfileViewModel>.nonReactive(
        viewModelBuilder: () => CheckUserProfileViewModel(),
        builder: (_, model, __) {
          emailController.text = model.user?.email ?? '';
          nameController.text = model.user?.displayName ?? '';
          genderController.text = user!.gender.name;
          dobController.text = user.dob.dateTimeString;
          currentCondtionController.text = user.condition.name;
          createdAtController.text =
              model.user?.metadata.creationTime?.dateTimeString ?? '';
          userTypeController.text = user.userType.name.toUpperCase();
          return Scaffold(
              backgroundColor: primaryColor,
              appBar: AppBar(
                title: const Text('PROFILE'),
                centerTitle: true,
                backgroundColor: primaryColor,
              ),
              body: Theme(
                data: Theme.of(context).copyWith(
                    textTheme: TextTheme(
                        subtitle1:
                            TextStyle(color: Colors.white.withOpacity(.5))),
                    inputDecorationTheme: const InputDecorationTheme(
                        labelStyle: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                        ),
                        disabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.white),
                        ))),
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: devSize.width * .1),
                    child: Column(children: [
                      const SizedBox(
                        height: 15,
                      ),
                      Container(
                        // height: 50,
                        // width: 50,
                        child: Image.asset(
                          user.gender == Gender.MALE
                              ? 'assets/images/user.png'
                              : 'assets/images/user1.png',
                          height: devSize.height * .25,
                        ),
                        decoration: BoxDecoration(
                            color: const Color(0xff2D84C8),
                            boxShadow: [
                              BoxShadow(
                                  color: Colors.black.withOpacity(.25),
                                  blurRadius: 10,
                                  offset: const Offset(0, 4),
                                  spreadRadius: 2)
                            ],
                            border: Border.all(
                              color: Colors.white.withOpacity(.5),
                            ),
                            shape: BoxShape.circle),
                      ),
                      const SizedBox(height: 15),
                      TextField(
                        decoration: const InputDecoration(labelText: 'Email'),
                        controller: emailController,
                        enabled: false,
                      ),
                      const SizedBox(height: 5),
                      TextField(
                        decoration:
                            const InputDecoration(labelText: 'Full Name'),
                        controller: nameController,
                        enabled: false,
                      ),
                      const SizedBox(height: 5),
                      TextField(
                        decoration: const InputDecoration(labelText: 'Gender'),
                        controller: genderController,
                        enabled: false,
                      ),
                      const SizedBox(height: 5),
                      TextField(
                        decoration: const InputDecoration(labelText: 'Dob'),
                        controller: dobController,
                        enabled: false,
                      ),
                      const SizedBox(height: 5),
                      TextField(
                        decoration: const InputDecoration(
                            labelText: 'Current Condition'),
                        controller: currentCondtionController,
                        enabled: false,
                      ),
                      const SizedBox(height: 5),
                      TextField(
                        decoration: const InputDecoration(
                            labelText: 'Account Creation Date'),
                        controller: createdAtController,
                        enabled: false,
                      ),
                      const SizedBox(height: 5),
                      TextField(
                        decoration:
                            const InputDecoration(labelText: 'Registered as'),
                        controller: userTypeController,
                        enabled: false,
                      ),
                    ]),
                  ),
                ),
              ));
        });
  }
}

extension on DateTime {
  String get dateTimeString => '$day/$month/$year';
}
