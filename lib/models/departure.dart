import 'package:flutter/material.dart';
import 'package:pendlerinfo/models/arrival_time.dart';
import 'package:pendlerinfo/models/comment.dart';
import 'package:pendlerinfo/models/departure_time.dart';
import 'package:pendlerinfo/models/featured_destination.dart';
import 'package:pendlerinfo/models/status.dart';
import 'package:pendlerinfo/models/platform.dart';
import 'package:pendlerinfo/models/path.dart';

class Departure {

  final String stopId;
  final String number;
  final bool wings;
  final ArrivalTime arrival;
  final DepartureTime departure;
  final Platform platform;
  final Path path;
  final FeaturedDestination featuredDestination;
  final String destination;
  final Status status;
  final List<Comment> comments;

  Departure({
    this.stopId,
    this.number,
    this.wings,
    this.arrival,
    this.departure,
    this.platform,
    this.path,
    this.featuredDestination,
    this.destination,
    this.status,
    this.comments
  });

  factory Departure.fromJson(Map<String, dynamic> json) {
    return Departure(
      stopId: json['stop_id'],
      number: json['number'],
      wings: json['wings'] == 1,
      arrival: ArrivalTime.fromJson(json['arrival']),
      departure: DepartureTime.fromJson(json['departure']),
      platform: Platform.fromJson(json['platform']),
      path: Path.fromJson(json['path']),
      featuredDestination: FeaturedDestination.fromJson(json['featured_destination']),
      destination: json['destination'],
      status: Status.fromJson(json['status']),
      comments: List<Comment>.from(json['comments'].map((c) => Comment.fromJson(c)))
    );
  }
}