class ArrivalTime {

  final DateTime planned;
  final DateTime changed;

  ArrivalTime({ this.planned, this.changed });

  factory ArrivalTime.fromJson(Map<String, dynamic> json) {
    return ArrivalTime(
      planned: json['planned'] != null ? DateTime.parse(json['planned']) : null,
      changed: json['changed'] != null ? DateTime.parse(json['changed']) : null
    );
  }

}