import 'package:powersync/powersync.dart';

const userProfilesTable = Table('user_profiles', [
  Column.text('user_id'),
  Column.text('first_name'),
  Column.text('last_name'),
  Column.text('birth_date'),
  Column.text('gender'),
  Column.text('address'),
], indexes: [
  Index('user_id', [IndexedColumn('user_id')])
]);
