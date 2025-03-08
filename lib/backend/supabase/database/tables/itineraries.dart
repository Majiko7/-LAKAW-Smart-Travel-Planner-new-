import '../database.dart';

class ItinerariesTable extends SupabaseTable<ItinerariesRow> {
  @override
  String get tableName => 'Itineraries';

  @override
  ItinerariesRow createRow(Map<String, dynamic> data) => ItinerariesRow(data);
}

class ItinerariesRow extends SupabaseDataRow {
  ItinerariesRow(Map<String, dynamic> data) : super(data);

  @override
  SupabaseTable get table => ItinerariesTable();

  int get id => getField<int>('id')!;
  set id(int value) => setField<int>('id', value);

  String get userId => getField<String>('user_id')!;
  set userId(String value) => setField<String>('user_id', value);

  String? get name => getField<String>('name');
  set name(String? value) => setField<String>('name', value);

  dynamic get destinations => getField<dynamic>('destinations');
  set destinations(dynamic value) => setField<dynamic>('destinations', value);

  dynamic get preferences => getField<dynamic>('preferences');
  set preferences(dynamic value) => setField<dynamic>('preferences', value);

  DateTime? get startDate => getField<DateTime>('start_date');
  set startDate(DateTime? value) => setField<DateTime>('start_date', value);

  DateTime? get endDate => getField<DateTime>('end_date');
  set endDate(DateTime? value) => setField<DateTime>('end_date', value);

  PostgresTime? get startTime => getField<PostgresTime>('start_time');
  set startTime(PostgresTime? value) =>
      setField<PostgresTime>('start_time', value);

  PostgresTime? get endTime => getField<PostgresTime>('end_time');
  set endTime(PostgresTime? value) => setField<PostgresTime>('end_time', value);

  DateTime get createdAt => getField<DateTime>('created_at')!;
  set createdAt(DateTime value) => setField<DateTime>('created_at', value);
}
