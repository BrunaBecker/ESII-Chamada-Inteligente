import 'package:flutter/material.dart';

import 'app/app_widget.dart';
import 'app/core/adapters/storage_adapter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await StorageAdapter.init();

  runApp(const AppWidget());
}
