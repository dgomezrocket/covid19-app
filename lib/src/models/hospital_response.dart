import 'dart:convert';

import 'package:covid19/src/models/hospital.dart';
import 'package:covid19/src/models/person.dart';

class HospitalResponse {
  Person person;
  List<Hospital> hospitals;

  HospitalResponse({this.person, this.hospitals});

  factory HospitalResponse.fromJson(dynamic json) {
    if (json['hospitals'] != null) {
      var hospitalsObjsJson = json['hospitals'] as List;

      List<Hospital> _hospitals = hospitalsObjsJson
          .map((hospital) => Hospital.fromJson(hospital))
          .toList();

      return HospitalResponse(
          person: Person.fromJson(json['person']), hospitals: _hospitals);
    } else
      return HospitalResponse(person: Person.fromJson(json['person']));
  }

  Map<String, dynamic> toJson() {
    if (this.hospitals != null)
      return {
        'person': person.toJson(),
        'hospitals': hospitals.map((hospital) => hospital.toJson()).toList()
      };
    else
      return {'person': person.toJson()};
  }

  @override
  String toString() {
    return '{ ${this.person}, ${this.hospitals} }';
  }
}
