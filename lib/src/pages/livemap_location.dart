import 'package:flutter/material.dart';
import 'package:covid19/src/models/location.dart';
import 'package:covid19/src/utils/functions_utils.dart';
import 'package:covid19/src/utils/styles_options.dart';
import 'package:covid19/src/utils/widgets.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:geolocator/geolocator.dart';
import 'package:latlong2/latlong.dart';

class LiveMap extends StatefulWidget {
  final Location? location;
  LiveMap({this.location});
  @override
  _LiveMapState createState() => _LiveMapState();
}

class _LiveMapState extends State<LiveMap> {
  Future<Position>? _lastKnownPositionFetched;
  Position _position = Position(
      latitude: -25.2819,
      longitude: -57.635,
      timestamp: DateTime.now(),
      accuracy: 0,
      altitude: 0,
      heading: 0,
      speed: 0,
      speedAccuracy: 0,
      altitudeAccuracy: 0,
      headingAccuracy: 0);
  Position? _finalResult;
  late LatLng _latLngPosition;

  double _mapZoom = 15.0;

  Widget? _bodyMap;

  LocationPermission? _permission;
  int _amountOfRequestPermission = 2;

  bool _load = false;
  Widget? _loadingIndicator;

  MapController _mapController = MapController();

  @override
  void initState() {
    super.initState();
    _latLngPosition = LatLng(_position.latitude, _position.longitude);
    _lastKnownPositionFetched = _loadDefaultPosition();
    _bodyMap = _createMap();
  }

  Future<Position> _loadDefaultPosition() async {
    if (widget.location != null) {
      _position = Position(
          latitude: widget.location!.latitude,
          longitude: widget.location!.longitude,
          timestamp: DateTime.now(),
          accuracy: 0,
          altitude: 0,
          heading: 0,
          speed: 0,
          speedAccuracy: 0,
          altitudeAccuracy: 0,
          headingAccuracy: 0);
    } else {
      await _loadPosition(0, true);
    }
    _latLngPosition = LatLng(_position.latitude, _position.longitude);
    return _position;
  }

  @override
  Widget build(BuildContext context) {
    _loadingIndicator = !_load ? Container() : createLoader();
    return FutureBuilder<Position>(
      future: _lastKnownPositionFetched,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return createCircularProgressIndicator();
        } else {
          if (snapshot.data != null) {
            _loadData(snapshot.data!);
          }

          return Scaffold(
            appBar: AppBar(title: Text("Mi domicilio")),
            body: Stack(
              children: <Widget>[
                _bodyMap ?? Container(),
                Align(
                  alignment: FractionalOffset.center,
                  child: _loadingIndicator,
                ),
              ],
            ),
            floatingActionButton: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                SizedBox(width: 30.0),
                FloatingActionButton(
                  heroTag: 'getPosition',
                  child: Icon(Icons.location_searching),
                  onPressed: () {
                    _setCurrentPosition();
                  },
                ),
                Expanded(child: SizedBox(width: 5.0)),
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

  void _loadData(Position data) {
    _position = data;
    _latLngPosition = LatLng(_position.latitude, _position.longitude);
  }

  Widget _createMap() {
    return FlutterMap(
      mapController: _mapController,
      options: MapOptions(
        initialCenter: _latLngPosition,
        initialZoom: _mapZoom,
      ),
      children: _createMarkerForPosition(),
    );
  }

  List<Widget> _createMarkerForPosition() {
    List<Widget> layers = [];

    layers.add(TileLayer(
      urlTemplate: 'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',
      subdomains: const ['a', 'b', 'c'],
    ));

    layers.add(_createMarker());

    return layers;
  }

  Widget _createMarker() {
    return MarkerLayer(
      markers: [
        Marker(
          width: 200.0,
          height: 200.0,
          point: LatLng(_position.latitude, _position.longitude),
          child: Icon(Icons.accessibility),
        ),
      ],
    );
  }

  Future<void> _setCurrentPosition() async {
    _showCircularProgressIndicator(true);
    await _loadPosition(0, false);
    _latLngPosition = LatLng(_position.latitude, _position.longitude);
    _finalResult = _position;
    setState(() {
      _bodyMap = _createMap();
      _mapController.move(_latLngPosition, _mapZoom);
    });
    _showCircularProgressIndicator(false);
  }

  void _returnLocationToProfile() {
    if (_finalResult == null) {
      Navigator.pop(context, _position);
    } else {
      Navigator.pop(context, _finalResult);
    }
  }

  Future<void> _loadPosition(int timesRequest, bool lastKnown) async {
    Position? tmp = await _getCurrentLocation(timesRequest, lastKnown);
    if (tmp != null) {
      _position = tmp;
    }
  }

  Future<Position?> _getCurrentLocation(int timesRequest, bool lastKnown) async {
    _permission = await Geolocator.checkPermission();
    if (_amountOfRequestPermission >= timesRequest) {
      if (_permission == LocationPermission.whileInUse ||
          _permission == LocationPermission.always) {
        bool isLocationServiceEnabled =
            await Geolocator.isLocationServiceEnabled();

        if (!isLocationServiceEnabled) {
          await _launchAlert('Por favor, active su gps para continuar.');
          return _getCurrentLocation(timesRequest + 1, lastKnown);
        }

        if (lastKnown) {
          return Geolocator.getLastKnownPosition();
        } else {
          return Geolocator.getCurrentPosition(
              desiredAccuracy: LocationAccuracy.high);
        }
      } else {
        if (_amountOfRequestPermission > timesRequest) {
          _permission = await Geolocator.requestPermission();
        }
        return _getCurrentLocation(timesRequest + 1, lastKnown);
      }
    } else {
      await _launchAlert('No se puede continuar por falta de permisos.');
      return null;
    }
  }

  Future<void> _launchAlert(String message) async {
    await showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0)),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Text(message, locale: localES),
              ],
            ),
            actions: <Widget>[
              TextButton(
                child: Text('Ok'),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ],
          );
        });
  }

  void _showCircularProgressIndicator(bool value) {
    setState(() {
      _load = value;
    });
  }
}
