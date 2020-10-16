class Location {
  int id;
  double latitude;
  double longitude;

  Location({this.id, this.latitude, this.longitude});

  factory Location.fromJson(dynamic json) {
    return Location(
        id: json['id'] as int,
        latitude: json['latitude'] as double,
        longitude: json['longitude'] as double);
  }

  @override
  String toString() {
    return '{ ${this.id}, ${this.latitude}, ${this.longitude} }';
  }
}
