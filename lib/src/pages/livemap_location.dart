import 'package:covid19/src/utils/functions_utils.dart';
import 'package:covid19/src/utils/styles_options.dart';
import 'package:covid19/src/utils/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:geolocator/geolocator.dart';
import 'package:latlong/latlong.dart';

class LiveMap extends StatefulWidget {
  @override
  _LiveMapState createState() => _LiveMapState();
}

class _LiveMapState extends State<LiveMap> {
  Future<Position> _lastKnownPositionFetched;
  Position position = Position(
      latitude: -25.2819, longitude: -57.635); // Asuncion location by default
  LatLng _latLngPosition;
  double _mapZoom = 15.0;

  LocationPermission _permission;
  int _amountOfRequestPermission = 3;

  bool _load = false;
  Widget _loadingIndicator;

  MapController _mapController = MapController();

  @override
  void initState() {
    _lastKnownPositionFetched = _getCurrentLocation(1, true);
    return super.initState();
  }

  @override
  Widget build(BuildContext context) {
    _loadingIndicator = !_load ? new Container() : createLoader();
    return FutureBuilder(
      future: _lastKnownPositionFetched,
      initialData: null,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting)
          return createCircularProgressIndicator();
        else {
          _loadData(snapshot.data);
          return Scaffold(
            appBar: AppBar(title: Text("Mi domicilio")),
            body: _createBody(),
            floatingActionButton: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                SizedBox(
                  width: 30.0,
                ),
                FloatingActionButton(
                  heroTag: 'getPosition',
                  child: Icon(Icons.location_searching),
                  onPressed: () {
                    _setCurrentPosition();
                  },
                ),
                Expanded(
                  child: SizedBox(width: 5.0),
                ),
                FloatingActionButton(
                  heroTag: 'returnPosition',
                  child: Icon(Icons.add_location),
                  onPressed: () {
                    _returnLocationToProfile();
                  },
                ),
              ],
            ),
          );
        }
      },
    );
  }

  _loadData(dynamic data) {
    if (data != null) position = cast<Position>(data);
    _latLngPosition = LatLng(position.latitude, position.longitude);
  }

  _createBody() {
    return Stack(
      children: <Widget>[
        _createMap(),
        Align(
          child: _loadingIndicator,
          alignment: FractionalOffset.center,
        ),
      ],
    );
  }

  _createMap() {
    return FlutterMap(
      mapController: _mapController,
      options: MapOptions(
        center: _latLngPosition,
        zoom: _mapZoom,
      ),
      layers: _createMarkerForPosition(),
    );
  }

  _createMarkerForPosition() {
    final List<LayerOptions> layers = [];

    TileLayerOptions tileLayerOptions = TileLayerOptions(
      urlTemplate: 'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',
      subdomains: ['a', 'b', 'c'],
    );

    layers..add(tileLayerOptions)..add(_createMarker());

    return layers;
  }

  _createMarker() {
    return MarkerLayerOptions(
      markers: [
        Marker(
          width: 200.0,
          height: 200.0,
          point: LatLng(position.latitude, position.longitude),
          builder: (ctx) => Container(
            child: Icon(Icons.accessibility),
          ),
        ),
      ],
    );
  }

  _setCurrentPosition() async {
    _showCircularProgressIndicator(true);
    Position newPosition = await _getCurrentLocation(1, false);
    setState(() {
      position = newPosition;
      _latLngPosition = LatLng(position.latitude, position.longitude);
      _mapController.move(_latLngPosition, _mapZoom);
    });
    _showCircularProgressIndicator(false);
  }

  _returnLocationToProfile() {
    Navigator.pop(context, position);
  }

  Future<Position> _getCurrentLocation(int timesRequest, bool lastKnown) async {
    _permission = await Geolocator.checkPermission();
    if (_amountOfRequestPermission > timesRequest) {
      if (_permission == LocationPermission.whileInUse ||
          _permission == LocationPermission.always) {
        bool isLocationServiceEnabled =
            await Geolocator.isLocationServiceEnabled();

        if (!isLocationServiceEnabled) {
          _launchAlert('Por favor, active su gps para continuar.');
        }

        if (lastKnown)
          return Geolocator.getLastKnownPosition();
        else
          return Geolocator.getCurrentPosition(
              desiredAccuracy: LocationAccuracy.high);
      } else {
        _permission = await Geolocator.requestPermission();
        _getCurrentLocation(timesRequest + 1, lastKnown);
      }
    } else {
      _launchAlert('No se puede continuar por falta de permisos.');
      return null;
    }
  }

  void _launchAlert(String message) {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0)),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Text(
                  message,
                  locale: localES,
                ),
              ],
            ),
            actions: <Widget>[
              FlatButton(
                child: Text('Ok'),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ],
          );
        });
  }

  _showCircularProgressIndicator(bool value) {
    setState(() {
      _load = value;
    });
  }
}
