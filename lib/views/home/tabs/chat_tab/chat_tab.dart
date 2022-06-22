import 'package:doctr/app/app.locator.dart';
import 'package:doctr/app/app.router.dart';
import 'package:doctr/models/gender.dart';
import 'package:doctr/models/user_additional_data_model.dart';
import 'package:doctr/models/user_type.dart';
import 'package:doctr/providers/user_additional_data_provider.dart';
import 'package:doctr/services/auth_services.dart';
import 'package:doctr/theme/colors.dart';
import 'package:doctr/views/home/tabs/chat_tab/chat_tab_view_model.dart';
import 'package:doctr/widgets/display_error_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:stream_chat_flutter_core/stream_chat_flutter_core.dart';

class ChatTab extends StatelessWidget {
  const ChatTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final client = StreamChatCore.of(context).client;
    return ViewModelBuilder<ChatTabViewModel>.reactive(
      onModelReady: (model) => model.connectUser(client, context),
      builder: (context, model, child) {
        return Column(
          children: [
            Container(
                decoration: BoxDecoration(color: primaryColor, boxShadow: [
                  BoxShadow(
                      offset: const Offset(0, 4),
                      blurRadius: 4,
                      spreadRadius: 0,
                      color: Colors.black.withOpacity(.25))
                ]),
                width: double.infinity,
                height: 56,
                child: const Center(
                    child: Text(
                  'CHAT',
                  style: TextStyle(color: Colors.white, fontSize: 20),
                ))),
            const Expanded(child: ContactsPage())
          ],
        );
      },
      viewModelBuilder: () => ChatTabViewModel(),
    );
  }
}

class ContactsPage extends StatelessWidget {
  const ContactsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final AuthServices _authServices = locator<AuthServices>();
    final provider = Provider.of<UserAdditionalDataProvider>(context);
    return UserListCore(
      limit: 20,
      filter: Filter.and([
        Filter.notEqual('id', _authServices.currentUser!.uid),
        Filter.equal('userType',
            provider.getUserAddData?.userType == UserType.user ? 1 : 0)
      ]),
      emptyBuilder: (context) {
        return const Center(child: Text('There are no users'));
      },
      loadingBuilder: (context) {
        return const Center(child: CircularProgressIndicator());
      },
      errorBuilder: (context, error) {
        return DisplayErrorMessage(error: error);
      },
      listBuilder: (context, items) {
        return Scrollbar(
          child: ListView.separated(
            itemCount: items.length,
            itemBuilder: (context, index) {
              return items[index].when(
                headerItem: (_) => const SizedBox.shrink(),
                userItem: (user) => _ContactTile(user: user),
              );
            },
            separatorBuilder: (BuildContext context, int index) =>
                const Divider(
              height: 0,
              color: Colors.white,
            ),
          ),
        );
      },
    );
  }
}

class _ContactTile extends StatelessWidget {
  const _ContactTile({
    Key? key,
    required this.user,
  }) : super(key: key);

  final User user;

  Future<void> createChannel(
      BuildContext context, int otherMemberGender) async {
    final core = StreamChatCore.of(context);
    final _authService = locator<AuthServices>();
    final _navigationService = locator<NavigationService>();
    final channel = core.client.channel('messaging', extraData: {
      'members': [
        _authService.currentUser!.uid,
        user.id,
      ]
    });
    await channel.watch();
    _navigationService.navigateTo(Routes.chatView,
        arguments: ChatViewArguments(
            channel: channel, otherMemberGender: otherMemberGender));
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () {
        createChannel(context, user.extraData['gender'] as int);
      },
      leading: CircleAvatar(
        backgroundImage: AssetImage(
            user.extraData['gender'] == Gender.MALE.index
                ? 'assets/images/user.png'
                : 'assets/images/user1.png'),
      ),
      title: Text(
        user.name,
        style: const TextStyle(color: Colors.white),
      ),
    );
  }
}
