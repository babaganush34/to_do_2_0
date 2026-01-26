import 'package:drift/drift.dart';

class Todos extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get title => text().withLength(min: 3, max: 30)();
  BoolColumn get isFinished =>
      boolean().withDefault(const Constant(false))();
  TextColumn get date => text()();
}