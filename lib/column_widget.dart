import 'package:flutter/material.dart';

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
