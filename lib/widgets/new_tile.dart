import 'package:cached_network_image/cached_network_image.dart';
import 'package:doctr/models/news_model.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class NewsTile extends StatelessWidget {
  final bool loading;
  final void Function(String url)? onLaunch;
  const NewsTile(
      {Key? key,
      required this.onLaunch,
      this.loading = false,
      required this.news})
      : super(key: key);
  const NewsTile.loading(
      {Key? key, this.news, this.onLaunch, this.loading = true})
      : super(key: key);
  final NewsModel? news;

  @override
  Widget build(BuildContext context) {
    final devSize = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 2, vertical: 8.0),
      child: loading
          ? Shimmer.fromColors(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                            color: Colors.black.withOpacity(.25),
                            offset: const Offset(0, 2),
                            blurRadius: 8,
                            spreadRadius: 2)
                      ],
                      color: Colors.white),
                  constraints: BoxConstraints.expand(
                    height: devSize.height * .3,
                    width: devSize.width * .45,
                  ),
                ),
              ),
              baseColor: Colors.white54,
              highlightColor: Colors.white24,
            )
          : InkWell(
              onTap: () => onLaunch!(news!.url ?? ''),
              child: Container(
                decoration: BoxDecoration(boxShadow: [
                  BoxShadow(
                      color: Colors.black.withOpacity(.25),
                      offset: const Offset(0, 2),
                      blurRadius: 8,
                      spreadRadius: 2)
                ]),
                constraints: BoxConstraints.expand(
                  height: devSize.height * .3,
                  width: devSize.width * .45,
                ),
                child: Stack(children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: Container(
                      height: devSize.height * .35,
                      child: CachedNetworkImage(
                        // height: devSize.height * .35,
                        fit: BoxFit.cover,
                        placeholder: (context, url) => Image.asset(
                          'assets/images/placeholder.png',
                          fit: BoxFit.cover,
                        ),
                        errorWidget: (context, url, error) => Image.asset(
                            'assets/images/placeholder.png',
                            fit: BoxFit.cover),
                        imageUrl: news?.imageUrl ??
                            'https://user-images.githubusercontent.com/2351721/31314483-7611c488-ac0e-11e7-97d1-3cfc1c79610e.png',
                      ),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        // image: loading
                        //     ? null
                        //     : DecorationImage(
                        //         image: CachedNetworkImageProvider(
                        //           news?.imageUrl ??
                        //               'https://icon-library.com/images/image-icon/image-icon-10.jpg',
                        //         ),
                        //         fit: BoxFit.cover
                        //         )
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 0,
                    right: 0,
                    left: 0,
                    child: Container(
                      decoration: const BoxDecoration(
                          color: Color(0xffC4C4C4),
                          borderRadius: BorderRadius.vertical(
                              bottom: Radius.circular(20))),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          news?.title ?? '',
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ),
                  ),
                ]),
              ),
            ),
    );
  }
}
