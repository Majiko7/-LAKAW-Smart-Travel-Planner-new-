import '/backend/supabase/supabase.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/index.dart';
import 'route_optimization_widget.dart' show RouteOptimizationWidget;
import 'package:flutter/material.dart';

class RouteOptimizationModel extends FlutterFlowModel<RouteOptimizationWidget> {
  ///  Local state fields for this page.

  List<double> selectedLatitude = [];
  void addToSelectedLatitude(double item) => selectedLatitude.add(item);
  void removeFromSelectedLatitude(double item) => selectedLatitude.remove(item);
  void removeAtIndexFromSelectedLatitude(int index) =>
      selectedLatitude.removeAt(index);
  void insertAtIndexInSelectedLatitude(int index, double item) =>
      selectedLatitude.insert(index, item);
  void updateSelectedLatitudeAtIndex(int index, Function(double) updateFn) =>
      selectedLatitude[index] = updateFn(selectedLatitude[index]);

  List<double> selectedLongitude = [];
  void addToSelectedLongitude(double item) => selectedLongitude.add(item);
  void removeFromSelectedLongitude(double item) =>
      selectedLongitude.remove(item);
  void removeAtIndexFromSelectedLongitude(int index) =>
      selectedLongitude.removeAt(index);
  void insertAtIndexInSelectedLongitude(int index, double item) =>
      selectedLongitude.insert(index, item);
  void updateSelectedLongitudeAtIndex(int index, Function(double) updateFn) =>
      selectedLongitude[index] = updateFn(selectedLongitude[index]);

  bool forceRefresh = false;

  List<bool> selectedCheckbox = [];
  void addToSelectedCheckbox(bool item) => selectedCheckbox.add(item);
  void removeFromSelectedCheckbox(bool item) => selectedCheckbox.remove(item);
  void removeAtIndexFromSelectedCheckbox(int index) =>
      selectedCheckbox.removeAt(index);
  void insertAtIndexInSelectedCheckbox(int index, bool item) =>
      selectedCheckbox.insert(index, item);
  void updateSelectedCheckboxAtIndex(int index, Function(bool) updateFn) =>
      selectedCheckbox[index] = updateFn(selectedCheckbox[index]);

  List<dynamic> routePolyline = [];
  void addToRoutePolyline(dynamic item) => routePolyline.add(item);
  void removeFromRoutePolyline(dynamic item) => routePolyline.remove(item);
  void removeAtIndexFromRoutePolyline(int index) =>
      routePolyline.removeAt(index);
  void insertAtIndexInRoutePolyline(int index, dynamic item) =>
      routePolyline.insert(index, item);
  void updateRoutePolylineAtIndex(int index, Function(dynamic) updateFn) =>
      routePolyline[index] = updateFn(routePolyline[index]);

  ///  State fields for stateful widgets in this page.

  // Stores action output result for [Custom Action - getCurrentLocation] action in RouteOptimization widget.
  LatLng? currentLocation;
  // State field(s) for Checkbox widget.
  Map<DestinationsRow, bool> checkboxValueMap = {};
  List<DestinationsRow> get checkboxCheckedItems =>
      checkboxValueMap.entries.where((e) => e.value).map((e) => e.key).toList();

  // Stores action output result for [Custom Action - combineLatLng] action in CalculateRoute widget.
  List<dynamic>? coordinatesJson;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {}
}
