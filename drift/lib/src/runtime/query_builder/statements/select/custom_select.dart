part of '../../query_builder.dart';

/// A select statement that is constructed with a raw sql prepared statement
/// instead of the high-level drift api.
class CustomSelectStatement with Selectable<QueryRow> {
  /// Tables this select statement reads from. When turning this select query
  /// into an auto-updating stream, that stream will emit new items whenever
  /// any of these tables changes.
  final Set<ResultSetImplementation> tables;

  /// The sql query string for this statement.
  final String query;

  /// The variables for the prepared statement, in the order they appear in
  /// [query]. Variables are denoted using a question mark in the query.
  final List<Variable> variables;
  final DatabaseConnectionUser _db;

  /// Constructs a new custom select statement for the query, the variables,
  /// the affected tables and the database.
  CustomSelectStatement(this.query, this.variables, this.tables, this._db);

  /// Constructs a fetcher for this query. The fetcher is responsible for
  /// updating a stream at the right moment.
  QueryStreamFetcher _constructFetcher() {
    final args = _mapArgs();

    return QueryStreamFetcher(
      readsFrom: TableUpdateQuery.onAllTables(tables),
      fetchData: () => _executeRaw(args),
      key: StreamKey(query, args),
    );
  }

  @override
  Future<List<QueryRow>> get() {
    return _executeRaw(_mapArgs()).then(_mapDbResponse);
  }

  @override
  Stream<List<QueryRow>> watch() {
    return _db.createStream(_constructFetcher()).map(_mapDbResponse);
  }

  List<dynamic> _mapArgs() {
    final ctx = GenerationContext.fromDb(_db);
    return variables.map((v) => v.mapToSimpleValue(ctx)).toList();
  }

  Future<List<Map<String, Object?>>> _executeRaw(List<Object?> mappedArgs) {
    return _db.doWhenOpened((e) => e.runSelect(query, mappedArgs));
  }

  List<QueryRow> _mapDbResponse(List<Map<String, Object?>> rows) {
    return rows.map((row) => QueryRow(row, _db)).toList();
  }
}

/// For custom select statements, represents a row in the result set.
class QueryRow {
  /// The raw data in this row.
  ///
  /// Note that the values in this map aren't mapped to Dart yet. For instance,
  /// a [DateTime] would be stored as an [int] in [data] because that's the way
  /// it's stored in the database. To read a value, use any of the [read]
  /// methods.
  final Map<String, dynamic> data;
  final DatabaseConnectionUser _db;

  /// Construct a row from the raw data and the query engine that maps the raw
  /// response to appropriate dart types.
  QueryRow(this.data, this._db);

  /// Reads an arbitrary value from the row and maps it to a fitting dart type.
  /// The dart type [T] must be supported by the type system of the database
  /// used (mostly contains booleans, strings, numbers and dates).
  T read<T extends Object>(String key) {
    final result = readNullable<T>(key);
    if (result == null) {
      throw StateError(
          'Called read<$T>($key) which would have returned `null`. Please use '
          '`readNullable` for reads that might be null instead.');
    } else {
      return result;
    }
  }

  T? readNullable<T extends Object>(String key) {
    final type = DriftSqlType.forType<T>();
    return _db.options.types.read(type, data[key]);
  }

  /// Reads a bool from the column named [key].
  @Deprecated('Use read<bool>(key) directly')
  bool readBool(String key) => read<bool>(key);

  /// Reads a string from the column named [key].
  @Deprecated('Use read<String>(key) directly')
  String readString(String key) => read<String>(key);

  /// Reads a int from the column named [key].
  @Deprecated('Use read<int>(key) directly')
  int readInt(String key) => read<int>(key);

  /// Reads a double from the column named [key].
  @Deprecated('Use read<double>(key) directly')
  double readDouble(String key) => read<double>(key);

  /// Reads a [DateTime] from the column named [key].
  @Deprecated('Use read<DateTime>(key) directly')
  DateTime readDateTime(String key) => read<DateTime>(key);

  /// Reads a [Uint8List] from the column named [key].
  @Deprecated('Use read<Uint8List>(key) directly')
  Uint8List readBlob(String key) => read<Uint8List>(key);
}
