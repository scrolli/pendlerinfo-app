import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:pendlerinfo/models/departure.dart';
import 'package:pendlerinfo/models/response.dart';
import 'package:pendlerinfo/models/station.dart';
import 'package:pendlerinfo/models/trackinfo.dart';
import 'package:pendlerinfo/models/comment.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

Future<List<Station>> fetchStations() async {
  final dir = await getApplicationDocumentsDirectory();
  final file = new File("${dir.path}/stations");

  var uri = Uri.https('https://api.pendlerinfo.app','/stations');
  final response = await http.get(uri);
  if (response.statusCode == 200) {
    file.writeAsString(response.body, flush: true, mode: FileMode.write);
    final List parsedList = json.decode(response.body);
    return parsedList.map((val) => Station.fromJson(val)).toList();
  } else if (file.existsSync()) {
    var response = await file.readAsString();
    final List parsedList = json.decode(response);
    return parsedList.map((val) => Station.fromJson(val)).toList();
  } else {
    return List.empty();
  }
}

Future<List<Departure>> fetchDepartures(int station, Station destination) async {
  final dir = await getApplicationDocumentsDirectory();
  final file = new File("${dir.path}/timetable-" + station.toString());

  print("${dir.path}/timetable-$station");

  var queryParameters = {
    'station': station.toString(),
    'destination': destination.eva.toString(),
  };
  var uri = Uri.https('https://api.pendlerinfo.app','/timetable', queryParameters);
  final response = await http.get(uri);
  if (response.statusCode == 200) {
    file.writeAsString(response.body, flush: true, mode: FileMode.write);
    final List parsedList = json.decode(response.body);
    return parsedList.map((val) => Departure.fromJson(val)).where((d) => d.path.planned.contains(destination.name)).toList();
  } else if (file.existsSync()) {
    var response = await file.readAsString();
    final List parsedList = json.decode(response);
    var result = parsedList.map((val) => Departure.fromJson(val)).toList();
    result.where((e) => DateTime.now().isAfter(e.departure.changed ?? e.departure.planned)).forEach((d) => d.status.left = true);
    return result;
  } else {
    return List.empty();
  }
}

Future<List<Trackinfo>> fetchTrackinfos() async {
  final dir = await getApplicationDocumentsDirectory();
  final file = new File("${dir.path}/trackinfos");


  var uri = Uri.https('https://api.pendlerinfo.app','/trackinfos');
  final response = await http.get(uri);
  if (response.statusCode == 200) {
    file.writeAsString(response.body, flush: true, mode: FileMode.write);
    final List parsedList = json.decode(response.body);
    return List<Trackinfo>.from(parsedList.map((val) => Trackinfo.fromJson(val)));
  } else if (file.existsSync()) {
    var response = await file.readAsString();
    final List parsedList = json.decode(response);
    return List<Trackinfo>.from(parsedList.map((val) => Trackinfo.fromJson(val)));
  } else {
    return List.empty();
  }
}

Future<List<Comment>> fetchComments() async {
  final dir = await getApplicationDocumentsDirectory();
  final file = new File("${dir.path}/comments");

  var uri = Uri.https('https://api.pendlerinfo.app','/comments');
  final response = await http.get(uri);
  if (response.statusCode == 200) {
    final List parsedList = json.decode(response.body);
    return List<Comment>.from(parsedList.map((val) => Comment.fromJson(val)));
  } else if (file.existsSync()) {
    var response = await file.readAsString();
    final List parsedList = json.decode(response);
    return List<Comment>.from(parsedList.map((val) => Comment.fromJson(val)));
  } else {
    return List.empty();
  }
}

Future<void> putComment(Comment comment) async {
  HttpClient httpClient = new HttpClient();
  HttpClientRequest request = await httpClient.putUrl(Uri.parse('https://api.pendlerinfo.app/comment'));
  request.headers.set('content-type', 'application/json');
  request.add(utf8.encode(json.encode(comment.toJson())));
  HttpClientResponse response = await request.close();
  final res = await response.transform(utf8.decoder).join();
  print(res);
  if (response.statusCode == 200) {
    final result = Response.fromJson(json.decode(res));
    if (!result.success) {
      throw Exception('Failed to post comment!');
    }
  } else {
    throw Exception('Failed to load comment!');
  }
}