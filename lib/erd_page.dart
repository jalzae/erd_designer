import 'dart:convert';

import 'package:flutter/material.dart';
import 'table_widget.dart';
import 'column_widget.dart';
import 'package:flutter/services.dart' show rootBundle;

class ERDPage extends StatefulWidget {
  @override
  _ERDPageState createState() => _ERDPageState();
}

class _ERDPageState extends State<ERDPage> {
  List<TableWidget> tables = [];

  void addTable() async {
    final jsonSchema = await rootBundle.loadString('assets/table.json');
    final tableData = json.decode(jsonSchema);

    setState(() {
      final newTableName = tableData['name'];
      final newPosition = Offset(50, 50); // Initial position

      final newTableWidget = TableWidget(
        tableName: newTableName,
        position: newPosition,
        onTableDragged: () {
          // Handle table dragged event if needed
        },
        columns: (tableData['columns'] as List).map<ColumnWidget>((columnData) {
          return ColumnWidget(
            columnName: columnData['name'],
            columnType: columnData['type'],
            primaryKey: columnData['primaryKey'] ?? false,
            autoIncrement: columnData['autoIncrement'] ?? false,
            nullable: columnData['nullable'] ?? false,
          );
        }).toList(),
      );

      setState(() {
        tables.add(newTableWidget);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          height: 500, // Replace with your preferred height
          color: Colors.grey[300],
        ),
        for (var table in tables)
          Positioned(
            left: table.position.dx,
            top: table.position.dy,
            child: table,
          ),
        ElevatedButton(
          onPressed: addTable,
          child: Text('Add Table'),
        ),
      ],
    );
  }
}
