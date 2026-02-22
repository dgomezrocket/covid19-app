import 'dart:convert';

import 'package:covid19/src/models/hospital.dart';
import 'package:covid19/src/models/person.dart';

class HospitalResponse {
  Person person;
  List<Hospital> hospitals;

  HospitalResponse({required this.person, required this.hospitals});

  factory HospitalResponse.fromJson(dynamic json) {
    List<Hospital> hospitals = [];
    if (json['hospitals'] != null) {
      var hospitalsObjsJson = json['hospitals'] as List;
      hospitals = hospitalsObjsJson
          .map((hospital) => Hospital.fromJson(hospital))
          .toList();
    }

    return HospitalResponse(
        person: Person.fromJson(json['person']), hospitals: hospitals);
  }

  Map<String, dynamic> toJson() => {
        'person': person.toJson(),
        'hospitals': hospitals.map((hospital) => hospital.toJson()).toList()
      };

  @override
  String toString() {
    return '{ $person, $hospitals }';
  }
}
