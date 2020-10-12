import 'package:flutter/material.dart';

import 'package:flutter_map/flutter_map.dart';
import 'package:latlong/latlong.dart';

class OSMMap extends StatefulWidget {
  OSMMap({Key key}) : super(key: key);

  @override
  _OSMMapState createState() => _OSMMapState();
}

class _OSMMapState extends State<OSMMap> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        FlutterMap(
          options: MapOptions(
            center: LatLng(-25.336135, -57.512170),
            zoom: 13.0,
          ),
          layers: [
            TileLayerOptions(
              urlTemplate: 'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',
              subdomains: ['a', 'b', 'c'],
            ),
            MarkerLayerOptions(
              markers: [
                Marker(
                  width: 100.0,
                  height: 100.0,
                  point: LatLng(-25.323450, -57.523677),
                  builder: (ctx) => Container(
                    child: Icon(Icons.local_hospital),
                  ),
                ),
              ],
            ),
            MarkerLayerOptions(
              markers: [
                Marker(
                  width: 100.0,
                  height: 100.0,
                  point: LatLng(-25.328890, -57.513951),
                  builder: (ctx) => Container(
                    child: Icon(Icons.local_hospital),
                  ),
                ),
              ],
            ),
            MarkerLayerOptions(markers: [
              Marker(
                  width: 45.0,
                  height: 45.0,
                  point: LatLng(-25.336135, -57.512170),
                  builder: (context) => Container(
                        child: IconButton(
                            icon: Icon(Icons.accessibility),
                            onPressed: () {
                              print('Marker tapped!');
                            }),
                      ))
            ])
          ],
        ),
      ],
    );
  }
}
