import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import '/app_constants.dart';

class PolylineMarkersPage extends StatefulWidget {
  const PolylineMarkersPage({Key? key}) : super(key: key);

  @override
  State<PolylineMarkersPage> createState() => _PolylineMarkersPageState();
}

class _PolylineMarkersPageState extends State<PolylineMarkersPage> {
  List<LatLng> tappedPoints = [];

  @override
  Widget build(BuildContext context) {
    var markers = tappedPoints.map((latlng) {
      return Marker(
        width: 80.0,
        height: 80.0,
        point: latlng,
        builder: (ctx) => const Icon(
          Icons.location_on,
          color: Colors.red,
          size: 40,
        ),
      );
    }).toList();

    return FlutterMap(
      options: MapOptions(
          center: AppConstants.myLocation,
          zoom: 13.0,
          minZoom: 5,
          maxZoom: 18,
          onTap: (tapPosition, latlng) {
            setState(() {
              tappedPoints.add(latlng);
              debugPrint(latlng.toString());
            });
          }),
      children: [
        TileLayer(
          // urlTemplate:
          //     "https://api.mapbox.com/styles/v1/mapbox/streets-v11/tiles/"
          //     "{z}/{x}/{y}?access_token=${AppConstants.mapBoxAccessToken}",
          urlTemplate:
          'https://api.mapbox.com/styles/v1/{id}/tiles/{z}/{x}/{y}?access_token=${AppConstants.mapBoxAccessToken}',
          additionalOptions: const {
            'accessToken': AppConstants.mapBoxAccessToken,
            'id': AppConstants.mapBoxStyleOutdoorId,
          },
        ),
        MarkerLayer(
          markers: markers,
        ),
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
    );
  }
}
