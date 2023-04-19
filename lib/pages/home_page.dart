import 'package:flutter/material.dart';
import 'package:flutter_map_package/pages/live_location_page.dart';
import 'package:flutter_map_package/pages/map_controller_page.dart';
import 'package:flutter_map_package/pages/polyline_markers_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: const Text('Flutter Map Package'),
        ),
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              children: [
                ElevatedButton(
                  onPressed: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const PolylineMarkersPage(),
                    ),
                  ),
                  child: const Text('Polyline Markers Page'),
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const LiveLocationPage(),
                    ),
                  ),
                  child: const Text('Live Location Page'),
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const MapControllerPage(),
                    ),
                  ),
                  child: const Text('Map Controller Page'),
                ),
              ],
            ),
          ),
        ),
      );
}
