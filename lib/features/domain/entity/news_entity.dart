class NewsEntity {
  final String title;
  final String content;
  final String thumbnail;
  final DateTime publishedAt;

  NewsEntity({
    required this.title,
    required this.content,
    required this.thumbnail,
    required this.publishedAt,
  });
}