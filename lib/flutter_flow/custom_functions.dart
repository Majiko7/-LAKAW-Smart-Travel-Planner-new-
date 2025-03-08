import 'dart:convert';
import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'lat_lng.dart';
import 'place.dart';
import 'uploaded_file.dart';
import '/backend/schema/structs/index.dart';
import '/backend/supabase/supabase.dart';
import '/auth/supabase_auth/auth_util.dart';

List<dynamic>? floydWarshallAlgo(
  List<dynamic>? locationsJson,
  LatLng? currentLocation,
) {
  /// ✅ Prevent null errors
  if (locationsJson == null || locationsJson.isEmpty || currentLocation == null)
    return [];

  // ✅ Add current location (blue marker) at the start of the list
  List<LatLng> locations = [
    currentLocation, // Insert at index 0
    ...locationsJson
        .map((item) => LatLng(item['lat'] as double, item['lng'] as double))
  ];

  int n = locations.length;
  List<List<double>> distanceMatrix =
      List.generate(n, (i) => List.filled(n, double.infinity));

  // ✅ Calculate distance using Haversine formula
  double calculateDistance(LatLng location1, LatLng location2) {
    const double earthRadius = 6371; // Earth radius in km
    double lat1 = location1.latitude * math.pi / 180;
    double lng1 = location1.longitude * math.pi / 180;
    double lat2 = location2.latitude * math.pi / 180;
    double lng2 = location2.longitude * math.pi / 180;

    double dLat = lat2 - lat1;
    double dLng = lng2 - lng1;

    double a = math.pow(math.sin(dLat / 2), 2) +
        math.cos(lat1) * math.cos(lat2) * math.pow(math.sin(dLng / 2), 2);
    double c = 2 * math.atan2(math.sqrt(a), math.sqrt(1 - a));

    return earthRadius * c;
  }

  // ✅ Populate the distance matrix
  for (int i = 0; i < n; i++) {
    for (int j = 0; j < n; j++) {
      if (i == j) {
        distanceMatrix[i][j] = 0;
      } else {
        distanceMatrix[i][j] = calculateDistance(locations[i], locations[j]);
      }
    }
  }

  // ✅ Apply Floyd-Warshall Algorithm to find shortest paths
  for (int k = 0; k < n; k++) {
    for (int i = 0; i < n; i++) {
      for (int j = 0; j < n; j++) {
        if (distanceMatrix[i][k] + distanceMatrix[k][j] <
            distanceMatrix[i][j]) {
          distanceMatrix[i][j] = distanceMatrix[i][k] + distanceMatrix[k][j];
        }
      }
    }
  }

  // ✅ Find the optimal route using a nearest-neighbor approach
  List<int> route = [];
  List<bool> visited = List.filled(n, false);
  int currentLocationIndex = 0; // Start from the blue marker
  route.add(currentLocationIndex);
  visited[currentLocationIndex] = true;

  for (int step = 1; step < n; step++) {
    double minDistance = double.infinity;
    int nextLocation = -1;

    for (int j = 0; j < n; j++) {
      if (!visited[j] &&
          distanceMatrix[currentLocationIndex][j] < minDistance) {
        minDistance = distanceMatrix[currentLocationIndex][j];
        nextLocation = j;
      }
    }

    if (nextLocation != -1) {
      visited[nextLocation] = true;
      route.add(nextLocation);
      currentLocationIndex = nextLocation;
    }
  }

  // ✅ Convert the optimized route order into JSON format for FlutterFlow
  List<Map<String, dynamic>> orderedLocations = route
      .map((index) =>
          {"lat": locations[index].latitude, "lng": locations[index].longitude})
      .toList();

  return orderedLocations; // ✅ Return optimized polyline points
}
