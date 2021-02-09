class Trackinfo {

  final int level;
  final DateTime published;
  final bool featured;
  final String title;
  final String message;

  Trackinfo({ this.level, this.published, this.featured, this.title, this.message });

  factory Trackinfo.fromJson(Map<String, dynamic> json) {
    return Trackinfo(
        level: json['level'],
        published: DateTime.parse(json['published']),
        featured: json['featured'],
        title: json['title'],
        message: json['message']
    );
  }
}