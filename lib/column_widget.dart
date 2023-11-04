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
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.black),
        borderRadius: BorderRadius.circular(5.0),
        color: Colors.white,
      ),
      padding: EdgeInsets.all(8.0),
      margin: EdgeInsets.all(4.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(columnName),
          Text("Type: $columnType"),
          if (primaryKey) Text("Primary Key"),
          if (autoIncrement) Text("Auto Increment"),
          if (nullable) Text("Nullable"),
        ],
      ),
    );
  }
}
