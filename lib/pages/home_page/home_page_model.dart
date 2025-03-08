import '/backend/supabase/supabase.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/index.dart';
import 'home_page_widget.dart' show HomePageWidget;
import 'package:flutter/material.dart';

class HomePageModel extends FlutterFlowModel<HomePageWidget> {
  ///  Local state fields for this page.

  int? limit = 10;

  List<DestinationsRow> destinations = [];
  void addToDestinations(DestinationsRow item) => destinations.add(item);
  void removeFromDestinations(DestinationsRow item) =>
      destinations.remove(item);
  void removeAtIndexFromDestinations(int index) => destinations.removeAt(index);
  void insertAtIndexInDestinations(int index, DestinationsRow item) =>
      destinations.insert(index, item);
  void updateDestinationsAtIndex(
          int index, Function(DestinationsRow) updateFn) =>
      destinations[index] = updateFn(destinations[index]);

  List<DestinationsRow> searchedDestinations = [];
  void addToSearchedDestinations(DestinationsRow item) =>
      searchedDestinations.add(item);
  void removeFromSearchedDestinations(DestinationsRow item) =>
      searchedDestinations.remove(item);
  void removeAtIndexFromSearchedDestinations(int index) =>
      searchedDestinations.removeAt(index);
  void insertAtIndexInSearchedDestinations(int index, DestinationsRow item) =>
      searchedDestinations.insert(index, item);
  void updateSearchedDestinationsAtIndex(
          int index, Function(DestinationsRow) updateFn) =>
      searchedDestinations[index] = updateFn(searchedDestinations[index]);

  ///  State fields for stateful widgets in this page.

  // Stores action output result for [Backend Call - Query Rows] action in HomePage widget.
  List<DestinationsRow>? allDestinations;
  // State field(s) for TextField widget.
  FocusNode? textFieldFocusNode;
  TextEditingController? textController;
  String? Function(BuildContext, String?)? textControllerValidator;
  List<String> simpleSearchResults = [];

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {
    textFieldFocusNode?.dispose();
    textController?.dispose();
  }
}
