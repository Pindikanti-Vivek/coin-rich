import 'package:hive/hive.dart';

class HiveStorage {
  HiveStorage._();

  static HiveStorage? _instance;

  static HiveStorage get instance => _instance ??= HiveStorage._();

  final Box hive = Hive.box("data");
}