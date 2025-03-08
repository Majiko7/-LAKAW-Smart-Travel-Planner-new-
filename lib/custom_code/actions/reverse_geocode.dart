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

// Set your action name, define your arguments and return parameter,
// and then add the boilerplate code using the green button on the right!
import 'dart:convert';
import 'package:http/http.dart' as http;

Future<String> reverseGeocode(double latitude, double longitude) async {
  const String accessToken =
      'pk.eyJ1IjoibWFqaWtvMjciLCJhIjoiY202MDVtNzZkMDhpYzJsc2YzcTZqNGtlZCJ9.idit4MwHQlrbp2LSMPOz_A'; // Replace with your Mapbox API Key

  final url = Uri.parse(
      'https://api.mapbox.com/geocoding/v5/mapbox.places/$longitude,$latitude.json?access_token=$accessToken');

  final response = await http.get(url);
  if (response.statusCode == 200) {
    final data = jsonDecode(response.body);
    if (data['features'].isNotEmpty) {
      return data['features'][0]['place_name'];
    }
  }
  return 'Unknown Location';
}
