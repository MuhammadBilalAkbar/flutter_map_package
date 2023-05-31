import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import '/app_constants.dart';

class PolylineMarkersPage extends StatefulWidget {
  const PolylineMarkersPage(this.title, {Key? key}) : super(key: key);

  final String title;

  @override
  State<PolylineMarkersPage> createState() => _PolylineMarkersPageState();
}

class _PolylineMarkersPageState extends State<PolylineMarkersPage> {
  List<LatLng> tappedPoints = [
    LatLng(51.5, -0.09),
    LatLng(51.506678, -0.097124),
  ];

  @override
  Widget build(BuildContext context) {
    var markers = tappedPoints
        .map(
          (latlng) => Marker(
            point: latlng,
            builder: (_) => const Icon(
              Icons.pin_drop,
              color: Colors.red,
              size: 30,
            ),
          ),
        )
        .toList();

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: FlutterMap(
        options: MapOptions(
          center: AppConstants.myLocation,
          zoom: 13.0,
          minZoom: 5,
          maxZoom: 18,
          onTap: (_, latlng) {
            setState(() {
              tappedPoints.add(latlng);
              debugPrint(latlng.toString());
            });
          },
        ),
        children: [
          TileLayer(
            urlTemplate: AppConstants.urlTemplate,
            additionalOptions: const {
              'accessToken': AppConstants.mapBoxAccessToken,
              'id': AppConstants.mapBoxStyleOutdoorId,
            },
          ),
          MarkerLayer(markers: markers),
          PolylineLayer(
            polylines: [
              Polyline(
                points: [
                  LatLng(51.5, -0.09),
                  LatLng(51.498557, -0.072061),
                  LatLng(51.482418, -0.081503),
                  LatLng(51.493855, -0.104677),
                  LatLng(51.506678, -0.097124),
                ],
                color: Colors.red,
                strokeWidth: 5.0,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
