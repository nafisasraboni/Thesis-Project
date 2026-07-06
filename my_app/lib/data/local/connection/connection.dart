import 'package:drift/drift.dart';
import 'package:flutter/foundation.dart';

import 'connection_native.dart'
    if (dart.library.html) 'connection_web.dart'
    as connection;

/// Returns the appropriate database executor for the current platform.
QueryExecutor openDatabaseConnection() {
  if (kIsWeb) {
    return connection.openConnection();
  }

  return connection.openConnection();
}
