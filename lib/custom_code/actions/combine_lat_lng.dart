// Automatic FlutterFlow imports
import '/backend/schema/structs/index.dart';
import '/backend/supabase/supabase.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'index.dart'; // Imports other custom actions
import '/flutter_flow/custom_functions.dart'; // Imports custom functions
import 'package:flutter/material.dart';
// Begin custom action code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!

List<dynamic>? combineLatLng(
    List<double>? latitudes, List<double>? longitudes) {
  /// ✅ Check if input is valid
  if (latitudes == null ||
      longitudes == null ||
      latitudes.length != longitudes.length) {
    return [];
  }

  /// ✅ Create a List of JSON objects with "lat" and "lng"
  List<Map<String, dynamic>> combinedList = [];
  for (int i = 0; i < latitudes.length; i++) {
    combinedList.add({
      "lat": latitudes[i],
      "lng": longitudes[i],
    });
  }

  return combinedList; // ✅ Returns List<JSON> (Valid for FlutterFlow)
}

// Set your action name, define your arguments and return parameter,
// and then add the boilerplate code using the green button on the right!
