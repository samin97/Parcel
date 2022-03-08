import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_osm_plugin/flutter_osm_plugin.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:latlong2/latlong.dart';

class LocationMap extends StatefulWidget {
  const LocationMap({Key? key}) : super(key: key);

  @override
  _LocationMapState createState() => _LocationMapState();
}

class _LocationMapState extends State<LocationMap> {
    MapController controller = MapController(
    initMapWithUserPosition: false,
    initPosition: GeoPoint(latitude: 47.4358055, longitude: 8.4737324),
    areaLimit: BoundingBox( east: 10.4922941, north: 47.8084648, south: 45.817995, west: 5.9559113,),
  );



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        flexibleSpace: Container(
          decoration: const BoxDecoration(
              gradient: LinearGradient(
            colors: [
              Colors.blue,
              Colors.orange,
            ],
            begin: FractionalOffset(0.0, 0.0),
            end: FractionalOffset(1.0, 0.0),
            stops: [0.0, 1.0],
            tileMode: TileMode.clamp,
          )),
        ),
        title: const Text(
          'Map',
          style: TextStyle(
            fontSize: 30,
            color: Colors.white,
            fontFamily: "Lobster",
          ),
        ),
        centerTitle: true,
        automaticallyImplyLeading: true,
      ),
      body: OSMFlutter(
        controller:mapController,
        trackMyPosition: false,
        initZoom: 12,
        minZoomLevel: 8,
        maxZoomLevel: 14,
        stepZoom: 1.0,
        userLocationMarker: UserLocationMaker(
          personMarker: const MarkerIcon(
            icon: Icon(
              Icons.location_history_rounded,
              color: Colors.red,
              size: 48,
            ),
          ),
          directionArrowMarker: const MarkerIcon(
            icon: Icon(
              Icons.double_arrow,
              size: 48,
            ),
          ),
        ),
        roadConfiguration: RoadConfiguration(
          startIcon: const MarkerIcon(
            icon: Icon(
              Icons.person,
              size: 64,
              color: Colors.brown,
            ),
          ),
          roadColor: Colors.yellowAccent,
        ),
        markerOption: MarkerOption(
            defaultMarker: const MarkerIcon(
              icon: Icon(
                Icons.person_pin_circle,
                color: Colors.blue,
                size: 56,
              ),
            )
        ),
      );
    );
  }
}
