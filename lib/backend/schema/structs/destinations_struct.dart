// ignore_for_file: unnecessary_getters_setters

import '/backend/schema/util/schema_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class DestinationsStruct extends BaseStruct {
  DestinationsStruct({
    String? name,
    String? municipalCity,
    String? category,
    String? imageUrl,
    double? rating,
    String? barangay,
  })  : _name = name,
        _municipalCity = municipalCity,
        _category = category,
        _imageUrl = imageUrl,
        _rating = rating,
        _barangay = barangay;

  // "name" field.
  String? _name;
  String get name => _name ?? '';
  set name(String? val) => _name = val;

  bool hasName() => _name != null;

  // "municipal_city" field.
  String? _municipalCity;
  String get municipalCity => _municipalCity ?? '';
  set municipalCity(String? val) => _municipalCity = val;

  bool hasMunicipalCity() => _municipalCity != null;

  // "category" field.
  String? _category;
  String get category => _category ?? '';
  set category(String? val) => _category = val;

  bool hasCategory() => _category != null;

  // "image_url" field.
  String? _imageUrl;
  String get imageUrl => _imageUrl ?? '';
  set imageUrl(String? val) => _imageUrl = val;

  bool hasImageUrl() => _imageUrl != null;

  // "rating" field.
  double? _rating;
  double get rating => _rating ?? 0.0;
  set rating(double? val) => _rating = val;

  void incrementRating(double amount) => rating = rating + amount;

  bool hasRating() => _rating != null;

  // "barangay" field.
  String? _barangay;
  String get barangay => _barangay ?? '';
  set barangay(String? val) => _barangay = val;

  bool hasBarangay() => _barangay != null;

  static DestinationsStruct fromMap(Map<String, dynamic> data) =>
      DestinationsStruct(
        name: data['name'] as String?,
        municipalCity: data['municipal_city'] as String?,
        category: data['category'] as String?,
        imageUrl: data['image_url'] as String?,
        rating: castToType<double>(data['rating']),
        barangay: data['barangay'] as String?,
      );

  static DestinationsStruct? maybeFromMap(dynamic data) => data is Map
      ? DestinationsStruct.fromMap(data.cast<String, dynamic>())
      : null;

  Map<String, dynamic> toMap() => {
        'name': _name,
        'municipal_city': _municipalCity,
        'category': _category,
        'image_url': _imageUrl,
        'rating': _rating,
        'barangay': _barangay,
      }.withoutNulls;

  @override
  Map<String, dynamic> toSerializableMap() => {
        'name': serializeParam(
          _name,
          ParamType.String,
        ),
        'municipal_city': serializeParam(
          _municipalCity,
          ParamType.String,
        ),
        'category': serializeParam(
          _category,
          ParamType.String,
        ),
        'image_url': serializeParam(
          _imageUrl,
          ParamType.String,
        ),
        'rating': serializeParam(
          _rating,
          ParamType.double,
        ),
        'barangay': serializeParam(
          _barangay,
          ParamType.String,
        ),
      }.withoutNulls;

  static DestinationsStruct fromSerializableMap(Map<String, dynamic> data) =>
      DestinationsStruct(
        name: deserializeParam(
          data['name'],
          ParamType.String,
          false,
        ),
        municipalCity: deserializeParam(
          data['municipal_city'],
          ParamType.String,
          false,
        ),
        category: deserializeParam(
          data['category'],
          ParamType.String,
          false,
        ),
        imageUrl: deserializeParam(
          data['image_url'],
          ParamType.String,
          false,
        ),
        rating: deserializeParam(
          data['rating'],
          ParamType.double,
          false,
        ),
        barangay: deserializeParam(
          data['barangay'],
          ParamType.String,
          false,
        ),
      );

  @override
  String toString() => 'DestinationsStruct(${toMap()})';

  @override
  bool operator ==(Object other) {
    return other is DestinationsStruct &&
        name == other.name &&
        municipalCity == other.municipalCity &&
        category == other.category &&
        imageUrl == other.imageUrl &&
        rating == other.rating &&
        barangay == other.barangay;
  }

  @override
  int get hashCode => const ListEquality()
      .hash([name, municipalCity, category, imageUrl, rating, barangay]);
}

DestinationsStruct createDestinationsStruct({
  String? name,
  String? municipalCity,
  String? category,
  String? imageUrl,
  double? rating,
  String? barangay,
}) =>
    DestinationsStruct(
      name: name,
      municipalCity: municipalCity,
      category: category,
      imageUrl: imageUrl,
      rating: rating,
      barangay: barangay,
    );
