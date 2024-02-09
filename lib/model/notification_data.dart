class Notify {
  final String id;
  final String content;
  final String title;
  final String pubDate;

  Notify({
    required this.id,
    required this.content,
    required this.title,
    required this.pubDate,
  });

  factory Notify.fromJson(Map<String, dynamic> json) {
    return Notify(
      id: json['id'],
      content: json['content'],
      title: json['title'],
      pubDate: json['pubDate'],
    );
  }
}
