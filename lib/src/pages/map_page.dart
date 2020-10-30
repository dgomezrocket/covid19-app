import 'package:flutter/material.dart';

import 'package:flutter_map/flutter_map.dart';
import 'package:latlong/latlong.dart';

import 'package:covid19/src/providers/profile_provider.dart';
import 'package:covid19/src/models/hospital_response.dart';
import 'package:covid19/src/models/location.dart';
import 'package:covid19/src/utils/widgets.dart';

class OSMMap extends StatefulWidget {
  @override
  _OSMMapState createState() => _OSMMapState();
}

class _OSMMapState extends State<OSMMap> {
  Future<HospitalResponse> _hospitalsFetched;
  @override
  void initState() {
    _hospitalsFetched = profileProvider.getHospitals();
    return super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _hospitalsFetched,
      initialData: null,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting)
          return createCircularProgressIndicator();
        else if (snapshot.hasData)
          return _createMap(snapshot.data);
        else
          return Container();
      },
    );
  }

  _createMap(HospitalResponse hospitalResponse) {
    return Stack(
      children: <Widget>[
        FlutterMap(
          options: MapOptions(
            center: LatLng(hospitalResponse.person.location.latitude,
                hospitalResponse.person.location.longitude),
            zoom: 15.0,
          ),
          layers: _createMarkertsIncludeLocation(hospitalResponse),
        ),
      ],
    );
  }

  _createMarkertsIncludeLocation(HospitalResponse hospitalResponse) {
    final List<LayerOptions> layers = [];

    TileLayerOptions tileLayerOptions = TileLayerOptions(
      urlTemplate: 'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',
      subdomains: ['a', 'b', 'c'],
    );

    layers
      ..add(tileLayerOptions)
      ..add(_createMarker(hospitalResponse.person.location, true));

    hospitalResponse.hospitals.forEach((hospital) {
      layers.add(_createMarker(hospital.location, false));
    });

    return layers;
  }

  _createMarker(Location location, bool person) {
    IconData icon = (person) ? Icons.accessibility : Icons.local_hospital;

    return MarkerLayerOptions(
      markers: [
        Marker(
          width: 200.0,
          height: 200.0,
          point: LatLng(location.latitude, location.longitude),
          builder: (ctx) => Container(
            child: Icon(icon),
          ),
        ),
      ],
    );
  }
}
