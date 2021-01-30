class Platform {

  final int planned;
  final int changed;

  Platform({ this.planned, this.changed });

  factory Platform.fromJson(Map<String, dynamic> json) {
    return Platform(
      planned: json['planned'] != null ? int.parse(json['planned']) : 0,
      changed: json['changed'] != null ? int.parse(json['changed']) : 0
    );
  }

}