import 'package:flutter/material.dart';

import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

import 'package:covid19/src/providers/profile_provider.dart';
import 'package:covid19/src/models/hospital_response.dart';
import 'package:covid19/src/models/location.dart';
import 'package:covid19/src/utils/widgets.dart';

class OSMMap extends StatefulWidget {
  @override
  _OSMMapState createState() => _OSMMapState();
}

class _OSMMapState extends State<OSMMap> {
  Future<HospitalResponse>? _hospitalsFetched;
  
  @override
  void initState() {
    super.initState();
    _hospitalsFetched = profileProvider.getHospitals();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<HospitalResponse>(
      future: _hospitalsFetched,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return createCircularProgressIndicator();
        } else if (snapshot.hasData) {
          return _createMap(snapshot.data!);
        } else {
          return Container();
        }
      },
    );
  }

  Widget _createMap(HospitalResponse hospitalResponse) {
    return Stack(
      children: <Widget>[
        FlutterMap(
          options: MapOptions(
            initialCenter: LatLng(
                hospitalResponse.person.location?.latitude ?? -25.2819,
                hospitalResponse.person.location?.longitude ?? -57.635),
            initialZoom: 15.0,
          ),
          children: _createMarkersIncludeLocation(hospitalResponse),
        ),
      ],
    );
  }

  List<Widget> _createMarkersIncludeLocation(HospitalResponse hospitalResponse) {
    final List<Widget> layers = [];

    layers.add(TileLayer(
      urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
      userAgentPackageName: 'com.example.covid19',
    ));

    if (hospitalResponse.person.location != null) {
      layers.add(_createMarker(hospitalResponse.person.location!, true));
    }

    for (var hospital in hospitalResponse.hospitals) {
      layers.add(_createMarker(hospital.location, false));
    }

    return layers;
  }

  Widget _createMarker(Location location, bool person) {
    IconData icon = person ? Icons.accessibility : Icons.local_hospital;

    return MarkerLayer(
      markers: [
        Marker(
          width: 200.0,
          height: 200.0,
          point: LatLng(location.latitude, location.longitude),
          child: Icon(icon),
        ),
      ],
    );
  }
}
