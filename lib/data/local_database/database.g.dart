// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'database.dart';

// ignore_for_file: type=lint
class $AccountsTable extends Accounts with TableInfo<$AccountsTable, AccountDataModel> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $AccountsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    clientDefault: () => _uuid.v4(),
  );
  @override
  List<GeneratedColumn> get $columns => [id];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'accounts';
  @override
  VerificationContext validateIntegrity(
    Insertable<AccountDataModel> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  AccountDataModel map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return AccountDataModel(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
    );
  }

  @override
  $AccountsTable createAlias(String alias) {
    return $AccountsTable(attachedDatabase, alias);
  }
}

class AccountDataModel extends DataClass implements Insertable<AccountDataModel> {
  final String id;
  const AccountDataModel({required this.id});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    return map;
  }

  AccountsCompanion toCompanion(bool nullToAbsent) {
    return AccountsCompanion(id: Value(id));
  }

  factory AccountDataModel.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return AccountDataModel(id: serializer.fromJson<String>(json['id']));
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{'id': serializer.toJson<String>(id)};
  }

  AccountDataModel copyWith({String? id}) => AccountDataModel(id: id ?? this.id);
  AccountDataModel copyWithCompanion(AccountsCompanion data) {
    return AccountDataModel(id: data.id.present ? data.id.value : this.id);
  }

  @override
  String toString() {
    return (StringBuffer('AccountDataModel(')
          ..write('id: $id')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => id.hashCode;
  @override
  bool operator ==(Object other) => identical(this, other) || (other is AccountDataModel && other.id == this.id);
}

class AccountsCompanion extends UpdateCompanion<AccountDataModel> {
  final Value<String> id;
  final Value<int> rowid;
  const AccountsCompanion({
    this.id = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  AccountsCompanion.insert({
    this.id = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  static Insertable<AccountDataModel> custom({
    Expression<String>? id,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (rowid != null) 'rowid': rowid,
    });
  }

  AccountsCompanion copyWith({Value<String>? id, Value<int>? rowid}) {
    return AccountsCompanion(id: id ?? this.id, rowid: rowid ?? this.rowid);
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('AccountsCompanion(')
          ..write('id: $id, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $UsersTable extends Users with TableInfo<$UsersTable, UserDataModel> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $UsersTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    clientDefault: () => _uuid.v4(),
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [id, createdAt];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'users';
  @override
  VerificationContext validateIntegrity(
    Insertable<UserDataModel> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  UserDataModel map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return UserDataModel(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
    );
  }

  @override
  $UsersTable createAlias(String alias) {
    return $UsersTable(attachedDatabase, alias);
  }
}

class UserDataModel extends DataClass implements Insertable<UserDataModel> {
  final String id;
  final DateTime createdAt;
  const UserDataModel({required this.id, required this.createdAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['created_at'] = Variable<DateTime>(createdAt);
    return map;
  }

  UsersCompanion toCompanion(bool nullToAbsent) {
    return UsersCompanion(id: Value(id), createdAt: Value(createdAt));
  }

  factory UserDataModel.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return UserDataModel(
      id: serializer.fromJson<String>(json['id']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  UserDataModel copyWith({String? id, DateTime? createdAt}) =>
      UserDataModel(id: id ?? this.id, createdAt: createdAt ?? this.createdAt);
  UserDataModel copyWithCompanion(UsersCompanion data) {
    return UserDataModel(
      id: data.id.present ? data.id.value : this.id,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('UserDataModel(')
          ..write('id: $id, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, createdAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) || (other is UserDataModel && other.id == this.id && other.createdAt == this.createdAt);
}

class UsersCompanion extends UpdateCompanion<UserDataModel> {
  final Value<String> id;
  final Value<DateTime> createdAt;
  final Value<int> rowid;
  const UsersCompanion({
    this.id = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  UsersCompanion.insert({
    this.id = const Value.absent(),
    required DateTime createdAt,
    this.rowid = const Value.absent(),
  }) : createdAt = Value(createdAt);
  static Insertable<UserDataModel> custom({
    Expression<String>? id,
    Expression<DateTime>? createdAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (createdAt != null) 'created_at': createdAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  UsersCompanion copyWith({
    Value<String>? id,
    Value<DateTime>? createdAt,
    Value<int>? rowid,
  }) {
    return UsersCompanion(
      id: id ?? this.id,
      createdAt: createdAt ?? this.createdAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('UsersCompanion(')
          ..write('id: $id, ')
          ..write('createdAt: $createdAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $BudgetsTable extends Budgets with TableInfo<$BudgetsTable, BudgetDataModel> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $BudgetsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    clientDefault: () => _uuid.v4(),
  );
  static const VerificationMeta _titleMeta = const VerificationMeta('title');
  @override
  late final GeneratedColumn<String> title = GeneratedColumn<String>(
    'title',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _descriptionMeta = const VerificationMeta(
    'description',
  );
  @override
  late final GeneratedColumn<String> description = GeneratedColumn<String>(
    'description',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _indexMeta = const VerificationMeta('index');
  @override
  late final GeneratedColumn<int> index = GeneratedColumn<int>(
    'index',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _amountMeta = const VerificationMeta('amount');
  @override
  late final GeneratedColumn<int> amount = GeneratedColumn<int>(
    'amount',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _activeMeta = const VerificationMeta('active');
  @override
  late final GeneratedColumn<bool> active = GeneratedColumn<bool>(
    'active',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("active" IN (0, 1))',
    ),
  );
  static const VerificationMeta _startedAtMeta = const VerificationMeta(
    'startedAt',
  );
  @override
  late final GeneratedColumn<DateTime> startedAt = GeneratedColumn<DateTime>(
    'started_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _endedAtMeta = const VerificationMeta(
    'endedAt',
  );
  @override
  late final GeneratedColumn<DateTime> endedAt = GeneratedColumn<DateTime>(
    'ended_at',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    title,
    description,
    createdAt,
    updatedAt,
    index,
    amount,
    active,
    startedAt,
    endedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'budgets';
  @override
  VerificationContext validateIntegrity(
    Insertable<BudgetDataModel> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('title')) {
      context.handle(
        _titleMeta,
        title.isAcceptableOrUnknown(data['title']!, _titleMeta),
      );
    } else if (isInserting) {
      context.missing(_titleMeta);
    }
    if (data.containsKey('description')) {
      context.handle(
        _descriptionMeta,
        description.isAcceptableOrUnknown(
          data['description']!,
          _descriptionMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_descriptionMeta);
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    }
    if (data.containsKey('index')) {
      context.handle(
        _indexMeta,
        index.isAcceptableOrUnknown(data['index']!, _indexMeta),
      );
    } else if (isInserting) {
      context.missing(_indexMeta);
    }
    if (data.containsKey('amount')) {
      context.handle(
        _amountMeta,
        amount.isAcceptableOrUnknown(data['amount']!, _amountMeta),
      );
    } else if (isInserting) {
      context.missing(_amountMeta);
    }
    if (data.containsKey('active')) {
      context.handle(
        _activeMeta,
        active.isAcceptableOrUnknown(data['active']!, _activeMeta),
      );
    } else if (isInserting) {
      context.missing(_activeMeta);
    }
    if (data.containsKey('started_at')) {
      context.handle(
        _startedAtMeta,
        startedAt.isAcceptableOrUnknown(data['started_at']!, _startedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_startedAtMeta);
    }
    if (data.containsKey('ended_at')) {
      context.handle(
        _endedAtMeta,
        endedAt.isAcceptableOrUnknown(data['ended_at']!, _endedAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  BudgetDataModel map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return BudgetDataModel(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      title: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}title'],
      )!,
      description: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}description'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      ),
      index: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}index'],
      )!,
      amount: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}amount'],
      )!,
      active: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}active'],
      )!,
      startedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}started_at'],
      )!,
      endedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}ended_at'],
      ),
    );
  }

  @override
  $BudgetsTable createAlias(String alias) {
    return $BudgetsTable(attachedDatabase, alias);
  }
}

class BudgetDataModel extends DataClass implements Insertable<BudgetDataModel> {
  final String id;
  final String title;
  final String description;
  final DateTime createdAt;
  final DateTime? updatedAt;
  final int index;
  final int amount;
  final bool active;
  final DateTime startedAt;
  final DateTime? endedAt;
  const BudgetDataModel({
    required this.id,
    required this.title,
    required this.description,
    required this.createdAt,
    this.updatedAt,
    required this.index,
    required this.amount,
    required this.active,
    required this.startedAt,
    this.endedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['title'] = Variable<String>(title);
    map['description'] = Variable<String>(description);
    map['created_at'] = Variable<DateTime>(createdAt);
    if (!nullToAbsent || updatedAt != null) {
      map['updated_at'] = Variable<DateTime>(updatedAt);
    }
    map['index'] = Variable<int>(index);
    map['amount'] = Variable<int>(amount);
    map['active'] = Variable<bool>(active);
    map['started_at'] = Variable<DateTime>(startedAt);
    if (!nullToAbsent || endedAt != null) {
      map['ended_at'] = Variable<DateTime>(endedAt);
    }
    return map;
  }

  BudgetsCompanion toCompanion(bool nullToAbsent) {
    return BudgetsCompanion(
      id: Value(id),
      title: Value(title),
      description: Value(description),
      createdAt: Value(createdAt),
      updatedAt: updatedAt == null && nullToAbsent ? const Value.absent() : Value(updatedAt),
      index: Value(index),
      amount: Value(amount),
      active: Value(active),
      startedAt: Value(startedAt),
      endedAt: endedAt == null && nullToAbsent ? const Value.absent() : Value(endedAt),
    );
  }

  factory BudgetDataModel.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return BudgetDataModel(
      id: serializer.fromJson<String>(json['id']),
      title: serializer.fromJson<String>(json['title']),
      description: serializer.fromJson<String>(json['description']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime?>(json['updatedAt']),
      index: serializer.fromJson<int>(json['index']),
      amount: serializer.fromJson<int>(json['amount']),
      active: serializer.fromJson<bool>(json['active']),
      startedAt: serializer.fromJson<DateTime>(json['startedAt']),
      endedAt: serializer.fromJson<DateTime?>(json['endedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'title': serializer.toJson<String>(title),
      'description': serializer.toJson<String>(description),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime?>(updatedAt),
      'index': serializer.toJson<int>(index),
      'amount': serializer.toJson<int>(amount),
      'active': serializer.toJson<bool>(active),
      'startedAt': serializer.toJson<DateTime>(startedAt),
      'endedAt': serializer.toJson<DateTime?>(endedAt),
    };
  }

  BudgetDataModel copyWith({
    String? id,
    String? title,
    String? description,
    DateTime? createdAt,
    Value<DateTime?> updatedAt = const Value.absent(),
    int? index,
    int? amount,
    bool? active,
    DateTime? startedAt,
    Value<DateTime?> endedAt = const Value.absent(),
  }) => BudgetDataModel(
    id: id ?? this.id,
    title: title ?? this.title,
    description: description ?? this.description,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt.present ? updatedAt.value : this.updatedAt,
    index: index ?? this.index,
    amount: amount ?? this.amount,
    active: active ?? this.active,
    startedAt: startedAt ?? this.startedAt,
    endedAt: endedAt.present ? endedAt.value : this.endedAt,
  );
  BudgetDataModel copyWithCompanion(BudgetsCompanion data) {
    return BudgetDataModel(
      id: data.id.present ? data.id.value : this.id,
      title: data.title.present ? data.title.value : this.title,
      description: data.description.present ? data.description.value : this.description,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
      index: data.index.present ? data.index.value : this.index,
      amount: data.amount.present ? data.amount.value : this.amount,
      active: data.active.present ? data.active.value : this.active,
      startedAt: data.startedAt.present ? data.startedAt.value : this.startedAt,
      endedAt: data.endedAt.present ? data.endedAt.value : this.endedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('BudgetDataModel(')
          ..write('id: $id, ')
          ..write('title: $title, ')
          ..write('description: $description, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('index: $index, ')
          ..write('amount: $amount, ')
          ..write('active: $active, ')
          ..write('startedAt: $startedAt, ')
          ..write('endedAt: $endedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    title,
    description,
    createdAt,
    updatedAt,
    index,
    amount,
    active,
    startedAt,
    endedAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is BudgetDataModel &&
          other.id == this.id &&
          other.title == this.title &&
          other.description == this.description &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt &&
          other.index == this.index &&
          other.amount == this.amount &&
          other.active == this.active &&
          other.startedAt == this.startedAt &&
          other.endedAt == this.endedAt);
}

class BudgetsCompanion extends UpdateCompanion<BudgetDataModel> {
  final Value<String> id;
  final Value<String> title;
  final Value<String> description;
  final Value<DateTime> createdAt;
  final Value<DateTime?> updatedAt;
  final Value<int> index;
  final Value<int> amount;
  final Value<bool> active;
  final Value<DateTime> startedAt;
  final Value<DateTime?> endedAt;
  final Value<int> rowid;
  const BudgetsCompanion({
    this.id = const Value.absent(),
    this.title = const Value.absent(),
    this.description = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.index = const Value.absent(),
    this.amount = const Value.absent(),
    this.active = const Value.absent(),
    this.startedAt = const Value.absent(),
    this.endedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  BudgetsCompanion.insert({
    this.id = const Value.absent(),
    required String title,
    required String description,
    required DateTime createdAt,
    this.updatedAt = const Value.absent(),
    required int index,
    required int amount,
    required bool active,
    required DateTime startedAt,
    this.endedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : title = Value(title),
       description = Value(description),
       createdAt = Value(createdAt),
       index = Value(index),
       amount = Value(amount),
       active = Value(active),
       startedAt = Value(startedAt);
  static Insertable<BudgetDataModel> custom({
    Expression<String>? id,
    Expression<String>? title,
    Expression<String>? description,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<int>? index,
    Expression<int>? amount,
    Expression<bool>? active,
    Expression<DateTime>? startedAt,
    Expression<DateTime>? endedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (title != null) 'title': title,
      if (description != null) 'description': description,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (index != null) 'index': index,
      if (amount != null) 'amount': amount,
      if (active != null) 'active': active,
      if (startedAt != null) 'started_at': startedAt,
      if (endedAt != null) 'ended_at': endedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  BudgetsCompanion copyWith({
    Value<String>? id,
    Value<String>? title,
    Value<String>? description,
    Value<DateTime>? createdAt,
    Value<DateTime?>? updatedAt,
    Value<int>? index,
    Value<int>? amount,
    Value<bool>? active,
    Value<DateTime>? startedAt,
    Value<DateTime?>? endedAt,
    Value<int>? rowid,
  }) {
    return BudgetsCompanion(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      index: index ?? this.index,
      amount: amount ?? this.amount,
      active: active ?? this.active,
      startedAt: startedAt ?? this.startedAt,
      endedAt: endedAt ?? this.endedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (title.present) {
      map['title'] = Variable<String>(title.value);
    }
    if (description.present) {
      map['description'] = Variable<String>(description.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (index.present) {
      map['index'] = Variable<int>(index.value);
    }
    if (amount.present) {
      map['amount'] = Variable<int>(amount.value);
    }
    if (active.present) {
      map['active'] = Variable<bool>(active.value);
    }
    if (startedAt.present) {
      map['started_at'] = Variable<DateTime>(startedAt.value);
    }
    if (endedAt.present) {
      map['ended_at'] = Variable<DateTime>(endedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('BudgetsCompanion(')
          ..write('id: $id, ')
          ..write('title: $title, ')
          ..write('description: $description, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('index: $index, ')
          ..write('amount: $amount, ')
          ..write('active: $active, ')
          ..write('startedAt: $startedAt, ')
          ..write('endedAt: $endedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $BudgetCategoriesTable extends BudgetCategories with TableInfo<$BudgetCategoriesTable, BudgetCategoryDataModel> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $BudgetCategoriesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    clientDefault: () => _uuid.v4(),
  );
  static const VerificationMeta _titleMeta = const VerificationMeta('title');
  @override
  late final GeneratedColumn<String> title = GeneratedColumn<String>(
    'title',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _descriptionMeta = const VerificationMeta(
    'description',
  );
  @override
  late final GeneratedColumn<String> description = GeneratedColumn<String>(
    'description',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _iconIndexMeta = const VerificationMeta(
    'iconIndex',
  );
  @override
  late final GeneratedColumn<int> iconIndex = GeneratedColumn<int>(
    'icon_index',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _colorSchemeIndexMeta = const VerificationMeta(
    'colorSchemeIndex',
  );
  @override
  late final GeneratedColumn<int> colorSchemeIndex = GeneratedColumn<int>(
    'color_scheme_index',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    title,
    description,
    createdAt,
    updatedAt,
    iconIndex,
    colorSchemeIndex,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'budget_categories';
  @override
  VerificationContext validateIntegrity(
    Insertable<BudgetCategoryDataModel> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('title')) {
      context.handle(
        _titleMeta,
        title.isAcceptableOrUnknown(data['title']!, _titleMeta),
      );
    } else if (isInserting) {
      context.missing(_titleMeta);
    }
    if (data.containsKey('description')) {
      context.handle(
        _descriptionMeta,
        description.isAcceptableOrUnknown(
          data['description']!,
          _descriptionMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_descriptionMeta);
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    }
    if (data.containsKey('icon_index')) {
      context.handle(
        _iconIndexMeta,
        iconIndex.isAcceptableOrUnknown(data['icon_index']!, _iconIndexMeta),
      );
    } else if (isInserting) {
      context.missing(_iconIndexMeta);
    }
    if (data.containsKey('color_scheme_index')) {
      context.handle(
        _colorSchemeIndexMeta,
        colorSchemeIndex.isAcceptableOrUnknown(
          data['color_scheme_index']!,
          _colorSchemeIndexMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_colorSchemeIndexMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  BudgetCategoryDataModel map(
    Map<String, dynamic> data, {
    String? tablePrefix,
  }) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return BudgetCategoryDataModel(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      title: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}title'],
      )!,
      description: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}description'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      ),
      iconIndex: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}icon_index'],
      )!,
      colorSchemeIndex: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}color_scheme_index'],
      )!,
    );
  }

  @override
  $BudgetCategoriesTable createAlias(String alias) {
    return $BudgetCategoriesTable(attachedDatabase, alias);
  }
}

class BudgetCategoryDataModel extends DataClass implements Insertable<BudgetCategoryDataModel> {
  final String id;
  final String title;
  final String description;
  final DateTime createdAt;
  final DateTime? updatedAt;
  final int iconIndex;
  final int colorSchemeIndex;
  const BudgetCategoryDataModel({
    required this.id,
    required this.title,
    required this.description,
    required this.createdAt,
    this.updatedAt,
    required this.iconIndex,
    required this.colorSchemeIndex,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['title'] = Variable<String>(title);
    map['description'] = Variable<String>(description);
    map['created_at'] = Variable<DateTime>(createdAt);
    if (!nullToAbsent || updatedAt != null) {
      map['updated_at'] = Variable<DateTime>(updatedAt);
    }
    map['icon_index'] = Variable<int>(iconIndex);
    map['color_scheme_index'] = Variable<int>(colorSchemeIndex);
    return map;
  }

  BudgetCategoriesCompanion toCompanion(bool nullToAbsent) {
    return BudgetCategoriesCompanion(
      id: Value(id),
      title: Value(title),
      description: Value(description),
      createdAt: Value(createdAt),
      updatedAt: updatedAt == null && nullToAbsent ? const Value.absent() : Value(updatedAt),
      iconIndex: Value(iconIndex),
      colorSchemeIndex: Value(colorSchemeIndex),
    );
  }

  factory BudgetCategoryDataModel.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return BudgetCategoryDataModel(
      id: serializer.fromJson<String>(json['id']),
      title: serializer.fromJson<String>(json['title']),
      description: serializer.fromJson<String>(json['description']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime?>(json['updatedAt']),
      iconIndex: serializer.fromJson<int>(json['iconIndex']),
      colorSchemeIndex: serializer.fromJson<int>(json['colorSchemeIndex']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'title': serializer.toJson<String>(title),
      'description': serializer.toJson<String>(description),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime?>(updatedAt),
      'iconIndex': serializer.toJson<int>(iconIndex),
      'colorSchemeIndex': serializer.toJson<int>(colorSchemeIndex),
    };
  }

  BudgetCategoryDataModel copyWith({
    String? id,
    String? title,
    String? description,
    DateTime? createdAt,
    Value<DateTime?> updatedAt = const Value.absent(),
    int? iconIndex,
    int? colorSchemeIndex,
  }) => BudgetCategoryDataModel(
    id: id ?? this.id,
    title: title ?? this.title,
    description: description ?? this.description,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt.present ? updatedAt.value : this.updatedAt,
    iconIndex: iconIndex ?? this.iconIndex,
    colorSchemeIndex: colorSchemeIndex ?? this.colorSchemeIndex,
  );
  BudgetCategoryDataModel copyWithCompanion(BudgetCategoriesCompanion data) {
    return BudgetCategoryDataModel(
      id: data.id.present ? data.id.value : this.id,
      title: data.title.present ? data.title.value : this.title,
      description: data.description.present ? data.description.value : this.description,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
      iconIndex: data.iconIndex.present ? data.iconIndex.value : this.iconIndex,
      colorSchemeIndex: data.colorSchemeIndex.present ? data.colorSchemeIndex.value : this.colorSchemeIndex,
    );
  }

  @override
  String toString() {
    return (StringBuffer('BudgetCategoryDataModel(')
          ..write('id: $id, ')
          ..write('title: $title, ')
          ..write('description: $description, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('iconIndex: $iconIndex, ')
          ..write('colorSchemeIndex: $colorSchemeIndex')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    title,
    description,
    createdAt,
    updatedAt,
    iconIndex,
    colorSchemeIndex,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is BudgetCategoryDataModel &&
          other.id == this.id &&
          other.title == this.title &&
          other.description == this.description &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt &&
          other.iconIndex == this.iconIndex &&
          other.colorSchemeIndex == this.colorSchemeIndex);
}

class BudgetCategoriesCompanion extends UpdateCompanion<BudgetCategoryDataModel> {
  final Value<String> id;
  final Value<String> title;
  final Value<String> description;
  final Value<DateTime> createdAt;
  final Value<DateTime?> updatedAt;
  final Value<int> iconIndex;
  final Value<int> colorSchemeIndex;
  final Value<int> rowid;
  const BudgetCategoriesCompanion({
    this.id = const Value.absent(),
    this.title = const Value.absent(),
    this.description = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.iconIndex = const Value.absent(),
    this.colorSchemeIndex = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  BudgetCategoriesCompanion.insert({
    this.id = const Value.absent(),
    required String title,
    required String description,
    required DateTime createdAt,
    this.updatedAt = const Value.absent(),
    required int iconIndex,
    required int colorSchemeIndex,
    this.rowid = const Value.absent(),
  }) : title = Value(title),
       description = Value(description),
       createdAt = Value(createdAt),
       iconIndex = Value(iconIndex),
       colorSchemeIndex = Value(colorSchemeIndex);
  static Insertable<BudgetCategoryDataModel> custom({
    Expression<String>? id,
    Expression<String>? title,
    Expression<String>? description,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<int>? iconIndex,
    Expression<int>? colorSchemeIndex,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (title != null) 'title': title,
      if (description != null) 'description': description,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (iconIndex != null) 'icon_index': iconIndex,
      if (colorSchemeIndex != null) 'color_scheme_index': colorSchemeIndex,
      if (rowid != null) 'rowid': rowid,
    });
  }

  BudgetCategoriesCompanion copyWith({
    Value<String>? id,
    Value<String>? title,
    Value<String>? description,
    Value<DateTime>? createdAt,
    Value<DateTime?>? updatedAt,
    Value<int>? iconIndex,
    Value<int>? colorSchemeIndex,
    Value<int>? rowid,
  }) {
    return BudgetCategoriesCompanion(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      iconIndex: iconIndex ?? this.iconIndex,
      colorSchemeIndex: colorSchemeIndex ?? this.colorSchemeIndex,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (title.present) {
      map['title'] = Variable<String>(title.value);
    }
    if (description.present) {
      map['description'] = Variable<String>(description.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (iconIndex.present) {
      map['icon_index'] = Variable<int>(iconIndex.value);
    }
    if (colorSchemeIndex.present) {
      map['color_scheme_index'] = Variable<int>(colorSchemeIndex.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('BudgetCategoriesCompanion(')
          ..write('id: $id, ')
          ..write('title: $title, ')
          ..write('description: $description, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('iconIndex: $iconIndex, ')
          ..write('colorSchemeIndex: $colorSchemeIndex, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $BudgetPlansTable extends BudgetPlans with TableInfo<$BudgetPlansTable, BudgetPlanDataModel> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $BudgetPlansTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    clientDefault: () => _uuid.v4(),
  );
  static const VerificationMeta _titleMeta = const VerificationMeta('title');
  @override
  late final GeneratedColumn<String> title = GeneratedColumn<String>(
    'title',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _descriptionMeta = const VerificationMeta(
    'description',
  );
  @override
  late final GeneratedColumn<String> description = GeneratedColumn<String>(
    'description',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _categoryMeta = const VerificationMeta(
    'category',
  );
  @override
  late final GeneratedColumn<String> category = GeneratedColumn<String>(
    'category',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES budget_categories (id)',
    ),
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    title,
    description,
    createdAt,
    updatedAt,
    category,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'budget_plans';
  @override
  VerificationContext validateIntegrity(
    Insertable<BudgetPlanDataModel> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('title')) {
      context.handle(
        _titleMeta,
        title.isAcceptableOrUnknown(data['title']!, _titleMeta),
      );
    } else if (isInserting) {
      context.missing(_titleMeta);
    }
    if (data.containsKey('description')) {
      context.handle(
        _descriptionMeta,
        description.isAcceptableOrUnknown(
          data['description']!,
          _descriptionMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_descriptionMeta);
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    }
    if (data.containsKey('category')) {
      context.handle(
        _categoryMeta,
        category.isAcceptableOrUnknown(data['category']!, _categoryMeta),
      );
    } else if (isInserting) {
      context.missing(_categoryMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  BudgetPlanDataModel map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return BudgetPlanDataModel(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      title: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}title'],
      )!,
      description: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}description'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      ),
      category: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}category'],
      )!,
    );
  }

  @override
  $BudgetPlansTable createAlias(String alias) {
    return $BudgetPlansTable(attachedDatabase, alias);
  }
}

class BudgetPlanDataModel extends DataClass implements Insertable<BudgetPlanDataModel> {
  final String id;
  final String title;
  final String description;
  final DateTime createdAt;
  final DateTime? updatedAt;
  final String category;
  const BudgetPlanDataModel({
    required this.id,
    required this.title,
    required this.description,
    required this.createdAt,
    this.updatedAt,
    required this.category,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['title'] = Variable<String>(title);
    map['description'] = Variable<String>(description);
    map['created_at'] = Variable<DateTime>(createdAt);
    if (!nullToAbsent || updatedAt != null) {
      map['updated_at'] = Variable<DateTime>(updatedAt);
    }
    map['category'] = Variable<String>(category);
    return map;
  }

  BudgetPlansCompanion toCompanion(bool nullToAbsent) {
    return BudgetPlansCompanion(
      id: Value(id),
      title: Value(title),
      description: Value(description),
      createdAt: Value(createdAt),
      updatedAt: updatedAt == null && nullToAbsent ? const Value.absent() : Value(updatedAt),
      category: Value(category),
    );
  }

  factory BudgetPlanDataModel.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return BudgetPlanDataModel(
      id: serializer.fromJson<String>(json['id']),
      title: serializer.fromJson<String>(json['title']),
      description: serializer.fromJson<String>(json['description']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime?>(json['updatedAt']),
      category: serializer.fromJson<String>(json['category']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'title': serializer.toJson<String>(title),
      'description': serializer.toJson<String>(description),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime?>(updatedAt),
      'category': serializer.toJson<String>(category),
    };
  }

  BudgetPlanDataModel copyWith({
    String? id,
    String? title,
    String? description,
    DateTime? createdAt,
    Value<DateTime?> updatedAt = const Value.absent(),
    String? category,
  }) => BudgetPlanDataModel(
    id: id ?? this.id,
    title: title ?? this.title,
    description: description ?? this.description,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt.present ? updatedAt.value : this.updatedAt,
    category: category ?? this.category,
  );
  BudgetPlanDataModel copyWithCompanion(BudgetPlansCompanion data) {
    return BudgetPlanDataModel(
      id: data.id.present ? data.id.value : this.id,
      title: data.title.present ? data.title.value : this.title,
      description: data.description.present ? data.description.value : this.description,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
      category: data.category.present ? data.category.value : this.category,
    );
  }

  @override
  String toString() {
    return (StringBuffer('BudgetPlanDataModel(')
          ..write('id: $id, ')
          ..write('title: $title, ')
          ..write('description: $description, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('category: $category')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, title, description, createdAt, updatedAt, category);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is BudgetPlanDataModel &&
          other.id == this.id &&
          other.title == this.title &&
          other.description == this.description &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt &&
          other.category == this.category);
}

class BudgetPlansCompanion extends UpdateCompanion<BudgetPlanDataModel> {
  final Value<String> id;
  final Value<String> title;
  final Value<String> description;
  final Value<DateTime> createdAt;
  final Value<DateTime?> updatedAt;
  final Value<String> category;
  final Value<int> rowid;
  const BudgetPlansCompanion({
    this.id = const Value.absent(),
    this.title = const Value.absent(),
    this.description = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.category = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  BudgetPlansCompanion.insert({
    this.id = const Value.absent(),
    required String title,
    required String description,
    required DateTime createdAt,
    this.updatedAt = const Value.absent(),
    required String category,
    this.rowid = const Value.absent(),
  }) : title = Value(title),
       description = Value(description),
       createdAt = Value(createdAt),
       category = Value(category);
  static Insertable<BudgetPlanDataModel> custom({
    Expression<String>? id,
    Expression<String>? title,
    Expression<String>? description,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<String>? category,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (title != null) 'title': title,
      if (description != null) 'description': description,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (category != null) 'category': category,
      if (rowid != null) 'rowid': rowid,
    });
  }

  BudgetPlansCompanion copyWith({
    Value<String>? id,
    Value<String>? title,
    Value<String>? description,
    Value<DateTime>? createdAt,
    Value<DateTime?>? updatedAt,
    Value<String>? category,
    Value<int>? rowid,
  }) {
    return BudgetPlansCompanion(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      category: category ?? this.category,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (title.present) {
      map['title'] = Variable<String>(title.value);
    }
    if (description.present) {
      map['description'] = Variable<String>(description.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (category.present) {
      map['category'] = Variable<String>(category.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('BudgetPlansCompanion(')
          ..write('id: $id, ')
          ..write('title: $title, ')
          ..write('description: $description, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('category: $category, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $BudgetAllocationsTable extends BudgetAllocations
    with TableInfo<$BudgetAllocationsTable, BudgetAllocationDataModel> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $BudgetAllocationsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    clientDefault: () => _uuid.v4(),
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _amountMeta = const VerificationMeta('amount');
  @override
  late final GeneratedColumn<int> amount = GeneratedColumn<int>(
    'amount',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _budgetMeta = const VerificationMeta('budget');
  @override
  late final GeneratedColumn<String> budget = GeneratedColumn<String>(
    'budget',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES budgets (id)',
    ),
  );
  static const VerificationMeta _planMeta = const VerificationMeta('plan');
  @override
  late final GeneratedColumn<String> plan = GeneratedColumn<String>(
    'plan',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES budget_plans (id)',
    ),
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    createdAt,
    updatedAt,
    amount,
    budget,
    plan,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'budget_allocations';
  @override
  VerificationContext validateIntegrity(
    Insertable<BudgetAllocationDataModel> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    }
    if (data.containsKey('amount')) {
      context.handle(
        _amountMeta,
        amount.isAcceptableOrUnknown(data['amount']!, _amountMeta),
      );
    } else if (isInserting) {
      context.missing(_amountMeta);
    }
    if (data.containsKey('budget')) {
      context.handle(
        _budgetMeta,
        budget.isAcceptableOrUnknown(data['budget']!, _budgetMeta),
      );
    } else if (isInserting) {
      context.missing(_budgetMeta);
    }
    if (data.containsKey('plan')) {
      context.handle(
        _planMeta,
        plan.isAcceptableOrUnknown(data['plan']!, _planMeta),
      );
    } else if (isInserting) {
      context.missing(_planMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  BudgetAllocationDataModel map(
    Map<String, dynamic> data, {
    String? tablePrefix,
  }) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return BudgetAllocationDataModel(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      ),
      amount: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}amount'],
      )!,
      budget: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}budget'],
      )!,
      plan: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}plan'],
      )!,
    );
  }

  @override
  $BudgetAllocationsTable createAlias(String alias) {
    return $BudgetAllocationsTable(attachedDatabase, alias);
  }
}

class BudgetAllocationDataModel extends DataClass implements Insertable<BudgetAllocationDataModel> {
  final String id;
  final DateTime createdAt;
  final DateTime? updatedAt;
  final int amount;
  final String budget;
  final String plan;
  const BudgetAllocationDataModel({
    required this.id,
    required this.createdAt,
    this.updatedAt,
    required this.amount,
    required this.budget,
    required this.plan,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['created_at'] = Variable<DateTime>(createdAt);
    if (!nullToAbsent || updatedAt != null) {
      map['updated_at'] = Variable<DateTime>(updatedAt);
    }
    map['amount'] = Variable<int>(amount);
    map['budget'] = Variable<String>(budget);
    map['plan'] = Variable<String>(plan);
    return map;
  }

  BudgetAllocationsCompanion toCompanion(bool nullToAbsent) {
    return BudgetAllocationsCompanion(
      id: Value(id),
      createdAt: Value(createdAt),
      updatedAt: updatedAt == null && nullToAbsent ? const Value.absent() : Value(updatedAt),
      amount: Value(amount),
      budget: Value(budget),
      plan: Value(plan),
    );
  }

  factory BudgetAllocationDataModel.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return BudgetAllocationDataModel(
      id: serializer.fromJson<String>(json['id']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime?>(json['updatedAt']),
      amount: serializer.fromJson<int>(json['amount']),
      budget: serializer.fromJson<String>(json['budget']),
      plan: serializer.fromJson<String>(json['plan']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime?>(updatedAt),
      'amount': serializer.toJson<int>(amount),
      'budget': serializer.toJson<String>(budget),
      'plan': serializer.toJson<String>(plan),
    };
  }

  BudgetAllocationDataModel copyWith({
    String? id,
    DateTime? createdAt,
    Value<DateTime?> updatedAt = const Value.absent(),
    int? amount,
    String? budget,
    String? plan,
  }) => BudgetAllocationDataModel(
    id: id ?? this.id,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt.present ? updatedAt.value : this.updatedAt,
    amount: amount ?? this.amount,
    budget: budget ?? this.budget,
    plan: plan ?? this.plan,
  );
  BudgetAllocationDataModel copyWithCompanion(BudgetAllocationsCompanion data) {
    return BudgetAllocationDataModel(
      id: data.id.present ? data.id.value : this.id,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
      amount: data.amount.present ? data.amount.value : this.amount,
      budget: data.budget.present ? data.budget.value : this.budget,
      plan: data.plan.present ? data.plan.value : this.plan,
    );
  }

  @override
  String toString() {
    return (StringBuffer('BudgetAllocationDataModel(')
          ..write('id: $id, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('amount: $amount, ')
          ..write('budget: $budget, ')
          ..write('plan: $plan')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, createdAt, updatedAt, amount, budget, plan);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is BudgetAllocationDataModel &&
          other.id == this.id &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt &&
          other.amount == this.amount &&
          other.budget == this.budget &&
          other.plan == this.plan);
}

class BudgetAllocationsCompanion extends UpdateCompanion<BudgetAllocationDataModel> {
  final Value<String> id;
  final Value<DateTime> createdAt;
  final Value<DateTime?> updatedAt;
  final Value<int> amount;
  final Value<String> budget;
  final Value<String> plan;
  final Value<int> rowid;
  const BudgetAllocationsCompanion({
    this.id = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.amount = const Value.absent(),
    this.budget = const Value.absent(),
    this.plan = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  BudgetAllocationsCompanion.insert({
    this.id = const Value.absent(),
    required DateTime createdAt,
    this.updatedAt = const Value.absent(),
    required int amount,
    required String budget,
    required String plan,
    this.rowid = const Value.absent(),
  }) : createdAt = Value(createdAt),
       amount = Value(amount),
       budget = Value(budget),
       plan = Value(plan);
  static Insertable<BudgetAllocationDataModel> custom({
    Expression<String>? id,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<int>? amount,
    Expression<String>? budget,
    Expression<String>? plan,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (amount != null) 'amount': amount,
      if (budget != null) 'budget': budget,
      if (plan != null) 'plan': plan,
      if (rowid != null) 'rowid': rowid,
    });
  }

  BudgetAllocationsCompanion copyWith({
    Value<String>? id,
    Value<DateTime>? createdAt,
    Value<DateTime?>? updatedAt,
    Value<int>? amount,
    Value<String>? budget,
    Value<String>? plan,
    Value<int>? rowid,
  }) {
    return BudgetAllocationsCompanion(
      id: id ?? this.id,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      amount: amount ?? this.amount,
      budget: budget ?? this.budget,
      plan: plan ?? this.plan,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (amount.present) {
      map['amount'] = Variable<int>(amount.value);
    }
    if (budget.present) {
      map['budget'] = Variable<String>(budget.value);
    }
    if (plan.present) {
      map['plan'] = Variable<String>(plan.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('BudgetAllocationsCompanion(')
          ..write('id: $id, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('amount: $amount, ')
          ..write('budget: $budget, ')
          ..write('plan: $plan, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $BudgetMetadataKeysTable extends BudgetMetadataKeys
    with TableInfo<$BudgetMetadataKeysTable, BudgetMetadataKeyDataModel> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $BudgetMetadataKeysTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    clientDefault: () => _uuid.v4(),
  );
  static const VerificationMeta _titleMeta = const VerificationMeta('title');
  @override
  late final GeneratedColumn<String> title = GeneratedColumn<String>(
    'title',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _descriptionMeta = const VerificationMeta(
    'description',
  );
  @override
  late final GeneratedColumn<String> description = GeneratedColumn<String>(
    'description',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    title,
    description,
    createdAt,
    updatedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'budget_metadata_keys';
  @override
  VerificationContext validateIntegrity(
    Insertable<BudgetMetadataKeyDataModel> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('title')) {
      context.handle(
        _titleMeta,
        title.isAcceptableOrUnknown(data['title']!, _titleMeta),
      );
    } else if (isInserting) {
      context.missing(_titleMeta);
    }
    if (data.containsKey('description')) {
      context.handle(
        _descriptionMeta,
        description.isAcceptableOrUnknown(
          data['description']!,
          _descriptionMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_descriptionMeta);
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  BudgetMetadataKeyDataModel map(
    Map<String, dynamic> data, {
    String? tablePrefix,
  }) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return BudgetMetadataKeyDataModel(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      title: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}title'],
      )!,
      description: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}description'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      ),
    );
  }

  @override
  $BudgetMetadataKeysTable createAlias(String alias) {
    return $BudgetMetadataKeysTable(attachedDatabase, alias);
  }
}

class BudgetMetadataKeyDataModel extends DataClass implements Insertable<BudgetMetadataKeyDataModel> {
  final String id;
  final String title;
  final String description;
  final DateTime createdAt;
  final DateTime? updatedAt;
  const BudgetMetadataKeyDataModel({
    required this.id,
    required this.title,
    required this.description,
    required this.createdAt,
    this.updatedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['title'] = Variable<String>(title);
    map['description'] = Variable<String>(description);
    map['created_at'] = Variable<DateTime>(createdAt);
    if (!nullToAbsent || updatedAt != null) {
      map['updated_at'] = Variable<DateTime>(updatedAt);
    }
    return map;
  }

  BudgetMetadataKeysCompanion toCompanion(bool nullToAbsent) {
    return BudgetMetadataKeysCompanion(
      id: Value(id),
      title: Value(title),
      description: Value(description),
      createdAt: Value(createdAt),
      updatedAt: updatedAt == null && nullToAbsent ? const Value.absent() : Value(updatedAt),
    );
  }

  factory BudgetMetadataKeyDataModel.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return BudgetMetadataKeyDataModel(
      id: serializer.fromJson<String>(json['id']),
      title: serializer.fromJson<String>(json['title']),
      description: serializer.fromJson<String>(json['description']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime?>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'title': serializer.toJson<String>(title),
      'description': serializer.toJson<String>(description),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime?>(updatedAt),
    };
  }

  BudgetMetadataKeyDataModel copyWith({
    String? id,
    String? title,
    String? description,
    DateTime? createdAt,
    Value<DateTime?> updatedAt = const Value.absent(),
  }) => BudgetMetadataKeyDataModel(
    id: id ?? this.id,
    title: title ?? this.title,
    description: description ?? this.description,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt.present ? updatedAt.value : this.updatedAt,
  );
  BudgetMetadataKeyDataModel copyWithCompanion(
    BudgetMetadataKeysCompanion data,
  ) {
    return BudgetMetadataKeyDataModel(
      id: data.id.present ? data.id.value : this.id,
      title: data.title.present ? data.title.value : this.title,
      description: data.description.present ? data.description.value : this.description,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('BudgetMetadataKeyDataModel(')
          ..write('id: $id, ')
          ..write('title: $title, ')
          ..write('description: $description, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, title, description, createdAt, updatedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is BudgetMetadataKeyDataModel &&
          other.id == this.id &&
          other.title == this.title &&
          other.description == this.description &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class BudgetMetadataKeysCompanion extends UpdateCompanion<BudgetMetadataKeyDataModel> {
  final Value<String> id;
  final Value<String> title;
  final Value<String> description;
  final Value<DateTime> createdAt;
  final Value<DateTime?> updatedAt;
  final Value<int> rowid;
  const BudgetMetadataKeysCompanion({
    this.id = const Value.absent(),
    this.title = const Value.absent(),
    this.description = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  BudgetMetadataKeysCompanion.insert({
    this.id = const Value.absent(),
    required String title,
    required String description,
    required DateTime createdAt,
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : title = Value(title),
       description = Value(description),
       createdAt = Value(createdAt);
  static Insertable<BudgetMetadataKeyDataModel> custom({
    Expression<String>? id,
    Expression<String>? title,
    Expression<String>? description,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (title != null) 'title': title,
      if (description != null) 'description': description,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  BudgetMetadataKeysCompanion copyWith({
    Value<String>? id,
    Value<String>? title,
    Value<String>? description,
    Value<DateTime>? createdAt,
    Value<DateTime?>? updatedAt,
    Value<int>? rowid,
  }) {
    return BudgetMetadataKeysCompanion(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (title.present) {
      map['title'] = Variable<String>(title.value);
    }
    if (description.present) {
      map['description'] = Variable<String>(description.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('BudgetMetadataKeysCompanion(')
          ..write('id: $id, ')
          ..write('title: $title, ')
          ..write('description: $description, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $BudgetMetadataValuesTable extends BudgetMetadataValues
    with TableInfo<$BudgetMetadataValuesTable, BudgetMetadataValueDataModel> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $BudgetMetadataValuesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    clientDefault: () => _uuid.v4(),
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _titleMeta = const VerificationMeta('title');
  @override
  late final GeneratedColumn<String> title = GeneratedColumn<String>(
    'title',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _keyMeta = const VerificationMeta('key');
  @override
  late final GeneratedColumn<String> key = GeneratedColumn<String>(
    'key',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES budget_metadata_keys (id)',
    ),
  );
  static const VerificationMeta _valueMeta = const VerificationMeta('value');
  @override
  late final GeneratedColumn<String> value = GeneratedColumn<String>(
    'value',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    createdAt,
    updatedAt,
    title,
    key,
    value,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'budget_metadata_values';
  @override
  VerificationContext validateIntegrity(
    Insertable<BudgetMetadataValueDataModel> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    }
    if (data.containsKey('title')) {
      context.handle(
        _titleMeta,
        title.isAcceptableOrUnknown(data['title']!, _titleMeta),
      );
    } else if (isInserting) {
      context.missing(_titleMeta);
    }
    if (data.containsKey('key')) {
      context.handle(
        _keyMeta,
        key.isAcceptableOrUnknown(data['key']!, _keyMeta),
      );
    } else if (isInserting) {
      context.missing(_keyMeta);
    }
    if (data.containsKey('value')) {
      context.handle(
        _valueMeta,
        value.isAcceptableOrUnknown(data['value']!, _valueMeta),
      );
    } else if (isInserting) {
      context.missing(_valueMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  BudgetMetadataValueDataModel map(
    Map<String, dynamic> data, {
    String? tablePrefix,
  }) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return BudgetMetadataValueDataModel(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      ),
      title: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}title'],
      )!,
      key: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}key'],
      )!,
      value: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}value'],
      )!,
    );
  }

  @override
  $BudgetMetadataValuesTable createAlias(String alias) {
    return $BudgetMetadataValuesTable(attachedDatabase, alias);
  }
}

class BudgetMetadataValueDataModel extends DataClass implements Insertable<BudgetMetadataValueDataModel> {
  final String id;
  final DateTime createdAt;
  final DateTime? updatedAt;
  final String title;
  final String key;
  final String value;
  const BudgetMetadataValueDataModel({
    required this.id,
    required this.createdAt,
    this.updatedAt,
    required this.title,
    required this.key,
    required this.value,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['created_at'] = Variable<DateTime>(createdAt);
    if (!nullToAbsent || updatedAt != null) {
      map['updated_at'] = Variable<DateTime>(updatedAt);
    }
    map['title'] = Variable<String>(title);
    map['key'] = Variable<String>(key);
    map['value'] = Variable<String>(value);
    return map;
  }

  BudgetMetadataValuesCompanion toCompanion(bool nullToAbsent) {
    return BudgetMetadataValuesCompanion(
      id: Value(id),
      createdAt: Value(createdAt),
      updatedAt: updatedAt == null && nullToAbsent ? const Value.absent() : Value(updatedAt),
      title: Value(title),
      key: Value(key),
      value: Value(value),
    );
  }

  factory BudgetMetadataValueDataModel.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return BudgetMetadataValueDataModel(
      id: serializer.fromJson<String>(json['id']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime?>(json['updatedAt']),
      title: serializer.fromJson<String>(json['title']),
      key: serializer.fromJson<String>(json['key']),
      value: serializer.fromJson<String>(json['value']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime?>(updatedAt),
      'title': serializer.toJson<String>(title),
      'key': serializer.toJson<String>(key),
      'value': serializer.toJson<String>(value),
    };
  }

  BudgetMetadataValueDataModel copyWith({
    String? id,
    DateTime? createdAt,
    Value<DateTime?> updatedAt = const Value.absent(),
    String? title,
    String? key,
    String? value,
  }) => BudgetMetadataValueDataModel(
    id: id ?? this.id,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt.present ? updatedAt.value : this.updatedAt,
    title: title ?? this.title,
    key: key ?? this.key,
    value: value ?? this.value,
  );
  BudgetMetadataValueDataModel copyWithCompanion(
    BudgetMetadataValuesCompanion data,
  ) {
    return BudgetMetadataValueDataModel(
      id: data.id.present ? data.id.value : this.id,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
      title: data.title.present ? data.title.value : this.title,
      key: data.key.present ? data.key.value : this.key,
      value: data.value.present ? data.value.value : this.value,
    );
  }

  @override
  String toString() {
    return (StringBuffer('BudgetMetadataValueDataModel(')
          ..write('id: $id, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('title: $title, ')
          ..write('key: $key, ')
          ..write('value: $value')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, createdAt, updatedAt, title, key, value);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is BudgetMetadataValueDataModel &&
          other.id == this.id &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt &&
          other.title == this.title &&
          other.key == this.key &&
          other.value == this.value);
}

class BudgetMetadataValuesCompanion extends UpdateCompanion<BudgetMetadataValueDataModel> {
  final Value<String> id;
  final Value<DateTime> createdAt;
  final Value<DateTime?> updatedAt;
  final Value<String> title;
  final Value<String> key;
  final Value<String> value;
  final Value<int> rowid;
  const BudgetMetadataValuesCompanion({
    this.id = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.title = const Value.absent(),
    this.key = const Value.absent(),
    this.value = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  BudgetMetadataValuesCompanion.insert({
    this.id = const Value.absent(),
    required DateTime createdAt,
    this.updatedAt = const Value.absent(),
    required String title,
    required String key,
    required String value,
    this.rowid = const Value.absent(),
  }) : createdAt = Value(createdAt),
       title = Value(title),
       key = Value(key),
       value = Value(value);
  static Insertable<BudgetMetadataValueDataModel> custom({
    Expression<String>? id,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<String>? title,
    Expression<String>? key,
    Expression<String>? value,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (title != null) 'title': title,
      if (key != null) 'key': key,
      if (value != null) 'value': value,
      if (rowid != null) 'rowid': rowid,
    });
  }

  BudgetMetadataValuesCompanion copyWith({
    Value<String>? id,
    Value<DateTime>? createdAt,
    Value<DateTime?>? updatedAt,
    Value<String>? title,
    Value<String>? key,
    Value<String>? value,
    Value<int>? rowid,
  }) {
    return BudgetMetadataValuesCompanion(
      id: id ?? this.id,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      title: title ?? this.title,
      key: key ?? this.key,
      value: value ?? this.value,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (title.present) {
      map['title'] = Variable<String>(title.value);
    }
    if (key.present) {
      map['key'] = Variable<String>(key.value);
    }
    if (value.present) {
      map['value'] = Variable<String>(value.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('BudgetMetadataValuesCompanion(')
          ..write('id: $id, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('title: $title, ')
          ..write('key: $key, ')
          ..write('value: $value, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $BudgetMetadataAssociationsTable extends BudgetMetadataAssociations
    with TableInfo<$BudgetMetadataAssociationsTable, BudgetMetadataAssociationDataModel> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $BudgetMetadataAssociationsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    clientDefault: () => _uuid.v4(),
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _planMeta = const VerificationMeta('plan');
  @override
  late final GeneratedColumn<String> plan = GeneratedColumn<String>(
    'plan',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES budget_plans (id)',
    ),
  );
  static const VerificationMeta _metadataMeta = const VerificationMeta(
    'metadata',
  );
  @override
  late final GeneratedColumn<String> metadata = GeneratedColumn<String>(
    'metadata',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES budget_metadata_values (id)',
    ),
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    createdAt,
    updatedAt,
    plan,
    metadata,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'budget_metadata_associations';
  @override
  VerificationContext validateIntegrity(
    Insertable<BudgetMetadataAssociationDataModel> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    }
    if (data.containsKey('plan')) {
      context.handle(
        _planMeta,
        plan.isAcceptableOrUnknown(data['plan']!, _planMeta),
      );
    } else if (isInserting) {
      context.missing(_planMeta);
    }
    if (data.containsKey('metadata')) {
      context.handle(
        _metadataMeta,
        metadata.isAcceptableOrUnknown(data['metadata']!, _metadataMeta),
      );
    } else if (isInserting) {
      context.missing(_metadataMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  BudgetMetadataAssociationDataModel map(
    Map<String, dynamic> data, {
    String? tablePrefix,
  }) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return BudgetMetadataAssociationDataModel(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      ),
      plan: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}plan'],
      )!,
      metadata: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}metadata'],
      )!,
    );
  }

  @override
  $BudgetMetadataAssociationsTable createAlias(String alias) {
    return $BudgetMetadataAssociationsTable(attachedDatabase, alias);
  }
}

class BudgetMetadataAssociationDataModel extends DataClass implements Insertable<BudgetMetadataAssociationDataModel> {
  final String id;
  final DateTime createdAt;
  final DateTime? updatedAt;
  final String plan;
  final String metadata;
  const BudgetMetadataAssociationDataModel({
    required this.id,
    required this.createdAt,
    this.updatedAt,
    required this.plan,
    required this.metadata,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['created_at'] = Variable<DateTime>(createdAt);
    if (!nullToAbsent || updatedAt != null) {
      map['updated_at'] = Variable<DateTime>(updatedAt);
    }
    map['plan'] = Variable<String>(plan);
    map['metadata'] = Variable<String>(metadata);
    return map;
  }

  BudgetMetadataAssociationsCompanion toCompanion(bool nullToAbsent) {
    return BudgetMetadataAssociationsCompanion(
      id: Value(id),
      createdAt: Value(createdAt),
      updatedAt: updatedAt == null && nullToAbsent ? const Value.absent() : Value(updatedAt),
      plan: Value(plan),
      metadata: Value(metadata),
    );
  }

  factory BudgetMetadataAssociationDataModel.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return BudgetMetadataAssociationDataModel(
      id: serializer.fromJson<String>(json['id']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime?>(json['updatedAt']),
      plan: serializer.fromJson<String>(json['plan']),
      metadata: serializer.fromJson<String>(json['metadata']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime?>(updatedAt),
      'plan': serializer.toJson<String>(plan),
      'metadata': serializer.toJson<String>(metadata),
    };
  }

  BudgetMetadataAssociationDataModel copyWith({
    String? id,
    DateTime? createdAt,
    Value<DateTime?> updatedAt = const Value.absent(),
    String? plan,
    String? metadata,
  }) => BudgetMetadataAssociationDataModel(
    id: id ?? this.id,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt.present ? updatedAt.value : this.updatedAt,
    plan: plan ?? this.plan,
    metadata: metadata ?? this.metadata,
  );
  BudgetMetadataAssociationDataModel copyWithCompanion(
    BudgetMetadataAssociationsCompanion data,
  ) {
    return BudgetMetadataAssociationDataModel(
      id: data.id.present ? data.id.value : this.id,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
      plan: data.plan.present ? data.plan.value : this.plan,
      metadata: data.metadata.present ? data.metadata.value : this.metadata,
    );
  }

  @override
  String toString() {
    return (StringBuffer('BudgetMetadataAssociationDataModel(')
          ..write('id: $id, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('plan: $plan, ')
          ..write('metadata: $metadata')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, createdAt, updatedAt, plan, metadata);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is BudgetMetadataAssociationDataModel &&
          other.id == this.id &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt &&
          other.plan == this.plan &&
          other.metadata == this.metadata);
}

class BudgetMetadataAssociationsCompanion extends UpdateCompanion<BudgetMetadataAssociationDataModel> {
  final Value<String> id;
  final Value<DateTime> createdAt;
  final Value<DateTime?> updatedAt;
  final Value<String> plan;
  final Value<String> metadata;
  final Value<int> rowid;
  const BudgetMetadataAssociationsCompanion({
    this.id = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.plan = const Value.absent(),
    this.metadata = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  BudgetMetadataAssociationsCompanion.insert({
    this.id = const Value.absent(),
    required DateTime createdAt,
    this.updatedAt = const Value.absent(),
    required String plan,
    required String metadata,
    this.rowid = const Value.absent(),
  }) : createdAt = Value(createdAt),
       plan = Value(plan),
       metadata = Value(metadata);
  static Insertable<BudgetMetadataAssociationDataModel> custom({
    Expression<String>? id,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<String>? plan,
    Expression<String>? metadata,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (plan != null) 'plan': plan,
      if (metadata != null) 'metadata': metadata,
      if (rowid != null) 'rowid': rowid,
    });
  }

  BudgetMetadataAssociationsCompanion copyWith({
    Value<String>? id,
    Value<DateTime>? createdAt,
    Value<DateTime?>? updatedAt,
    Value<String>? plan,
    Value<String>? metadata,
    Value<int>? rowid,
  }) {
    return BudgetMetadataAssociationsCompanion(
      id: id ?? this.id,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      plan: plan ?? this.plan,
      metadata: metadata ?? this.metadata,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (plan.present) {
      map['plan'] = Variable<String>(plan.value);
    }
    if (metadata.present) {
      map['metadata'] = Variable<String>(metadata.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('BudgetMetadataAssociationsCompanion(')
          ..write('id: $id, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('plan: $plan, ')
          ..write('metadata: $metadata, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

abstract class _$Database extends GeneratedDatabase {
  _$Database(QueryExecutor e) : super(e);
  $DatabaseManager get managers => $DatabaseManager(this);
  late final $AccountsTable accounts = $AccountsTable(this);
  late final $UsersTable users = $UsersTable(this);
  late final $BudgetsTable budgets = $BudgetsTable(this);
  late final $BudgetCategoriesTable budgetCategories = $BudgetCategoriesTable(
    this,
  );
  late final $BudgetPlansTable budgetPlans = $BudgetPlansTable(this);
  late final $BudgetAllocationsTable budgetAllocations = $BudgetAllocationsTable(this);
  late final $BudgetMetadataKeysTable budgetMetadataKeys = $BudgetMetadataKeysTable(this);
  late final $BudgetMetadataValuesTable budgetMetadataValues = $BudgetMetadataValuesTable(this);
  late final $BudgetMetadataAssociationsTable budgetMetadataAssociations = $BudgetMetadataAssociationsTable(this);
  late final AccountsDao accountsDao = AccountsDao(this as Database);
  late final UsersDao usersDao = UsersDao(this as Database);
  late final BudgetsDao budgetsDao = BudgetsDao(this as Database);
  late final BudgetPlansDao budgetPlansDao = BudgetPlansDao(this as Database);
  late final BudgetCategoriesDao budgetCategoriesDao = BudgetCategoriesDao(
    this as Database,
  );
  late final BudgetAllocationsDao budgetAllocationsDao = BudgetAllocationsDao(
    this as Database,
  );
  late final BudgetMetadataDao budgetMetadataDao = BudgetMetadataDao(
    this as Database,
  );
  @override
  Iterable<TableInfo<Table, Object?>> get allTables => allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
    accounts,
    users,
    budgets,
    budgetCategories,
    budgetPlans,
    budgetAllocations,
    budgetMetadataKeys,
    budgetMetadataValues,
    budgetMetadataAssociations,
  ];
}

typedef $$AccountsTableCreateCompanionBuilder = AccountsCompanion Function({Value<String> id, Value<int> rowid});
typedef $$AccountsTableUpdateCompanionBuilder = AccountsCompanion Function({Value<String> id, Value<int> rowid});

class $$AccountsTableFilterComposer extends Composer<_$Database, $AccountsTable> {
  $$AccountsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );
}

class $$AccountsTableOrderingComposer extends Composer<_$Database, $AccountsTable> {
  $$AccountsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$AccountsTableAnnotationComposer extends Composer<_$Database, $AccountsTable> {
  $$AccountsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id => $composableBuilder(column: $table.id, builder: (column) => column);
}

class $$AccountsTableTableManager
    extends
        RootTableManager<
          _$Database,
          $AccountsTable,
          AccountDataModel,
          $$AccountsTableFilterComposer,
          $$AccountsTableOrderingComposer,
          $$AccountsTableAnnotationComposer,
          $$AccountsTableCreateCompanionBuilder,
          $$AccountsTableUpdateCompanionBuilder,
          (
            AccountDataModel,
            BaseReferences<_$Database, $AccountsTable, AccountDataModel>,
          ),
          AccountDataModel,
          PrefetchHooks Function()
        > {
  $$AccountsTableTableManager(_$Database db, $AccountsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () => $$AccountsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () => $$AccountsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () => $$AccountsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => AccountsCompanion(id: id, rowid: rowid),
          createCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => AccountsCompanion.insert(id: id, rowid: rowid),
          withReferenceMapper: (p0) => p0.map((e) => (e.readTable(table), BaseReferences(db, table, e))).toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$AccountsTableProcessedTableManager =
    ProcessedTableManager<
      _$Database,
      $AccountsTable,
      AccountDataModel,
      $$AccountsTableFilterComposer,
      $$AccountsTableOrderingComposer,
      $$AccountsTableAnnotationComposer,
      $$AccountsTableCreateCompanionBuilder,
      $$AccountsTableUpdateCompanionBuilder,
      (
        AccountDataModel,
        BaseReferences<_$Database, $AccountsTable, AccountDataModel>,
      ),
      AccountDataModel,
      PrefetchHooks Function()
    >;
typedef $$UsersTableCreateCompanionBuilder =
    UsersCompanion Function({
      Value<String> id,
      required DateTime createdAt,
      Value<int> rowid,
    });
typedef $$UsersTableUpdateCompanionBuilder =
    UsersCompanion Function({
      Value<String> id,
      Value<DateTime> createdAt,
      Value<int> rowid,
    });

class $$UsersTableFilterComposer extends Composer<_$Database, $UsersTable> {
  $$UsersTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$UsersTableOrderingComposer extends Composer<_$Database, $UsersTable> {
  $$UsersTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$UsersTableAnnotationComposer extends Composer<_$Database, $UsersTable> {
  $$UsersTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id => $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt => $composableBuilder(column: $table.createdAt, builder: (column) => column);
}

class $$UsersTableTableManager
    extends
        RootTableManager<
          _$Database,
          $UsersTable,
          UserDataModel,
          $$UsersTableFilterComposer,
          $$UsersTableOrderingComposer,
          $$UsersTableAnnotationComposer,
          $$UsersTableCreateCompanionBuilder,
          $$UsersTableUpdateCompanionBuilder,
          (
            UserDataModel,
            BaseReferences<_$Database, $UsersTable, UserDataModel>,
          ),
          UserDataModel,
          PrefetchHooks Function()
        > {
  $$UsersTableTableManager(_$Database db, $UsersTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () => $$UsersTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () => $$UsersTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () => $$UsersTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => UsersCompanion(id: id, createdAt: createdAt, rowid: rowid),
          createCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                required DateTime createdAt,
                Value<int> rowid = const Value.absent(),
              }) => UsersCompanion.insert(
                id: id,
                createdAt: createdAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0.map((e) => (e.readTable(table), BaseReferences(db, table, e))).toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$UsersTableProcessedTableManager =
    ProcessedTableManager<
      _$Database,
      $UsersTable,
      UserDataModel,
      $$UsersTableFilterComposer,
      $$UsersTableOrderingComposer,
      $$UsersTableAnnotationComposer,
      $$UsersTableCreateCompanionBuilder,
      $$UsersTableUpdateCompanionBuilder,
      (UserDataModel, BaseReferences<_$Database, $UsersTable, UserDataModel>),
      UserDataModel,
      PrefetchHooks Function()
    >;
typedef $$BudgetsTableCreateCompanionBuilder =
    BudgetsCompanion Function({
      Value<String> id,
      required String title,
      required String description,
      required DateTime createdAt,
      Value<DateTime?> updatedAt,
      required int index,
      required int amount,
      required bool active,
      required DateTime startedAt,
      Value<DateTime?> endedAt,
      Value<int> rowid,
    });
typedef $$BudgetsTableUpdateCompanionBuilder =
    BudgetsCompanion Function({
      Value<String> id,
      Value<String> title,
      Value<String> description,
      Value<DateTime> createdAt,
      Value<DateTime?> updatedAt,
      Value<int> index,
      Value<int> amount,
      Value<bool> active,
      Value<DateTime> startedAt,
      Value<DateTime?> endedAt,
      Value<int> rowid,
    });

final class $$BudgetsTableReferences extends BaseReferences<_$Database, $BudgetsTable, BudgetDataModel> {
  $$BudgetsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<$BudgetAllocationsTable, List<BudgetAllocationDataModel>> _budgetAllocationsRefsTable(
    _$Database db,
  ) => MultiTypedResultKey.fromTable(
    db.budgetAllocations,
    aliasName: $_aliasNameGenerator(db.budgets.id, db.budgetAllocations.budget),
  );

  $$BudgetAllocationsTableProcessedTableManager get budgetAllocationsRefs {
    final manager = $$BudgetAllocationsTableTableManager(
      $_db,
      $_db.budgetAllocations,
    ).filter((f) => f.budget.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _budgetAllocationsRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$BudgetsTableFilterComposer extends Composer<_$Database, $BudgetsTable> {
  $$BudgetsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get title => $composableBuilder(
    column: $table.title,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get index => $composableBuilder(
    column: $table.index,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get amount => $composableBuilder(
    column: $table.amount,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get active => $composableBuilder(
    column: $table.active,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get startedAt => $composableBuilder(
    column: $table.startedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get endedAt => $composableBuilder(
    column: $table.endedAt,
    builder: (column) => ColumnFilters(column),
  );

  Expression<bool> budgetAllocationsRefs(
    Expression<bool> Function($$BudgetAllocationsTableFilterComposer f) f,
  ) {
    final $$BudgetAllocationsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.budgetAllocations,
      getReferencedColumn: (t) => t.budget,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$BudgetAllocationsTableFilterComposer(
            $db: $db,
            $table: $db.budgetAllocations,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer: $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$BudgetsTableOrderingComposer extends Composer<_$Database, $BudgetsTable> {
  $$BudgetsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get title => $composableBuilder(
    column: $table.title,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get index => $composableBuilder(
    column: $table.index,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get amount => $composableBuilder(
    column: $table.amount,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get active => $composableBuilder(
    column: $table.active,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get startedAt => $composableBuilder(
    column: $table.startedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get endedAt => $composableBuilder(
    column: $table.endedAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$BudgetsTableAnnotationComposer extends Composer<_$Database, $BudgetsTable> {
  $$BudgetsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id => $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get title => $composableBuilder(column: $table.title, builder: (column) => column);

  GeneratedColumn<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get createdAt => $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt => $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  GeneratedColumn<int> get index => $composableBuilder(column: $table.index, builder: (column) => column);

  GeneratedColumn<int> get amount => $composableBuilder(column: $table.amount, builder: (column) => column);

  GeneratedColumn<bool> get active => $composableBuilder(column: $table.active, builder: (column) => column);

  GeneratedColumn<DateTime> get startedAt => $composableBuilder(column: $table.startedAt, builder: (column) => column);

  GeneratedColumn<DateTime> get endedAt => $composableBuilder(column: $table.endedAt, builder: (column) => column);

  Expression<T> budgetAllocationsRefs<T extends Object>(
    Expression<T> Function($$BudgetAllocationsTableAnnotationComposer a) f,
  ) {
    final $$BudgetAllocationsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.budgetAllocations,
      getReferencedColumn: (t) => t.budget,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$BudgetAllocationsTableAnnotationComposer(
            $db: $db,
            $table: $db.budgetAllocations,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer: $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$BudgetsTableTableManager
    extends
        RootTableManager<
          _$Database,
          $BudgetsTable,
          BudgetDataModel,
          $$BudgetsTableFilterComposer,
          $$BudgetsTableOrderingComposer,
          $$BudgetsTableAnnotationComposer,
          $$BudgetsTableCreateCompanionBuilder,
          $$BudgetsTableUpdateCompanionBuilder,
          (BudgetDataModel, $$BudgetsTableReferences),
          BudgetDataModel,
          PrefetchHooks Function({bool budgetAllocationsRefs})
        > {
  $$BudgetsTableTableManager(_$Database db, $BudgetsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () => $$BudgetsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () => $$BudgetsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () => $$BudgetsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> title = const Value.absent(),
                Value<String> description = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime?> updatedAt = const Value.absent(),
                Value<int> index = const Value.absent(),
                Value<int> amount = const Value.absent(),
                Value<bool> active = const Value.absent(),
                Value<DateTime> startedAt = const Value.absent(),
                Value<DateTime?> endedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => BudgetsCompanion(
                id: id,
                title: title,
                description: description,
                createdAt: createdAt,
                updatedAt: updatedAt,
                index: index,
                amount: amount,
                active: active,
                startedAt: startedAt,
                endedAt: endedAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                required String title,
                required String description,
                required DateTime createdAt,
                Value<DateTime?> updatedAt = const Value.absent(),
                required int index,
                required int amount,
                required bool active,
                required DateTime startedAt,
                Value<DateTime?> endedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => BudgetsCompanion.insert(
                id: id,
                title: title,
                description: description,
                createdAt: createdAt,
                updatedAt: updatedAt,
                index: index,
                amount: amount,
                active: active,
                startedAt: startedAt,
                endedAt: endedAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$BudgetsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({budgetAllocationsRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [
                if (budgetAllocationsRefs) db.budgetAllocations,
              ],
              addJoins: null,
              getPrefetchedDataCallback: (items) async {
                return [
                  if (budgetAllocationsRefs)
                    await $_getPrefetchedData<BudgetDataModel, $BudgetsTable, BudgetAllocationDataModel>(
                      currentTable: table,
                      referencedTable: $$BudgetsTableReferences._budgetAllocationsRefsTable(db),
                      managerFromTypedResult: (p0) => $$BudgetsTableReferences(
                        db,
                        table,
                        p0,
                      ).budgetAllocationsRefs,
                      referencedItemsForCurrentItem: (item, referencedItems) =>
                          referencedItems.where((e) => e.budget == item.id),
                      typedResults: items,
                    ),
                ];
              },
            );
          },
        ),
      );
}

typedef $$BudgetsTableProcessedTableManager =
    ProcessedTableManager<
      _$Database,
      $BudgetsTable,
      BudgetDataModel,
      $$BudgetsTableFilterComposer,
      $$BudgetsTableOrderingComposer,
      $$BudgetsTableAnnotationComposer,
      $$BudgetsTableCreateCompanionBuilder,
      $$BudgetsTableUpdateCompanionBuilder,
      (BudgetDataModel, $$BudgetsTableReferences),
      BudgetDataModel,
      PrefetchHooks Function({bool budgetAllocationsRefs})
    >;
typedef $$BudgetCategoriesTableCreateCompanionBuilder =
    BudgetCategoriesCompanion Function({
      Value<String> id,
      required String title,
      required String description,
      required DateTime createdAt,
      Value<DateTime?> updatedAt,
      required int iconIndex,
      required int colorSchemeIndex,
      Value<int> rowid,
    });
typedef $$BudgetCategoriesTableUpdateCompanionBuilder =
    BudgetCategoriesCompanion Function({
      Value<String> id,
      Value<String> title,
      Value<String> description,
      Value<DateTime> createdAt,
      Value<DateTime?> updatedAt,
      Value<int> iconIndex,
      Value<int> colorSchemeIndex,
      Value<int> rowid,
    });

final class $$BudgetCategoriesTableReferences
    extends BaseReferences<_$Database, $BudgetCategoriesTable, BudgetCategoryDataModel> {
  $$BudgetCategoriesTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static MultiTypedResultKey<$BudgetPlansTable, List<BudgetPlanDataModel>> _budgetPlansRefsTable(_$Database db) =>
      MultiTypedResultKey.fromTable(
        db.budgetPlans,
        aliasName: $_aliasNameGenerator(
          db.budgetCategories.id,
          db.budgetPlans.category,
        ),
      );

  $$BudgetPlansTableProcessedTableManager get budgetPlansRefs {
    final manager = $$BudgetPlansTableTableManager(
      $_db,
      $_db.budgetPlans,
    ).filter((f) => f.category.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_budgetPlansRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$BudgetCategoriesTableFilterComposer extends Composer<_$Database, $BudgetCategoriesTable> {
  $$BudgetCategoriesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get title => $composableBuilder(
    column: $table.title,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get iconIndex => $composableBuilder(
    column: $table.iconIndex,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get colorSchemeIndex => $composableBuilder(
    column: $table.colorSchemeIndex,
    builder: (column) => ColumnFilters(column),
  );

  Expression<bool> budgetPlansRefs(
    Expression<bool> Function($$BudgetPlansTableFilterComposer f) f,
  ) {
    final $$BudgetPlansTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.budgetPlans,
      getReferencedColumn: (t) => t.category,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$BudgetPlansTableFilterComposer(
            $db: $db,
            $table: $db.budgetPlans,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer: $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$BudgetCategoriesTableOrderingComposer extends Composer<_$Database, $BudgetCategoriesTable> {
  $$BudgetCategoriesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get title => $composableBuilder(
    column: $table.title,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get iconIndex => $composableBuilder(
    column: $table.iconIndex,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get colorSchemeIndex => $composableBuilder(
    column: $table.colorSchemeIndex,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$BudgetCategoriesTableAnnotationComposer extends Composer<_$Database, $BudgetCategoriesTable> {
  $$BudgetCategoriesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id => $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get title => $composableBuilder(column: $table.title, builder: (column) => column);

  GeneratedColumn<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get createdAt => $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt => $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  GeneratedColumn<int> get iconIndex => $composableBuilder(column: $table.iconIndex, builder: (column) => column);

  GeneratedColumn<int> get colorSchemeIndex => $composableBuilder(
    column: $table.colorSchemeIndex,
    builder: (column) => column,
  );

  Expression<T> budgetPlansRefs<T extends Object>(
    Expression<T> Function($$BudgetPlansTableAnnotationComposer a) f,
  ) {
    final $$BudgetPlansTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.budgetPlans,
      getReferencedColumn: (t) => t.category,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$BudgetPlansTableAnnotationComposer(
            $db: $db,
            $table: $db.budgetPlans,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer: $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$BudgetCategoriesTableTableManager
    extends
        RootTableManager<
          _$Database,
          $BudgetCategoriesTable,
          BudgetCategoryDataModel,
          $$BudgetCategoriesTableFilterComposer,
          $$BudgetCategoriesTableOrderingComposer,
          $$BudgetCategoriesTableAnnotationComposer,
          $$BudgetCategoriesTableCreateCompanionBuilder,
          $$BudgetCategoriesTableUpdateCompanionBuilder,
          (BudgetCategoryDataModel, $$BudgetCategoriesTableReferences),
          BudgetCategoryDataModel,
          PrefetchHooks Function({bool budgetPlansRefs})
        > {
  $$BudgetCategoriesTableTableManager(
    _$Database db,
    $BudgetCategoriesTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () => $$BudgetCategoriesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () => $$BudgetCategoriesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () => $$BudgetCategoriesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> title = const Value.absent(),
                Value<String> description = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime?> updatedAt = const Value.absent(),
                Value<int> iconIndex = const Value.absent(),
                Value<int> colorSchemeIndex = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => BudgetCategoriesCompanion(
                id: id,
                title: title,
                description: description,
                createdAt: createdAt,
                updatedAt: updatedAt,
                iconIndex: iconIndex,
                colorSchemeIndex: colorSchemeIndex,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                required String title,
                required String description,
                required DateTime createdAt,
                Value<DateTime?> updatedAt = const Value.absent(),
                required int iconIndex,
                required int colorSchemeIndex,
                Value<int> rowid = const Value.absent(),
              }) => BudgetCategoriesCompanion.insert(
                id: id,
                title: title,
                description: description,
                createdAt: createdAt,
                updatedAt: updatedAt,
                iconIndex: iconIndex,
                colorSchemeIndex: colorSchemeIndex,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$BudgetCategoriesTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({budgetPlansRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [if (budgetPlansRefs) db.budgetPlans],
              addJoins: null,
              getPrefetchedDataCallback: (items) async {
                return [
                  if (budgetPlansRefs)
                    await $_getPrefetchedData<BudgetCategoryDataModel, $BudgetCategoriesTable, BudgetPlanDataModel>(
                      currentTable: table,
                      referencedTable: $$BudgetCategoriesTableReferences._budgetPlansRefsTable(db),
                      managerFromTypedResult: (p0) => $$BudgetCategoriesTableReferences(
                        db,
                        table,
                        p0,
                      ).budgetPlansRefs,
                      referencedItemsForCurrentItem: (item, referencedItems) =>
                          referencedItems.where((e) => e.category == item.id),
                      typedResults: items,
                    ),
                ];
              },
            );
          },
        ),
      );
}

typedef $$BudgetCategoriesTableProcessedTableManager =
    ProcessedTableManager<
      _$Database,
      $BudgetCategoriesTable,
      BudgetCategoryDataModel,
      $$BudgetCategoriesTableFilterComposer,
      $$BudgetCategoriesTableOrderingComposer,
      $$BudgetCategoriesTableAnnotationComposer,
      $$BudgetCategoriesTableCreateCompanionBuilder,
      $$BudgetCategoriesTableUpdateCompanionBuilder,
      (BudgetCategoryDataModel, $$BudgetCategoriesTableReferences),
      BudgetCategoryDataModel,
      PrefetchHooks Function({bool budgetPlansRefs})
    >;
typedef $$BudgetPlansTableCreateCompanionBuilder =
    BudgetPlansCompanion Function({
      Value<String> id,
      required String title,
      required String description,
      required DateTime createdAt,
      Value<DateTime?> updatedAt,
      required String category,
      Value<int> rowid,
    });
typedef $$BudgetPlansTableUpdateCompanionBuilder =
    BudgetPlansCompanion Function({
      Value<String> id,
      Value<String> title,
      Value<String> description,
      Value<DateTime> createdAt,
      Value<DateTime?> updatedAt,
      Value<String> category,
      Value<int> rowid,
    });

final class $$BudgetPlansTableReferences extends BaseReferences<_$Database, $BudgetPlansTable, BudgetPlanDataModel> {
  $$BudgetPlansTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $BudgetCategoriesTable _categoryTable(_$Database db) => db.budgetCategories.createAlias(
    $_aliasNameGenerator(db.budgetPlans.category, db.budgetCategories.id),
  );

  $$BudgetCategoriesTableProcessedTableManager get category {
    final $_column = $_itemColumn<String>('category')!;

    final manager = $$BudgetCategoriesTableTableManager(
      $_db,
      $_db.budgetCategories,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_categoryTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static MultiTypedResultKey<$BudgetAllocationsTable, List<BudgetAllocationDataModel>> _budgetAllocationsRefsTable(
    _$Database db,
  ) => MultiTypedResultKey.fromTable(
    db.budgetAllocations,
    aliasName: $_aliasNameGenerator(
      db.budgetPlans.id,
      db.budgetAllocations.plan,
    ),
  );

  $$BudgetAllocationsTableProcessedTableManager get budgetAllocationsRefs {
    final manager = $$BudgetAllocationsTableTableManager(
      $_db,
      $_db.budgetAllocations,
    ).filter((f) => f.plan.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _budgetAllocationsRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$BudgetMetadataAssociationsTable, List<BudgetMetadataAssociationDataModel>>
  _budgetMetadataAssociationsRefsTable(_$Database db) => MultiTypedResultKey.fromTable(
    db.budgetMetadataAssociations,
    aliasName: $_aliasNameGenerator(
      db.budgetPlans.id,
      db.budgetMetadataAssociations.plan,
    ),
  );

  $$BudgetMetadataAssociationsTableProcessedTableManager get budgetMetadataAssociationsRefs {
    final manager = $$BudgetMetadataAssociationsTableTableManager(
      $_db,
      $_db.budgetMetadataAssociations,
    ).filter((f) => f.plan.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _budgetMetadataAssociationsRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$BudgetPlansTableFilterComposer extends Composer<_$Database, $BudgetPlansTable> {
  $$BudgetPlansTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get title => $composableBuilder(
    column: $table.title,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  $$BudgetCategoriesTableFilterComposer get category {
    final $$BudgetCategoriesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.category,
      referencedTable: $db.budgetCategories,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$BudgetCategoriesTableFilterComposer(
            $db: $db,
            $table: $db.budgetCategories,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer: $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<bool> budgetAllocationsRefs(
    Expression<bool> Function($$BudgetAllocationsTableFilterComposer f) f,
  ) {
    final $$BudgetAllocationsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.budgetAllocations,
      getReferencedColumn: (t) => t.plan,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$BudgetAllocationsTableFilterComposer(
            $db: $db,
            $table: $db.budgetAllocations,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer: $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> budgetMetadataAssociationsRefs(
    Expression<bool> Function($$BudgetMetadataAssociationsTableFilterComposer f) f,
  ) {
    final $$BudgetMetadataAssociationsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.budgetMetadataAssociations,
      getReferencedColumn: (t) => t.plan,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$BudgetMetadataAssociationsTableFilterComposer(
            $db: $db,
            $table: $db.budgetMetadataAssociations,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer: $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$BudgetPlansTableOrderingComposer extends Composer<_$Database, $BudgetPlansTable> {
  $$BudgetPlansTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get title => $composableBuilder(
    column: $table.title,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );

  $$BudgetCategoriesTableOrderingComposer get category {
    final $$BudgetCategoriesTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.category,
      referencedTable: $db.budgetCategories,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$BudgetCategoriesTableOrderingComposer(
            $db: $db,
            $table: $db.budgetCategories,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer: $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$BudgetPlansTableAnnotationComposer extends Composer<_$Database, $BudgetPlansTable> {
  $$BudgetPlansTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id => $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get title => $composableBuilder(column: $table.title, builder: (column) => column);

  GeneratedColumn<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get createdAt => $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt => $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  $$BudgetCategoriesTableAnnotationComposer get category {
    final $$BudgetCategoriesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.category,
      referencedTable: $db.budgetCategories,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$BudgetCategoriesTableAnnotationComposer(
            $db: $db,
            $table: $db.budgetCategories,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer: $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<T> budgetAllocationsRefs<T extends Object>(
    Expression<T> Function($$BudgetAllocationsTableAnnotationComposer a) f,
  ) {
    final $$BudgetAllocationsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.budgetAllocations,
      getReferencedColumn: (t) => t.plan,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$BudgetAllocationsTableAnnotationComposer(
            $db: $db,
            $table: $db.budgetAllocations,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer: $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> budgetMetadataAssociationsRefs<T extends Object>(
    Expression<T> Function(
      $$BudgetMetadataAssociationsTableAnnotationComposer a,
    )
    f,
  ) {
    final $$BudgetMetadataAssociationsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.budgetMetadataAssociations,
      getReferencedColumn: (t) => t.plan,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$BudgetMetadataAssociationsTableAnnotationComposer(
            $db: $db,
            $table: $db.budgetMetadataAssociations,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer: $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$BudgetPlansTableTableManager
    extends
        RootTableManager<
          _$Database,
          $BudgetPlansTable,
          BudgetPlanDataModel,
          $$BudgetPlansTableFilterComposer,
          $$BudgetPlansTableOrderingComposer,
          $$BudgetPlansTableAnnotationComposer,
          $$BudgetPlansTableCreateCompanionBuilder,
          $$BudgetPlansTableUpdateCompanionBuilder,
          (BudgetPlanDataModel, $$BudgetPlansTableReferences),
          BudgetPlanDataModel,
          PrefetchHooks Function({
            bool category,
            bool budgetAllocationsRefs,
            bool budgetMetadataAssociationsRefs,
          })
        > {
  $$BudgetPlansTableTableManager(_$Database db, $BudgetPlansTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () => $$BudgetPlansTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () => $$BudgetPlansTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () => $$BudgetPlansTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> title = const Value.absent(),
                Value<String> description = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime?> updatedAt = const Value.absent(),
                Value<String> category = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => BudgetPlansCompanion(
                id: id,
                title: title,
                description: description,
                createdAt: createdAt,
                updatedAt: updatedAt,
                category: category,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                required String title,
                required String description,
                required DateTime createdAt,
                Value<DateTime?> updatedAt = const Value.absent(),
                required String category,
                Value<int> rowid = const Value.absent(),
              }) => BudgetPlansCompanion.insert(
                id: id,
                title: title,
                description: description,
                createdAt: createdAt,
                updatedAt: updatedAt,
                category: category,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$BudgetPlansTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback:
              ({
                category = false,
                budgetAllocationsRefs = false,
                budgetMetadataAssociationsRefs = false,
              }) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [
                    if (budgetAllocationsRefs) db.budgetAllocations,
                    if (budgetMetadataAssociationsRefs) db.budgetMetadataAssociations,
                  ],
                  addJoins:
                      <
                        T extends TableManagerState<
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic
                        >
                      >(state) {
                        if (category) {
                          state =
                              state.withJoin(
                                    currentTable: table,
                                    currentColumn: table.category,
                                    referencedTable: $$BudgetPlansTableReferences._categoryTable(db),
                                    referencedColumn: $$BudgetPlansTableReferences._categoryTable(db).id,
                                  )
                                  as T;
                        }

                        return state;
                      },
                  getPrefetchedDataCallback: (items) async {
                    return [
                      if (budgetAllocationsRefs)
                        await $_getPrefetchedData<BudgetPlanDataModel, $BudgetPlansTable, BudgetAllocationDataModel>(
                          currentTable: table,
                          referencedTable: $$BudgetPlansTableReferences._budgetAllocationsRefsTable(db),
                          managerFromTypedResult: (p0) => $$BudgetPlansTableReferences(
                            db,
                            table,
                            p0,
                          ).budgetAllocationsRefs,
                          referencedItemsForCurrentItem: (item, referencedItems) => referencedItems.where(
                            (e) => e.plan == item.id,
                          ),
                          typedResults: items,
                        ),
                      if (budgetMetadataAssociationsRefs)
                        await $_getPrefetchedData<
                          BudgetPlanDataModel,
                          $BudgetPlansTable,
                          BudgetMetadataAssociationDataModel
                        >(
                          currentTable: table,
                          referencedTable: $$BudgetPlansTableReferences._budgetMetadataAssociationsRefsTable(db),
                          managerFromTypedResult: (p0) => $$BudgetPlansTableReferences(
                            db,
                            table,
                            p0,
                          ).budgetMetadataAssociationsRefs,
                          referencedItemsForCurrentItem: (item, referencedItems) => referencedItems.where(
                            (e) => e.plan == item.id,
                          ),
                          typedResults: items,
                        ),
                    ];
                  },
                );
              },
        ),
      );
}

typedef $$BudgetPlansTableProcessedTableManager =
    ProcessedTableManager<
      _$Database,
      $BudgetPlansTable,
      BudgetPlanDataModel,
      $$BudgetPlansTableFilterComposer,
      $$BudgetPlansTableOrderingComposer,
      $$BudgetPlansTableAnnotationComposer,
      $$BudgetPlansTableCreateCompanionBuilder,
      $$BudgetPlansTableUpdateCompanionBuilder,
      (BudgetPlanDataModel, $$BudgetPlansTableReferences),
      BudgetPlanDataModel,
      PrefetchHooks Function({
        bool category,
        bool budgetAllocationsRefs,
        bool budgetMetadataAssociationsRefs,
      })
    >;
typedef $$BudgetAllocationsTableCreateCompanionBuilder =
    BudgetAllocationsCompanion Function({
      Value<String> id,
      required DateTime createdAt,
      Value<DateTime?> updatedAt,
      required int amount,
      required String budget,
      required String plan,
      Value<int> rowid,
    });
typedef $$BudgetAllocationsTableUpdateCompanionBuilder =
    BudgetAllocationsCompanion Function({
      Value<String> id,
      Value<DateTime> createdAt,
      Value<DateTime?> updatedAt,
      Value<int> amount,
      Value<String> budget,
      Value<String> plan,
      Value<int> rowid,
    });

final class $$BudgetAllocationsTableReferences
    extends BaseReferences<_$Database, $BudgetAllocationsTable, BudgetAllocationDataModel> {
  $$BudgetAllocationsTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $BudgetsTable _budgetTable(_$Database db) => db.budgets.createAlias(
    $_aliasNameGenerator(db.budgetAllocations.budget, db.budgets.id),
  );

  $$BudgetsTableProcessedTableManager get budget {
    final $_column = $_itemColumn<String>('budget')!;

    final manager = $$BudgetsTableTableManager(
      $_db,
      $_db.budgets,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_budgetTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static $BudgetPlansTable _planTable(_$Database db) => db.budgetPlans.createAlias(
    $_aliasNameGenerator(db.budgetAllocations.plan, db.budgetPlans.id),
  );

  $$BudgetPlansTableProcessedTableManager get plan {
    final $_column = $_itemColumn<String>('plan')!;

    final manager = $$BudgetPlansTableTableManager(
      $_db,
      $_db.budgetPlans,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_planTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$BudgetAllocationsTableFilterComposer extends Composer<_$Database, $BudgetAllocationsTable> {
  $$BudgetAllocationsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get amount => $composableBuilder(
    column: $table.amount,
    builder: (column) => ColumnFilters(column),
  );

  $$BudgetsTableFilterComposer get budget {
    final $$BudgetsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.budget,
      referencedTable: $db.budgets,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$BudgetsTableFilterComposer(
            $db: $db,
            $table: $db.budgets,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer: $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$BudgetPlansTableFilterComposer get plan {
    final $$BudgetPlansTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.plan,
      referencedTable: $db.budgetPlans,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$BudgetPlansTableFilterComposer(
            $db: $db,
            $table: $db.budgetPlans,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer: $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$BudgetAllocationsTableOrderingComposer extends Composer<_$Database, $BudgetAllocationsTable> {
  $$BudgetAllocationsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get amount => $composableBuilder(
    column: $table.amount,
    builder: (column) => ColumnOrderings(column),
  );

  $$BudgetsTableOrderingComposer get budget {
    final $$BudgetsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.budget,
      referencedTable: $db.budgets,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$BudgetsTableOrderingComposer(
            $db: $db,
            $table: $db.budgets,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer: $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$BudgetPlansTableOrderingComposer get plan {
    final $$BudgetPlansTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.plan,
      referencedTable: $db.budgetPlans,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$BudgetPlansTableOrderingComposer(
            $db: $db,
            $table: $db.budgetPlans,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer: $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$BudgetAllocationsTableAnnotationComposer extends Composer<_$Database, $BudgetAllocationsTable> {
  $$BudgetAllocationsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id => $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt => $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt => $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  GeneratedColumn<int> get amount => $composableBuilder(column: $table.amount, builder: (column) => column);

  $$BudgetsTableAnnotationComposer get budget {
    final $$BudgetsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.budget,
      referencedTable: $db.budgets,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$BudgetsTableAnnotationComposer(
            $db: $db,
            $table: $db.budgets,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer: $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$BudgetPlansTableAnnotationComposer get plan {
    final $$BudgetPlansTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.plan,
      referencedTable: $db.budgetPlans,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$BudgetPlansTableAnnotationComposer(
            $db: $db,
            $table: $db.budgetPlans,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer: $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$BudgetAllocationsTableTableManager
    extends
        RootTableManager<
          _$Database,
          $BudgetAllocationsTable,
          BudgetAllocationDataModel,
          $$BudgetAllocationsTableFilterComposer,
          $$BudgetAllocationsTableOrderingComposer,
          $$BudgetAllocationsTableAnnotationComposer,
          $$BudgetAllocationsTableCreateCompanionBuilder,
          $$BudgetAllocationsTableUpdateCompanionBuilder,
          (BudgetAllocationDataModel, $$BudgetAllocationsTableReferences),
          BudgetAllocationDataModel,
          PrefetchHooks Function({bool budget, bool plan})
        > {
  $$BudgetAllocationsTableTableManager(
    _$Database db,
    $BudgetAllocationsTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () => $$BudgetAllocationsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () => $$BudgetAllocationsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () => $$BudgetAllocationsTableAnnotationComposer(
            $db: db,
            $table: table,
          ),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime?> updatedAt = const Value.absent(),
                Value<int> amount = const Value.absent(),
                Value<String> budget = const Value.absent(),
                Value<String> plan = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => BudgetAllocationsCompanion(
                id: id,
                createdAt: createdAt,
                updatedAt: updatedAt,
                amount: amount,
                budget: budget,
                plan: plan,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                required DateTime createdAt,
                Value<DateTime?> updatedAt = const Value.absent(),
                required int amount,
                required String budget,
                required String plan,
                Value<int> rowid = const Value.absent(),
              }) => BudgetAllocationsCompanion.insert(
                id: id,
                createdAt: createdAt,
                updatedAt: updatedAt,
                amount: amount,
                budget: budget,
                plan: plan,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$BudgetAllocationsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({budget = false, plan = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (budget) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.budget,
                                referencedTable: $$BudgetAllocationsTableReferences._budgetTable(db),
                                referencedColumn: $$BudgetAllocationsTableReferences._budgetTable(db).id,
                              )
                              as T;
                    }
                    if (plan) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.plan,
                                referencedTable: $$BudgetAllocationsTableReferences._planTable(db),
                                referencedColumn: $$BudgetAllocationsTableReferences._planTable(db).id,
                              )
                              as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$BudgetAllocationsTableProcessedTableManager =
    ProcessedTableManager<
      _$Database,
      $BudgetAllocationsTable,
      BudgetAllocationDataModel,
      $$BudgetAllocationsTableFilterComposer,
      $$BudgetAllocationsTableOrderingComposer,
      $$BudgetAllocationsTableAnnotationComposer,
      $$BudgetAllocationsTableCreateCompanionBuilder,
      $$BudgetAllocationsTableUpdateCompanionBuilder,
      (BudgetAllocationDataModel, $$BudgetAllocationsTableReferences),
      BudgetAllocationDataModel,
      PrefetchHooks Function({bool budget, bool plan})
    >;
typedef $$BudgetMetadataKeysTableCreateCompanionBuilder =
    BudgetMetadataKeysCompanion Function({
      Value<String> id,
      required String title,
      required String description,
      required DateTime createdAt,
      Value<DateTime?> updatedAt,
      Value<int> rowid,
    });
typedef $$BudgetMetadataKeysTableUpdateCompanionBuilder =
    BudgetMetadataKeysCompanion Function({
      Value<String> id,
      Value<String> title,
      Value<String> description,
      Value<DateTime> createdAt,
      Value<DateTime?> updatedAt,
      Value<int> rowid,
    });

final class $$BudgetMetadataKeysTableReferences
    extends BaseReferences<_$Database, $BudgetMetadataKeysTable, BudgetMetadataKeyDataModel> {
  $$BudgetMetadataKeysTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static MultiTypedResultKey<$BudgetMetadataValuesTable, List<BudgetMetadataValueDataModel>>
  _budgetMetadataValuesRefsTable(_$Database db) => MultiTypedResultKey.fromTable(
    db.budgetMetadataValues,
    aliasName: $_aliasNameGenerator(
      db.budgetMetadataKeys.id,
      db.budgetMetadataValues.key,
    ),
  );

  $$BudgetMetadataValuesTableProcessedTableManager get budgetMetadataValuesRefs {
    final manager = $$BudgetMetadataValuesTableTableManager(
      $_db,
      $_db.budgetMetadataValues,
    ).filter((f) => f.key.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _budgetMetadataValuesRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$BudgetMetadataKeysTableFilterComposer extends Composer<_$Database, $BudgetMetadataKeysTable> {
  $$BudgetMetadataKeysTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get title => $composableBuilder(
    column: $table.title,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  Expression<bool> budgetMetadataValuesRefs(
    Expression<bool> Function($$BudgetMetadataValuesTableFilterComposer f) f,
  ) {
    final $$BudgetMetadataValuesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.budgetMetadataValues,
      getReferencedColumn: (t) => t.key,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$BudgetMetadataValuesTableFilterComposer(
            $db: $db,
            $table: $db.budgetMetadataValues,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer: $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$BudgetMetadataKeysTableOrderingComposer extends Composer<_$Database, $BudgetMetadataKeysTable> {
  $$BudgetMetadataKeysTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get title => $composableBuilder(
    column: $table.title,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$BudgetMetadataKeysTableAnnotationComposer extends Composer<_$Database, $BudgetMetadataKeysTable> {
  $$BudgetMetadataKeysTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id => $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get title => $composableBuilder(column: $table.title, builder: (column) => column);

  GeneratedColumn<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get createdAt => $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt => $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  Expression<T> budgetMetadataValuesRefs<T extends Object>(
    Expression<T> Function($$BudgetMetadataValuesTableAnnotationComposer a) f,
  ) {
    final $$BudgetMetadataValuesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.budgetMetadataValues,
      getReferencedColumn: (t) => t.key,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$BudgetMetadataValuesTableAnnotationComposer(
            $db: $db,
            $table: $db.budgetMetadataValues,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer: $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$BudgetMetadataKeysTableTableManager
    extends
        RootTableManager<
          _$Database,
          $BudgetMetadataKeysTable,
          BudgetMetadataKeyDataModel,
          $$BudgetMetadataKeysTableFilterComposer,
          $$BudgetMetadataKeysTableOrderingComposer,
          $$BudgetMetadataKeysTableAnnotationComposer,
          $$BudgetMetadataKeysTableCreateCompanionBuilder,
          $$BudgetMetadataKeysTableUpdateCompanionBuilder,
          (BudgetMetadataKeyDataModel, $$BudgetMetadataKeysTableReferences),
          BudgetMetadataKeyDataModel,
          PrefetchHooks Function({bool budgetMetadataValuesRefs})
        > {
  $$BudgetMetadataKeysTableTableManager(
    _$Database db,
    $BudgetMetadataKeysTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () => $$BudgetMetadataKeysTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () => $$BudgetMetadataKeysTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () => $$BudgetMetadataKeysTableAnnotationComposer(
            $db: db,
            $table: table,
          ),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> title = const Value.absent(),
                Value<String> description = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime?> updatedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => BudgetMetadataKeysCompanion(
                id: id,
                title: title,
                description: description,
                createdAt: createdAt,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                required String title,
                required String description,
                required DateTime createdAt,
                Value<DateTime?> updatedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => BudgetMetadataKeysCompanion.insert(
                id: id,
                title: title,
                description: description,
                createdAt: createdAt,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$BudgetMetadataKeysTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({budgetMetadataValuesRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [
                if (budgetMetadataValuesRefs) db.budgetMetadataValues,
              ],
              addJoins: null,
              getPrefetchedDataCallback: (items) async {
                return [
                  if (budgetMetadataValuesRefs)
                    await $_getPrefetchedData<
                      BudgetMetadataKeyDataModel,
                      $BudgetMetadataKeysTable,
                      BudgetMetadataValueDataModel
                    >(
                      currentTable: table,
                      referencedTable: $$BudgetMetadataKeysTableReferences._budgetMetadataValuesRefsTable(db),
                      managerFromTypedResult: (p0) => $$BudgetMetadataKeysTableReferences(
                        db,
                        table,
                        p0,
                      ).budgetMetadataValuesRefs,
                      referencedItemsForCurrentItem: (item, referencedItems) =>
                          referencedItems.where((e) => e.key == item.id),
                      typedResults: items,
                    ),
                ];
              },
            );
          },
        ),
      );
}

typedef $$BudgetMetadataKeysTableProcessedTableManager =
    ProcessedTableManager<
      _$Database,
      $BudgetMetadataKeysTable,
      BudgetMetadataKeyDataModel,
      $$BudgetMetadataKeysTableFilterComposer,
      $$BudgetMetadataKeysTableOrderingComposer,
      $$BudgetMetadataKeysTableAnnotationComposer,
      $$BudgetMetadataKeysTableCreateCompanionBuilder,
      $$BudgetMetadataKeysTableUpdateCompanionBuilder,
      (BudgetMetadataKeyDataModel, $$BudgetMetadataKeysTableReferences),
      BudgetMetadataKeyDataModel,
      PrefetchHooks Function({bool budgetMetadataValuesRefs})
    >;
typedef $$BudgetMetadataValuesTableCreateCompanionBuilder =
    BudgetMetadataValuesCompanion Function({
      Value<String> id,
      required DateTime createdAt,
      Value<DateTime?> updatedAt,
      required String title,
      required String key,
      required String value,
      Value<int> rowid,
    });
typedef $$BudgetMetadataValuesTableUpdateCompanionBuilder =
    BudgetMetadataValuesCompanion Function({
      Value<String> id,
      Value<DateTime> createdAt,
      Value<DateTime?> updatedAt,
      Value<String> title,
      Value<String> key,
      Value<String> value,
      Value<int> rowid,
    });

final class $$BudgetMetadataValuesTableReferences
    extends BaseReferences<_$Database, $BudgetMetadataValuesTable, BudgetMetadataValueDataModel> {
  $$BudgetMetadataValuesTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $BudgetMetadataKeysTable _keyTable(_$Database db) => db.budgetMetadataKeys.createAlias(
    $_aliasNameGenerator(
      db.budgetMetadataValues.key,
      db.budgetMetadataKeys.id,
    ),
  );

  $$BudgetMetadataKeysTableProcessedTableManager get key {
    final $_column = $_itemColumn<String>('key')!;

    final manager = $$BudgetMetadataKeysTableTableManager(
      $_db,
      $_db.budgetMetadataKeys,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_keyTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static MultiTypedResultKey<$BudgetMetadataAssociationsTable, List<BudgetMetadataAssociationDataModel>>
  _budgetMetadataAssociationsRefsTable(_$Database db) => MultiTypedResultKey.fromTable(
    db.budgetMetadataAssociations,
    aliasName: $_aliasNameGenerator(
      db.budgetMetadataValues.id,
      db.budgetMetadataAssociations.metadata,
    ),
  );

  $$BudgetMetadataAssociationsTableProcessedTableManager get budgetMetadataAssociationsRefs {
    final manager = $$BudgetMetadataAssociationsTableTableManager(
      $_db,
      $_db.budgetMetadataAssociations,
    ).filter((f) => f.metadata.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _budgetMetadataAssociationsRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$BudgetMetadataValuesTableFilterComposer extends Composer<_$Database, $BudgetMetadataValuesTable> {
  $$BudgetMetadataValuesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get title => $composableBuilder(
    column: $table.title,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get value => $composableBuilder(
    column: $table.value,
    builder: (column) => ColumnFilters(column),
  );

  $$BudgetMetadataKeysTableFilterComposer get key {
    final $$BudgetMetadataKeysTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.key,
      referencedTable: $db.budgetMetadataKeys,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$BudgetMetadataKeysTableFilterComposer(
            $db: $db,
            $table: $db.budgetMetadataKeys,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer: $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<bool> budgetMetadataAssociationsRefs(
    Expression<bool> Function($$BudgetMetadataAssociationsTableFilterComposer f) f,
  ) {
    final $$BudgetMetadataAssociationsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.budgetMetadataAssociations,
      getReferencedColumn: (t) => t.metadata,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$BudgetMetadataAssociationsTableFilterComposer(
            $db: $db,
            $table: $db.budgetMetadataAssociations,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer: $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$BudgetMetadataValuesTableOrderingComposer extends Composer<_$Database, $BudgetMetadataValuesTable> {
  $$BudgetMetadataValuesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get title => $composableBuilder(
    column: $table.title,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get value => $composableBuilder(
    column: $table.value,
    builder: (column) => ColumnOrderings(column),
  );

  $$BudgetMetadataKeysTableOrderingComposer get key {
    final $$BudgetMetadataKeysTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.key,
      referencedTable: $db.budgetMetadataKeys,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$BudgetMetadataKeysTableOrderingComposer(
            $db: $db,
            $table: $db.budgetMetadataKeys,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer: $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$BudgetMetadataValuesTableAnnotationComposer extends Composer<_$Database, $BudgetMetadataValuesTable> {
  $$BudgetMetadataValuesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id => $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt => $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt => $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  GeneratedColumn<String> get title => $composableBuilder(column: $table.title, builder: (column) => column);

  GeneratedColumn<String> get value => $composableBuilder(column: $table.value, builder: (column) => column);

  $$BudgetMetadataKeysTableAnnotationComposer get key {
    final $$BudgetMetadataKeysTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.key,
      referencedTable: $db.budgetMetadataKeys,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$BudgetMetadataKeysTableAnnotationComposer(
            $db: $db,
            $table: $db.budgetMetadataKeys,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer: $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<T> budgetMetadataAssociationsRefs<T extends Object>(
    Expression<T> Function(
      $$BudgetMetadataAssociationsTableAnnotationComposer a,
    )
    f,
  ) {
    final $$BudgetMetadataAssociationsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.budgetMetadataAssociations,
      getReferencedColumn: (t) => t.metadata,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$BudgetMetadataAssociationsTableAnnotationComposer(
            $db: $db,
            $table: $db.budgetMetadataAssociations,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer: $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$BudgetMetadataValuesTableTableManager
    extends
        RootTableManager<
          _$Database,
          $BudgetMetadataValuesTable,
          BudgetMetadataValueDataModel,
          $$BudgetMetadataValuesTableFilterComposer,
          $$BudgetMetadataValuesTableOrderingComposer,
          $$BudgetMetadataValuesTableAnnotationComposer,
          $$BudgetMetadataValuesTableCreateCompanionBuilder,
          $$BudgetMetadataValuesTableUpdateCompanionBuilder,
          (BudgetMetadataValueDataModel, $$BudgetMetadataValuesTableReferences),
          BudgetMetadataValueDataModel,
          PrefetchHooks Function({
            bool key,
            bool budgetMetadataAssociationsRefs,
          })
        > {
  $$BudgetMetadataValuesTableTableManager(
    _$Database db,
    $BudgetMetadataValuesTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () => $$BudgetMetadataValuesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () => $$BudgetMetadataValuesTableOrderingComposer(
            $db: db,
            $table: table,
          ),
          createComputedFieldComposer: () => $$BudgetMetadataValuesTableAnnotationComposer(
            $db: db,
            $table: table,
          ),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime?> updatedAt = const Value.absent(),
                Value<String> title = const Value.absent(),
                Value<String> key = const Value.absent(),
                Value<String> value = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => BudgetMetadataValuesCompanion(
                id: id,
                createdAt: createdAt,
                updatedAt: updatedAt,
                title: title,
                key: key,
                value: value,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                required DateTime createdAt,
                Value<DateTime?> updatedAt = const Value.absent(),
                required String title,
                required String key,
                required String value,
                Value<int> rowid = const Value.absent(),
              }) => BudgetMetadataValuesCompanion.insert(
                id: id,
                createdAt: createdAt,
                updatedAt: updatedAt,
                title: title,
                key: key,
                value: value,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$BudgetMetadataValuesTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({key = false, budgetMetadataAssociationsRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [
                if (budgetMetadataAssociationsRefs) db.budgetMetadataAssociations,
              ],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (key) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.key,
                                referencedTable: $$BudgetMetadataValuesTableReferences._keyTable(db),
                                referencedColumn: $$BudgetMetadataValuesTableReferences._keyTable(db).id,
                              )
                              as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [
                  if (budgetMetadataAssociationsRefs)
                    await $_getPrefetchedData<
                      BudgetMetadataValueDataModel,
                      $BudgetMetadataValuesTable,
                      BudgetMetadataAssociationDataModel
                    >(
                      currentTable: table,
                      referencedTable: $$BudgetMetadataValuesTableReferences._budgetMetadataAssociationsRefsTable(db),
                      managerFromTypedResult: (p0) => $$BudgetMetadataValuesTableReferences(
                        db,
                        table,
                        p0,
                      ).budgetMetadataAssociationsRefs,
                      referencedItemsForCurrentItem: (item, referencedItems) => referencedItems.where(
                        (e) => e.metadata == item.id,
                      ),
                      typedResults: items,
                    ),
                ];
              },
            );
          },
        ),
      );
}

typedef $$BudgetMetadataValuesTableProcessedTableManager =
    ProcessedTableManager<
      _$Database,
      $BudgetMetadataValuesTable,
      BudgetMetadataValueDataModel,
      $$BudgetMetadataValuesTableFilterComposer,
      $$BudgetMetadataValuesTableOrderingComposer,
      $$BudgetMetadataValuesTableAnnotationComposer,
      $$BudgetMetadataValuesTableCreateCompanionBuilder,
      $$BudgetMetadataValuesTableUpdateCompanionBuilder,
      (BudgetMetadataValueDataModel, $$BudgetMetadataValuesTableReferences),
      BudgetMetadataValueDataModel,
      PrefetchHooks Function({bool key, bool budgetMetadataAssociationsRefs})
    >;
typedef $$BudgetMetadataAssociationsTableCreateCompanionBuilder =
    BudgetMetadataAssociationsCompanion Function({
      Value<String> id,
      required DateTime createdAt,
      Value<DateTime?> updatedAt,
      required String plan,
      required String metadata,
      Value<int> rowid,
    });
typedef $$BudgetMetadataAssociationsTableUpdateCompanionBuilder =
    BudgetMetadataAssociationsCompanion Function({
      Value<String> id,
      Value<DateTime> createdAt,
      Value<DateTime?> updatedAt,
      Value<String> plan,
      Value<String> metadata,
      Value<int> rowid,
    });

final class $$BudgetMetadataAssociationsTableReferences
    extends BaseReferences<_$Database, $BudgetMetadataAssociationsTable, BudgetMetadataAssociationDataModel> {
  $$BudgetMetadataAssociationsTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $BudgetPlansTable _planTable(_$Database db) => db.budgetPlans.createAlias(
    $_aliasNameGenerator(
      db.budgetMetadataAssociations.plan,
      db.budgetPlans.id,
    ),
  );

  $$BudgetPlansTableProcessedTableManager get plan {
    final $_column = $_itemColumn<String>('plan')!;

    final manager = $$BudgetPlansTableTableManager(
      $_db,
      $_db.budgetPlans,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_planTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static $BudgetMetadataValuesTable _metadataTable(_$Database db) => db.budgetMetadataValues.createAlias(
    $_aliasNameGenerator(
      db.budgetMetadataAssociations.metadata,
      db.budgetMetadataValues.id,
    ),
  );

  $$BudgetMetadataValuesTableProcessedTableManager get metadata {
    final $_column = $_itemColumn<String>('metadata')!;

    final manager = $$BudgetMetadataValuesTableTableManager(
      $_db,
      $_db.budgetMetadataValues,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_metadataTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$BudgetMetadataAssociationsTableFilterComposer extends Composer<_$Database, $BudgetMetadataAssociationsTable> {
  $$BudgetMetadataAssociationsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  $$BudgetPlansTableFilterComposer get plan {
    final $$BudgetPlansTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.plan,
      referencedTable: $db.budgetPlans,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$BudgetPlansTableFilterComposer(
            $db: $db,
            $table: $db.budgetPlans,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer: $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$BudgetMetadataValuesTableFilterComposer get metadata {
    final $$BudgetMetadataValuesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.metadata,
      referencedTable: $db.budgetMetadataValues,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$BudgetMetadataValuesTableFilterComposer(
            $db: $db,
            $table: $db.budgetMetadataValues,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer: $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$BudgetMetadataAssociationsTableOrderingComposer extends Composer<_$Database, $BudgetMetadataAssociationsTable> {
  $$BudgetMetadataAssociationsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );

  $$BudgetPlansTableOrderingComposer get plan {
    final $$BudgetPlansTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.plan,
      referencedTable: $db.budgetPlans,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$BudgetPlansTableOrderingComposer(
            $db: $db,
            $table: $db.budgetPlans,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer: $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$BudgetMetadataValuesTableOrderingComposer get metadata {
    final $$BudgetMetadataValuesTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.metadata,
      referencedTable: $db.budgetMetadataValues,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$BudgetMetadataValuesTableOrderingComposer(
            $db: $db,
            $table: $db.budgetMetadataValues,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer: $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$BudgetMetadataAssociationsTableAnnotationComposer
    extends Composer<_$Database, $BudgetMetadataAssociationsTable> {
  $$BudgetMetadataAssociationsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id => $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt => $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt => $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  $$BudgetPlansTableAnnotationComposer get plan {
    final $$BudgetPlansTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.plan,
      referencedTable: $db.budgetPlans,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$BudgetPlansTableAnnotationComposer(
            $db: $db,
            $table: $db.budgetPlans,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer: $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$BudgetMetadataValuesTableAnnotationComposer get metadata {
    final $$BudgetMetadataValuesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.metadata,
      referencedTable: $db.budgetMetadataValues,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$BudgetMetadataValuesTableAnnotationComposer(
            $db: $db,
            $table: $db.budgetMetadataValues,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer: $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$BudgetMetadataAssociationsTableTableManager
    extends
        RootTableManager<
          _$Database,
          $BudgetMetadataAssociationsTable,
          BudgetMetadataAssociationDataModel,
          $$BudgetMetadataAssociationsTableFilterComposer,
          $$BudgetMetadataAssociationsTableOrderingComposer,
          $$BudgetMetadataAssociationsTableAnnotationComposer,
          $$BudgetMetadataAssociationsTableCreateCompanionBuilder,
          $$BudgetMetadataAssociationsTableUpdateCompanionBuilder,
          (
            BudgetMetadataAssociationDataModel,
            $$BudgetMetadataAssociationsTableReferences,
          ),
          BudgetMetadataAssociationDataModel,
          PrefetchHooks Function({bool plan, bool metadata})
        > {
  $$BudgetMetadataAssociationsTableTableManager(
    _$Database db,
    $BudgetMetadataAssociationsTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () => $$BudgetMetadataAssociationsTableFilterComposer(
            $db: db,
            $table: table,
          ),
          createOrderingComposer: () => $$BudgetMetadataAssociationsTableOrderingComposer(
            $db: db,
            $table: table,
          ),
          createComputedFieldComposer: () => $$BudgetMetadataAssociationsTableAnnotationComposer(
            $db: db,
            $table: table,
          ),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime?> updatedAt = const Value.absent(),
                Value<String> plan = const Value.absent(),
                Value<String> metadata = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => BudgetMetadataAssociationsCompanion(
                id: id,
                createdAt: createdAt,
                updatedAt: updatedAt,
                plan: plan,
                metadata: metadata,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                required DateTime createdAt,
                Value<DateTime?> updatedAt = const Value.absent(),
                required String plan,
                required String metadata,
                Value<int> rowid = const Value.absent(),
              }) => BudgetMetadataAssociationsCompanion.insert(
                id: id,
                createdAt: createdAt,
                updatedAt: updatedAt,
                plan: plan,
                metadata: metadata,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$BudgetMetadataAssociationsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({plan = false, metadata = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (plan) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.plan,
                                referencedTable: $$BudgetMetadataAssociationsTableReferences._planTable(db),
                                referencedColumn: $$BudgetMetadataAssociationsTableReferences._planTable(db).id,
                              )
                              as T;
                    }
                    if (metadata) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.metadata,
                                referencedTable: $$BudgetMetadataAssociationsTableReferences._metadataTable(db),
                                referencedColumn: $$BudgetMetadataAssociationsTableReferences._metadataTable(db).id,
                              )
                              as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$BudgetMetadataAssociationsTableProcessedTableManager =
    ProcessedTableManager<
      _$Database,
      $BudgetMetadataAssociationsTable,
      BudgetMetadataAssociationDataModel,
      $$BudgetMetadataAssociationsTableFilterComposer,
      $$BudgetMetadataAssociationsTableOrderingComposer,
      $$BudgetMetadataAssociationsTableAnnotationComposer,
      $$BudgetMetadataAssociationsTableCreateCompanionBuilder,
      $$BudgetMetadataAssociationsTableUpdateCompanionBuilder,
      (
        BudgetMetadataAssociationDataModel,
        $$BudgetMetadataAssociationsTableReferences,
      ),
      BudgetMetadataAssociationDataModel,
      PrefetchHooks Function({bool plan, bool metadata})
    >;

class $DatabaseManager {
  final _$Database _db;
  $DatabaseManager(this._db);
  $$AccountsTableTableManager get accounts => $$AccountsTableTableManager(_db, _db.accounts);
  $$UsersTableTableManager get users => $$UsersTableTableManager(_db, _db.users);
  $$BudgetsTableTableManager get budgets => $$BudgetsTableTableManager(_db, _db.budgets);
  $$BudgetCategoriesTableTableManager get budgetCategories =>
      $$BudgetCategoriesTableTableManager(_db, _db.budgetCategories);
  $$BudgetPlansTableTableManager get budgetPlans => $$BudgetPlansTableTableManager(_db, _db.budgetPlans);
  $$BudgetAllocationsTableTableManager get budgetAllocations =>
      $$BudgetAllocationsTableTableManager(_db, _db.budgetAllocations);
  $$BudgetMetadataKeysTableTableManager get budgetMetadataKeys =>
      $$BudgetMetadataKeysTableTableManager(_db, _db.budgetMetadataKeys);
  $$BudgetMetadataValuesTableTableManager get budgetMetadataValues =>
      $$BudgetMetadataValuesTableTableManager(_db, _db.budgetMetadataValues);
  $$BudgetMetadataAssociationsTableTableManager get budgetMetadataAssociations =>
      $$BudgetMetadataAssociationsTableTableManager(
        _db,
        _db.budgetMetadataAssociations,
      );
}

mixin _$AccountsDaoMixin on DatabaseAccessor<Database> {
  $AccountsTable get accounts => attachedDatabase.accounts;
}
mixin _$UsersDaoMixin on DatabaseAccessor<Database> {
  $UsersTable get users => attachedDatabase.users;
}
mixin _$BudgetsDaoMixin on DatabaseAccessor<Database> {
  $BudgetsTable get budgets => attachedDatabase.budgets;
}
mixin _$BudgetPlansDaoMixin on DatabaseAccessor<Database> {
  $BudgetCategoriesTable get budgetCategories => attachedDatabase.budgetCategories;
  $BudgetPlansTable get budgetPlans => attachedDatabase.budgetPlans;
}
mixin _$BudgetCategoriesDaoMixin on DatabaseAccessor<Database> {
  $BudgetCategoriesTable get budgetCategories => attachedDatabase.budgetCategories;
}
mixin _$BudgetAllocationsDaoMixin on DatabaseAccessor<Database> {
  $BudgetsTable get budgets => attachedDatabase.budgets;
  $BudgetCategoriesTable get budgetCategories => attachedDatabase.budgetCategories;
  $BudgetPlansTable get budgetPlans => attachedDatabase.budgetPlans;
  $BudgetAllocationsTable get budgetAllocations => attachedDatabase.budgetAllocations;
}
mixin _$BudgetMetadataDaoMixin on DatabaseAccessor<Database> {
  $BudgetMetadataKeysTable get budgetMetadataKeys => attachedDatabase.budgetMetadataKeys;
  $BudgetMetadataValuesTable get budgetMetadataValues => attachedDatabase.budgetMetadataValues;
  $BudgetCategoriesTable get budgetCategories => attachedDatabase.budgetCategories;
  $BudgetPlansTable get budgetPlans => attachedDatabase.budgetPlans;
  $BudgetMetadataAssociationsTable get budgetMetadataAssociations => attachedDatabase.budgetMetadataAssociations;
}
