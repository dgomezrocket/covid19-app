class Location {
  int? id;
  double latitude;
  double longitude;

  Location({this.id, required this.latitude, required this.longitude});

  factory Location.fromJson(dynamic json) {
    return Location(
        id: json['id'] as int?,
        latitude: (json['latitude'] as num).toDouble(),
        longitude: (json['longitude'] as num).toDouble());
  }

  Map<String, dynamic> toJson() =>
      {'id': id, 'latitude': latitude, 'longitude': longitude};

  @override
  String toString() {
    return '{ $id, $latitude, $longitude }';
  }
}
