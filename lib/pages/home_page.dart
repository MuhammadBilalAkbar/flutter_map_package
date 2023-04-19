import 'package:flutter/material.dart';

import '/pages/map_controller_page.dart';
import '/pages/polyline_markers_page.dart';

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
                      builder: (context) =>
                          const PolylineMarkersPage('Polyline Markers Page'),
                    ),
                  ),
                  child: const Text('Polyline Markers Page'),
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          const MapControllerPage('Map Controller Page'),
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
