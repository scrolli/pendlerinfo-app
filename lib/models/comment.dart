class Comment {

  final String stopId;
  final DateTime published;
  final String message;

  Comment({ this.stopId, this.published, this.message });

  factory Comment.fromJson(Map<String, dynamic> json) {
    return Comment(
      stopId: json['stopId'],
      published: DateTime.parse(json['published']),
      message: json['message']
    );
  }
}