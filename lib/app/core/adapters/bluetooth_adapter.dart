import 'dart:html';

import 'package:location/location.dart';

import 'location_adapter.dart';

import 'package:http/http.dart' as http;

enum Role { student, teacher, admin }

class VirtualZone {
  final LocationAdapter _locationAdapter = LocationAdapter();
  LocationData? center;
  double radius;

  VirtualZone(this.radius) {
    _locationAdapter.getCurrentLocation().then((value) {
      center = value;
    });
  }

  VirtualZone.fromJson(Map<String, dynamic> json)
      : center = LocationData.fromMap(json['center']),
        radius = json['radius'];

  Map<String, dynamic> toJson() => {
        'center': {
          'latitude': center?.latitude,
          'longitude': center?.longitude,
        },
        'radius': radius,
      };
}

class ClassData {
  String turma;
  String disciplina;
  DateTime startTime;
  DateTime endTime;

  ClassData(this.turma, this.disciplina, this.startTime, this.endTime);

  ClassData.fromJson(Map<String, dynamic> json)
      : turma = json['turma'],
        disciplina = json['disciplina'],
        startTime = DateTime.parse(json['startTime']),
        endTime = DateTime.parse(json['endTime']);

  Map<String, dynamic> toJson() => {
        'turma': turma,
        'disciplina': disciplina,
        'startTime': startTime.toIso8601String(),
        'endTime': endTime.toIso8601String(),
      };
}

class CommsAdapter {
  Role role;
  ClassData classData;
  VirtualZone virtualZone;

  CommsAdapter(this.role, this.classData, this.virtualZone);

  CommsAdapter.fromJson(Map<String, dynamic> json)
      : role = json['role'],
        classData = ClassData.fromJson(json['classData']),
        virtualZone = VirtualZone.fromJson(json['virtualZone']);

  Map<String, dynamic> toJson() => {
        'role': role.toString(),
        'classData': classData.toJson(),
        'virtualZone': virtualZone.toJson(),
      };

  dynamic sendData() async {
    // Send data to Rest API
    // Receive response
    var response = await http.post(
        Uri.parse('https://example.com/whatsit/create'),
        headers: {'Content-Type': 'application/json'},
        body: toJson());

    if (response.statusCode == 200) {
      return response.body;
    } else {
      print('Failed with status code: ${response.statusCode}.');
    }
  }

  void receiveData() {
    // Receive data from Rest API
    // Deserialize data
    // Process data
    // Return data
  }

  void checkInZone(Location myLocation) {
    // Check if user is in virtual zone
    // If not, send error message
    // If yes, send check-in data
  }
}
