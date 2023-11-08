import 'dart:convert';

import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'geolocator_adapter.dart';
import 'package:http/http.dart' as http;

class AttendenceData {
  // TODO: Add more fields
  AttendenceData.fromJson(dynamic json);
}

class MacFiAdapter {
  String baseUrl = 'localhost:9999/';
  GeolocatorAdapter geolocatorAdapter = GeolocatorAdapter();
  Position? position;
  String userId;
  Duration pingInterval = const Duration(seconds: 10);

  MacFiAdapter(this.userId, int? pingDelayInSeconds) {
    pingInterval = Duration(seconds: pingDelayInSeconds ?? 10);
  }

  Future<bool> joinAttendence() async {
    Map<String, dynamic> data = await generateAttendenceData('join');

    Uri url = Uri.parse('${baseUrl}attendence');
    var response = await http.post(url, body: data);
    if (response.statusCode == 200) {
      return true;
    }

    return false;
  }

  Future<bool> pingAttendence() async {
    Map<String, dynamic> data = await generateAttendenceData('ping');

    Uri url = Uri.parse('${baseUrl}attendence');
    var response = await http.post(url, body: data);
    if (response.statusCode == 200) {
      return true;
    }

    return false;
  }

  Future<Map<String, dynamic>> generateAttendenceData(String type) async {
    position = await geolocatorAdapter.determinePosition();
    DateTime dateTime = position!.timestamp!;

    return {
      'userId': userId,
      'latitude': position!.latitude,
      'longitude': position!.longitude,
      'timestamp': dateTime.millisecondsSinceEpoch,
      'type': type,
    };
  }

  Future<void> startPingLoop() async {
    bool keepPinging = true;
    while (keepPinging) {
      keepPinging = await pingAttendence();
      await Future.delayed(const Duration(seconds: 10));
    }
  }

  Future<AttendenceData?> getAttendenceData() async {
    Uri url = Uri.parse('${baseUrl}attendence');
    var response = await http.get(url);
    if (response.statusCode == 200) {
      var jsonResponse = jsonDecode(response.body);
      return AttendenceData.fromJson(jsonResponse);
    }

    return null;
  }

  Future<Placemark> getPlacemark() async {
    position = await geolocatorAdapter.determinePosition();
    List<Placemark> placemarks = await placemarkFromCoordinates(position!.latitude, position!.longitude);
    return placemarks.first;
  }
}
