// Automatic FlutterFlow imports
import '/backend/schema/structs/index.dart';
import '/backend/supabase/supabase.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'index.dart'; // Imports other custom widgets
import '/custom_code/actions/index.dart'; // Imports custom actions
import '/flutter_flow/custom_functions.dart'; // Imports custom functions
import 'package:flutter/material.dart';
// Begin custom widget code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!

import 'dart:convert';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart' as ll;
import 'package:flutter_polyline_points/flutter_polyline_points.dart'; // For polyline decoding
import 'package:http/http.dart' as http;

class DynamicMapbox extends StatefulWidget {
  const DynamicMapbox({
    super.key,
    this.width,
    this.height,
    required this.accessToken,
    this.startingPoint,
    required this.startingZoom,
    this.currentLocation,
    required this.selectedLatitude,
    required this.selectedLongitude,
    required this.routePolyline,
    required this.showRoute, // ✅ Ensures polyline appears only when "Calculate Route" is clicked
  });

  final double? width;
  final double? height;
  final String accessToken;
  final LatLng? startingPoint;
  final double startingZoom;
  final LatLng? currentLocation;
  final List<double> selectedLatitude;
  final List<double> selectedLongitude;
  final List<dynamic>? routePolyline;
  final bool showRoute; // ✅ Determines when to show polylines

  @override
  State<DynamicMapbox> createState() => _DynamicMapboxWidgetState();
}

class _DynamicMapboxWidgetState extends State<DynamicMapbox> {
  List<Marker> allMarkers = [];
  List<Polyline> routePolylines = [];
  late MapController mapController;
  final polylinePoints = PolylinePoints(); // For decoding polyline

  @override
  void initState() {
    super.initState();
    mapController = MapController();
    refreshMapElements();
  }

  /// ✅ Fix: Get proper road routes from Mapbox API
  Future<void> _getRouteFromMapbox() async {
    if (widget.startingPoint == null || widget.selectedLatitude.isEmpty) {
      print("⚠️ No starting point or destinations selected.");
      return;
    }

    print("🛣️ Fetching route from Mapbox...");

    // Build the Mapbox API request URL
    String baseUrl = "https://api.mapbox.com/directions/v5/mapbox/driving/";
    String coordinates =
        "${widget.startingPoint!.longitude},${widget.startingPoint!.latitude}";

    for (int i = 0; i < widget.selectedLatitude.length; i++) {
      coordinates +=
          ";${widget.selectedLongitude[i]},${widget.selectedLatitude[i]}";
    }

    String url =
        "$baseUrl$coordinates?geometries=polyline&overview=full&access_token=${widget.accessToken}";

    try {
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final List<dynamic> routes = data['routes'];
        final routeGeometry = routes[0]['geometry']; // ✅ Extract route geometry

        // Decode the polyline data
        final result = polylinePoints.decodePolyline(routeGeometry);
        List<ll.LatLng> polylinePointsList = result
            .map((point) => ll.LatLng(point.latitude, point.longitude))
            .toList();

        setState(() {
          routePolylines = [
            Polyline(
              points: polylinePointsList,
              strokeWidth: 4.0,
              color: Colors.blue, // ✅ Polyline is BLUE
            )
          ];
        });

        print("✅ Route successfully generated!");
      } else {
        print("❌ Error fetching directions: ${response.statusCode}");
      }
    } catch (e) {
      print("❌ Exception while fetching route: $e");
    }
  }

  void refreshMapElements() {
    print("🔥 Refreshing map elements...");

    List<Marker> markers = [];

    // ✅ Add BLUE marker for current location
    if (widget.currentLocation != null) {
      markers.add(
        Marker(
          point: ll.LatLng(
            widget.currentLocation!.latitude,
            widget.currentLocation!.longitude,
          ),
          width: 40,
          height: 40,
          child: const Icon(Icons.location_pin, color: Colors.blue, size: 40),
        ),
      );
    }

    // ✅ Add RED markers for selected destinations
    for (int i = 0; i < widget.selectedLatitude.length; i++) {
      markers.add(
        Marker(
          point: ll.LatLng(
              widget.selectedLatitude[i], widget.selectedLongitude[i]),
          width: 30,
          height: 30,
          child: const Icon(Icons.location_pin, color: Colors.red, size: 30),
        ),
      );
    }

    // ✅ Only fetch and show the route when "Calculate Route" is clicked
    if (widget.showRoute) {
      _getRouteFromMapbox(); // ✅ Fetch road routes
    } else {
      print("⚠️ Route is NOT being displayed yet.");
    }

    setState(() {
      allMarkers = markers;
    });
  }

  @override
  void didUpdateWidget(covariant DynamicMapbox oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.showRoute != oldWidget.showRoute ||
        widget.routePolyline != oldWidget.routePolyline) {
      print("🔄 Route Updated! Refreshing...");
      refreshMapElements();
    }
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: widget.width ?? MediaQuery.of(context).size.width,
      height: widget.height ?? MediaQuery.of(context).size.height,
      child: FlutterMap(
        mapController: mapController,
        options: MapOptions(
          initialCenter: widget.currentLocation != null
              ? ll.LatLng(widget.currentLocation!.latitude,
                  widget.currentLocation!.longitude)
              : widget.startingPoint != null
                  ? ll.LatLng(widget.startingPoint!.latitude,
                      widget.startingPoint!.longitude)
                  : const ll.LatLng(13.1333, 123.7333),
          initialZoom: widget.startingZoom,
        ),
        children: [
          TileLayer(
            urlTemplate:
                'https://api.mapbox.com/styles/v1/mapbox/streets-v11/tiles/{z}/{x}/{y}?access_token=${widget.accessToken}',
            additionalOptions: {
              'accessToken': widget.accessToken,
            },
          ),
          if (widget
              .showRoute) // ✅ Only show route if "Calculate Route" was clicked
            PolylineLayer(
              polylines: routePolylines,
            ),
          MarkerLayer(
            markers: allMarkers,
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    mapController.dispose();
    super.dispose();
  }
}
