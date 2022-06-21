class NewsModel {
  final String? title;
  final String? imageUrl;
  final String? url;
  NewsModel({
    this.url = '',
    required this.title,
    required this.imageUrl,
  });

  NewsModel.fromJson(Map<String, dynamic> data)
      : title = data['title'],
        imageUrl = data['urlToImage'],
        url = data['url'];
}
