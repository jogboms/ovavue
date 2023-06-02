import 'dart:io';

import 'package:clock/clock.dart';
import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:meta/meta.dart';
import 'package:ovavue/core.dart';
import 'package:ovavue/domain.dart';
import 'package:rxdart/transformers.dart';
import 'package:uuid/uuid.dart';

part 'daos.dart';
part 'database.g.dart';
part 'mappings.dart';
part 'tables.dart';

@DriftDatabase(
  tables: <Type>[
    Accounts,
    Users,
    Budgets,
    BudgetPlans,
    BudgetCategories,
    BudgetAllocations,
    BudgetMetadataKeys,
    BudgetMetadataValues,
    BudgetMetadataAssociations,
  ],
  daos: <Type>[
    AccountsDao,
    UsersDao,
    BudgetsDao,
    BudgetPlansDao,
    BudgetCategoriesDao,
    BudgetAllocationsDao,
    BudgetMetadataDao,
  ],
)
class Database extends _$Database {
  Database(String path) : super(LazyDatabase(() => NativeDatabase.createInBackground(File(path))));

  Database.memory() : super(NativeDatabase.memory(logStatements: true));

  @override
  int get schemaVersion => 2;

  @override
  MigrationStrategy get migration => MigrationStrategy(
        beforeOpen: (OpeningDetails details) async => customStatement('PRAGMA foreign_keys = ON'),
        onCreate: (Migrator m) async => m.createAll(),
        onUpgrade: (Migrator m, int from, int to) async {
          if (from < 2) {
            await Future.wait(<Future<void>>[
              m.createTable(budgetMetadataKeys),
              m.createTable(budgetMetadataValues),
              m.createTable(budgetMetadataAssociations),
            ]);
          }
        },
      );
}
