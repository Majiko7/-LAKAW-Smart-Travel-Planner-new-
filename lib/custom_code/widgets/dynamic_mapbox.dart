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
    this.routePolyline,
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

  @override
  State<DynamicMapbox> createState() => _DynamicMapboxWidgetState();
}

class _DynamicMapboxWidgetState extends State<DynamicMapbox> {
  List<Marker> allMarkers = [];
  List<Polyline> routePolylines = [];
  late MapController mapController;
  final polylinePoints = PolylinePoints(); // For decoding polyline
  List<LatLng> destinationsLatLng = [];

  @override
  void initState() {
    super.initState();
    mapController = MapController();
    refreshMapElements();
  }

  // Step 1: Get directions from Mapbox API and decode polyline for actual route
  Future<void> _getRouteFromMapbox(List<LatLng> orderedDestinations) async {
    // Start with the starting point
    String url =
        "https://api.mapbox.com/directions/v5/mapbox/driving/${widget.startingPoint!.longitude},${widget.startingPoint!.latitude}"; // starting point coordinates

    // Add each ordered destination to the URL
    for (int i = 0; i < orderedDestinations.length; i++) {
      url +=
          ";${orderedDestinations[i].longitude},${orderedDestinations[i].latitude}";
    }

    url +=
        "?access_token=${widget.accessToken}&geometries=polyline&overview=full"; // Detailed route geometry

    // Send HTTP request to Mapbox Directions API
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final List<dynamic> routes = data['routes'];
      final routeGeometry =
          routes[0]['geometry']; // Get the geometry of the first route

      // Step 2: Decode the polyline from the geometry data
      final result = polylinePoints.decodePolyline(routeGeometry);
      List<ll.LatLng> polylinePointsList = result
          .map((point) => ll.LatLng(point.latitude, point.longitude))
          .toList();

      // Step 3: Update the route polylines with decoded points
      setState(() {
        routePolylines = [
          Polyline(
            points: polylinePointsList,
            strokeWidth: 4.0,
            color: Colors.blue, // Set color for the route polyline
          )
        ];
      });
    } else {
      print("Error fetching directions: ${response.statusCode}");
    }
  }

  // Step 4: Refresh markers and polylines for the map
  void refreshMapElements() {
    print("🔥 Refreshing map elements...");

    List<Marker> markers = [];

    // Add BLUE marker for current location
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

    // Add RED markers for selected destinations
    destinationsLatLng.clear();
    for (int i = 0; i < widget.selectedLatitude.length; i++) {
      double lat = widget.selectedLatitude[i];
      double lon = widget.selectedLongitude[i];

      if (lat.isFinite && lon.isFinite) {
        markers.add(
          Marker(
            point: ll.LatLng(lat, lon),
            width: 30,
            height: 30,
            child: const Icon(Icons.location_pin, color: Colors.red, size: 30),
          ),
        );
        destinationsLatLng.add(LatLng(lat, lon)); // Save as LatLng
      }
    }

    // Step 5: Sorting destinations by distance from the starting point
    List<LatLng> orderedDestinations =
        _sortDestinationsByDistance(destinationsLatLng);

    // Call the Mapbox API to get the route
    _getRouteFromMapbox(orderedDestinations);

    setState(() {
      allMarkers = markers;
    });
  }

  // Sort destinations based on distance from starting point
  List<LatLng> _sortDestinationsByDistance(List<LatLng> destinations) {
    destinations.sort((a, b) {
      double distanceA = _calculateDistance(widget.startingPoint!, a);
      double distanceB = _calculateDistance(widget.startingPoint!, b);
      return distanceA.compareTo(distanceB);
    });
    return destinations;
  }

// Calculate the distance between two LatLng points (in kilometers)
  double _calculateDistance(LatLng start, LatLng end) {
    final startLatLng = ll.LatLng(start.latitude, start.longitude);
    final endLatLng = ll.LatLng(end.latitude, end.longitude);

    // Use the distance method to calculate the distance in meters
    double distanceInMeters = ll.Distance().distance(startLatLng, endLatLng);

    // Convert distance from meters to kilometers
    return distanceInMeters / 1000;
  }

  @override
  void didUpdateWidget(covariant DynamicMapbox oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.selectedLatitude != oldWidget.selectedLatitude ||
        widget.selectedLongitude != oldWidget.selectedLongitude ||
        widget.routePolyline != oldWidget.routePolyline) {
      print("🔄 Widget Updated! Refreshing Map...");
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
          PolylineLayer(
            polylines: routePolylines, // Display the updated route
          ),
          MarkerLayer(
            markers: allMarkers, // Display all markers (blue, red)
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
