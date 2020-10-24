// import 'package:flutter/material.dart';
// import 'package:geolocator/geolocator.dart';

// class LiveMap extends StatefulWidget {
//   @override
//   _LiveMapState createState() => _LiveMapState();
// }

// class _LiveMapState extends State<LiveMap> {
//   String _locationMessage = "";
//   Position position;

//   void _getCurrentLocation() async {
//     position = await Geolocator()
//         .getCurrentPosition(desiredAccuracy: LocationAccuracy.high);

//     print(position);

//     setState(() {
//       _locationMessage = "${position.latitude}, ${position.longitude}";
//     });
//   }

//   // This widget is the root of your application.
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       //appBar: AppBar(title: Text("Location Services")),
//       body: Align(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: <Widget>[
//             Text(_locationMessage),
//           ],
//         ),
//       ),
//       floatingActionButton: FloatingActionButton(
//         child: Icon(Icons.location_searching),
//         onPressed: () {
//           _getCurrentLocation();
//         },
//       ),
//     );
//   }
// }
