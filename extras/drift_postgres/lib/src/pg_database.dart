import 'package:collection/collection.dart';
import 'package:drift/backends.dart';
import 'package:postgres/postgres.dart';

/// A drift database implementation that talks to a postgres database.
class PgDatabase extends DelegatedDatabase {
  /// Creates a drift database implementation from a postgres database
  /// [connection].
  PgDatabase(PostgreSQLExecutionContext connection, {bool logStatements = false})
      : super(_PgDelegate(connection),
            isSequential: true, logStatements: logStatements);

  @override
  SqlDialect get dialect => SqlDialect.postgres;
}

class _PgDelegate extends DatabaseDelegate {
  final PostgreSQLExecutionContext _ec;

  _PgDelegate(this._ec);

  bool _isOpen = false;

  @override
  TransactionDelegate get transactionDelegate => const NoTransactionDelegate();

  @override
  late DbVersionDelegate versionDelegate;

  @override
  Future<bool> get isOpen => Future.value(_isOpen);

  @override
  Future<void> open(QueryExecutorUser user) async {
    final pgVersionDelegate = _PgVersionDelegate(_ec);

    if (_ec is PostgreSQLConnection) {
      await (_ec as PostgreSQLConnection).open();
    }
    await pgVersionDelegate.init();

    versionDelegate = pgVersionDelegate;
    _isOpen = true;
  }

  Future _ensureOpen() async {
    if (_ec is PostgreSQLConnection) {
      final db = _ec as PostgreSQLConnection;
      if (db.isClosed) {
        await db.open();
      }
    }
  }

  @override
  Future<void> runBatched(BatchedStatements statements) async {
    await _ensureOpen();

    for (final row in statements.arguments) {
      final stmt = statements.statements[row.statementIndex];
      final args = row.arguments;

      await _ec.execute(stmt, substitutionValues: _convertArgs(args));
    }

    return Future.value();
  }

  Future<int> _runWithArgs(String statement, List<Object?> args) async {
    await _ensureOpen();

    if (args.isEmpty) {
      return _ec.execute(statement);
    } else {
      return _ec.execute(statement, substitutionValues: _convertArgs(args));
    }
  }

  @override
  Future<void> runCustom(String statement, List<Object?> args) async {
    await _runWithArgs(statement, args);
  }

  @override
  Future<int> runInsert(String statement, List<Object?> args) async {
    await _ensureOpen();
    PostgreSQLResult result;
    if (args.isEmpty) {
      result = await _ec.query(statement);
    } else {
      result = await _ec.query(
        statement,
        substitutionValues: _convertArgs(args),
      );
    }
    return result.firstOrNull?[0] as int? ?? 0;
  }

  @override
  Future<int> runUpdate(String statement, List<Object?> args) async {
    return _runWithArgs(statement, args);
  }

  @override
  Future<QueryResult> runSelect(String statement, List<Object?> args) async {
    await _ensureOpen();
    final result = await _ec.query(
      statement,
      substitutionValues: _convertArgs(args),
    );

    return Future.value(QueryResult.fromRows(
        result.map((e) => e.toColumnMap()).toList(growable: false)));
  }

  @override
  Future<void> close() async {
    // This delegate does not handle the connection lifecycle.
  }

  Object? _convertValue(Object? value) {
    if (value is BigInt) {
      return value.toInt();
    }
    return value;
  }

  Map<String, dynamic> _convertArgs(List<Object?> args) {
    return args.asMap().map(
          (key, value) => MapEntry(
            (key + 1).toString(),
            _convertValue(value),
          ),
        );
  }
}

class _PgVersionDelegate extends DynamicVersionDelegate {
  final PostgreSQLExecutionContext database;

  _PgVersionDelegate(this.database);

  @override
  Future<int> get schemaVersion async {
    final result = await database.query('SELECT version FROM __schema');
    return result[0][0] as int;
  }

  Future init() async {
    await database.query('CREATE TABLE IF NOT EXISTS __schema ('
        'version integer NOT NULL DEFAULT 0)');
    final count = await database.query('SELECT COUNT(*) FROM __schema');
    if (count[0][0] as int == 0) {
      await database.query('INSERT INTO __schema (version) VALUES (0)');
    }
  }

  @override
  Future<void> setSchemaVersion(int version) async {
    await database.query('UPDATE __schema SET version = @1',
        substitutionValues: {'1': version});
  }
}
