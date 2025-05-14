import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapPage extends StatefulWidget {
  @override
  _MapPageState createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  final Set<Marker> _markers = {};

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Pest Map')),
      body: GoogleMap(
        initialCameraPosition: CameraPosition(target: LatLng(37.5665, 126.9780), zoom: 10.0),
        markers: _markers,
      ),
    );
  }
}
