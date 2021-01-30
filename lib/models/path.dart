class Path {

  final String planned;
  final String changed;

  Path({ this.planned, this.changed });

  factory Path.fromJson(Map<String, dynamic> json) {
    return Path(
      planned: json['planned'],
      changed: json['changed']
    );
  }

}