import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: Text('ERD Designer')),
        body: ERDPage(),
      ),
    );
  }
}

class ERDPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: TableWidget(
        tableName: "User",
        columns: [
          ColumnWidget(
            columnName: "id",
            columnType: "uuid",
            primaryKey: true,
            autoIncrement: true,
            nullable: false,
          ),
          ColumnWidget(
            columnName: "username",
            columnType: "varchar",
            primaryKey: false,
            autoIncrement: false,
            nullable: false,
          ),
          ColumnWidget(
            columnName: "password",
            columnType: "text",
            primaryKey: false,
            autoIncrement: false,
            nullable: false,
          ),
          ColumnWidget(
            columnName: "email",
            columnType: "varchar",
            primaryKey: false,
            autoIncrement: false,
            nullable: true,
          ),
        ],
      ),
    );
  }
}

class TableWidget extends StatelessWidget {
  final String tableName;
  final List<ColumnWidget> columns;

  TableWidget({
    required this.tableName,
    required this.columns,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: const BoxConstraints(maxWidth: 150),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.blue, width: 2.0),
        borderRadius: BorderRadius.circular(5.0),
      ),
      child: IntrinsicHeight(
        child: Column(
          children: [
            Text(
              tableName,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
            Divider(color: Colors.blue),
            ...columns,
          ],
        ),
      ),
    );
  }
}

class ColumnWidget extends StatelessWidget {
  final String columnName;
  final String columnType;
  final bool primaryKey;
  final bool autoIncrement;
  final bool nullable;

  ColumnWidget({
    required this.columnName,
    required this.columnType,
    this.primaryKey = false,
    this.autoIncrement = false,
    this.nullable = false,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(columnName),
      subtitle: Text(columnType),
    );
  }
}
