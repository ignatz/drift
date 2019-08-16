// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'custom_tables.dart';

// **************************************************************************
// MoorGenerator
// **************************************************************************

// ignore_for_file: unnecessary_brace_in_string_interps
class NoId extends DataClass implements Insertable<NoId> {
  final Uint8List payload;
  NoId({@required this.payload});
  factory NoId.fromData(Map<String, dynamic> data, GeneratedDatabase db,
      {String prefix}) {
    final effectivePrefix = prefix ?? '';
    final uint8ListType = db.typeSystem.forDartType<Uint8List>();
    return NoId(
      payload: uint8ListType
          .mapFromDatabaseResponse(data['${effectivePrefix}payload']),
    );
  }
  factory NoId.fromJson(Map<String, dynamic> json,
      {ValueSerializer serializer = const ValueSerializer.defaults()}) {
    return NoId(
      payload: serializer.fromJson<Uint8List>(json['payload']),
    );
  }
  @override
  Map<String, dynamic> toJson(
      {ValueSerializer serializer = const ValueSerializer.defaults()}) {
    return {
      'payload': serializer.toJson<Uint8List>(payload),
    };
  }

  @override
  T createCompanion<T extends UpdateCompanion<NoId>>(bool nullToAbsent) {
    return NoIdsCompanion(
      payload: payload == null && nullToAbsent
          ? const Value.absent()
          : Value(payload),
    ) as T;
  }

  NoId copyWith({Uint8List payload}) => NoId(
        payload: payload ?? this.payload,
      );
  @override
  String toString() {
    return (StringBuffer('NoId(')..write('payload: $payload')..write(')'))
        .toString();
  }

  @override
  int get hashCode => $mrjf(payload.hashCode);
  @override
  bool operator ==(other) =>
      identical(this, other) || (other is NoId && other.payload == payload);
}

class NoIdsCompanion extends UpdateCompanion<NoId> {
  final Value<Uint8List> payload;
  const NoIdsCompanion({
    this.payload = const Value.absent(),
  });
  NoIdsCompanion copyWith({Value<Uint8List> payload}) {
    return NoIdsCompanion(
      payload: payload ?? this.payload,
    );
  }
}

class NoIds extends Table with TableInfo<NoIds, NoId> {
  final GeneratedDatabase _db;
  final String _alias;
  NoIds(this._db, [this._alias]);
  final VerificationMeta _payloadMeta = const VerificationMeta('payload');
  GeneratedBlobColumn _payload;
  GeneratedBlobColumn get payload => _payload ??= _constructPayload();
  GeneratedBlobColumn _constructPayload() {
    return GeneratedBlobColumn('payload', $tableName, false,
        $customConstraints: 'NOT NULL');
  }

