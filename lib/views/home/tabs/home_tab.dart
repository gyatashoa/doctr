import 'package:doctr/models/news_model.dart';
import 'package:doctr/theme/colors.dart';
import 'package:doctr/views/home/home_view_model.dart';
import 'package:doctr/widgets/emoji_btn.dart';
import 'package:doctr/widgets/new_tile.dart';
import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
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
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Container(
          //     decoration: BoxDecoration(color: primaryColor, boxShadow: [
          //       BoxShadow(
          //           offset: const Offset(0, 4),
          //           blurRadius: 4,
          //           spreadRadius: 0,
          //           color: Colors.black.withOpacity(.25))
          //     ]),
          //     width: double.infinity,
          //     height: 56,
          //     child: const Center(
          //         child: Text(
          //       'HOME',
          //       style: TextStyle(color: Colors.white, fontSize: 20),
          //     ))),
          const SizedBox(
            height: 35,
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: devSize.width * .1),
            child: const Text(
              'Hi Felix',
              style: TextStyle(color: Colors.white, fontSize: 25),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: devSize.width * .1),
            child: _DiseaseTextField(),
          ),
          const SizedBox(
            height: 20,
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: devSize.width * .1),
            child: _HowAreYouFeelingSection(),
          ),
          const SizedBox(
            height: 35,
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: devSize.width * .1),
            child: const Text(
              'News for you',
              style: TextStyle(color: Colors.white, fontSize: 16),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          _NewsSection(news: _news)
        ],
      ),
    );
  }
}

class _HowAreYouFeelingSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'How are you feeling today?',
          style: TextStyle(color: Colors.white, fontSize: 15),
        ),
        const SizedBox(
          height: 20,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            EmojiButton(
                onTap: () {}, text: 'Sick', emoji: 'assets/icons/sick.png'),
            EmojiButton(
                onTap: () {},
                text: 'Neutral',
                emoji: 'assets/icons/neutral.png'),
            EmojiButton(
                onTap: () {}, text: 'Happy', emoji: 'assets/icons/happy.png'),
          ],
        )
      ],
    );
  }
}

class _DiseaseTextField extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final devSize = MediaQuery.of(context).size;
    return Container(
      width: devSize.width,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(18), color: Color(0xff2D84C8)),
      child: Padding(
        padding: const EdgeInsets.all(18.0),
        child: Row(
          children: const [
            Expanded(
              child: TextField(
                cursorColor: Colors.white,
                style: TextStyle(color: Colors.white, fontSize: 16),
                decoration: InputDecoration.collapsed(
                    hintStyle: TextStyle(color: Colors.white38),
                    hintText: 'Disease name ...'),
              ),
            ),
            InkWell(
              child: Icon(
                Ionicons.search,
                size: 18,
                color: Colors.white38,
              ),
            )
          ],
        ),
      ),
    );
  }
}

class _NewsSection extends StatelessWidget {
  const _NewsSection({Key? key, required this.news}) : super(key: key);
  final List<NewsModel> news;

  @override
  Widget build(BuildContext context) {
    final devSize = MediaQuery.of(context).size;
    // print(devSize.height * .3);
    return SizedBox(
      height: devSize.height * .3,
      width: double.infinity,
      child: ListView.builder(
          physics: const BouncingScrollPhysics(),
          scrollDirection: Axis.horizontal,
          itemCount: news.length,
          itemBuilder: (_, i) => Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 2, horizontal: 8.0),
                child: NewsTile(
                  news: news[i],
                ),
              )),
    );
  }
}