import 'package:flutter/material.dart';

class DepartureTime {

  final DateTime planned;
  final DateTime changed;
  final DateTime prediction;

  DepartureTime({ this.planned, this.changed, this.prediction });

  factory DepartureTime.fromJson(Map<String, dynamic> json) {
    return DepartureTime(
      planned: json['planned'] != null ? DateTime.parse(json['planned']) : null,
      changed: json['changed'] != null ? DateTime.parse(json['changed']) : null,
      prediction: json['prediction'] != null ? DateTime.parse(json['prediction']) : null
    );
  }

}