class Comment {

  final String stopId;
  final String number;
  final DateTime published;
  final String message;

  Comment({ this.stopId, this.number, this.published, this.message });

  factory Comment.fromJson(Map<String, dynamic> json) {
    return Comment(
      stopId: json['stopId'],
      number: json['number'].toString(),
      published: DateTime.parse(json['published']),
      message: json['message']
    );
  }

  Map<String, dynamic> toJson() =>
      {
        'stopId': stopId,
        'number': number,
        'published': published,
        'message': message
      };
}