import '../database.dart';

class DestinationsTable extends SupabaseTable<DestinationsRow> {
  @override
  String get tableName => 'Destinations';

  @override
  DestinationsRow createRow(Map<String, dynamic> data) => DestinationsRow(data);
}

class DestinationsRow extends SupabaseDataRow {
  DestinationsRow(Map<String, dynamic> data) : super(data);

  @override
  SupabaseTable get table => DestinationsTable();

  String get id => getField<String>('id')!;
  set id(String value) => setField<String>('id', value);

  String? get description => getField<String>('description');
  set description(String? value) => setField<String>('description', value);

  String? get barangay => getField<String>('barangay');
  set barangay(String? value) => setField<String>('barangay', value);

  String? get municipalCity => getField<String>('municipal_city');
  set municipalCity(String? value) => setField<String>('municipal_city', value);

  String? get category => getField<String>('category');
  set category(String? value) => setField<String>('category', value);

  double? get latitude => getField<double>('latitude');
  set latitude(double? value) => setField<double>('latitude', value);

  double? get longhitude => getField<double>('longhitude');
  set longhitude(double? value) => setField<double>('longhitude', value);

  PostgresTime? get openingHour => getField<PostgresTime>('opening_hour');
  set openingHour(PostgresTime? value) =>
      setField<PostgresTime>('opening_hour', value);

  PostgresTime? get closingHour => getField<PostgresTime>('closing_hour');
  set closingHour(PostgresTime? value) =>
      setField<PostgresTime>('closing_hour', value);

  double? get rating => getField<double>('rating');
  set rating(double? value) => setField<double>('rating', value);

  DateTime get createdAt => getField<DateTime>('created_at')!;
  set createdAt(DateTime value) => setField<DateTime>('created_at', value);

  String? get imageUrl => getField<String>('image_url');
  set imageUrl(String? value) => setField<String>('image_url', value);

  String? get name => getField<String>('name');
  set name(String? value) => setField<String>('name', value);
}
