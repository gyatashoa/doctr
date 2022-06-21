import 'dart:developer';

import 'package:doctr/app/app.locator.dart';
import 'package:doctr/services/auth_services.dart';
import 'package:stacked/stacked.dart';
import 'package:stream_chat_flutter_core/stream_chat_flutter_core.dart'
    as stream_core;

class ChatTabViewModel extends FutureViewModel<int> {
  final _authServices = locator<AuthServices>();

  @override
  Future<int> futureToRun() {
    return Future.delayed(Duration(seconds: 1), () => 1);
  }

  Future<void> connectUser(stream_core.StreamChatClient client) async {
    final user = _authServices.currentUser;
    try {
      await client.connectUser(
        stream_core.User(
          id: user!.uid,
          extraData: {'name': user.displayName},
        ),
        client.devToken(user.uid).rawValue,
      );
      log('user connected!');
    } on Exception catch (e, st) {
      log('Unable to connect user', stackTrace: st, error: e);
    }
  }
}
