class Status {

  final bool started;
  final bool left;
  final bool cancelled;
  final String reason;

  Status({ this.started, this.left, this.cancelled, this.reason });

  factory Status.fromJson(Map<String, dynamic> json) {
    return Status(
      started: json['started'],
      left: json['started'],
      cancelled: json['cancelled'],
      reason: json['reason']
    );
  }
}