  @override
  List<GeneratedColumn> get $columns => [payload];
  @override
  NoIds get asDslTable => this;
  @override
  String get $tableName => _alias ?? 'no_ids';
  @override
  final String actualTableName = 'no_ids';
  @override
  VerificationContext validateIntegrity(NoIdsCompanion d,
      {bool isInserting = false}) {
    final context = VerificationContext();
    if (d.payload.present) {
      context.handle(_payloadMeta,
          payload.isAcceptableValue(d.payload.value, _payloadMeta));
    } else if (payload.isRequired && isInserting) {
      context.missing(_payloadMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => <GeneratedColumn>{};
  @override
  NoId map(Map<String, dynamic> data, {String tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : null;
    return NoId.fromData(data, _db, prefix: effectivePrefix);
  }

  @override
  Map<String, Variable> entityToSql(NoIdsCompanion d) {
    final map = <String, Variable>{};
    if (d.payload.present) {
      map['payload'] = Variable<Uint8List, BlobType>(d.payload.value);
    }
    return map;
  }

  @override
  NoIds createAlias(String alias) {
    return NoIds(_db, alias);
  }

  @override
  final bool withoutRowId = true;
  @override
  final bool dontWriteConstraints = true;
}

class WithDefault extends DataClass implements Insertable<WithDefault> {
  final String a;
  final int b;
  WithDefault({this.a, this.b});
  factory WithDefault.fromData(Map<String, dynamic> data, GeneratedDatabase db,
      {String prefix}) {
    final effectivePrefix = prefix ?? '';
    final stringType = db.typeSystem.forDartType<String>();
    final intType = db.typeSystem.forDartType<int>();
    return WithDefault(
      a: stringType.mapFromDatabaseResponse(data['${effectivePrefix}a']),
      b: intType.mapFromDatabaseResponse(data['${effectivePrefix}b']),
    );
  }
  factory WithDefault.fromJson(Map<String, dynamic> json,
      {ValueSerializer serializer = const ValueSerializer.defaults()}) {
    return WithDefault(
      a: serializer.fromJson<String>(json['a']),
      b: serializer.fromJson<int>(json['b']),
    );
  }
  @override
  Map<String, dynamic> toJson(
      {ValueSerializer serializer = const ValueSerializer.defaults()}) {
    return {
      'a': serializer.toJson<String>(a),
      'b': serializer.toJson<int>(b),
    };
  }

  @override
  T createCompanion<T extends UpdateCompanion<WithDefault>>(bool nullToAbsent) {
    return WithDefaultsCompanion(
      a: a == null && nullToAbsent ? const Value.absent() : Value(a),
      b: b == null && nullToAbsent ? const Value.absent() : Value(b),
    ) as T;
  }

  WithDefault copyWith({String a, int b}) => WithDefault(
        a: a ?? this.a,
        b: b ?? this.b,
      );
  @override
  String toString() {
    return (StringBuffer('WithDefault(')
          ..write('a: $a, ')
          ..write('b: $b')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => $mrjf($mrjc(a.hashCode, b.hashCode));
  @override
  bool operator ==(other) =>
      identical(this, other) ||
      (other is WithDefault && other.a == a && other.b == b);
}

class WithDefaultsCompanion extends UpdateCompanion<WithDefault> {
  final Value<String> a;
  final Value<int> b;
  const WithDefaultsCompanion({
    this.a = const Value.absent(),
    this.b = const Value.absent(),
  });
  WithDefaultsCompanion copyWith({Value<String> a, Value<int> b}) {
    return WithDefaultsCompanion(
      a: a ?? this.a,
      b: b ?? this.b,
    );
  }
}

class WithDefaults extends Table with TableInfo<WithDefaults, WithDefault> {
  final GeneratedDatabase _db;
  final String _alias;
  WithDefaults(this._db, [this._alias]);
  final VerificationMeta _aMeta = const VerificationMeta('a');
  GeneratedTextColumn _a;
  GeneratedTextColumn get a => _a ??= _constructA();
  GeneratedTextColumn _constructA() {
    return GeneratedTextColumn('a', $tableName, true,
        $customConstraints: 'DEFAULT \'something\'',
        defaultValue:
            const CustomExpression<String, StringType>('\'something\''));
  }

  final VerificationMeta _bMeta = const VerificationMeta('b');
  GeneratedIntColumn _b;
  GeneratedIntColumn get b => _b ??= _constructB();
  GeneratedIntColumn _constructB() {
    return GeneratedIntColumn('b', $tableName, true,
        $customConstraints: 'UNIQUE');
  }

  @override
  List<GeneratedColumn> get $columns => [a, b];
  @override
  WithDefaults get asDslTable => this;
  @override
  String get $tableName => _alias ?? 'with_defaults';
  @override
  final String actualTableName = 'with_defaults';
  @override
  VerificationContext validateIntegrity(WithDefaultsCompanion d,
      {bool isInserting = false}) {
    final context = VerificationContext();
    if (d.a.present) {
      context.handle(_aMeta, a.isAcceptableValue(d.a.value, _aMeta));
    } else if (a.isRequired && isInserting) {
      context.missing(_aMeta);
    }
    if (d.b.present) {
      context.handle(_bMeta, b.isAcceptableValue(d.b.value, _bMeta));
    } else if (b.isRequired && isInserting) {
      context.missing(_bMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => <GeneratedColumn>{};
  @override
  WithDefault map(Map<String, dynamic> data, {String tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : null;
    return WithDefault.fromData(data, _db, prefix: effectivePrefix);
  }

  @override
  Map<String, Variable> entityToSql(WithDefaultsCompanion d) {
    final map = <String, Variable>{};
    if (d.a.present) {
      map['a'] = Variable<String, StringType>(d.a.value);
    }
    if (d.b.present) {
      map['b'] = Variable<int, IntType>(d.b.value);
    }
    return map;
  }

  @override
  WithDefaults createAlias(String alias) {
    return WithDefaults(_db, alias);
  }

  @override
  final bool dontWriteConstraints = true;
}

class WithConstraint extends DataClass implements Insertable<WithConstraint> {
  final String a;
  final int b;
  final double c;
  WithConstraint({this.a, @required this.b, this.c});
  factory WithConstraint.fromData(
      Map<String, dynamic> data, GeneratedDatabase db,
      {String prefix}) {
    final effectivePrefix = prefix ?? '';
    final stringType = db.typeSystem.forDartType<String>();
    final intType = db.typeSystem.forDartType<int>();
    final doubleType = db.typeSystem.forDartType<double>();
    return WithConstraint(
      a: stringType.mapFromDatabaseResponse(data['${effectivePrefix}a']),
      b: intType.mapFromDatabaseResponse(data['${effectivePrefix}b']),
      c: doubleType.mapFromDatabaseResponse(data['${effectivePrefix}c']),
    );
  }
  factory WithConstraint.fromJson(Map<String, dynamic> json,
      {ValueSerializer serializer = const ValueSerializer.defaults()}) {
    return WithConstraint(
      a: serializer.fromJson<String>(json['a']),
      b: serializer.fromJson<int>(json['b']),
      c: serializer.fromJson<double>(json['c']),
    );
  }
  @override
  Map<String, dynamic> toJson(
      {ValueSerializer serializer = const ValueSerializer.defaults()}) {
    return {
      'a': serializer.toJson<String>(a),
      'b': serializer.toJson<int>(b),
      'c': serializer.toJson<double>(c),
    };
  }

  @override
  T createCompanion<T extends UpdateCompanion<WithConstraint>>(
      bool nullToAbsent) {
    return WithConstraintsCompanion(
      a: a == null && nullToAbsent ? const Value.absent() : Value(a),
      b: b == null && nullToAbsent ? const Value.absent() : Value(b),
      c: c == null && nullToAbsent ? const Value.absent() : Value(c),
    ) as T;
  }

  WithConstraint copyWith({String a, int b, double c}) => WithConstraint(
        a: a ?? this.a,
        b: b ?? this.b,
        c: c ?? this.c,
      );
  @override
  String toString() {
    return (StringBuffer('WithConstraint(')
          ..write('a: $a, ')
          ..write('b: $b, ')
          ..write('c: $c')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => $mrjf($mrjc(a.hashCode, $mrjc(b.hashCode, c.hashCode)));
  @override
  bool operator ==(other) =>
      identical(this, other) ||
      (other is WithConstraint && other.a == a && other.b == b && other.c == c);
}

class WithConstraintsCompanion extends UpdateCompanion<WithConstraint> {
  final Value<String> a;
  final Value<int> b;
  final Value<double> c;
  const WithConstraintsCompanion({
    this.a = const Value.absent(),
    this.b = const Value.absent(),
    this.c = const Value.absent(),
  });
  WithConstraintsCompanion copyWith(
      {Value<String> a, Value<int> b, Value<double> c}) {
    return WithConstraintsCompanion(
      a: a ?? this.a,
      b: b ?? this.b,
      c: c ?? this.c,
    );
  }
}

class WithConstraints extends Table
    with TableInfo<WithConstraints, WithConstraint> {
  final GeneratedDatabase _db;
  final String _alias;
  WithConstraints(this._db, [this._alias]);
  final VerificationMeta _aMeta = const VerificationMeta('a');
  GeneratedTextColumn _a;
  GeneratedTextColumn get a => _a ??= _constructA();
  GeneratedTextColumn _constructA() {
    return GeneratedTextColumn('a', $tableName, true, $customConstraints: '');
  }

  final VerificationMeta _bMeta = const VerificationMeta('b');
  GeneratedIntColumn _b;
  GeneratedIntColumn get b => _b ??= _constructB();
  GeneratedIntColumn _constructB() {
    return GeneratedIntColumn('b', $tableName, false,
        $customConstraints: 'NOT NULL');
  }

  final VerificationMeta _cMeta = const VerificationMeta('c');
  GeneratedRealColumn _c;
  GeneratedRealColumn get c => _c ??= _constructC();
  GeneratedRealColumn _constructC() {
    return GeneratedRealColumn('c', $tableName, true, $customConstraints: '');
  }

  @override
  List<GeneratedColumn> get $columns => [a, b, c];
  @override
  WithConstraints get asDslTable => this;
  @override
  String get $tableName => _alias ?? 'with_constraints';
  @override
  final String actualTableName = 'with_constraints';
  @override
  VerificationContext validateIntegrity(WithConstraintsCompanion d,
      {bool isInserting = false}) {
    final context = VerificationContext();
    if (d.a.present) {
      context.handle(_aMeta, a.isAcceptableValue(d.a.value, _aMeta));
    } else if (a.isRequired && isInserting) {
      context.missing(_aMeta);
    }
    if (d.b.present) {
      context.handle(_bMeta, b.isAcceptableValue(d.b.value, _bMeta));
    } else if (b.isRequired && isInserting) {
      context.missing(_bMeta);
    }
    if (d.c.present) {
      context.handle(_cMeta, c.isAcceptableValue(d.c.value, _cMeta));
    } else if (c.isRequired && isInserting) {
      context.missing(_cMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => <GeneratedColumn>{};
  @override
  WithConstraint map(Map<String, dynamic> data, {String tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : null;
    return WithConstraint.fromData(data, _db, prefix: effectivePrefix);
  }

  @override
  Map<String, Variable> entityToSql(WithConstraintsCompanion d) {
    final map = <String, Variable>{};
    if (d.a.present) {
      map['a'] = Variable<String, StringType>(d.a.value);
    }
    if (d.b.present) {
      map['b'] = Variable<int, IntType>(d.b.value);
    }
    if (d.c.present) {
      map['c'] = Variable<double, RealType>(d.c.value);
    }
    return map;
  }

  @override
  WithConstraints createAlias(String alias) {
    return WithConstraints(_db, alias);
  }

  @override
  final List<String> customConstraints = const [
    'FOREIGN KEY (a, b) REFERENCES with_defaults (a, b)'
  ];
  @override
  final bool dontWriteConstraints = true;
}

class ConfigData extends DataClass implements Insertable<ConfigData> {
  final String configKey;
  final String configValue;
  ConfigData({@required this.configKey, this.configValue});
  factory ConfigData.fromData(Map<String, dynamic> data, GeneratedDatabase db,
      {String prefix}) {
    final effectivePrefix = prefix ?? '';
    final stringType = db.typeSystem.forDartType<String>();
    return ConfigData(
      configKey: stringType
          .mapFromDatabaseResponse(data['${effectivePrefix}config_key']),
      configValue: stringType
          .mapFromDatabaseResponse(data['${effectivePrefix}config_value']),
    );
  }
  factory ConfigData.fromJson(Map<String, dynamic> json,
      {ValueSerializer serializer = const ValueSerializer.defaults()}) {
    return ConfigData(
      configKey: serializer.fromJson<String>(json['configKey']),
      configValue: serializer.fromJson<String>(json['configValue']),
    );
  }
  @override
  Map<String, dynamic> toJson(
      {ValueSerializer serializer = const ValueSerializer.defaults()}) {
    return {
      'configKey': serializer.toJson<String>(configKey),
      'configValue': serializer.toJson<String>(configValue),
    };
  }

  @override
  T createCompanion<T extends UpdateCompanion<ConfigData>>(bool nullToAbsent) {
    return ConfigCompanion(
      configKey: configKey == null && nullToAbsent
          ? const Value.absent()
          : Value(configKey),
      configValue: configValue == null && nullToAbsent
          ? const Value.absent()
          : Value(configValue),
    ) as T;
  }

  ConfigData copyWith({String configKey, String configValue}) => ConfigData(
        configKey: configKey ?? this.configKey,
        configValue: configValue ?? this.configValue,
      );
  @override
  String toString() {
    return (StringBuffer('ConfigData(')
          ..write('configKey: $configKey, ')
          ..write('configValue: $configValue')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => $mrjf($mrjc(configKey.hashCode, configValue.hashCode));
  @override
  bool operator ==(other) =>
      identical(this, other) ||
      (other is ConfigData &&
          other.configKey == configKey &&
          other.configValue == configValue);
}

class ConfigCompanion extends UpdateCompanion<ConfigData> {
  final Value<String> configKey;
  final Value<String> configValue;
  const ConfigCompanion({
    this.configKey = const Value.absent(),
    this.configValue = const Value.absent(),
  });
  ConfigCompanion copyWith(
      {Value<String> configKey, Value<String> configValue}) {
    return ConfigCompanion(
      configKey: configKey ?? this.configKey,
      configValue: configValue ?? this.configValue,
    );
  }
}

class Config extends Table with TableInfo<Config, ConfigData> {
  final GeneratedDatabase _db;
  final String _alias;
  Config(this._db, [this._alias]);
  final VerificationMeta _configKeyMeta = const VerificationMeta('configKey');
  GeneratedTextColumn _configKey;
  GeneratedTextColumn get configKey => _configKey ??= _constructConfigKey();
  GeneratedTextColumn _constructConfigKey() {
    return GeneratedTextColumn('config_key', $tableName, false,
        $customConstraints: 'not null primary key');
  }

  final VerificationMeta _configValueMeta =
      const VerificationMeta('configValue');
  GeneratedTextColumn _configValue;
  GeneratedTextColumn get configValue =>
      _configValue ??= _constructConfigValue();
  GeneratedTextColumn _constructConfigValue() {
    return GeneratedTextColumn('config_value', $tableName, true,
        $customConstraints: '');
  }

  @override
  List<GeneratedColumn> get $columns => [configKey, configValue];
  @override
  Config get asDslTable => this;
  @override
  String get $tableName => _alias ?? 'config';
  @override
  final String actualTableName = 'config';
  @override
  VerificationContext validateIntegrity(ConfigCompanion d,
      {bool isInserting = false}) {
    final context = VerificationContext();
    if (d.configKey.present) {
      context.handle(_configKeyMeta,
          configKey.isAcceptableValue(d.configKey.value, _configKeyMeta));
    } else if (configKey.isRequired && isInserting) {
      context.missing(_configKeyMeta);
    }
    if (d.configValue.present) {
      context.handle(_configValueMeta,
          configValue.isAcceptableValue(d.configValue.value, _configValueMeta));
    } else if (configValue.isRequired && isInserting) {
      context.missing(_configValueMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {configKey};
  @override
  ConfigData map(Map<String, dynamic> data, {String tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : null;
    return ConfigData.fromData(data, _db, prefix: effectivePrefix);
  }

  @override
  Map<String, Variable> entityToSql(ConfigCompanion d) {
    final map = <String, Variable>{};
    if (d.configKey.present) {
      map['config_key'] = Variable<String, StringType>(d.configKey.value);
    }
    if (d.configValue.present) {
      map['config_value'] = Variable<String, StringType>(d.configValue.value);
    }
    return map;
  }

  @override
  Config createAlias(String alias) {
    return Config(_db, alias);
  }

  @override
  final bool dontWriteConstraints = true;
}

abstract class _$CustomTablesDb extends GeneratedDatabase {
  _$CustomTablesDb(QueryExecutor e)
      : super(const SqlTypeSystem.withDefaults(), e);
  NoIds _noIds;
  NoIds get noIds => _noIds ??= NoIds(this);
  WithDefaults _withDefaults;
  WithDefaults get withDefaults => _withDefaults ??= WithDefaults(this);
  WithConstraints _withConstraints;
  WithConstraints get withConstraints =>
      _withConstraints ??= WithConstraints(this);
  Config _config;
  Config get config => _config ??= Config(this);
  @override
  List<TableInfo> get allTables =>
      [noIds, withDefaults, withConstraints, config];
}
