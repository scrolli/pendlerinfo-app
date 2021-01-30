class Station {

  final String name;
  final String nameShort;
  final int eva;

  Station({ this.name, this.nameShort, this.eva });

  factory Station.fromJson(Map<String, dynamic> json) {
    return Station(
      name: json['name'],
      nameShort: json['name_short'],
      eva: int.parse(json['eva'])
    );
  }
}