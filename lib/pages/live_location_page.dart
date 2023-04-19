import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:location/location.dart';

import '../app_constants.dart';

class LiveLocationPage extends StatefulWidget {
  const LiveLocationPage(this.title, {Key? key}) : super(key: key);

  final String title;

  @override
  LiveLocationPageState createState() => LiveLocationPageState();
}

class LiveLocationPageState extends State<LiveLocationPage> {
  LocationData? currentLocation;
  late final MapController mapController;

  bool liveUpdate = false;
  bool permision = false;

  String? serviceError = '';

  int interActiveFlags = InteractiveFlag.all;

  final locationService = Location();

  @override
  void initState() {
    super.initState();
    mapController = MapController();
    initLocationService();
  }

  void initLocationService() async {
    await locationService.changeSettings(
      accuracy: LocationAccuracy.high,
      interval: 1000,
    );

    LocationData? location;
    bool serviceEnabled;
    bool serviceRequestResult;

    try {
      serviceEnabled = await locationService.serviceEnabled();
      if (!serviceEnabled) {
        debugPrint('Location services are disabled.');
        return Future.error('Location services are disabled.');
      } else if (serviceEnabled) {
        final permission = await locationService.requestPermission();
        permision = permission == PermissionStatus.granted;
        if (!permision) {
          debugPrint('Permission of location is denied.');
          return Future.error('Permission of location is denied.');
        }
        location = await locationService.getLocation();
        currentLocation = location;
        locationService.onLocationChanged.listen((LocationData result) async {
          if (mounted) {
            setState(() {
              currentLocation = result;
              if (liveUpdate) {
                mapController.move(
                    LatLng(currentLocation!.latitude!,
                        currentLocation!.longitude!),
                    mapController.zoom);
              }
            });
          }
        });
      } else {
        serviceRequestResult = await locationService.requestService();
        if (serviceRequestResult) {
          initLocationService();
          return;
        }
      }
    } on PlatformException catch (e) {
      debugPrint(e.toString());
      if (e.code == 'PERMISSION_DENIED') {
        serviceError = e.message;
      } else if (e.code == 'SERVICE_STATUS_ERROR') {
        serviceError = e.message;
      }
      location = null;
    }
  }

  @override
  Widget build(BuildContext context) {
    LatLng currentLatLng;

    if (currentLocation != null) {
      currentLatLng =
          LatLng(currentLocation!.latitude!, currentLocation!.longitude!);
    } else {
      currentLatLng = LatLng(0, 0);
    }

    final markers = <Marker>[
      Marker(
        point: currentLatLng,
        builder: (ctx) => const Icon(
          Icons.location_pin,
          color: Colors.red,
          size: 40,
        ),
      ),
    ];

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 8, bottom: 8),
              child: serviceError!.isEmpty
                  ? Text('This is a map that is showing '
                      '(${currentLatLng.latitude}, ${currentLatLng.longitude}).')
                  : Text(
                      'Error occurred while acquiring location. Error Message : '
                      '$serviceError'),
            ),
            Flexible(
              child: FlutterMap(
                mapController: mapController,
                options: MapOptions(
                  center: LatLng(
                    currentLatLng.latitude,
                    currentLatLng.longitude,
                  ),
                  zoom: 5,
                  interactiveFlags: interActiveFlags,
                ),
                children: [
                  TileLayer(
                    urlTemplate: AppConstants.urlTemplate,
                    additionalOptions: const {
                      'accessToken': AppConstants.mapBoxAccessToken,
                      'id': AppConstants.mapBoxStyleStreetId,
                    },
                  ),
                  MarkerLayer(markers: markers),
                ],
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: Builder(
        builder: (context) => FloatingActionButton(
          onPressed: () => setState(() {
            liveUpdate = !liveUpdate;
            if (liveUpdate) {
              interActiveFlags = InteractiveFlag.rotate |
                  InteractiveFlag.pinchZoom |
                  InteractiveFlag.doubleTapZoom;

              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('In live location rotation is disable'),
                ),
              );
            } else {
              interActiveFlags = InteractiveFlag.all;
            }
          }),
          child: liveUpdate
              ? const Icon(Icons.location_on)
              : const Icon(Icons.location_off),
        ),
      ),
    );
  }
}
