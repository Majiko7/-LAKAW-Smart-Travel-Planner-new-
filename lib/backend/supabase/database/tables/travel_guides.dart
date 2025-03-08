import '../database.dart';

class TravelGuidesTable extends SupabaseTable<TravelGuidesRow> {
  @override
  String get tableName => 'TravelGuides';

  @override
  TravelGuidesRow createRow(Map<String, dynamic> data) => TravelGuidesRow(data);
}

class TravelGuidesRow extends SupabaseDataRow {
  TravelGuidesRow(Map<String, dynamic> data) : super(data);

  @override
  SupabaseTable get table => TravelGuidesTable();

  int get id => getField<int>('id')!;
  set id(int value) => setField<int>('id', value);

  String get title => getField<String>('title')!;
  set title(String value) => setField<String>('title', value);

  String? get description => getField<String>('description');
  set description(String? value) => setField<String>('description', value);

  String? get content => getField<String>('content');
  set content(String? value) => setField<String>('content', value);

  String? get icon => getField<String>('icon');
  set icon(String? value) => setField<String>('icon', value);
}
