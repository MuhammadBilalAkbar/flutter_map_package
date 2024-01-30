import 'package:flutter/material.dart';

import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

import '../app_constants.dart';

class MapControllerPage extends StatefulWidget {
  const MapControllerPage(this.title, {Key? key}) : super(key: key);

  final String title;

  @override
  MapControllerPageState createState() => MapControllerPageState();
}

const LatLng london = LatLng(51.5, -0.09);
const LatLng paris = LatLng(48.8566, 2.3522);
const LatLng dublin = LatLng(53.3498, -6.2603);

class MapControllerPageState extends State<MapControllerPage> {
  late final MapController mapController;

  @override
  void initState() {
    super.initState();
    mapController = MapController();
  }

  @override
  void dispose() {
    mapController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final markers = [
      const Marker(
        width: 80,
        height: 80,
        point: london,
        child: Icon(
          Icons.pin_drop,
          color: Colors.blue,
          size: 80,
        ),
      ),
      const Marker(
        width: 80,
        height: 80,
        point: dublin,
        child: Icon(
          Icons.pin_drop,
          color: Colors.green,
          size: 80,
        ),
      ),
      const Marker(
        width: 80,
        height: 80,
        point: paris,
        child: Icon(
          Icons.pin_drop,
          color: Colors.purple,
          size: 80,
        ),
      ),
    ];

    return Scaffold(
      appBar: AppBar(title: Text(widget.title)),
      body: Padding(
        padding: const EdgeInsets.all(8),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 8, bottom: 8),
              child: Row(
                children: [
                  MaterialButton(
                    onPressed: () => mapController.move(london, 18),
                    child: const Text('London'),
                  ),
                  MaterialButton(
                    onPressed: () => mapController.move(paris, 5),
                    child: const Text('Paris'),
                  ),
                  MaterialButton(
                    onPressed: () => mapController.move(dublin, 5),
                    child: const Text('Dublin'),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 8, bottom: 8),
              child: Row(
                children: [
                  MaterialButton(
                    onPressed: () {
                      final bounds = LatLngBounds.fromPoints([
                        dublin,
                        paris,
                        london,
                      ]);
                      mapController.fitCamera(
                        CameraFit.bounds(
                          bounds: bounds,
                          padding: const EdgeInsets.only(left: 15, right: 15),
                        ),
                      );
                    },
                    child: const Text('Fit Bounds'),
                  ),
                  Builder(builder: (BuildContext context) {
                    return MaterialButton(
                      onPressed: () {
                        final bounds = mapController.camera.visibleBounds;

                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                              'Map bounds: \n'
                              'E: ${bounds.east} \n'
                              'N: ${bounds.north} \n'
                              'W: ${bounds.west} \n'
                              'S: ${bounds.south}',
                            ),
                          ),
                        );
                      },
                      child: const Text('Get Bounds'),
                    );
                  }),
                ],
              ),
            ),
            Flexible(
              child: FlutterMap(
                mapController: mapController,
                options: const MapOptions(
                  initialCenter: LatLng(51.5, -0.09),
                  initialZoom: 5,
                  maxZoom: 5,
                  minZoom: 3,
                ),
                children: [
                  /// opeStreetMap
                  TileLayer(
                    urlTemplate: AppConstants.urlTemplate,
                    additionalOptions: const {
                      'id': AppConstants.mapBoxStyleNightId,
                    },
                    fallbackUrl: AppConstants.urlTemplate,
                  ),
                  MarkerLayer(markers: markers),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
