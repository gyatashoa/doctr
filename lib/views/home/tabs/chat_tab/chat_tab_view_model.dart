import 'dart:developer';

import 'package:doctr/app/app.locator.dart';
import 'package:doctr/providers/user_additional_data_provider.dart';
import 'package:doctr/services/auth_services.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:stacked/stacked.dart';
import 'package:stream_chat_flutter_core/stream_chat_flutter_core.dart'
    as stream_core;

class ChatTabViewModel extends BaseViewModel {
  final _authServices = locator<AuthServices>();

  Future<void> connectUser(
      stream_core.StreamChatClient client, BuildContext context) async {
    final user = _authServices.currentUser;
    final provider =
        Provider.of<UserAdditionalDataProvider>(context, listen: false);
    try {
      await client.connectUser(
        stream_core.User(
          id: user!.uid,
          extraData: {
            'name': user.displayName,
            'userType': provider.getUserAddData?.userType.index
          },
        ),
        client.devToken(user.uid).rawValue,
      );
      log('user connected!');
    } on Exception catch (e, st) {
      log('Unable to connect user', stackTrace: st, error: e);
    }
  }
}
