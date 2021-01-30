import 'package:pendlerinfo/models/trackinfo.dart';

class Trackinfos {

  final List<Trackinfo> featured;
  final List<Trackinfo> further;

  Trackinfos({ this.featured, this.further });

  factory Trackinfos.fromJson(Map<String, dynamic> json) {
    return Trackinfos(
      featured: List<Trackinfo>.from(json['featured'].map((t) => Trackinfo.fromJson(t))),
      further: List<Trackinfo>.from(json['further'].map((t) => Trackinfo.fromJson(t)))
    );
  }
}