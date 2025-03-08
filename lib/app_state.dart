import 'package:flutter/material.dart';
import 'backend/supabase/supabase.dart';
import 'flutter_flow/flutter_flow_util.dart';

class FFAppState extends ChangeNotifier {
  static FFAppState _instance = FFAppState._internal();

  factory FFAppState() {
    return _instance;
  }

  FFAppState._internal();

  static void reset() {
    _instance = FFAppState._internal();
  }

  Future initializePersistedState() async {}

  void update(VoidCallback callback) {
    callback();
    notifyListeners();
  }

  String _apiKey =
      'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImxqaHBlam9hbHJvZ2NoZ2t6c2ZvIiwicm9sZSI6ImFub24iLCJpYXQiOjE3MzY5MTYwNzAsImV4cCI6MjA1MjQ5MjA3MH0.j0DrlSVYNp2_vAtXFy47X2gFTkItz6gZQYTnUgmste0';
  String get apiKey => _apiKey;
  set apiKey(String value) {
    _apiKey = value;
  }

  LatLng? _currentLocation;
  LatLng? get currentLocation => _currentLocation;
  set currentLocation(LatLng? value) {
    _currentLocation = value;
  }

  /// loading of Mapbox Map in route optimization page
  bool _isLoading = true;
  bool get isLoading => _isLoading;
  set isLoading(bool value) {
    _isLoading = value;
  }

  /// List of chosen destinations
  List<String> _selectedDestinations = [];
  List<String> get selectedDestinations => _selectedDestinations;
  set selectedDestinations(List<String> value) {
    _selectedDestinations = value;
  }

  void addToSelectedDestinations(String value) {
    selectedDestinations.add(value);
  }

  void removeFromSelectedDestinations(String value) {
    selectedDestinations.remove(value);
  }

  void removeAtIndexFromSelectedDestinations(int index) {
    selectedDestinations.removeAt(index);
  }

  void updateSelectedDestinationsAtIndex(
    int index,
    String Function(String) updateFn,
  ) {
    selectedDestinations[index] = updateFn(_selectedDestinations[index]);
  }

  void insertAtIndexInSelectedDestinations(int index, String value) {
    selectedDestinations.insert(index, value);
  }

  /// controls visibility of list view in Route Optimization Page
  bool _isListVisibleROpt = false;
  bool get isListVisibleROpt => _isListVisibleROpt;
  set isListVisibleROpt(bool value) {
    _isListVisibleROpt = value;
  }
}
