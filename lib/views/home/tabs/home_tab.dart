import 'package:doctr/models/news_model.dart';
import 'package:doctr/views/home/home_view_model.dart';
import 'package:doctr/widgets/emoji_btn.dart';
import 'package:doctr/widgets/new_tile.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

class HomeTab extends ViewModelWidget<HomeViewModel> {
  const HomeTab({Key? key}) : super(key: key, reactive: false);

  @override
  Widget build(BuildContext context, HomeViewModel model) {
    //TODO: Remove after api is implemented
    List<NewsModel> _news = [
      NewsModel(
          title: 'Is Oregon’s flu vacation over? - Oregon Public Broadcasting',
          imageUrl: 'assets/images/health_compressed.jpg'),
      NewsModel(
          title: 'Is Oregon’s flu vacation over? - Oregon Public Broadcasting',
          imageUrl: 'assets/images/health_compressed.jpg'),
      NewsModel(
          title: 'Is Oregon’s flu vacation over? - Oregon Public Broadcasting',
          imageUrl: 'assets/images/health_compressed.jpg')
    ];
    final devSize = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: FocusScope.of(context).unfocus,
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: devSize.width * .1),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Padding(
                padding: EdgeInsets.symmetric(vertical: devSize.height * .05),
                child: Text(
                  'Hi Felix',
                  style: Theme.of(context).textTheme.displayMedium!.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.w400,
                      fontSize: devSize.height * .04),
                ),
              ),
              Container(
                  decoration: BoxDecoration(
                      color: const Color(0xff2D84C8),
                      borderRadius: BorderRadius.circular(20)),
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: TextField(
                        cursorColor: Colors.white,
                        style: Theme.of(context)
                            .textTheme
                            .displaySmall!
                            .copyWith(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                                color: Colors.white.withOpacity(.8)),
                        decoration: InputDecoration.collapsed(
                            hintStyle: Theme.of(context)
                                .textTheme
                                .displaySmall!
                                .copyWith(
                                    fontSize: 15,
                                    color: Colors.white.withOpacity(.4)),
                            hintText: 'Disease name...')),
                  )),
              Padding(
                padding: EdgeInsets.symmetric(vertical: devSize.height * .04),
                child: Text(
                  'How are you feeling today?',
                  style: Theme.of(context)
                      .textTheme
                      .displaySmall!
                      .copyWith(color: Colors.white, fontSize: 15),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  EmojiButton(
                      emoji: 'assets/icons/sick.svg',
                      text: 'Sick',
                      onTap: () {}),
                  EmojiButton(
                      emoji: 'assets/icons/neutral.svg',
                      text: 'Neutral',
                      onTap: () {}),
                  EmojiButton(
                      emoji: 'assets/icons/smiling.svg',
                      text: 'Happy',
                      onTap: () {}),
                ],
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: devSize.height * .035),
                child: Text(
                  'News for you',
                  style: Theme.of(context)
                      .textTheme
                      .bodyMedium!
                      .copyWith(fontSize: 18, color: Colors.white),
                ),
              ),
            ]),
          ),
          Flexible(
            // height: devSize.height * .3,
            // width: double.infinity,
            child: ListView.builder(
                physics: const BouncingScrollPhysics(),
                scrollDirection: Axis.horizontal,
                itemCount: _news.length,
                itemBuilder: (_, i) => Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: NewsTile(
                        news: _news[i],
                      ),
                    )),
          )
        ],
      ),
    );
  }
}
