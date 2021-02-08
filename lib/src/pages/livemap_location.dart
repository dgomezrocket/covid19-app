import 'package:flutter/material.dart';
import 'package:covid19/src/models/location.dart';
import 'package:covid19/src/utils/functions_utils.dart';
import 'package:covid19/src/utils/styles_options.dart';
import 'package:covid19/src/utils/widgets.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:geolocator/geolocator.dart';
import 'package:latlong/latlong.dart';

class LiveMap extends StatefulWidget {
  Location location;
  LiveMap({this.location});
  @override
  _LiveMapState createState() => _LiveMapState();
}

class _LiveMapState extends State<LiveMap> {
  Future<Position> _lastKnownPositionFetched;
  Position _position = Position(
      latitude: -25.2819, longitude: -57.635); // Asuncion location by default
  Position _finalResult;
  LatLng _latLngPosition;

  double _mapZoom = 15.0;

  Widget _bodyMap;

  LocationPermission _permission;
  int _amountOfRequestPermission = 2;

  bool _load = false;
  Widget _loadingIndicator;

  MapController _mapController = MapController();

  @override
  void initState() {
    _lastKnownPositionFetched = _loadDefaultPosition();
    _bodyMap = _createMap();
    return super.initState();
  }

  Future<Position> _loadDefaultPosition() async {
    if (widget.location != null) {
      _position = Position(
          latitude: widget.location.latitude,
          longitude: widget.location.longitude);
    } else
      _loadPosition(0, true);
    _latLngPosition = LatLng(_position.latitude, _position.longitude);
    return _position;
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
            body: Stack(
              children: <Widget>[
                _bodyMap,
                Align(
                  child: _loadingIndicator,
                  alignment: FractionalOffset.center,
                ),
              ],
            ),
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
    if (data != null) _position = cast<Position>(data);
    _latLngPosition = LatLng(_position.latitude, _position.longitude);
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

  List<LayerOptions> _createMarkerForPosition() {
    List<LayerOptions> layers = [];

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
          point: LatLng(_position.latitude, _position.longitude),
          builder: (ctx) => Container(
            child: Icon(Icons.accessibility),
          ),
        ),
      ],
    );
  }

  _setCurrentPosition() async {
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

  _returnLocationToProfile() {
    if (_finalResult == null)
      Navigator.pop(context, _position);
    else
      Navigator.pop(context, _finalResult);
  }

  Future<dynamic> _loadPosition(int timesRequest, bool lastKnown) async {
    Position tmp = await _getCurrentLocation(timesRequest, lastKnown);
    if (tmp != null) {
      _position = tmp;
    }
  }

  Future<Position> _getCurrentLocation(int timesRequest, bool lastKnown) async {
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

        if (lastKnown)
          return Geolocator.getLastKnownPosition();
        else
          return Geolocator.getCurrentPosition(
              desiredAccuracy: LocationAccuracy.high);
      } else {
        if (_amountOfRequestPermission > timesRequest)
          _permission = await Geolocator.requestPermission();
        return _getCurrentLocation(timesRequest + 1, lastKnown);
      }
    } else {
      await _launchAlert('No se puede continuar por falta de permisos.');
      return null;
    }
  }

  Future<dynamic> _launchAlert(String message) async {
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
