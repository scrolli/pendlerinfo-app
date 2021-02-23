class Response {
  final bool success;

  Response({ this.success });

  factory Response.fromJson(Map<String, dynamic> json) {
    return Response(success: json['success']);
  }
}