import 'dart:async';

import 'package:doctr/app/app.locator.dart';
import 'package:doctr/models/gender.dart';
import 'package:doctr/services/auth_services.dart';
import 'package:doctr/theme/colors.dart';
import 'package:doctr/theme/theme.dart';
import 'package:doctr/utils/helpers.dart';
import 'package:doctr/widgets/avatar.dart';
import 'package:doctr/widgets/display_error_widget.dart';
import 'package:doctr/widgets/glowing_action_button.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:jiffy/jiffy.dart';
import 'package:stream_chat_flutter_core/stream_chat_flutter_core.dart';

class ChatView extends StatelessWidget {
  final Channel channel;
  final int otherMemberGender;
  const ChatView(
      {Key? key, required this.otherMemberGender, required this.channel})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamChannel(
      channel: channel,
      child: ChatView1(otherMemberGender: otherMemberGender, channel: channel),
    );
  }
}

class ChatView1 extends StatefulWidget {
  final Channel channel;
  final int otherMemberGender;
  const ChatView1(
      {Key? key, required this.otherMemberGender, required this.channel})
      : super(key: key);

  @override
  _ChatViewState createState() => _ChatViewState();
}

class _ChatViewState extends State<ChatView1> {
  late StreamSubscription<int> unreadCountSubscription;

  @override
  void initState() {
    super.initState();

    unreadCountSubscription = StreamChannel.of(context)
        .channel
        .state!
        .unreadCountStream
        .listen(_unreadCountHandler);
  }

  Future<void> _unreadCountHandler(int count) async {
    if (count > 0) {
      await StreamChannel.of(context).channel.markRead();
    }
  }

  @override
  void dispose() {
    unreadCountSubscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: primaryColor,
          title: _AppBarTitle(otherMemberGender: widget.otherMemberGender),
        ),
        body: Column(
          children: [
            Expanded(
              child: MessageListCore(
                loadingBuilder: (context) {
                  return const Center(child: CircularProgressIndicator());
                },
                emptyBuilder: (context) => const SizedBox.shrink(),
                errorBuilder: (context, error) =>
                    DisplayErrorMessage(error: error),
                messageListBuilder: (context, messages) =>
                    _MessageList(messages: messages),
              ),
            ),
            const _ActionBar(),
          ],
        ),
      ),
    );
  }
}

class _MessageList extends StatelessWidget {
  const _MessageList({
    Key? key,
    required this.messages,
  }) : super(key: key);

  final List<Message> messages;

  @override
  Widget build(BuildContext context) {
    final _authServices = locator<AuthServices>();
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ListView.separated(
        physics: const BouncingScrollPhysics(),
        itemCount: messages.length + 1,
        reverse: true,
        separatorBuilder: (context, index) {
          if (index == messages.length - 1) {
            return _DateLable(dateTime: messages[index].createdAt);
          }
          if (messages.length == 1) {
            return const SizedBox.shrink();
          } else if (index >= messages.length - 1) {
            return const SizedBox.shrink();
          } else if (index <= messages.length) {
            final message = messages[index];
            final nextMessage = messages[index + 1];
            if (!Jiffy(message.createdAt.toLocal())
                .isSame(nextMessage.createdAt.toLocal(), Units.DAY)) {
              return _DateLable(
                dateTime: message.createdAt,
              );
            } else {
              return const SizedBox.shrink();
            }
          } else {
            return const SizedBox.shrink();
          }
        },
        itemBuilder: (context, index) {
          if (index < messages.length) {
            final message = messages[index];
            if (message.user?.id == _authServices.currentUser!.uid) {
              return _MessageOwnTile(message: message);
            } else {
              return _MessageTile(message: message);
            }
          } else {
            return const SizedBox.shrink();
          }
        },
      ),
    );
  }
}

class _MessageTile extends StatelessWidget {
  const _MessageTile({
    Key? key,
    required this.message,
  }) : super(key: key);

  final Message message;

