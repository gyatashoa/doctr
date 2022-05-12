import 'package:doctr/models/news_model.dart';
import 'package:flutter/material.dart';

class NewsTile extends StatelessWidget {
  const NewsTile({Key? key, required this.news}) : super(key: key);
  final NewsModel news;

  @override
  Widget build(BuildContext context) {
    final devSize = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Container(
        decoration: BoxDecoration(boxShadow: [
          BoxShadow(
              color: Colors.black.withOpacity(.25),
              offset: Offset(0, 2),
              blurRadius: 8,
              spreadRadius: 2)
        ]),
        // height: devSize.height * .009,
        width: devSize.width * .45,
        child: Stack(children: [
          Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                image: DecorationImage(
                    image: AssetImage(news.imageUrl), fit: BoxFit.cover)),
          ),
          Positioned(
            bottom: 0,
            right: 0,
            left: 0,
            child: Container(
              decoration: const BoxDecoration(
                  color: Color(0xffC4C4C4),
                  borderRadius:
                      BorderRadius.vertical(bottom: Radius.circular(20))),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  news.title,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ),
          ),
        ]),
      ),
    );
  }
}
