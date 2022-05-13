import 'package:doctr/models/chat_model.dart';
import 'package:doctr/theme/colors.dart';
import 'package:doctr/views/home/home_view_model.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

class ChatTab extends ViewModelWidget<HomeViewModel> {
  const ChatTab({Key? key}) : super(key: key, reactive: false);

  @override
  Widget build(BuildContext context, HomeViewModel model) {
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
        Flexible(
            child: ListView.separated(
                physics: const BouncingScrollPhysics(),
                itemBuilder: (_, i) => ListTile(
                      onTap: () {},
                      leading: CircleAvatar(
                        backgroundImage: AssetImage(chats[i].imgUrl),
                      ),
                      title: Text(
                        chats[i].name,
                        style: const TextStyle(color: Colors.white),
                      ),
                    ),
                separatorBuilder: (_, i) => const Divider(
                      height: 0,
                      color: Colors.white,
                    ),
                itemCount: chats.length))
      ],
    );
  }
}
