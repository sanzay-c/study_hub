// lib/core/services/local/database/app_database.dart

import 'dart:developer';

import 'package:drift/drift.dart';
import 'package:drift_flutter/drift_flutter.dart';
import 'package:study_hub/core/services/local/database/daos/auth_dao.dart';
import 'package:study_hub/core/services/local/database/table/auth_table.dart';

part 'auth_database.g.dart';

@DriftDatabase(
  tables: [
    AuthTokens,
    Users,
  ],

  daos: [
    AuthDao, 
  ],
)
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(_openConnection());

  @override
  int get schemaVersion => 1;

  @override
  MigrationStrategy get migration {
    return MigrationStrategy(
      onCreate: (Migrator m) async {
        await m.createAll();
      },
      onUpgrade: (Migrator m, int from, int to) async {
        // Handle schema migrations
        // Example:
        // if (from < 2) {
        //   await m.addColumn(users, users.newColumn);
        // }
      },
      beforeOpen: (details) async {
        // Enable foreign keys
        await customStatement('PRAGMA foreign_keys = ON');

        // Debug info
        log('📊 Database opened: ${details.wasCreated ? "Created" : "Existing"}');
        log('📊 Database version: ${details.versionNow}');
      },
    );
  }
}

// Database connection
QueryExecutor _openConnection() {
  return driftDatabase(
    name: 'auth_database',
    web: DriftWebOptions(
      sqlite3Wasm: Uri.parse('sqlite3.wasm'),
      driftWorker: Uri.parse('drift_worker.js'),
    ),
  );
}