import 'dart:convert';

import 'package:flutter/foundation.dart';

import 'api_manager.dart';

export 'api_manager.dart' show ApiCallResponse;

const _kPrivateApiFunctionName = 'ffPrivateApiCall';

class GetDestinationNameCall {
  static Future<ApiCallResponse> call({
    String? apiKey = '',
    String? name = '',
    String? municipalCity = '',
    int? offset,
    int? limit,
    double? rating,
    String? category = '',
    String? imageUrl = '',
    String? barangay = '',
    String? openingHour = '',
    String? closingHour = '',
  }) async {
    return ApiManager.instance.makeApiCall(
      callName: 'Get Destination Name',
      apiUrl: 'https://ljhpejoalrogchgkzsfo.supabase.co/rest/v1/Destinations',
      callType: ApiCallType.GET,
      headers: {
        'apiKey': '${apiKey}',
      },
      params: {
        'offset': offset,
        'limit': limit,
      },
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }
}

class GetTravelGuidesCall {
  static Future<ApiCallResponse> call({
    String? title = '',
    String? description = '',
    int? offset,
    int? limit,
    String? content = '',
    String? apiKey = '',
  }) async {
    return ApiManager.instance.makeApiCall(
      callName: 'Get Travel Guides',
      apiUrl: 'https://ljhpejoalrogchgkzsfo.supabase.co/rest/v1/TravelGuides',
      callType: ApiCallType.GET,
      headers: {
        'apiKey': '${apiKey}',
      },
      params: {
        'offset': offset,
        'limit': limit,
      },
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }
}

class ApiPagingParams {
  int nextPageNumber = 0;
  int numItems = 0;
  dynamic lastResponse;

  ApiPagingParams({
    required this.nextPageNumber,
    required this.numItems,
    required this.lastResponse,
  });

  @override
  String toString() =>
      'PagingParams(nextPageNumber: $nextPageNumber, numItems: $numItems, lastResponse: $lastResponse,)';
}

String _toEncodable(dynamic item) {
  return item;
}

String _serializeList(List? list) {
  list ??= <String>[];
  try {
    return json.encode(list, toEncodable: _toEncodable);
  } catch (_) {
    if (kDebugMode) {
      print("List serialization failed. Returning empty list.");
    }
    return '[]';
  }
}

String _serializeJson(dynamic jsonVar, [bool isList = false]) {
  jsonVar ??= (isList ? [] : {});
  try {
    return json.encode(jsonVar, toEncodable: _toEncodable);
  } catch (_) {
    if (kDebugMode) {
      print("Json serialization failed. Returning empty json.");
    }
    return isList ? '[]' : '{}';
  }
}
