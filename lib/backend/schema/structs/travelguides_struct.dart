// ignore_for_file: unnecessary_getters_setters

import '/backend/schema/util/schema_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class TravelguidesStruct extends BaseStruct {
  TravelguidesStruct({
    String? title,
    String? description,
    String? content,
  })  : _title = title,
        _description = description,
        _content = content;

  // "title" field.
  String? _title;
  String get title => _title ?? '';
  set title(String? val) => _title = val;

  bool hasTitle() => _title != null;

  // "description" field.
  String? _description;
  String get description => _description ?? '';
  set description(String? val) => _description = val;

  bool hasDescription() => _description != null;

  // "content" field.
  String? _content;
  String get content => _content ?? '';
  set content(String? val) => _content = val;

  bool hasContent() => _content != null;

  static TravelguidesStruct fromMap(Map<String, dynamic> data) =>
      TravelguidesStruct(
        title: data['title'] as String?,
        description: data['description'] as String?,
        content: data['content'] as String?,
      );

  static TravelguidesStruct? maybeFromMap(dynamic data) => data is Map
      ? TravelguidesStruct.fromMap(data.cast<String, dynamic>())
      : null;

  Map<String, dynamic> toMap() => {
        'title': _title,
        'description': _description,
        'content': _content,
      }.withoutNulls;

  @override
  Map<String, dynamic> toSerializableMap() => {
        'title': serializeParam(
          _title,
          ParamType.String,
        ),
        'description': serializeParam(
          _description,
          ParamType.String,
        ),
        'content': serializeParam(
          _content,
          ParamType.String,
        ),
      }.withoutNulls;

  static TravelguidesStruct fromSerializableMap(Map<String, dynamic> data) =>
      TravelguidesStruct(
        title: deserializeParam(
          data['title'],
          ParamType.String,
          false,
        ),
        description: deserializeParam(
          data['description'],
          ParamType.String,
          false,
        ),
        content: deserializeParam(
          data['content'],
          ParamType.String,
          false,
        ),
      );

  @override
  String toString() => 'TravelguidesStruct(${toMap()})';

  @override
  bool operator ==(Object other) {
    return other is TravelguidesStruct &&
        title == other.title &&
        description == other.description &&
        content == other.content;
  }

  @override
  int get hashCode => const ListEquality().hash([title, description, content]);
}

TravelguidesStruct createTravelguidesStruct({
  String? title,
  String? description,
  String? content,
}) =>
    TravelguidesStruct(
      title: title,
      description: description,
      content: content,
    );
