import '../database.dart';

class Users1Table extends SupabaseTable<Users1Row> {
  @override
  String get tableName => 'Users1';

  @override
  Users1Row createRow(Map<String, dynamic> data) => Users1Row(data);
}

class Users1Row extends SupabaseDataRow {
  Users1Row(Map<String, dynamic> data) : super(data);

  @override
  SupabaseTable get table => Users1Table();

  String get id => getField<String>('id')!;
  set id(String value) => setField<String>('id', value);

  String? get username => getField<String>('username');
  set username(String? value) => setField<String>('username', value);

  dynamic get preferences => getField<dynamic>('preferences');
  set preferences(dynamic value) => setField<dynamic>('preferences', value);

  String? get password => getField<String>('password');
  set password(String? value) => setField<String>('password', value);

  DateTime get createdAt => getField<DateTime>('created_at')!;
  set createdAt(DateTime value) => setField<DateTime>('created_at', value);

  String? get profileImage => getField<String>('profile_image');
  set profileImage(String? value) => setField<String>('profile_image', value);
}
