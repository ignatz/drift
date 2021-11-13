// For more information on using drift, please see https://drift.simonbinder.eu/docs/getting-started/

import 'package:drift/drift.dart';
import 'package:drift/native.dart';

part 'main.g.dart';

class TodoCategories extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get name => text()();
}

class TodoItems extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get title => text()();
  TextColumn get content => text().nullable()();
  IntColumn get categoryId => integer().references(TodoCategories, #id)();
}

abstract class TodoCategoryItemCount extends View {
  $TodoItemsTable get todoItems;
  $TodoCategoriesTable get todoCategories;

  IntColumn get itemCount => integer().generatedAs(todoItems.id.count())();

  @override
  Query as() => select([
        todoCategories.name,
        itemCount,
      ]).from(todoCategories).join([
        innerJoin(todoItems, todoItems.categoryId.equalsExp(todoCategories.id))
      ]);
}

class TodoItemWithCategoryName extends View {
  late $TodoItemsTable todoItems;
  late $TodoCategoriesTable todoCategories;

  TextColumn get title => text().generatedAs(todoItems.title +
      const Constant(' (') +
      todoCategories.name +
      const Constant(')'))();

  @override
  Query as() => select([todoItems.id, title]).from(todoItems).join([
        innerJoin(
            todoCategories, todoCategories.id.equalsExp(todoItems.categoryId))
      ]);
}

@DriftDatabase(tables: [
  TodoItems,
  TodoCategories,
], views: [
  TodoCategoryItemCount,
  TodoItemWithCategoryName,
])
class Database extends _$Database {
  Database(QueryExecutor e) : super(e);

  @override
  int get schemaVersion => 1;

  @override
  MigrationStrategy get migration {
    return MigrationStrategy(
      onCreate: (m) async {
        await m.createAll();

        // Add a bunch of default items in a batch
        await batch((b) {
          b.insertAll(todoItems, [
            TodoItemsCompanion.insert(title: 'A first entry', categoryId: 0),
            TodoItemsCompanion.insert(
              title: 'Todo: Checkout drift',
              content: const Value('Drift is a persistence library for Dart '
                  'and Flutter applications.'),
              categoryId: 0,
            ),
          ]);
        });
      },
    );
  }

  // The TodoItem class has been generated by drift, based on the TodoItems
  // table description.
  //
  // In drift, queries can be watched by using .watch() in the end.
  // For more information on queries, see https://drift.simonbinder.eu/docs/getting-started/writing_queries/
  Stream<List<TodoItem>> get allItems => select(todoItems).watch();
}

Future<void> main() async {
  // Create an in-memory instance of the database with todo items.
  final db = Database(NativeDatabase.memory());

  db.allItems.listen((event) {
    print('Todo-item in database: $event');
  });

  // Add category
  final categoryId = await db
      .into(db.todoCategories)
      .insert(TodoCategoriesCompanion.insert(name: 'Category'));

  // Add another entry
  await db.into(db.todoItems).insert(TodoItemsCompanion.insert(
      title: 'Another entry added later', categoryId: categoryId));

  // Delete all todo items
  await db.delete(db.todoItems).go();
}
