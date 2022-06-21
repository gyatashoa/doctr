import 'package:doctr/app/app.locator.dart';
import 'package:doctr/app/app.router.dart';
import 'package:doctr/models/chat_model.dart';
import 'package:doctr/services/auth_services.dart';
import 'package:doctr/theme/colors.dart';
import 'package:doctr/views/home/home_view_model.dart';
import 'package:doctr/views/home/tabs/chat_tab/chat_tab_view_model.dart';
import 'package:doctr/widgets/display_error_widget.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:stream_chat_flutter_core/stream_chat_flutter_core.dart';

class ChatTab extends StatelessWidget {
  const ChatTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<ChatModel> chats = [
      ChatModel(name: 'Dr Asamoah Felix', imgUrl: 'assets/images/user.png'),
      ChatModel(name: 'Dr Asamoah Felix', imgUrl: 'assets/images/user.png'),
      ChatModel(name: 'Dr Asamoah Felix', imgUrl: 'assets/images/user.png'),
      ChatModel(name: 'Dr Asamoah Felix', imgUrl: 'assets/images/user.png'),
      ChatModel(name: 'Dr Asamoah Felix', imgUrl: 'assets/images/user.png'),
      ChatModel(name: 'Dr Asamoah Felix', imgUrl: 'assets/images/user.png'),
      ChatModel(name: 'Dr Asamoah Felix', imgUrl: 'assets/images/user.png'),
      ChatModel(name: 'Dr Asamoah Felix', imgUrl: 'assets/images/user.png'),
    ];
    final client = StreamChatCore.of(context).client;
    return ViewModelBuilder<ChatTabViewModel>.reactive(
      onModelReady: (model) => model.connectUser(client),
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
            // Flexible(
            //     child: ListView.separated(
            //         physics: const BouncingScrollPhysics(),
            //         itemBuilder: (_, i) => ListTile(
            //               onTap: () {},
            //               leading: CircleAvatar(
            //                 backgroundImage: AssetImage(chats[i].imgUrl),
            //               ),
            //               title: Text(
            //                 chats[i].name,
            //                 style: const TextStyle(color: Colors.white),
            //               ),
            //             ),
            //         separatorBuilder: (_, i) => const Divider(
            //               height: 0,
            //               color: Colors.white,
            //             ),
            //         itemCount: chats.length))
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
    return UserListCore(
      limit: 20,
      //Will add a filter to show only doctors
      filter: Filter.notEqual('id', _authServices.currentUser!.uid),
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

  Future<void> createChannel(BuildContext context) async {
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
        arguments: ChatViewArguments(channel: channel));
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () {
        createChannel(context);
      },
      leading: const CircleAvatar(
        backgroundImage: AssetImage('assets/images/user.png'),
      ),
      title: Text(
        user.name,
        style: const TextStyle(color: Colors.white),
      ),
    );
  }
}

// class MessagesPage extends StatefulWidget {
//   const MessagesPage({Key? key}) : super(key: key);

//   @override
//   _MessagesPageState createState() => _MessagesPageState();
// }

// class _MessagesPageState extends State<MessagesPage> {
//   final channelListController = ChannelListController();
//   final AuthServices _authServices = locator<AuthServices>();

//   @override
//   Widget build(BuildContext context) {
//     return ChannelListCore(
//       channelListController: channelListController,
//       filter: Filter.and(
//         [
//           Filter.equal('type', 'messaging'),
//           Filter.in_('members', [
//             _authServices.currentUser!.uid,
//           ])
//         ],
//       ),
//       emptyBuilder: (context) => const Center(
//         child: Text(
//           'So empty.\nGo and message someone.',
//           textAlign: TextAlign.center,
//         ),
//       ),
//       errorBuilder: (context, error) => DisplayErrorMessage(
//         error: error,
//       ),
//       loadingBuilder: (
//         context,
//       ) =>
//           const Center(
//         child: SizedBox(
//           height: 100,
//           width: 100,
//           child: CircularProgressIndicator(),
//         ),
//       ),
//       listBuilder: (context, channels) {
//         return CustomScrollView(
//           slivers: [
//             const SliverToBoxAdapter(
//                 // child: _Stories(),
//                 ),
//             SliverList(
//               delegate: SliverChildBuilderDelegate(
//                 (context, index) {
//                   return Container();
//                   // return _MessageTile(
//                   //   channel: channels[index],
//                   // );
//                 },
//                 childCount: channels.length,
//               ),
//             )
//           ],
//         );
//       },
//     );
//   }
// }