  static const _borderRadius = 26.0;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              decoration: BoxDecoration(
                color: primaryColor.withOpacity(.8),
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(_borderRadius),
                  topRight: Radius.circular(_borderRadius),
                  bottomRight: Radius.circular(_borderRadius),
                ),
              ),
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 12.0, vertical: 20),
                child: Text(
                  message.text ?? '',
                  style: GoogleFonts.ptSans(color: Colors.white),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: Text(
                Jiffy(message.createdAt.toLocal()).jm,
                style: const TextStyle(
                  color: AppColors.textFaded,
                  fontSize: 10,
                  fontWeight: FontWeight.bold,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class _MessageOwnTile extends StatelessWidget {
  const _MessageOwnTile({
    Key? key,
    required this.message,
  }) : super(key: key);

  final Message message;

  static const _borderRadius = 26.0;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Align(
        alignment: Alignment.centerRight,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Container(
              decoration: const BoxDecoration(
                color: primaryColor,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(_borderRadius),
                  bottomRight: Radius.circular(_borderRadius),
                  bottomLeft: Radius.circular(_borderRadius),
                ),
              ),
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 12.0, vertical: 20),
                child: Text(message.text ?? '',
                    style: const TextStyle(
                      color: AppColors.textLigth,
                    )),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: Text(
                Jiffy(message.createdAt.toLocal()).jm,
                style: const TextStyle(
                  color: AppColors.textFaded,
                  fontSize: 10,
                  fontWeight: FontWeight.bold,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class _DateLable extends StatefulWidget {
  const _DateLable({
    Key? key,
    required this.dateTime,
  }) : super(key: key);

  final DateTime dateTime;

  @override
  __DateLableState createState() => __DateLableState();
}

class __DateLableState extends State<_DateLable> {
  late String dayInfo;

  @override
  void initState() {
    final createdAt = Jiffy(widget.dateTime);
    final now = DateTime.now();

    if (Jiffy(createdAt).isSame(now, Units.DAY)) {
      dayInfo = 'TODAY';
    } else if (Jiffy(createdAt)
        .isSame(now.subtract(const Duration(days: 1)), Units.DAY)) {
      dayInfo = 'YESTERDAY';
    } else if (Jiffy(createdAt).isAfter(
      now.subtract(const Duration(days: 7)),
      Units.DAY,
    )) {
      dayInfo = createdAt.EEEE;
    } else if (Jiffy(createdAt).isAfter(
      Jiffy(now).subtract(years: 1),
      Units.DAY,
    )) {
      dayInfo = createdAt.MMMd;
    } else {
      dayInfo = createdAt.MMMd;
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 32.0),
        child: Container(
          decoration: BoxDecoration(
              color: primaryColor,
              borderRadius: BorderRadius.circular(12),
              boxShadow: const [
                BoxShadow(
                    color: Colors.black12,
                    blurRadius: 2,
                    offset: Offset(0, 1),
                    spreadRadius: 2)
              ]),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 12),
            child: Text(
              dayInfo,
              style: const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _AppBarTitle extends StatelessWidget {
  final int otherMemberGender;
  const _AppBarTitle({Key? key, required this.otherMemberGender})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final channel = StreamChannel.of(context).channel;
    // final _authServices = locator<AuthServices>();
    return Row(
      children: [
        Avatar.small(
          url: otherMemberGender == Gender.MALE.index
              ? 'assets/images/user.png'
              : 'assets/images/user1.png',
        ),
        const SizedBox(
          width: 16,
        ),
        Expanded(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                Helpers.getChannelName(channel, context.currentUser!),
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(fontSize: 14),
              ),
              const SizedBox(height: 2),
              BetterStreamBuilder<List<Member>>(
                stream: channel.state!.membersStream,
                initialData: channel.state!.members,
                builder: (context, data) => ConnectionStatusBuilder(
                  statusBuilder: (context, status) {
                    switch (status) {
                      case ConnectionStatus.connected:
                        return _buildConnectedTitleState(context, data);
                      case ConnectionStatus.connecting:
                        return const Text(
                          'Connecting',
                          style: TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                            color: Colors.green,
                          ),
                        );
                      case ConnectionStatus.disconnected:
                        return const Text(
                          'Offline',
                          style: TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                            color: Colors.red,
                          ),
                        );
                      default:
                        return const SizedBox.shrink();
                    }
                  },
                ),
              ),
            ],
          ),
        )
      ],
    );
  }

  Widget _buildConnectedTitleState(
    BuildContext context,
    List<Member>? members,
  ) {
    Widget? alternativeWidget;
    final channel = StreamChannel.of(context).channel;
    final memberCount = channel.memberCount;
    if (memberCount != null && memberCount > 2) {
      var text = 'Members: $memberCount';
      final watcherCount = channel.state?.watcherCount ?? 0;
      if (watcherCount > 0) {
        text = 'watchers $watcherCount';
      }
      alternativeWidget = Text(
        text,
      );
    } else {
      final userId = StreamChatCore.of(context).currentUser?.id;
      final otherMember = members
          ?.where(
            (element) => element.userId != userId,
          )
          .first;

      if (otherMember != null) {
        if (otherMember.user?.online == true) {
          alternativeWidget = const Text(
            'Online',
            style: TextStyle(
              fontSize: 10,
              fontWeight: FontWeight.bold,
              color: Colors.green,
            ),
          );
        } else {
          alternativeWidget = Text(
            'Last online: '
            '${Jiffy(otherMember.user?.lastActive).fromNow()}',
            style: TextStyle(
              fontSize: 10,
              fontWeight: FontWeight.bold,
              color: Colors.white.withOpacity(.5),
            ),
          );
        }
      }
    }

    return TypingIndicator(
      alternativeWidget: alternativeWidget,
    );
  }
}

/// Widget to show the current list of typing users
class TypingIndicator extends StatelessWidget {
  /// Instantiate a new TypingIndicator
  const TypingIndicator({
    Key? key,
    this.alternativeWidget,
  }) : super(key: key);

  /// Widget built when no typings is happening
  final Widget? alternativeWidget;

  @override
  Widget build(BuildContext context) {
    final channelState = StreamChannel.of(context).channel.state!;

    final altWidget = alternativeWidget ?? const SizedBox.shrink();

    return BetterStreamBuilder<Iterable<User>>(
      initialData: channelState.typingEvents.keys,
      stream: channelState.typingEventsStream
          .map((typings) => typings.entries.map((e) => e.key)),
      builder: (context, data) {
        return Align(
          alignment: Alignment.centerLeft,
          child: AnimatedSwitcher(
            duration: const Duration(milliseconds: 300),
            child: data.isNotEmpty == true
                ? const Align(
                    alignment: Alignment.centerLeft,
                    key: ValueKey('typing-text'),
                    child: Text(
                      'Typing message',
                      maxLines: 1,
                      style: TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  )
                : Align(
                    alignment: Alignment.centerLeft,
                    key: const ValueKey('altwidget'),
                    child: altWidget,
                  ),
          ),
        );
      },
    );
  }
}

/// Widget that builds itself based on the latest snapshot of interaction with
/// a [Stream] of type [ConnectionStatus].
///
/// The widget will use the closest [StreamChatClient.wsConnectionStatusStream]
/// in case no stream is provided.
class ConnectionStatusBuilder extends StatelessWidget {
  /// Creates a new ConnectionStatusBuilder
  const ConnectionStatusBuilder({
    Key? key,
    required this.statusBuilder,
    this.connectionStatusStream,
    this.errorBuilder,
    this.loadingBuilder,
  }) : super(key: key);

  /// The asynchronous computation to which this builder is currently connected.
  final Stream<ConnectionStatus>? connectionStatusStream;

  /// The builder that will be used in case of error
  final Widget Function(BuildContext context, Object? error)? errorBuilder;

  /// The builder that will be used in case of loading
  final WidgetBuilder? loadingBuilder;

  /// The builder that will be used in case of data
  final Widget Function(BuildContext context, ConnectionStatus status)
      statusBuilder;

  @override
  Widget build(BuildContext context) {
    final stream = connectionStatusStream ??
        StreamChatCore.of(context).client.wsConnectionStatusStream;
    final client = StreamChatCore.of(context).client;
    return BetterStreamBuilder<ConnectionStatus>(
      initialData: client.wsConnectionStatus,
      stream: stream,
      noDataBuilder: loadingBuilder,
      errorBuilder: (context, error) {
        if (errorBuilder != null) {
          return errorBuilder!(context, error);
        }
        return const Offstage();
      },
      builder: statusBuilder,
    );
  }
}

class _ActionBar extends StatefulWidget {
  const _ActionBar({Key? key}) : super(key: key);

  @override
  __ActionBarState createState() => __ActionBarState();
}

class __ActionBarState extends State<_ActionBar> {
  final TextEditingController controller = TextEditingController();

  Future<void> _sendMessage() async {
    if (controller.text.isNotEmpty) {
      StreamChannel.of(context)
          .channel
          .sendMessage(Message(text: controller.text));
      controller.clear();
      FocusScope.of(context).unfocus();
    }
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      bottom: true,
      top: false,
      child: Row(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(left: 16.0),
              child: TextField(
                controller: controller,
                onChanged: (val) {
                  StreamChannel.of(context).channel.keyStroke();
                },
                style: const TextStyle(fontSize: 14),
                decoration: const InputDecoration(
                  hintText: 'Type something...',
                  border: InputBorder.none,
                ),
                onSubmitted: (_) => _sendMessage(),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
              // left: 12,
              right: 8.0,
            ),
            child: GlowingActionButton(
              color: primaryColor,
              icon: Icons.send_rounded,
              onPressed: _sendMessage,
            ),
          ),
        ],
      ),
    );
  }
}

extension StreamChatContext on BuildContext {
  /// Fetches the current user image.
  String? get currentUserImage => currentUser!.image;

  /// Fetches the current user.
  User? get currentUser => StreamChatCore.of(this).currentUser;
}
