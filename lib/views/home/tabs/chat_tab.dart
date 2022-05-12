import 'package:doctr/views/home/home_view_model.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

class ChatTab extends ViewModelWidget<HomeViewModel> {
  const ChatTab({Key? key}) : super(key: key, reactive: false);

  @override
  Widget build(BuildContext context, HomeViewModel model) {
    return Container(
      child: Center(
        child: Text('chat'),
      ),
    );
  }
}
