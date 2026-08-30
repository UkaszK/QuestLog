import 'package:flutter/material.dart';
import 'package:questlog/data/isar_data_store.dart';
import 'app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await IsarDataStore.init();
  runApp(const App());
}
