import 'package:pendlerinfo/models/departure.dart';
import 'package:pendlerinfo/models/station.dart';
import 'package:pendlerinfo/models/trackinfos.dart';
import 'package:pendlerinfo/models/comment.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

Future<List<Station>> fetchStations() async {
  final response = await http.get('https://api.pendlerinfo.app/stations');
  if (response.statusCode == 200) {
    final List parsedList = json.decode(response.body);
    return parsedList.map((val) => Station.fromJson(val)).toList();
  } else {
    throw Exception('Failed to load stations');
  }
}

Future<List<Departure>> fetchDepartures() async {
  final response = await http.get(
      'https://api.pendlerinfo.app/timetable?station=8000261');
  if (response.statusCode == 200) {
    final List parsedList = json.decode(response.body);
    return parsedList.map((val) => Departure.fromJson(val)).toList();
  } else {
    throw Exception('Failed to load departures');
  }
}

Future<Trackinfos> fetchTrackinfos() async {
  final response = await http.get(
      'https://api.pendlerinfo.app/trackinfos');
  if (response.statusCode == 200) {
    final val = json.decode(response.body);
    return Trackinfos.fromJson(val);
  } else {
    throw Exception('Failed to load trackinfos');
  }
}

Future<List<Comment>> fetchComments() async {
  final response = await http.get(
      'https://api.pendlerinfo.app/comments');
  if (response.statusCode == 200) {
    final List parsedList = json.decode(response.body);
    return List<Comment>.from(parsedList.map((val) => Comment.fromJson(val)));
  } else {
    throw Exception('Failed to load comments');
  }
}